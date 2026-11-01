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
    const subnavLinks = Array.from(document.querySelectorAll('.c-subnav-link'));
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
    const anchorLinks = Array.from(document.querySelectorAll('.c-subnav-link, a[href^="#"]:not(.skip-link):not([data-no-scroll])'));
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
    const syllabusSearchInput = document.getElementById('syllabus-search');
    let currentPhaseFilter = 'all';

    const filterCurriculum = () => {
      const query = syllabusSearchInput ? syllabusSearchInput.value.trim().toLowerCase() : '';
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
        showToast('All curriculum modules expanded');
      });
    }

    if (btnCollapseAll) {
      btnCollapseAll.addEventListener('click', () => {
        phaseModules.forEach((mod) => mod.removeAttribute('open'));
        showToast('Curriculum modules collapsed');
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
  });
})();

