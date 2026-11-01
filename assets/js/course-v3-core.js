/**
 * ============================================================================
 * ONESKILLS ACADEMY — MASTER COURSE INTERACTIVITY LAYER (V3 CORE)
 * Unified interactivity for all OneSkills course pages.
 * Supports: Scroll-spy, smooth anchor scrolling, curriculum tabs & search,
 * tuition switcher, batch selector, commuter transit tabs, mobile conversion dock,
 * and WCAG 2.2 compliant keyboard/screen-reader accessibility.
 * ============================================================================
 */

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
    // Only run on course pages
    if (!document.body.classList.contains('course-v3-page') &&
        !document.body.classList.contains('course-v2-page')) {
      return;
    }

    const courseTitle = document.body.getAttribute('data-course-title') ||
                        (document.querySelector('.c-hero-title') ? document.querySelector('.c-hero-title').textContent.trim() : 'OneSkills Academy Course');
    const waNumber = '923176036127';

    /* ------------------------------------------------------------------------
       1. Toast Helper & Accessible Announcements
       ------------------------------------------------------------------------ */
    let toastTimer = null;
    const showToast = (msg) => {
      let toast = document.querySelector('.c-toast');
      if (!toast) {
        toast = document.createElement('div');
        toast.className = 'c-toast';
        toast.setAttribute('role', 'status');
        toast.setAttribute('aria-live', 'polite');
        toast.setAttribute('aria-atomic', 'true');
        document.body.appendChild(toast);
      }
      toast.textContent = msg;
      toast.classList.add('show');
      clearTimeout(toastTimer);
      toastTimer = setTimeout(() => {
        toast.classList.remove('show');
      }, 3000);
    };

    const copyText = (text, successMsg) => {
      if (navigator.clipboard && navigator.clipboard.writeText) {
        navigator.clipboard.writeText(text).then(() => {
          showToast(successMsg);
        }).catch(() => {
          fallbackCopy(text, successMsg);
        });
      } else {
        fallbackCopy(text, successMsg);
      }
    };

    const fallbackCopy = (text, successMsg) => {
      const ta = document.createElement('textarea');
      ta.value = text;
      ta.style.position = 'fixed';
      ta.style.opacity = '0';
      document.body.appendChild(ta);
      ta.select();
      try {
        document.execCommand('copy');
        showToast(successMsg);
      } catch (e) {
        showToast('Text copied to clipboard');
      }
      document.body.removeChild(ta);
    };

    /* ------------------------------------------------------------------------
       2. Sticky Course Subnav Scroll-Spy
       ------------------------------------------------------------------------ */
    const subnavLinks = Array.from(document.querySelectorAll('.c-subnav-link, .c-subnav__link'));
    const sections = subnavLinks
      .map((link) => {
        const id = link.getAttribute('href');
        if (id && id.startsWith('#') && id.length > 1) {
          return document.querySelector(id);
        }
        return null;
      })
      .filter(Boolean);

    if (subnavLinks.length && sections.length && 'IntersectionObserver' in window) {
      const observer = new IntersectionObserver(
        (entries) => {
          entries.forEach((entry) => {
            if (entry.isIntersecting) {
              const activeId = '#' + entry.target.id;
              subnavLinks.forEach((link) => {
                const isActive = link.getAttribute('href') === activeId;
                link.classList.toggle('active', isActive);
                link.classList.toggle('is-active', isActive);
                if (isActive) {
                  link.setAttribute('aria-current', 'true');
                } else {
                  link.removeAttribute('aria-current');
                }
              });
            }
          });
        },
        {
          rootMargin: '-20% 0px -65% 0px',
          threshold: 0
        }
      );

      sections.forEach((section) => observer.observe(section));
    }

    /* ------------------------------------------------------------------------
       3. Smooth Anchor Scrolling with Header & Subnav Offset
       ------------------------------------------------------------------------ */
    const anchorLinks = Array.from(document.querySelectorAll('.c-subnav-link, .c-subnav__link, a[href^="#"]:not(.skip-link):not([data-no-scroll])'));
    anchorLinks.forEach((link) => {
      link.addEventListener('click', (e) => {
        const href = link.getAttribute('href');
        if (href && href.startsWith('#') && href.length > 1) {
          const target = document.querySelector(href);
          if (target) {
            e.preventDefault();
            const headerOffset = 135;
            const elementPosition = target.getBoundingClientRect().top;
            const offsetPosition = elementPosition + window.pageYOffset - headerOffset;

            window.scrollTo({
              top: offsetPosition,
              behavior: window.matchMedia('(prefers-reduced-motion: reduce)').matches ? 'auto' : 'smooth'
            });

            target.setAttribute('tabindex', '-1');
            target.focus({ preventScroll: true });

            if (history.pushState) {
              history.pushState(null, '', href);
            }
          }
        }
      });
    });

    /* ------------------------------------------------------------------------
       4. Mobile Conversion Dock Behavior & Scroll Reveal
       ------------------------------------------------------------------------ */
    const mobileDock = document.querySelector('.c-mobile-dock');
    const primaryNav = document.getElementById('primary-nav');

    if (mobileDock) {
      const checkNavOpen = () => {
        const isOpen = Boolean(primaryNav && primaryNav.classList.contains('nav-open'));
        mobileDock.style.display = isOpen ? 'none' : '';
      };

      if (primaryNav) {
        const navObserver = new MutationObserver(checkNavOpen);
        navObserver.observe(primaryNav, { attributes: true, attributeFilter: ['class'] });
      }

      const toggleMobileDock = () => {
        const top = window.scrollY || document.documentElement.scrollTop || 0;
        const pastHero = top > 380;
        mobileDock.classList.toggle('visible', pastHero);
      };

      window.addEventListener('scroll', toggleMobileDock, { passive: true });
      window.addEventListener('resize', toggleMobileDock, { passive: true });
      toggleMobileDock();
    }

    /* ------------------------------------------------------------------------
       5. Interactive Curriculum Tabs, Live Search & Expand/Collapse
       ------------------------------------------------------------------------ */
    const curriculumFilterBtns = Array.from(document.querySelectorAll('#curriculum-filter-tabs .c-filter-btn, .c-curriculum-tabs .c-filter-btn'));
    const phaseModules = Array.from(document.querySelectorAll('#syllabus-stack .c-phase-item, .c-phase-stack .c-phase-item'));
    const bAccordionModules = Array.from(document.querySelectorAll('.c-curriculum-accordion .c-accordion-item'));
    const syllabusSearchInput = document.getElementById('syllabus-search') || document.getElementById('curriculum-search');
    let currentPhaseFilter = 'all';

    const filterCurriculum = () => {
      const query = syllabusSearchInput ? syllabusSearchInput.value.trim().toLowerCase() : '';
      
      // Filter Cohort A modules
      phaseModules.forEach((mod) => {
        const phaseAttr = (mod.getAttribute('data-mod-cat') || mod.getAttribute('data-phase') || '').toLowerCase();
        const textContent = mod.textContent.toLowerCase();

        const matchesPhase = currentPhaseFilter === 'all' || phaseAttr.indexOf(currentPhaseFilter) !== -1;
        const matchesQuery = !query || textContent.indexOf(query) !== -1;

        if (matchesPhase && matchesQuery) {
          mod.style.display = 'block';
          if (query) {
            mod.setAttribute('open', '');
          }
        } else {
          mod.style.display = 'none';
        }
      });

      // Filter Cohort B modules
      bAccordionModules.forEach((mod) => {
        const textContent = mod.textContent.toLowerCase();
        const matchesQuery = !query || textContent.indexOf(query) !== -1;
        mod.style.display = matchesQuery ? 'block' : 'none';
        if (query && matchesQuery) {
          mod.classList.add('is-open');
        }
      });
    };

    if (curriculumFilterBtns.length) {
      curriculumFilterBtns.forEach((btn) => {
        btn.addEventListener('click', () => {
          currentPhaseFilter = btn.getAttribute('data-mod-filter') || btn.getAttribute('data-phase-filter') || 'all';
          curriculumFilterBtns.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
            b.setAttribute('aria-pressed', String(isTarget));
          });
          filterCurriculum();
        });
      });
    }

    if (syllabusSearchInput) {
      syllabusSearchInput.addEventListener('input', filterCurriculum);
    }

    const btnExpandAll = document.getElementById('btn-expand-modules');
    const btnCollapseAll = document.getElementById('btn-collapse-modules');

    if (btnExpandAll) {
      btnExpandAll.addEventListener('click', () => {
        phaseModules.forEach((mod) => mod.setAttribute('open', ''));
        bAccordionModules.forEach((mod) => mod.classList.add('is-open'));
        showToast('All curriculum modules expanded');
      });
    }

    if (btnCollapseAll) {
      btnCollapseAll.addEventListener('click', () => {
        phaseModules.forEach((mod) => mod.removeAttribute('open'));
        bAccordionModules.forEach((mod) => mod.classList.remove('is-open'));
        showToast('Curriculum modules collapsed');
      });
    }

    // Cohort B Accordion Triggers
    const accordionTriggers = Array.from(document.querySelectorAll('.c-accordion-item__trigger, .c-faq-item__trigger'));
    if (accordionTriggers.length) {
      accordionTriggers.forEach((btn) => {
        btn.addEventListener('click', () => {
          const item = btn.closest('.c-accordion-item, .c-faq-item');
          if (item) {
            const isOpen = item.classList.contains('is-open');
            item.classList.toggle('is-open', !isOpen);
            btn.setAttribute('aria-expanded', String(!isOpen));
            const content = item.querySelector('.c-accordion-item__content, .c-faq-item__content');
            if (content) {
              if (!isOpen) {
                content.removeAttribute('hidden');
              } else {
                content.setAttribute('hidden', '');
              }
            }
          }
        });
      });
    }

    /* ------------------------------------------------------------------------
       6. Tuition & Payment Plan Switcher
       ------------------------------------------------------------------------ */
    const btnFeeFull = document.getElementById('btn-fee-full');
    const btnFeeInstall = document.getElementById('btn-fee-install');
    const feeDisplayEl = document.getElementById('fee-display-amount') || document.querySelector('.c-tuition-val');
    const feeSubDisplayEl = document.getElementById('fee-display-sub') || document.querySelector('.c-tuition-sub');

    // Default fee data can be configured via page container attributes or fallbacks
    const fullFeeText = document.body.getAttribute('data-fee-full') || 'PKR 28,000';
    const installFeeText = document.body.getAttribute('data-fee-install') || '2 Payments of PKR 14,000';

    const setFeePlan = (isFull) => {
      if (btnFeeFull) {
        btnFeeFull.classList.toggle('active', isFull);
        btnFeeFull.setAttribute('aria-pressed', String(isFull));
      }
      if (btnFeeInstall) {
        btnFeeInstall.classList.toggle('active', !isFull);
        btnFeeInstall.setAttribute('aria-pressed', String(!isFull));
      }
      if (feeDisplayEl) {
        feeDisplayEl.textContent = isFull ? fullFeeText : installFeeText;
      }
      if (feeSubDisplayEl) {
        feeSubDisplayEl.textContent = isFull
          ? 'Full Tuition Fee · 14-Day Full Refund Guarantee'
          : '2 Equal Installments · 14-Day Full Refund Guarantee';
      }
    };

    if (btnFeeFull && btnFeeInstall) {
      btnFeeFull.addEventListener('click', () => setFeePlan(true));
      btnFeeInstall.addEventListener('click', () => setFeePlan(false));
    }

    // Cohort B Tuition Switcher
    const tuitionSwitcherBtns = Array.from(document.querySelectorAll('.c-tuition-switcher__btn'));
    if (tuitionSwitcherBtns.length) {
      tuitionSwitcherBtns.forEach((btn) => {
        btn.addEventListener('click', () => {
          const mode = btn.getAttribute('data-tuition-mode') || 'full';
          tuitionSwitcherBtns.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('is-active', isTarget);
            b.setAttribute('aria-pressed', String(isTarget));
          });
          const fullDisplay = document.querySelector('[data-tuition-display="full"]');
          const installDisplay = document.querySelector('[data-tuition-display="installment"]');
          if (fullDisplay && installDisplay) {
            if (mode === 'full') {
              fullDisplay.classList.remove('is-hidden');
              installDisplay.classList.add('is-hidden');
            } else {
              fullDisplay.classList.add('is-hidden');
              installDisplay.classList.remove('is-hidden');
            }
          }
        });
      });
    }

    /* ------------------------------------------------------------------------
       7. Interactive Batch Slot Selector
       ------------------------------------------------------------------------ */
    const batchButtons = Array.from(document.querySelectorAll('.c-batch-slot-btn'));
    const slotTitleDisplay = document.getElementById('batch-slot-title');
    const seatsBadgeDisplay = document.getElementById('batch-seats-badge');
    const audienceNoteDisplay = document.getElementById('batch-audience-note');
    const waBookingCta = document.getElementById('card-wa-cta');

    const BATCH_SPECS = {
      morning: {
        title: 'Morning Batch (10:00 AM – 12:30 PM)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Ideal for fresh graduates, job seekers & morning learners in Sheikhupura.',
        slotName: 'Morning 10:00 AM'
      },
      afternoon: {
        title: 'Afternoon Batch (3:00 PM – 5:00 PM)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Popular with university students & commuters from Farooqabad and Safdarabad.',
        slotName: 'Afternoon 3:00 PM'
      },
      evening: {
        title: 'Evening Batch (6:00 PM – 8:00 PM)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Designed for professionals, job holders & business owners in Sheikhupura.',
        slotName: 'Evening 6:00 PM'
      },
      weekend: {
        title: 'Weekend Commuter Batch (Sat & Sun)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Tailored for commuters traveling from Muridke, Nankana Sahib, Farooqabad & Safdarabad.',
        slotName: 'Weekend Commuter'
      }
    };

    if (batchButtons.length) {
      batchButtons.forEach((btn) => {
        btn.addEventListener('click', () => {
          const key = btn.getAttribute('data-batch') || 'morning';
          const info = BATCH_SPECS[key];
          if (!info) return;

          batchButtons.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
          });

          if (slotTitleDisplay) slotTitleDisplay.textContent = info.title;
          if (seatsBadgeDisplay) seatsBadgeDisplay.textContent = info.seats;
          if (audienceNoteDisplay) audienceNoteDisplay.textContent = info.note;

          if (waBookingCta) {
            const msg = `Assalam-o-Alaikum OneSkills Academy! I would like to book a Free Demo Session for the ${courseTitle} (${info.slotName} Batch) in Sheikhupura.`;
            waBookingCta.href = `https://wa.me/${waNumber}?text=${encodeURIComponent(msg)}`;
          }
        });
      });
    }

    /* ------------------------------------------------------------------------
       8. Commuter Town Transit Selector
       ------------------------------------------------------------------------ */
    const townButtons = Array.from(document.querySelectorAll('.c-town-btn'));
    const mapRouteBadge = document.getElementById('map-route-badge');
    const townTitle = document.getElementById('town-commute-title');
    const townDesc = document.getElementById('town-commute-desc');

    const TOWN_SPECS = {
      skp: {
        badge: '📍 Sheikhupura Central (2–8 mins)',
        title: 'Sheikhupura City, Housing Colony, Civil Lines & Batti Chowk',
        desc: 'Located directly on Main Lahore–Sargodha Road (Opposite Mian Hospital, near KIPS College). Morning, Afternoon, and Evening batches available.'
      },
      farooqabad: {
        badge: '🚌 Farooqabad Direct Corridor (18–22 mins)',
        title: 'Direct Highway Transit for Farooqabad Students',
        desc: 'Direct transport from Farooqabad stops outside Mian Hospital / KIPS College on Main Sargodha Road without city congestion. Recommended: Afternoon or Weekend batch.'
      },
      safdarabad: {
        badge: '🚌 Safdarabad Transit Line (35–40 mins)',
        title: 'Straight Road Route for Safdarabad Students',
        desc: 'Convenient direct commute down the Sargodha Road corridor into Sheikhupura. Recommended: Afternoon (3:00 PM) or Weekend cohorts.'
      },
      muridke: {
        badge: '🚗 Muridke & GT Road Belt (30–35 mins)',
        title: 'Direct Link for Muridke & GT Road Students',
        desc: 'Fast inter-district access to hands-on practical academy facilities not available in general computer institutes.'
      },
      nankana: {
        badge: '🚌 Nankana Sahib Commuter Route (35–45 mins)',
        title: 'Dedicated Schedules for Nankana Sahib Learners',
        desc: 'Attend practical weekend or 3-day batches with direct highway connection and mentor support between sessions.'
      }
    };

    if (townButtons.length) {
      townButtons.forEach((btn) => {
        btn.addEventListener('click', () => {
          const key = btn.getAttribute('data-town') || 'skp';
          const data = TOWN_SPECS[key];
          if (!data) return;

          townButtons.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-pressed', String(isTarget));
            b.setAttribute('aria-selected', String(isTarget));
          });

          if (mapRouteBadge) mapRouteBadge.textContent = data.badge;
          if (townTitle) townTitle.textContent = data.title;
          if (townDesc) townDesc.textContent = data.desc;
        });
      });
    }

    /* ------------------------------------------------------------------------
       9. Demo Booking Form Submission
       ------------------------------------------------------------------------ */
    const demoBookingForm = document.getElementById('demo-booking-form');
    if (demoBookingForm) {
      demoBookingForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const nameInput = document.getElementById('student-name');
        const name = (nameInput && nameInput.value ? nameInput.value : 'Prospective Student').trim();
        const city = (document.getElementById('student-city') || {}).value || 'Sheikhupura';
        const batch = (document.getElementById('student-batch') || {}).value || 'Morning';

        const msg = `Assalam-o-Alaikum OneSkills Academy! My name is ${name} from ${city}. I want to reserve a Free Demo Seat for the ${courseTitle} (${batch} Batch).`;
        const waUrl = `https://wa.me/${waNumber}?text=${encodeURIComponent(msg)}`;

        showToast(`Opening WhatsApp demo pass for ${name}...`);
        window.open(waUrl, '_blank', 'noopener,noreferrer');
      });
    }

    /* ------------------------------------------------------------------------
       10. Clipboard Copy Utility Triggers
       ------------------------------------------------------------------------ */
    const btnCopyCurriculum = document.getElementById('btn-copy-full-curriculum');
    if (btnCopyCurriculum) {
      btnCopyCurriculum.addEventListener('click', () => {
        const aeoSummaryEl = document.querySelector('.c-aeo-summary-text, .c-aeo-text');
        const textToCopy = aeoSummaryEl ? aeoSummaryEl.innerText.trim() : `${courseTitle} at OneSkills Academy Sheikhupura`;
        copyText(textToCopy, 'Course syllabus overview copied to clipboard!');
      });
    }

    /* ------------------------------------------------------------------------
       11. Cohort B Commuter Tabs & Route Switching
       ------------------------------------------------------------------------ */
    const commuterTabs = Array.from(document.querySelectorAll('.c-commuter-tab'));
    if (commuterTabs.length) {
      commuterTabs.forEach((tab) => {
        tab.addEventListener('click', () => {
          const route = tab.getAttribute('data-route') || 'skp';
          commuterTabs.forEach((t) => {
            const isTarget = t === tab;
            t.classList.toggle('is-active', isTarget);
            t.setAttribute('aria-selected', String(isTarget));
          });
          const routePanels = Array.from(document.querySelectorAll('.c-route-info'));
          routePanels.forEach((panel) => {
            const isMatch = panel.getAttribute('data-route-content') === route;
            panel.classList.toggle('is-active', isMatch);
          });
        });
      });
    }

    /* ------------------------------------------------------------------------
       12. Theme Toggle Controller (Light / Dark)
       ------------------------------------------------------------------------ */
    const themeBtns = Array.from(document.querySelectorAll('.theme-toggle, .theme-toggle-btn, #theme-toggle'));
    if (themeBtns.length) {
      themeBtns.forEach((btn) => {
        btn.addEventListener('click', () => {
          const currentTheme = document.documentElement.getAttribute('data-theme') ||
                              document.body.getAttribute('data-theme') ||
                              (window.matchMedia && window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
          const nextTheme = currentTheme === 'dark' ? 'light' : 'dark';
          document.documentElement.setAttribute('data-theme', nextTheme);
          document.body.setAttribute('data-theme', nextTheme);
          try {
            localStorage.setItem('oneskills-theme', nextTheme);
          } catch (e) {}
        });
      });
    }

    /* ------------------------------------------------------------------------
       13. Master Catalog Hub Filter & Search Controller (`courses/index.html`)
       ------------------------------------------------------------------------ */
    const catalogTabs = Array.from(document.querySelectorAll('.catalog-tab-btn'));
    const catalogSearchInput = document.getElementById('catalog-search');
    const catalogCards = Array.from(document.querySelectorAll('.catalog-grid .c-card'));

    const runCatalogFilter = () => {
      const activeTab = document.querySelector('.catalog-tab-btn.is-active');
      const cat = activeTab ? (activeTab.getAttribute('data-cat') || 'all') : 'all';
      const q = catalogSearchInput ? catalogSearchInput.value.trim().toLowerCase() : '';

      catalogCards.forEach((card) => {
        const cardCat = (card.getAttribute('data-category') || '').toLowerCase();
        const cardText = card.textContent.toLowerCase();
        const matchesCat = cat === 'all' || cardCat.indexOf(cat) !== -1;
        const matchesQ = !q || cardText.indexOf(q) !== -1;
        card.style.display = (matchesCat && matchesQ) ? 'flex' : 'none';
      });
    };

    if (catalogTabs.length) {
      catalogTabs.forEach((tab) => {
        tab.addEventListener('click', () => {
          catalogTabs.forEach((t) => t.classList.remove('is-active'));
          tab.classList.add('is-active');
          runCatalogFilter();
        });
      });
    }

    if (catalogSearchInput) {
      catalogSearchInput.addEventListener('input', runCatalogFilter);
    }
  });
})();

