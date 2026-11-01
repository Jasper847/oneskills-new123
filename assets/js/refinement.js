/* ============================================================
   ONESKILLS — HOMEPAGE UX & ACCESSIBILITY REFINEMENTS
   Load after main.js. No dependencies.
   ============================================================ */

(() => {
  'use strict';

  const ready = (callback) => {
    if (document.readyState === 'loading') {
      document.addEventListener('DOMContentLoaded', callback, { once: true });
    } else {
      callback();
    }
  };

  ready(() => {
    if (!document.body.classList.contains('home-page')) return;

    const safely = (label, callback) => {
      try {
        callback();
      } catch (error) {
        console.warn(`[OneSkills refinement: ${label}]`, error);
      }
    };

    /* ----------------------------------------------------------
       Native semantic ordering & accessibility synchronization
       ---------------------------------------------------------- */

    /* ----------------------------------------------------------
       Convert filtering controls to accurate button semantics
       ---------------------------------------------------------- */

    const normalizeButtonGroup = (container, buttonSelector) => {
      if (!container) return;

      const buttons = Array.from(
        container.querySelectorAll(buttonSelector)
      );

      if (!buttons.length) return;

      if (container.tagName === 'NAV') {
        container.removeAttribute('role');
      } else {
        container.setAttribute('role', 'group');
      }

      const synchronize = () => {
        buttons.forEach((button) => {
          const active = button.classList.contains('active');

          button.removeAttribute('role');
          button.removeAttribute('aria-selected');
          button.setAttribute('aria-pressed', String(active));
        });
      };

      synchronize();

      container.addEventListener('click', (event) => {
        if (event.target.closest(buttonSelector)) {
          requestAnimationFrame(synchronize);
        }
      });

      const observer = new MutationObserver(synchronize);
      observer.observe(container, {
        attributes: true,
        attributeFilter: ['class'],
        subtree: true
      });
    };

    safely('course filter semantics', () => {
      normalizeButtonGroup(
        document.getElementById('filter-tabs'),
        '.filter-btn'
      );
    });

    safely('FAQ filter semantics', () => {
      normalizeButtonGroup(
        document.querySelector('.faq-filter-row'),
        '.filter-btn'
      );
    });

    safely('review pagination semantics', () => {
      normalizeButtonGroup(
        document.getElementById('reviews-dots'),
        '.review-dot'
      );
    });

    /* ----------------------------------------------------------
       Accessible dialog names
       ---------------------------------------------------------- */

    safely('dialog labels', () => {
      const reviewDialog = document.getElementById(
        'review-modal-backdrop'
      );

      if (reviewDialog) {
        reviewDialog.setAttribute(
          'aria-labelledby',
          'modal-reviewer-name'
        );
        reviewDialog.setAttribute(
          'aria-describedby',
          'modal-full-text'
        );
      }
    });

    /* ----------------------------------------------------------
       Coordinated navigation, dialogs, inert background and CTAs
       ---------------------------------------------------------- */

    safely('UI coordination', () => {
      const body = document.body;
      const header = document.getElementById('site-header');
      const main = document.querySelector('main');
      const footer = document.querySelector('footer');
      const nav = document.getElementById('primary-nav');
      const navOverlay = document.getElementById('nav-overlay');
      const videoDialog = document.getElementById(
        'video-modal-overlay'
      );
      const reviewDialog = document.getElementById(
        'review-modal-backdrop'
      );
      const stickyCTA = document.querySelector('.sticky-cta');
      const floatingWA = document.querySelector('.floating-wa');

      const synchronizeUI = () => {
        const menuOpen = Boolean(
          nav &&
          nav.classList.contains('nav-open') &&
          window.innerWidth <= 900
        );

        const videoOpen = Boolean(
          videoDialog &&
          videoDialog.classList.contains('modal-open')
        );

        const reviewOpen = Boolean(
          reviewDialog &&
          reviewDialog.classList.contains('is-open')
        );

        const locked = menuOpen || videoOpen || reviewOpen;
        const sections = Array.from(
          document.querySelectorAll('main > section')
        );

        body.classList.toggle('os-ui-locked', locked);
        body.classList.toggle('os-menu-active', menuOpen);
        body.classList.toggle(
          'os-dialog-active',
          videoOpen || reviewOpen
        );

        [header, main, footer, stickyCTA, floatingWA].forEach(
          (element) => {
            if (element) element.inert = false;
          }
        );

        sections.forEach((section) => {
          section.inert = false;
        });

        if (reviewOpen) {
          if (header) header.inert = true;
          if (footer) footer.inert = true;

          sections.forEach((section) => {
            section.inert = true;
          });
        } else if (videoOpen) {
          if (header) header.inert = true;
          if (main) main.inert = true;
          if (footer) footer.inert = true;
        } else if (menuOpen) {
          if (main) main.inert = true;
          if (footer) footer.inert = true;
        }

        if (locked) {
          if (stickyCTA) stickyCTA.inert = true;
          if (floatingWA) floatingWA.inert = true;
        }
      };

      const watchedElements = [
        nav,
        navOverlay,
        videoDialog,
        reviewDialog
      ].filter(Boolean);

      const observer = new MutationObserver(synchronizeUI);

      watchedElements.forEach((element) => {
        observer.observe(element, {
          attributes: true,
          attributeFilter: ['class']
        });
      });

      window.addEventListener('resize', synchronizeUI, {
        passive: true
      });

      synchronizeUI();
    });

    /* ----------------------------------------------------------
       Mobile navigation focus containment and restoration
       ---------------------------------------------------------- */

    safely('mobile navigation focus', () => {
      const button = document.getElementById('hamburger-btn');
      const nav = document.getElementById('primary-nav');

      if (!button || !nav) return;

      const isVisible = (element) => Boolean(
        element.offsetWidth ||
        element.offsetHeight ||
        element.getClientRects().length
      );

      const menuIsOpen = () => (
        nav.classList.contains('nav-open') &&
        window.innerWidth <= 900
      );

      button.addEventListener('click', () => {
        window.setTimeout(() => {
          if (!menuIsOpen()) return;

          const firstLink = nav.querySelector(
            'a[href], button:not([disabled])'
          );

          if (firstLink) {
            firstLink.focus({ preventScroll: true });
          }
        }, 40);
      });

      document.addEventListener('keydown', (event) => {
        if (!menuIsOpen()) return;

        if (event.key === 'Escape') {
          window.setTimeout(() => {
            button.focus({ preventScroll: true });
          }, 0);
          return;
        }

        if (event.key !== 'Tab') return;

        const focusable = [
          button,
          ...nav.querySelectorAll(
            'a[href], button:not([disabled]), [tabindex="0"]'
          )
        ].filter(isVisible);

        if (!focusable.length) return;

        const first = focusable[0];
        const last = focusable[focusable.length - 1];
        const active = document.activeElement;

        if (!focusable.includes(active)) {
          event.preventDefault();
          (event.shiftKey ? last : first).focus();
          return;
        }

        if (event.shiftKey && active === first) {
          event.preventDefault();
          last.focus();
        } else if (!event.shiftKey && active === last) {
          event.preventDefault();
          first.focus();
        }
      });
    });

    /* ----------------------------------------------------------
       Remove off-screen review cards from keyboard/accessibility
       navigation while retaining the original carousel engine
       ---------------------------------------------------------- */

    safely('review carousel visibility', () => {
      const track = document.getElementById(
        'reviews-carousel-track'
      );
      const viewport = document.getElementById(
        'reviews-carousel-viewport'
      );
      const dots = document.getElementById('reviews-dots');

      if (!track || !viewport) return;

      const cards = Array.from(
        track.querySelectorAll('.supporting-review-card')
      );

      if (!cards.length) return;

      const status = document.createElement('div');
      status.className = 'os-sr-only';
      status.setAttribute('aria-live', 'polite');
      status.setAttribute('aria-atomic', 'true');

      if (dots && dots.parentNode) {
        dots.parentNode.insertBefore(status, dots.nextSibling);
      } else {
        viewport.parentNode.appendChild(status);
      }

      let timers = [];

      const synchronize = () => {
        const viewportRect = viewport.getBoundingClientRect();
        const visibleIndexes = [];

        cards.forEach((card, index) => {
          const rect = card.getBoundingClientRect();

          if (!rect.width || !rect.height) return;

          const visibleWidth = Math.max(
            0,
            Math.min(rect.right, viewportRect.right) -
            Math.max(rect.left, viewportRect.left)
          );

          const visibleHeight = Math.max(
            0,
            Math.min(rect.bottom, viewportRect.bottom) -
            Math.max(rect.top, viewportRect.top)
          );

          const visible = (
            visibleWidth >= rect.width * 0.55 &&
            visibleHeight >= rect.height * 0.5
          );

          if (
            !visible &&
            card.contains(document.activeElement)
          ) {
            viewport.focus({ preventScroll: true });
          }

          card.tabIndex = visible ? 0 : -1;
          card.inert = !visible;
          card.setAttribute(
            'aria-hidden',
            visible ? 'false' : 'true'
          );

          if (visible) visibleIndexes.push(index);
        });

        if (visibleIndexes.length) {
          const first = visibleIndexes[0] + 1;
          const last =
            visibleIndexes[visibleIndexes.length - 1] + 1;

          const message = (
            first === last
              ? `Showing review ${first} of ${cards.length}.`
              : `Showing reviews ${first} to ${last} of ${cards.length}.`
          );

          if (status.textContent !== message) {
            status.textContent = message;
          }
        }
      };

      const schedule = () => {
        timers.forEach(window.clearTimeout);
        timers = [];

        [40, 520].forEach((delay) => {
          timers.push(window.setTimeout(synchronize, delay));
        });
      };

      const observer = new MutationObserver(schedule);
      observer.observe(track, {
        attributes: true,
        attributeFilter: ['style']
      });

      track.addEventListener('transitionend', schedule);
      viewport.addEventListener('keyup', schedule);
      viewport.addEventListener('touchend', schedule, {
        passive: true
      });

      document
        .querySelectorAll(
          '#reviews-prev-btn, #reviews-next-btn, .review-dot'
        )
        .forEach((control) => {
          control.addEventListener('click', schedule);
        });

      window.addEventListener('resize', schedule, {
        passive: true
      });

      schedule();
    });

    /* ----------------------------------------------------------
       Campus map interaction enhancement and resilient fallback
       ---------------------------------------------------------- */

    safely('campus map enhancements', () => {
      const mapElement = document.getElementById(
        'campus-real-map'
      );

      if (!mapElement) return;

      /*
       * The existing map is lazy-initialized. Wrapping the Leaflet
       * factory here lets us refine the instance without changing
       * its coordinates, markers, theme tiles or recenter control.
       */
      if (
        window.L &&
        typeof window.L.map === 'function' &&
        !window.L.map.__oneSkillsRefined
      ) {
        const originalMapFactory = window.L.map;

        const refinedMapFactory = function (...args) {
          const instance = originalMapFactory.apply(this, args);
          const target = args[0];

          if (
            target === 'campus-real-map' ||
            target === mapElement
          ) {
            const disableWheelZoom = () => {
              try {
                instance.scrollWheelZoom.disable();
              } catch (error) {
                // Map may already be destroyed; no action needed.
              }
            };

            mapElement.addEventListener(
              'mouseleave',
              disableWheelZoom,
              { passive: true }
            );

            mapElement.addEventListener('focusout', () => {
              window.setTimeout(() => {
                if (
                  !mapElement.contains(document.activeElement)
                ) {
                  disableWheelZoom();
                }
              }, 0);
            });

            instance.on('blur', disableWheelZoom);
          }

          return instance;
        };

        refinedMapFactory.__oneSkillsRefined = true;
        window.L.map = refinedMapFactory;
      }

      let fallback = null;

      const hasLoadedTiles = () => Boolean(
        mapElement.querySelector('.leaflet-tile-loaded')
      );

      const removeFallback = () => {
        if (fallback) {
          fallback.remove();
          fallback = null;
        }
      };

      const showFallback = () => {
        if (hasLoadedTiles() || fallback) return;

        fallback = document.createElement('div');
        fallback.className = 'os-map-fallback';
        fallback.setAttribute('role', 'status');
        fallback.innerHTML = `
          <p>
            <strong>Need campus directions?</strong>
            The interactive map is taking longer to load. You can still
            open the verified OneSkills location directly.
          </p>
          <a
            href="https://maps.app.goo.gl/k8ykDNX1Cn9hEi3P7"
            target="_blank"
            rel="noopener noreferrer"
          >Open Google Maps ↗</a>
        `;

        mapElement.appendChild(fallback);
      };

      const observer = new MutationObserver(() => {
        if (hasLoadedTiles()) removeFallback();
      });

      observer.observe(mapElement, {
        childList: true,
        subtree: true
      });

      window.setTimeout(showFallback, 12000);
    });
  });
})();
