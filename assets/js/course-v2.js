/* ============================================================
   ONESKILLS — COURSE V2 INTERACTIVITY LAYER
   Tabs, scroll-spy, and accessibility controls.
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
    if (!document.body.classList.contains('course-v2-page')) return;



    /* ----------------------------------------------------------
       Sticky Course Subnavigation Scroll-Spy
       ---------------------------------------------------------- */
    const subnavLinks = Array.from(document.querySelectorAll('.c-subnav-link'));
    const sections = subnavLinks
      .map((link) => {
        const id = link.getAttribute('href');
        if (id && id.startsWith('#')) {
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
          rootMargin: '-20% 0px -70% 0px',
          threshold: 0
        }
      );

      sections.forEach((section) => observer.observe(section));
    }

    /* ----------------------------------------------------------
       Smooth Anchor Scrolling with Subnav & Header Offset
       ---------------------------------------------------------- */
    const anchorLinks = Array.from(document.querySelectorAll('.c-subnav-link, .c-hero-video-cta, a[href^="#"]:not(.skip-link)'));
    anchorLinks.forEach((link) => {
      link.addEventListener('click', (e) => {
        const href = link.getAttribute('href');
        if (href && href.startsWith('#') && href.length > 1) {
          const target = document.querySelector(href);
          if (target) {
            e.preventDefault();
            const headerOffset = 130;
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

    /* ----------------------------------------------------------
       Mobile Action Dock & Dialog Inert Coordination + Scroll Reveal
       ---------------------------------------------------------- */
    const mobileDock = document.querySelector('.c-mobile-dock');
    const nav = document.getElementById('primary-nav');

    if (mobileDock) {
      const checkDock = () => {
        const menuOpen = Boolean(nav && nav.classList.contains('nav-open'));
        mobileDock.style.display = menuOpen ? 'none' : '';
      };

      if (nav) {
        const observer = new MutationObserver(checkDock);
        observer.observe(nav, { attributes: true, attributeFilter: ['class'] });
      }

      const toggleMobileDock = () => {
        const top = window.scrollY || document.documentElement.scrollTop || (document.body ? document.body.scrollTop : 0) || 0;
        const pastHero = top > 350;
        mobileDock.classList.toggle('visible', pastHero);
      };
      window.addEventListener('scroll', toggleMobileDock, { passive: true });
      window.addEventListener('resize', toggleMobileDock, { passive: true });
      toggleMobileDock();
    }

    /* ----------------------------------------------------------
       Toast Helper & Clipboard Copy
       ---------------------------------------------------------- */
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
      }, 2800);
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
        showToast('Ready to copy');
      }
      document.body.removeChild(ta);
    };

    /* ----------------------------------------------------------
       AEO Course Summary Copy Button
       ---------------------------------------------------------- */
    const copyCurriculumBtn = document.getElementById('btn-copy-full-curriculum');
    if (copyCurriculumBtn) {
      copyCurriculumBtn.addEventListener('click', () => {
        const aeoText = document.querySelector('.c-aeo-summary-text, .c-aeo-text');
        const textToCopy = aeoText ? aeoText.innerText.trim() : 'OneSkills Academy Freelancing & Digital Marketing Mastery Course';
        copyText(textToCopy, 'Complete course overview copied to clipboard!');
      });
    }

    /* ----------------------------------------------------------
       21-Skill Pillar Bento Filter Tabs
       ---------------------------------------------------------- */
    const skillTabs = Array.from(document.querySelectorAll('#skill-pillar-tabs .c-filter-btn, #skill-pillar-tabs .filter-btn'));
    const skillCards = Array.from(document.querySelectorAll('#skills-21-grid .c-skill-pillar-card'));
    const skillCountEl = document.getElementById('skill-pillar-count');

    if (skillTabs.length && skillCards.length) {
      skillTabs.forEach((btn) => {
        btn.addEventListener('click', () => {
          const cat = btn.getAttribute('data-skill-cat') || 'all';
          skillTabs.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
            b.setAttribute('aria-pressed', String(isTarget));
          });

          let visibleCount = 0;
          skillCards.forEach((card) => {
            const group = card.getAttribute('data-skill-group') || '';
            if (cat === 'all' || group.indexOf(cat) !== -1) {
              card.style.display = 'flex';
              visibleCount++;
            } else {
              card.style.display = 'none';
            }
          });
          if (skillCountEl) skillCountEl.textContent = String(visibleCount);
        });
      });
    }

    /* ----------------------------------------------------------
       12-Week Curriculum Filter & Live Search
       ---------------------------------------------------------- */
    const modFilterBtns = Array.from(document.querySelectorAll('#curriculum-filter-tabs .c-filter-btn, #curriculum-filter-tabs .filter-btn'));
    const modAccordions = Array.from(document.querySelectorAll('#syllabus-stack .c-phase-item'));
    const searchInput = document.getElementById('syllabus-search');
    let currentModFilter = 'all';

    const filterModules = () => {
      const q = searchInput ? searchInput.value.trim().toLowerCase() : '';
      modAccordions.forEach((acc) => {
        const cats = (acc.getAttribute('data-mod-cat') || '').toLowerCase();
        const text = acc.textContent.toLowerCase();
        const matchCat = currentModFilter === 'all' || cats.indexOf(currentModFilter) !== -1;
        const matchQ = !q || text.indexOf(q) !== -1;
        if (matchCat && matchQ) {
          acc.style.display = 'block';
          if (q) acc.setAttribute('open', '');
        } else {
          acc.style.display = 'none';
        }
      });
    };

    if (modFilterBtns.length) {
      modFilterBtns.forEach((btn) => {
        btn.addEventListener('click', () => {
          currentModFilter = btn.getAttribute('data-mod-filter') || 'all';
          modFilterBtns.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
            b.setAttribute('aria-pressed', String(isTarget));
          });
          filterModules();
        });
      });
    }

    if (searchInput) {
      searchInput.addEventListener('input', filterModules);
    }

    const btnExpand = document.getElementById('btn-expand-modules');
    const btnCollapse = document.getElementById('btn-collapse-modules');
    if (btnExpand) {
      btnExpand.addEventListener('click', () => {
        modAccordions.forEach((acc) => acc.setAttribute('open', ''));
        showToast('Expanded all 12 curriculum modules (84 lessons)');
      });
    }
    if (btnCollapse) {
      btnCollapse.addEventListener('click', () => {
        modAccordions.forEach((acc) => acc.removeAttribute('open'));
        showToast('Collapsed curriculum modules');
      });
    }

    /* ----------------------------------------------------------
       Interactive Curriculum Blueprint Tabs
       ---------------------------------------------------------- */
    const bpTabBtns = Array.from(document.querySelectorAll('.c-blueprint-tab-btn'));
    const bpPanels = Array.from(document.querySelectorAll('.c-blueprint-panel'));

    if (bpTabBtns.length && bpPanels.length) {
      bpTabBtns.forEach((btn, index) => {
        btn.addEventListener('click', () => {
          const targetId = btn.getAttribute('aria-controls');
          bpTabBtns.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
            b.setAttribute('tabindex', isTarget ? '0' : '-1');
          });
          bpPanels.forEach((panel) => {
            const isTarget = panel.id === targetId;
            panel.classList.toggle('active', isTarget);
            if (isTarget) {
              panel.removeAttribute('hidden');
            } else {
              panel.setAttribute('hidden', '');
            }
          });
        });

        btn.addEventListener('keydown', (e) => {
          let nextIndex = null;
          if (e.key === 'ArrowRight' || e.key === 'ArrowDown') {
            nextIndex = (index + 1) % bpTabBtns.length;
          } else if (e.key === 'ArrowLeft' || e.key === 'ArrowUp') {
            nextIndex = (index - 1 + bpTabBtns.length) % bpTabBtns.length;
          } else if (e.key === 'Home') {
            nextIndex = 0;
          } else if (e.key === 'End') {
            nextIndex = bpTabBtns.length - 1;
          }

          if (nextIndex !== null) {
            e.preventDefault();
            bpTabBtns[nextIndex].focus();
            bpTabBtns[nextIndex].click();
          }
        });
      });
    }

    /* ----------------------------------------------------------
       Interactive Batch Slot Selector
       ---------------------------------------------------------- */
    const BATCH_DATA = {
      morning: {
        title: 'Morning Batch (10:00 AM – 12:30 PM)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Ideal for female students, fresh graduates & morning learners in Sheikhupura.',
        btnLabel: 'Reserve Morning Demo on WhatsApp →',
        waText: 'Assalam-o-Alaikum OneSkills Academy! I want to book a Free Demo Seat for the Freelancing & Digital Marketing Mastery Course (Morning 10:00 AM Batch) in Sheikhupura.'
      },
      afternoon: {
        title: 'Afternoon Batch (3:00 PM – 5:00 PM)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Popular with college/university students & commuters from Farooqabad and Safdarabad.',
        btnLabel: 'Reserve Afternoon Demo on WhatsApp →',
        waText: 'Assalam-o-Alaikum OneSkills Academy! I want to book a Free Demo Seat for the Freelancing & Digital Marketing Mastery Course (Afternoon 3:00 PM Batch) in Sheikhupura.'
      },
      evening: {
        title: 'Evening Batch (6:00 PM – 8:00 PM)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Designed for job holders, business owners & evening learners in Sheikhupura.',
        btnLabel: 'Reserve Evening Demo on WhatsApp →',
        waText: 'Assalam-o-Alaikum OneSkills Academy! I want to book a Free Demo Seat for the Freelancing & Digital Marketing Mastery Course (Evening 6:00 PM Batch) in Sheikhupura.'
      },
      weekend: {
        title: 'Weekend Commuter Batch (Sat & Sun)',
        seats: 'Small batches · Maximum 12 students',
        note: 'Tailored for students traveling from Muridke, Nankana Sahib, Farooqabad & Safdarabad.',
        btnLabel: 'Reserve Weekend Demo on WhatsApp →',
        waText: 'Assalam-o-Alaikum OneSkills Academy! I want to book a Free Demo Seat for the Freelancing & Digital Marketing Mastery Course (Weekend Commuter Batch) in Sheikhupura.'
      }
    };

    const batchBtns = Array.from(document.querySelectorAll('.c-batch-slot-btn'));
    const slotTitleEl = document.getElementById('batch-slot-title');
    const seatsBadgeEl = document.getElementById('batch-seats-badge');
    const audienceNoteEl = document.getElementById('batch-audience-note');
    const cardWaCta = document.getElementById('card-wa-cta');
    const cardWaBtnText = document.getElementById('card-wa-btn-text');

    if (batchBtns.length) {
      batchBtns.forEach((btn) => {
        btn.addEventListener('click', () => {
          const key = btn.getAttribute('data-batch');
          const info = BATCH_DATA[key];
          if (!info) return;
          batchBtns.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
            b.setAttribute('aria-checked', String(isTarget));
          });
          if (slotTitleEl) slotTitleEl.textContent = info.title;
          if (seatsBadgeEl) seatsBadgeEl.textContent = info.seats;
          if (audienceNoteEl) audienceNoteEl.textContent = info.note;
          if (cardWaBtnText) cardWaBtnText.textContent = info.btnLabel;
          if (cardWaCta) {
            cardWaCta.href = 'https://wa.me/923176036127?text=' + encodeURIComponent(info.waText);
          }
        });
      });
    }

    /* ----------------------------------------------------------
       Tuition & Installment Plan Switcher
       ---------------------------------------------------------- */
    const btnFeeFull = document.getElementById('btn-fee-full');
    const btnFeeInstall = document.getElementById('btn-fee-install');
    const feeAmountEl = document.getElementById('fee-display-amount');
    const feeSubEl = document.getElementById('fee-display-sub');

    const updateFeePlan = (isFull) => {
      if (btnFeeFull) {
        btnFeeFull.classList.toggle('active', isFull);
        btnFeeFull.setAttribute('aria-pressed', String(isFull));
      }
      if (btnFeeInstall) {
        btnFeeInstall.classList.toggle('active', !isFull);
        btnFeeInstall.setAttribute('aria-pressed', String(!isFull));
      }
      if (feeAmountEl) feeAmountEl.textContent = isFull ? 'PKR 28,000' : '2 Installments of PKR 14,000';
      if (feeSubEl) feeSubEl.textContent = isFull
        ? 'All-inclusive 12-Week Track · 80+ Practical Hours & AI Workflows'
        : '2 Flexible Installments of PKR 14,000 · 14-Day Full Refund Policy';
    };

    if (btnFeeFull && btnFeeInstall) {
      btnFeeFull.addEventListener('click', () => updateFeePlan(true));
      btnFeeInstall.addEventListener('click', () => updateFeePlan(false));
    }

    /* ----------------------------------------------------------
       Commuter Town Route Selector
       ---------------------------------------------------------- */
    const TOWN_ROUTES = {
      skp: {
        badge: '📍 Sheikhupura Central (2–8 mins)',
        title: 'Sheikhupura City, Housing Colony, Civil Lines & Batti Chowk',
        desc: 'Only 2–8 minutes away on Main Lahore–Sargodha Road (Opposite Mian Hospital, near KIPS College). Morning (10 AM), Afternoon (3 PM), and Evening (6 PM) batches available.'
      },
      farooqabad: {
        badge: '🚌 Farooqabad Direct Route (18–22 mins)',
        title: 'Direct Lahore–Sargodha Road Access for Farooqabad Students',
        desc: 'Public and private transport from Farooqabad drops you directly outside Mian Hospital / KIPS College on Main Sargodha Road without changing vans inside city traffic. Recommended: Afternoon (3 PM) or Weekend batch.'
      },
      safdarabad: {
        badge: '🚌 Safdarabad Corridor (35–40 mins)',
        title: 'Straight Highway Commute for Safdarabad Learners',
        desc: 'Located directly at the main Sargodha Road entrance of Sheikhupura opposite Mian Hospital. Ideal for Afternoon (3:00 PM) or Weekend Intensive cohorts.'
      },
      muridke: {
        badge: '🚗 Muridke & GT Road Belt (30–35 mins)',
        title: 'Advanced AI & Freelancing Labs for Muridke Students',
        desc: 'Easy inter-city access for students seeking hands-on Upwork, Technical SEO, Meta Ads, and AI workflows not taught in traditional institutes. Recommended: Weekend or Afternoon batch.'
      },
      nankana: {
        badge: '🚌 Nankana Sahib Route (35–45 mins)',
        title: 'Weekend & 3-Day Batches for Nankana Sahib Learners',
        desc: 'Join fellow students from Nankana Sahib in our small-batch practical studio with full remote follow-up support between campus sessions.'
      }
    };

    const townBtns = Array.from(document.querySelectorAll('.c-town-btn'));
    const mapRouteBadge = document.getElementById('map-route-badge');
    const townTitle = document.getElementById('town-commute-title');
    const townDesc = document.getElementById('town-commute-desc');
    const citySelect = document.getElementById('student-city');

    if (townBtns.length) {
      townBtns.forEach((btn) => {
        btn.addEventListener('click', () => {
          const key = btn.getAttribute('data-town');
          const data = TOWN_ROUTES[key];
          if (!data) return;
          townBtns.forEach((b) => {
            const isTarget = b === btn;
            b.classList.toggle('active', isTarget);
            b.setAttribute('aria-selected', String(isTarget));
            b.setAttribute('aria-pressed', String(isTarget));
          });
          if (mapRouteBadge) mapRouteBadge.textContent = data.badge;
          if (townTitle) townTitle.textContent = data.title;
          if (townDesc) townDesc.textContent = data.desc;
          if (citySelect) {
            const mapVal = { skp: 'Sheikhupura', farooqabad: 'Farooqabad', safdarabad: 'Safdarabad', muridke: 'Muridke', nankana: 'Nankana Sahib' }[key];
            if (mapVal) citySelect.value = mapVal;
          }
        });
      });
    }

    /* ----------------------------------------------------------
       Instant Demo Booking Form
       ---------------------------------------------------------- */
    const demoForm = document.getElementById('demo-booking-form');
    if (demoForm) {
      demoForm.addEventListener('submit', (e) => {
        e.preventDefault();
        const nameInput = document.getElementById('student-name');
        const name = (nameInput && nameInput.value ? nameInput.value : 'Prospective Student').trim();
        const city = (document.getElementById('student-city') || {}).value || 'Sheikhupura';
        const batch = (document.getElementById('student-batch') || {}).value || 'Morning (10:00 AM)';
        const goal = (document.getElementById('student-goal') || {}).value || 'Freelancing & Digital Marketing';
        const msg = `Assalam-o-Alaikum OneSkills Academy! My name is ${name} from ${city}. I want to reserve a Free Demo Seat for the Freelancing & Digital Marketing Mastery Course (${batch}). My primary goal is: ${goal}.`;
        const waUrl = 'https://wa.me/923176036127?text=' + encodeURIComponent(msg);
        showToast(`Opening WhatsApp Demo Pass for ${name}...`);
        window.open(waUrl, '_blank', 'noopener,noreferrer');
      });
    }

  });
})();

