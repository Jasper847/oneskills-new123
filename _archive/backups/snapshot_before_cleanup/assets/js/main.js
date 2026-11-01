    'use strict';
    document.documentElement.classList.add('js');
    const isReducedMotion = () => matchMedia('(prefers-reduced-motion: reduce)').matches;

    /* ---- Footer Back to Top Smooth Scroll ---- */
    (() => {
      const btt = document.getElementById('footer-back-to-top');
      if (!btt) return;
      btt.addEventListener('click', (e) => {
        e.preventDefault();
        window.scrollTo({ top: 0, behavior: isReducedMotion() ? 'instant' : 'smooth' });
      });
    })();

    /* ---- Header Scroll & Glassmorphism Transition (rAF Throttled) ---- */
    (() => {
      const header = document.getElementById('site-header');
      if (!header) return;

      let ticking = false;
      const updateHeader = () => {
        if (!ticking) {
          requestAnimationFrame(() => {
            header.classList.toggle('scrolled', window.scrollY > 20);
            ticking = false;
          });
          ticking = true;
        }
      };
      window.addEventListener('scroll', updateHeader, { passive: true });
      updateHeader();
    })();

    /* ---- Navigation Scroll-Spy ---- */
    (() => {
      const navLinks = document.querySelectorAll('.primary-nav .nav-link');
      const sections = document.querySelectorAll('section[id], main[id]');
      if (!navLinks.length || !sections.length) return;

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            const id = entry.target.getAttribute('id');
            navLinks.forEach(link => {
              const href = link.getAttribute('href');
              const isMatch = href === `#${id}` || (id === 'home' && href === '#home');
              link.classList.toggle('active', isMatch);
            });
          }
        });
      }, { rootMargin: '-20% 0px -60% 0px' });

      sections.forEach(sec => observer.observe(sec));
    })();

    /* ---- Mobile Navigation & Accessible Focus Management ---- */
    (() => {
      const btn = document.getElementById('hamburger-btn');
      const nav = document.getElementById('primary-nav');
      const overlay = document.getElementById('nav-overlay');
      if (!btn || !nav || !overlay) return;

      const navLinks = nav.querySelectorAll('a');
      let isOpen = false;

      const setNav = (openState) => {
        isOpen = openState;
        btn.setAttribute('aria-expanded', String(openState));
        btn.setAttribute('aria-label', openState ? 'Close navigation menu' : 'Open navigation menu');
        nav.classList.toggle('nav-open', openState);
        overlay.classList.toggle('overlay-open', openState);
        document.body.style.overflow = openState ? 'hidden' : '';

        // Prevent keyboard focus on closed mobile navigation
        const isMobile = window.innerWidth <= 900;
        navLinks.forEach(link => {
          if (isMobile && !openState) {
            link.setAttribute('tabindex', '-1');
          } else {
            link.removeAttribute('tabindex');
          }
        });
      };

      // Initial check
      if (window.innerWidth <= 900) {
        navLinks.forEach(link => link.setAttribute('tabindex', '-1'));
      }

      btn.addEventListener('click', () => setNav(!isOpen));
      overlay.addEventListener('click', () => setNav(false));

      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && isOpen) setNav(false);
      });

      navLinks.forEach(link => {
        link.addEventListener('click', () => setNav(false));
      });

      window.addEventListener('resize', () => {
        if (window.innerWidth > 900) {
          if (isOpen) setNav(false);
          navLinks.forEach(link => link.removeAttribute('tabindex'));
        } else if (!isOpen) {
          navLinks.forEach(link => link.setAttribute('tabindex', '-1'));
        }
      }, { passive: true });
    })();

    /* ---- Standalone Floating Icons (Pure Visual Symbols) ---- */

    /* ---- Hero Decorative Animation Performance Optimizer ---- */
    (() => {
      const hero = document.getElementById('home');
      const portalRings = document.querySelector('.mascot-portal-rings');
      const mascotFrame = document.getElementById('mascot-frame');
      if (!hero || (!portalRings && !mascotFrame)) return;

      const setAnimationRunning = (running) => {
        const state = running ? 'running' : 'paused';
        if (portalRings) {
          portalRings.querySelectorAll('.portal-ring').forEach(r => r.style.animationPlayState = state);
        }
        if (mascotFrame) {
          mascotFrame.style.animationPlayState = state;
        }
      };

      if ('IntersectionObserver' in window) {
        const observer = new IntersectionObserver((entries) => {
          entries.forEach(entry => {
            setAnimationRunning(entry.isIntersecting && !document.hidden);
          });
        }, { threshold: 0.05 });
        observer.observe(hero);
      }

      document.addEventListener('visibilitychange', () => {
        if (document.hidden) {
          setAnimationRunning(false);
        } else if (hero.getBoundingClientRect().bottom > 0 && hero.getBoundingClientRect().top < window.innerHeight) {
          setAnimationRunning(true);
        }
      });
    })();

    /* ---- Official Hero Mascot (Static & Intact Asset — No Artificial Image Distortion) ---- */

    /* ---- 2030 3D Interactive Card Tilt Physics (Optimized Layout) ---- */
    (() => {
      if (isReducedMotion() || matchMedia('(hover: none)').matches) return;
      const cards = document.querySelectorAll('.tilt-card');

      cards.forEach(card => {
        let rect = null;
        let ticking = false;

        card.addEventListener('mouseenter', () => {
          rect = card.getBoundingClientRect();
        });

        card.addEventListener('mousemove', e => {
          if (!rect) rect = card.getBoundingClientRect();
          if (!ticking) {
            requestAnimationFrame(() => {
              const x = e.clientX - rect.left;
              const y = e.clientY - rect.top;
              const centerX = rect.width / 2;
              const centerY = rect.height / 2;
              const rotateX = ((y - centerY) / centerY) * -6;
              const rotateY = ((x - centerX) / centerX) * 6;

              card.style.transform = `perspective(1000px) rotateX(${rotateX.toFixed(2)}deg) rotateY(${rotateY.toFixed(2)}deg) translateZ(6px)`;
              ticking = false;
            });
            ticking = true;
          }
        });

        card.addEventListener('mouseleave', () => {
          rect = null;
          card.style.transform = 'perspective(1000px) rotateX(0deg) rotateY(0deg) translateZ(0px)';
        });
      });
    })();

    /* ---- Dynamic Course Category Filter Tabs (with animation) ---- */
    (() => {
      const tabs = document.querySelectorAll('#filter-tabs .filter-btn');
      const flagship = document.querySelector('.course-card-flagship');
      const grid = document.querySelector('.courses-grid-cards');
      const standardCards = document.querySelectorAll('.courses-grid-cards .course-card-standard');
      if (!tabs.length || !standardCards.length) return;

      tabs.forEach(tab => {
        tab.addEventListener('click', () => {
          tabs.forEach(t => {
            t.classList.remove('active');
            t.setAttribute('aria-selected', 'false');
          });
          tab.classList.add('active');
          tab.setAttribute('aria-selected', 'true');

          const filter = tab.dataset.filter;
          const isAll = filter === 'all';

          if (grid) {
            if (isAll) {
              grid.classList.remove('is-filtered');
            } else {
              grid.classList.add('is-filtered');
            }
          }

          // Flagship card handling
          if (flagship) {
            const flagshipCategories = (flagship.dataset.category || '').split(/\s+/);
            const matchesFlagship = isAll || flagshipCategories.includes(filter);
            if (matchesFlagship) {
              flagship.classList.remove('hidden-card');
              if (!isReducedMotion()) {
                flagship.classList.remove('card-animate-in');
                void flagship.offsetWidth;
                flagship.classList.add('card-animate-in');
              }
            } else {
              flagship.classList.add('hidden-card');
            }
          }

          // Standard cards handling
          let visibleCount = 0;
          standardCards.forEach(card => {
            const categories = (card.dataset.category || '').split(/\s+/);
            const matches = isAll || categories.includes(filter);
            if (matches) {
              card.classList.remove('hidden-card');
              if (!isReducedMotion()) {
                card.classList.remove('card-animate-in');
                void card.offsetWidth;
                card.style.animationDelay = `${visibleCount * 0.04}s`;
                card.classList.add('card-animate-in');
              }
              visibleCount++;
            } else {
              card.classList.add('hidden-card');
            }
          });
        });
      });
    })();

    /* ---- Hero Dashboard Progress Fills ---- */
    (() => {
      const fills = document.querySelectorAll('.course-fill');
      if (!fills.length) return;

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            // Use scaleX on the compositor thread instead of layout-triggering width
            const pct = parseFloat(entry.target.dataset.w) / 100;
            entry.target.style.transform = `scaleX(${pct})`;
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.3 });

      fills.forEach(fill => observer.observe(fill));
    })();

    /* ---- IntersectionObserver Reveal (Sections 01 - 08) ---- */
    (() => {
      if (isReducedMotion()) return;
      const reveals = [...document.querySelectorAll('.reveal')];
      if (!reveals.length) return;

      const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
          if (entry.isIntersecting) {
            entry.target.classList.add('show');
            observer.unobserve(entry.target);
          }
        });
      }, { threshold: 0.05 });

      reveals.forEach(el => observer.observe(el));
    })();

    /* ---- Sticky Mobile CTA Bar ---- */
    (() => {
      const bar = document.querySelector('.sticky-cta');
      if (!bar) return;

      let lastScrollY = 0;
      let ticking = false;

      const onScroll = () => {
        lastScrollY = window.scrollY;
        if (!ticking) {
          requestAnimationFrame(() => {
            bar.classList.toggle('visible', lastScrollY > 500);
            ticking = false;
          });
          ticking = true;
        }
      };

      window.addEventListener('scroll', onScroll, { passive: true });
    })();

    /* ---- Light / Dark Theme Controller ---- */
    (() => {
      const btn = document.getElementById('theme-toggle');
      const mobileBtn = document.getElementById('mobile-theme-btn');
      const metaTheme = document.getElementById('meta-theme-color');
      if (!btn) return;

      const getTheme = () => document.documentElement.getAttribute('data-theme') || 'dark';

      const updateToggleAria = (theme) => {
        const isLight = theme === 'light';
        const label = isLight ? 'Switch to dark theme' : 'Switch to light theme';
        btn.setAttribute('aria-label', label);
        btn.setAttribute('title', label);
        if (mobileBtn) {
          mobileBtn.setAttribute('aria-label', label);
          const icon = mobileBtn.querySelector('.mobile-theme-icon');
          if (icon) icon.textContent = isLight ? '🌙 Dark' : '☀️ Light';
        }
      };

      updateToggleAria(getTheme());

      if (mobileBtn) {
        mobileBtn.addEventListener('click', () => btn.click());
      }

      btn.addEventListener('click', () => {
        document.documentElement.classList.add('theme-transitioning');
        const current = getTheme();
        const next = current === 'dark' ? 'light' : 'dark';

        document.documentElement.setAttribute('data-theme', next);
        localStorage.setItem('theme', next);

        if (metaTheme) {
          metaTheme.setAttribute('content', next === 'light' ? '#faf8ff' : '#090614');
        }

        updateToggleAria(next);

        setTimeout(() => {
          document.documentElement.classList.remove('theme-transitioning');
        }, 400);
      });

      // Listen for OS theme preference changes if user hasn't manually set a preference
      window.matchMedia('(prefers-color-scheme: dark)').addEventListener('change', (e) => {
        if (!localStorage.getItem('theme')) {
          const newTheme = e.matches ? 'dark' : 'light';
          document.documentElement.setAttribute('data-theme', newTheme);
          if (metaTheme) metaTheme.setAttribute('content', newTheme === 'light' ? '#faf8ff' : '#090614');
          updateToggleAria(newTheme);
        }
      });
    })();

    /* ---- Video Demo Modal Controller ---- */
    (() => {
      const watchBtn = document.getElementById('btn-watch-demo');
      const overlay = document.getElementById('video-modal-overlay');
      if (!watchBtn || !overlay) return;

      const closeBtn = document.getElementById('video-modal-close');
      const videoPlayer = document.getElementById('demo-video-player');

      const openVideoModal = () => {
        overlay.classList.add('modal-open');
        overlay.setAttribute('aria-hidden', 'false');
        overlay.inert = false;
        watchBtn.setAttribute('aria-expanded', 'true');
        document.body.style.overflow = 'hidden';
        if (videoPlayer) {
          videoPlayer.currentTime = 0;
          videoPlayer.play().catch(() => { });
        }
        if (closeBtn) closeBtn.focus();
      };

      const closeVideoModal = () => {
        overlay.classList.remove('modal-open');
        overlay.setAttribute('aria-hidden', 'true');
        overlay.inert = true;
        watchBtn.setAttribute('aria-expanded', 'false');
        document.body.style.overflow = '';
        if (videoPlayer) {
          videoPlayer.pause();
        }
        watchBtn.focus();
      };

      watchBtn.addEventListener('click', openVideoModal);
      if (closeBtn) closeBtn.addEventListener('click', closeVideoModal);

      overlay.addEventListener('click', (e) => {
        if (e.target === overlay) closeVideoModal();
      });

      overlay.addEventListener('keydown', (e) => {
        if (e.key === 'Tab') {
          const focusables = overlay.querySelectorAll('button, [href], video, input, select, textarea, [tabindex]:not([tabindex="-1"])');
          if (focusables.length === 0) return;
          const first = focusables[0];
          const last = focusables[focusables.length - 1];
          if (e.shiftKey) {
            if (document.activeElement === first) {
              e.preventDefault();
              last.focus();
            }
          } else {
            if (document.activeElement === last) {
              e.preventDefault();
              first.focus();
            }
          }
        }
      });

      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && overlay.classList.contains('modal-open')) {
          closeVideoModal();
        }
      });
    })();

    /* ---- Section 04: Refined Mentor Network Orbital Engine ---- */
    (() => {
      const stage = document.getElementById('mentor-stage');
      const pods = document.querySelectorAll('.mentor-pod');
      const arena = document.getElementById('mentor-orbit-arena');
      const section = document.getElementById('instructors');
      if (!stage || pods.length === 0 || !arena) return;

      // Base angles matching the mockup positions:
      // Webio: -120deg (Top-Left), Hussnain: -60deg (Top-Right), Rubbi: 0deg (Right),
      // Asghar: 60deg (Bottom-Right), Bilal: 120deg (Bottom-Left), Attique: 180deg (Left)
      const baseAngles = [-2 * Math.PI / 3, -Math.PI / 3, 0, Math.PI / 3, 2 * Math.PI / 3, Math.PI];

      let isPaused = false;
      let isVisible = true;
      let time = 0;

      function isMobile() {
        return window.innerWidth <= 640;
      }

      function getRadius() {
        const stageWidth = stage.offsetWidth || 530;
        return stageWidth / 2;
      }

      function positionPods(driftAngle) {
        if (isMobile()) {
          pods.forEach(pod => { pod.style.transform = ''; });
          return;
        }

        const radius = getRadius();
        pods.forEach((pod, index) => {
          const baseAngle = baseAngles[index] !== undefined ? baseAngles[index] : (index * (2 * Math.PI / pods.length));
          const podAngle = baseAngle + driftAngle;
          const x = Math.cos(podAngle) * radius;
          const y = Math.sin(podAngle) * radius;
          pod.style.transform = `translate3d(${x.toFixed(2)}px, ${y.toFixed(2)}px, 0)`;
        });
      }

      // Initial layout (exact mockup alignment)
      positionPods(0);

      // Subtle breathing drift (calm, elegant, never collides with boundaries)
      function renderOrbit() {
        if (!isReducedMotion() && !isMobile() && !isPaused && isVisible && !document.hidden) {
          time += 0.012;
          const drift = Math.sin(time) * 0.035; // gentle +/- 2 degree micro-sway
          positionPods(drift);
        }
        requestAnimationFrame(renderOrbit);
      }

      if (!isReducedMotion() && !isMobile()) {
        requestAnimationFrame(renderOrbit);
      }

      // Hover controls: pause on arena or pod hover
      arena.addEventListener('mouseenter', () => { isPaused = true; }, { passive: true });
      arena.addEventListener('mouseleave', () => { isPaused = false; }, { passive: true });
      pods.forEach(pod => {
        pod.addEventListener('focus', () => { isPaused = true; });
        pod.addEventListener('blur', () => { isPaused = false; });
      });

      // Viewport IntersectionObserver for performance
      if ('IntersectionObserver' in window && section) {
        const observer = new IntersectionObserver((entries) => {
          entries.forEach(entry => {
            isVisible = entry.isIntersecting;
          });
        }, { threshold: 0.05 });
        observer.observe(section);
      }

      // Tab visibility change
      document.addEventListener('visibilitychange', () => {
        if (document.hidden) {
          isVisible = false;
        } else if (section) {
          const rect = section.getBoundingClientRect();
          isVisible = (rect.bottom > 0 && rect.top < window.innerHeight);
        }
      });

      // Resize listener to adapt radius or clear transforms on mobile
      let resizeTimer;
      window.addEventListener('resize', () => {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(() => {
          positionPods(0);
        }, 100);
      }, { passive: true });
    })();

    /* ---- Section 05: Student Stories Carousel & Google Review Modal Controller ---- */
    (() => {
      // 1. Google Review Modal
      const backdrop = document.getElementById('review-modal-backdrop');
      const closeBtn = document.getElementById('modal-close-btn');
      const avatar = document.getElementById('modal-avatar');
      const name = document.getElementById('modal-reviewer-name');
      const course = document.getElementById('modal-course-badge');
      const fullText = document.getElementById('modal-full-text');
      const interactiveCards = document.querySelectorAll('.review-interactive-card, .review-marquee-card');
      let lastReviewTrigger = null;

      const openModal = (card) => {
        if (!backdrop) return;
        lastReviewTrigger = card;
        const dName = card.dataset.name;
        const dAvatar = card.dataset.avatar;
        const dColor = card.dataset.color || '#6e44ff,#a855f7';
        const dCourse = card.dataset.course;
        const dFull = card.dataset.full;

        if (!dName) return;

        if (name) name.textContent = dName;
        if (avatar) {
          avatar.textContent = dAvatar;
          avatar.style.background = `linear-gradient(135deg, ${dColor})`;
        }
        if (course) course.textContent = dCourse;
        if (fullText) fullText.textContent = `“${dFull}”`;

        backdrop.classList.add('is-open');
        backdrop.setAttribute('aria-hidden', 'false');
        backdrop.inert = false;
        document.body.style.overflow = 'hidden';
        if (closeBtn) closeBtn.focus();
      };

      const closeModal = () => {
        if (!backdrop) return;
        backdrop.classList.remove('is-open');
        backdrop.setAttribute('aria-hidden', 'true');
        backdrop.inert = true;
        document.body.style.overflow = '';
        if (lastReviewTrigger && typeof lastReviewTrigger.focus === 'function') {
          lastReviewTrigger.focus();
        }
      };

      interactiveCards.forEach(card => {
        card.addEventListener('click', () => openModal(card));
        card.addEventListener('keydown', (e) => {
          if (e.key === 'Enter' || e.key === ' ') {
            e.preventDefault();
            openModal(card);
          }
        });
      });

      if (closeBtn) closeBtn.addEventListener('click', closeModal);
      if (backdrop) {
        backdrop.addEventListener('click', (e) => {
          if (e.target === backdrop) closeModal();
        });
        backdrop.addEventListener('keydown', (e) => {
          if (e.key === 'Tab') {
            const focusables = backdrop.querySelectorAll('button, [href], input, select, textarea, [tabindex]:not([tabindex="-1"])');
            if (focusables.length === 0) return;
            const first = focusables[0];
            const last = focusables[focusables.length - 1];
            if (e.shiftKey) {
              if (document.activeElement === first) {
                e.preventDefault();
                last.focus();
              }
            } else {
              if (document.activeElement === last) {
                e.preventDefault();
                first.focus();
              }
            }
          }
        });
      }
      document.addEventListener('keydown', (e) => {
        if (e.key === 'Escape' && backdrop && backdrop.classList.contains('is-open')) {
          closeModal();
        }
      });

      // 2. Supporting Reviews Carousel
      const track = document.getElementById('reviews-carousel-track');
      const viewport = document.getElementById('reviews-carousel-viewport');
      const prevBtn = document.getElementById('reviews-prev-btn');
      const nextBtn = document.getElementById('reviews-next-btn');
      const dotsContainer = document.getElementById('reviews-dots');
      const cards = track ? track.querySelectorAll('.supporting-review-card') : [];

      if (!track || !cards.length) return;

      let currentIndex = 0;

      const getCardsPerView = () => {
        const w = window.innerWidth;
        if (w <= 768) return 1;
        if (w <= 960) return 2;
        return 3;
      };

      const getMaxIndex = () => {
        const perView = getCardsPerView();
        return Math.max(0, cards.length - perView);
      };

      const updateCarousel = (index) => {
        const maxIndex = getMaxIndex();
        currentIndex = Math.max(0, Math.min(index, maxIndex));

        const card = cards[0];
        if (!card) return;

        const style = window.getComputedStyle(track);
        const gap = parseFloat(style.gap) || 20;
        const cardWidth = card.getBoundingClientRect().width;
        const offset = currentIndex * (cardWidth + gap);

        track.style.transform = `translate3d(-${offset}px, 0, 0)`;

        if (prevBtn) prevBtn.disabled = currentIndex === 0;
        if (nextBtn) nextBtn.disabled = currentIndex >= maxIndex;

        // Update dot pagination
        if (dotsContainer) {
          const dots = dotsContainer.querySelectorAll('.review-dot');
          const totalDots = dots.length;
          if (totalDots > 0) {
            const activeDotIdx = maxIndex > 0 ? Math.round((currentIndex / maxIndex) * (totalDots - 1)) : 0;
            dots.forEach((dot, i) => {
              const isActive = i === activeDotIdx;
              dot.classList.toggle('active', isActive);
              dot.setAttribute('aria-selected', isActive ? 'true' : 'false');
            });
          }
        }
      };

      if (prevBtn) {
        prevBtn.addEventListener('click', () => {
          updateCarousel(currentIndex - 1);
        });
      }

      if (nextBtn) {
        nextBtn.addEventListener('click', () => {
          updateCarousel(currentIndex + 1);
        });
      }

      if (dotsContainer) {
        const dots = dotsContainer.querySelectorAll('.review-dot');
        dots.forEach((dot, idx) => {
          dot.addEventListener('click', () => {
            const maxIndex = getMaxIndex();
            const target = Math.round((idx / (dots.length - 1)) * maxIndex);
            updateCarousel(target);
          });
        });
      }

      // Touch / Swipe Navigation
      if (viewport) {
        let touchStartX = 0;
        let touchEndX = 0;
        viewport.addEventListener('touchstart', (e) => {
          touchStartX = e.changedTouches[0].screenX;
        }, { passive: true });

        viewport.addEventListener('touchend', (e) => {
          touchEndX = e.changedTouches[0].screenX;
          const diff = touchStartX - touchEndX;
          if (Math.abs(diff) > 40) {
            if (diff > 0) {
              updateCarousel(currentIndex + 1);
            } else {
              updateCarousel(currentIndex - 1);
            }
          }
        }, { passive: true });
      }

      // Keyboard navigation on carousel container
      if (viewport) {
        viewport.setAttribute('tabindex', '0');
        viewport.setAttribute('aria-label', 'Student reviews carousel. Use Left and Right arrow keys to navigate.');
        viewport.addEventListener('keydown', (e) => {
          if (e.key === 'ArrowLeft') {
            e.preventDefault();
            updateCarousel(currentIndex - 1);
          } else if (e.key === 'ArrowRight') {
            e.preventDefault();
            updateCarousel(currentIndex + 1);
          }
        });
      }

      // Handle Resize
      let resizeTimer;
      window.addEventListener('resize', () => {
        clearTimeout(resizeTimer);
        resizeTimer = setTimeout(() => {
          updateCarousel(currentIndex);
        }, 120);
      }, { passive: true });

      // Focus parameter support for testing/scrolling
      if (window.location.search.includes('focus=reviews') || window.location.hash === '#reviews') {
        const r = document.getElementById('reviews');
        if (r) {
          setTimeout(() => {
            r.scrollIntoView({ behavior: 'instant', block: 'start' });
          }, 80);
        }
      }

      // Initial alignment
      updateCarousel(0);
    })();

    /* ---- Section 06: FAQ Category Filter & Single-Open Accordion ---- */
    (() => {
      const filterBtns = document.querySelectorAll('.faq-filter-row .filter-btn');
      const items = document.querySelectorAll('.faq-accordion-stack .faq-item');
      if (filterBtns.length && items.length) {
        filterBtns.forEach(btn => {
          btn.addEventListener('click', () => {
            filterBtns.forEach(b => {
              b.classList.remove('active');
              b.setAttribute('aria-selected', 'false');
            });
            btn.classList.add('active');
            btn.setAttribute('aria-selected', 'true');

            const target = btn.dataset.category;
            items.forEach(item => {
              const itemCat = item.dataset.category;
              if (target === 'all' || itemCat === target) {
                item.classList.remove('hidden-item');
              } else {
                item.classList.add('hidden-item');
              }
            });
          });
        });
      }

      if (items.length) {
        items.forEach(targetDetail => {
          targetDetail.addEventListener('toggle', () => {
            if (targetDetail.open) {
              items.forEach(detail => {
                if (detail !== targetDetail && detail.open) {
                  detail.open = false;
                }
              });
            }
          });
        });
      }
    })();

    /* Graceful fallback for method images if opened via file:// */
    if (window.location.protocol === 'file:') {
      document.querySelectorAll('.method-section img[src^="/"]').forEach(img => {
        img.addEventListener('error', () => {
          img.src = img.getAttribute('src').replace(/^\//, '');
        }, { once: true });
      });
    }

    /* Update section coordinates for QA inspection */
    const updateSectionCoords = () => {
      const getDocTop = (el) => {
        let top = 0;
        let curr = el;
        while (curr) {
          top += curr.offsetTop || 0;
          curr = curr.offsetParent;
        }
        return top;
      };

      const s = document.getElementById('instructors');
      if (s) {
        s.dataset.top = Math.round(getDocTop(s));
        s.dataset.height = Math.round(s.offsetHeight);
      }
      const rev = document.getElementById('reviews');
      if (rev) {
        rev.dataset.top = Math.round(getDocTop(rev));
        rev.dataset.height = Math.round(rev.offsetHeight);
      }
      const faq = document.getElementById('faq');
      if (faq) {
        faq.dataset.top = Math.round(getDocTop(faq));
        faq.dataset.height = Math.round(faq.offsetHeight);
      }
      const cta = document.getElementById('contact');
      if (cta) {
        cta.dataset.top = Math.round(getDocTop(cta));
        cta.dataset.height = Math.round(cta.offsetHeight);
      }
      const campus = document.getElementById('campus');
      if (campus) {
        campus.dataset.top = Math.round(getDocTop(campus));
        campus.dataset.height = Math.round(campus.offsetHeight);
      }
    };
    window.addEventListener('DOMContentLoaded', updateSectionCoords);
    window.addEventListener('load', updateSectionCoords);
    setTimeout(updateSectionCoords, 500);

    if (window.location.search.includes('focus=faq') || window.location.hash === '#faq') {
      const f = document.getElementById('faq');
      if (f) {
        setTimeout(() => {
          f.scrollIntoView({ behavior: 'instant', block: 'start' });
        }, 80);
      }
    }
    if (window.location.search.includes('focus=contact') || window.location.hash === '#contact') {
      const c = document.getElementById('contact');
      if (c) {
        setTimeout(() => {
          c.scrollIntoView({ behavior: 'instant', block: 'start' });
        }, 80);
      }
    }
    if (window.location.search.includes('focus=campus') || window.location.hash === '#campus') {
      const camp = document.getElementById('campus');
      if (camp) {
        setTimeout(() => {
          camp.scrollIntoView({ behavior: 'instant', block: 'start' });
        }, 80);
      }
    }
    if (window.location.search.includes('focus=footer') || window.location.hash === '#footer') {
      const foot = document.getElementById('footer');
      if (foot) {
        setTimeout(() => {
          foot.scrollIntoView({ behavior: 'instant', block: 'start' });
        }, 80);
      }
    }

    /* Campus Real Interactive Lightweight Map (Leaflet.js + CartoDB) */
    (function initCampusMap() {
      const mapContainer = document.getElementById('campus-real-map');
      if (!mapContainer) return;

      const lat = 31.7214862;
      const lng = 73.9426348;
      let map = null;
      let currentTileLayer = null;

      function getTileConfig() {
        const isDark = document.documentElement.getAttribute('data-theme') === 'dark';
        const url = isDark
          ? 'https://{s}.basemaps.cartocdn.com/dark_all/{z}/{x}/{y}{r}.png'
          : 'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}{r}.png';
        return {
          url: url,
          options: {
            attribution: '&copy; <a href="https://www.openstreetmap.org/copyright" target="_blank" rel="noopener">OSM</a> &copy; <a href="https://carto.com/attributions" target="_blank" rel="noopener">CARTO</a>',
            subdomains: 'abcd',
            maxZoom: 19
          }
        };
      }

      function createMap() {
        if (map || typeof L === 'undefined') return;

        try {
          map = L.map('campus-real-map', {
            center: [lat, lng],
            zoom: 15,
            zoomControl: false,
            scrollWheelZoom: false,
            attributionControl: true
          });

          // Zoom control in top-right to preserve floating badges
          L.control.zoom({ position: 'topright' }).addTo(map);

          // Enable scroll wheel zoom only on user interaction so page scroll is buttery smooth
          map.on('focus', function () { map.scrollWheelZoom.enable(); });
          mapContainer.addEventListener('click', function () { map.scrollWheelZoom.enable(); });

          // Tile Layer with dark/light mode support
          const tileConfig = getTileConfig();
          currentTileLayer = L.tileLayer(tileConfig.url, tileConfig.options).addTo(map);

          // Watch theme switch
          const themeObserver = new MutationObserver(function (mutations) {
            mutations.forEach(function (m) {
              if (m.attributeName === 'data-theme' && map && currentTileLayer) {
                map.removeLayer(currentTileLayer);
                const nextConfig = getTileConfig();
                currentTileLayer = L.tileLayer(nextConfig.url, nextConfig.options).addTo(map);
              }
            });
          });
          themeObserver.observe(document.documentElement, { attributes: true });

          // Primary OneSkills Academy Pin
          const oneSkillsIcon = L.divIcon({
            className: 'oneskills-pin-wrapper',
            html: '<div class="oneskills-pin-container">' +
              '<div class="oneskills-pin-pulse"></div>' +
              '<div class="oneskills-pin-body">' +
                '<span class="oneskills-pin-icon">' +
                  '<svg viewBox="0 0 24 24" fill="currentColor">' +
                    '<path d="M12 2C8.13 2 5 5.13 5 9c0 5.25 7 13 7 13s7-7.75 7-13c0-3.87-3.13-7-7-7zm0 9.5a2.5 2.5 0 1 1 0-5 2.5 2.5 0 0 1 0 5z"/>' +
                  '</svg>' +
                '</span>' +
              '</div>' +
              '<div class="oneskills-marker-tag">OneSkills Academy</div>' +
            '</div>',
            iconSize: [38, 38],
            iconAnchor: [19, 32],
            popupAnchor: [0, -32]
          });

          const primaryMarker = L.marker([lat, lng], { icon: oneSkillsIcon }).addTo(map);
          primaryMarker.bindPopup(
            '<div class="campus-map-popup">' +
              '<h4>OneSkills Academy</h4>' +
              '<p>Lahore – Sargodha Road, Sheikhupura</p>' +
              '<a href="https://maps.app.goo.gl/k8ykDNX1Cn9hEi3P7" target="_blank" rel="noopener noreferrer">' +
                'Get Directions &nearr;' +
              '</a>' +
            '</div>'
          );

          // Landmarks for Sheikhupura orientation
          const landmarks = [
            { name: 'KIPS College', coords: [31.7228, 73.9385] },
            { name: 'Punjab College', coords: [31.7198, 73.9372] },
            { name: 'Mian Hospital', coords: [31.7225, 73.9442] },
            { name: 'The Mega Mall', coords: [31.7202, 73.9458] },
            { name: 'Railway Station', coords: [31.7245, 73.9482] }
          ];

          landmarks.forEach(function (lm) {
            const lmIcon = L.divIcon({
              className: 'landmark-pin-wrapper',
              html: '<div class="landmark-pin-container" title="' + lm.name + '">' +
                '<div class="landmark-pin-dot"></div>' +
                '<div class="landmark-marker-label">' + lm.name + '</div>' +
              '</div>',
              iconSize: [20, 20],
              iconAnchor: [10, 10]
            });
            L.marker(lm.coords, { icon: lmIcon }).addTo(map).bindPopup(
              '<strong>' + lm.name + '</strong><br><span style="font-size:11px;color:#666;">Sheikhupura</span>'
            );
          });

          // Recenter Button
          const recenterBtn = document.getElementById('campus-recenter-btn');
          if (recenterBtn) {
            recenterBtn.addEventListener('click', function (e) {
              e.preventDefault();
              e.stopPropagation();
              const prefersReducedMotion = window.matchMedia('(prefers-reduced-motion: reduce)').matches;
              if (prefersReducedMotion) {
                map.setView([lat, lng], 15);
              } else {
                map.flyTo([lat, lng], 15, { animate: true, duration: 0.8 });
              }
            });
          }

          // Ensure container sizing is recalculated cleanly
          setTimeout(function () {
            if (map) map.invalidateSize();
          }, 200);

        } catch (err) {
          console.error('Campus map initialization error:', err);
        }
      }

      // Lazy initialize when section scrolls into view
      if ('IntersectionObserver' in window) {
        const observer = new IntersectionObserver(function (entries, obs) {
          entries.forEach(function (entry) {
            if (entry.isIntersecting) {
              if (typeof L !== 'undefined') {
                createMap();
              } else {
                let attempts = 0;
                const interval = setInterval(function () {
                  attempts++;
                  if (typeof L !== 'undefined') {
                    clearInterval(interval);
                    createMap();
                  } else if (attempts > 40) {
                    clearInterval(interval);
                  }
                }, 50);
              }
              obs.unobserve(entry.target);
            }
          });
        }, { rootMargin: '350px 0px' });

        observer.observe(mapContainer);
      } else {
        window.addEventListener('load', function () {
          setTimeout(createMap, 300);
        });
      }
    })();