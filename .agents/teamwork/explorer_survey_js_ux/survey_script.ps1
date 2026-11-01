$courseHtml = Get-Content 'courses/freelancing-mastery.html' -Raw
$courseJs = Get-Content 'assets/js/course-v2.js' -Raw
$mainJs = Get-Content 'assets/js/main.js' -Raw

Write-Host "=== COURSE-V2.JS SELECTOR AUDIT IN freelancing-mastery.html ==="
$selectors = @(
  'c-tab-btn',
  'c-studio-pane',
  'c-subnav-link',
  'c-hero-video-cta',
  'c-mobile-dock',
  'primary-nav',
  'btn-copy-full-curriculum',
  'c-aeo-summary-text',
  'c-aeo-text',
  'skill-pillar-tabs',
  'skills-21-grid',
  'c-skill-pillar-card',
  'skill-pillar-count',
  'curriculum-filter-tabs',
  'syllabus-stack',
  'c-phase-item',
  'syllabus-search',
  'btn-expand-modules',
  'btn-collapse-modules',
  'c-batch-slot-btn',
  'batch-slot-title',
  'batch-seats-badge',
  'batch-audience-note',
  'card-wa-cta',
  'card-wa-btn-text',
  'btn-fee-full',
  'btn-fee-install',
  'fee-display-amount',
  'fee-display-sub',
  'c-town-btn',
  'map-route-badge',
  'town-commute-title',
  'town-commute-desc',
  'student-city',
  'demo-booking-form',
  'student-name',
  'student-batch',
  'student-goal'
)

foreach ($s in $selectors) {
  $found = $courseHtml.IndexOf($s) -ge 0
  Write-Host "Token [$s] : $(if ($found) {'EXISTS'} else {'*** MISSING ***'})"
}

Write-Host "`n=== MAIN.JS SELECTOR AUDIT IN freelancing-mastery.html ==="
$mainSelectors = @(
  'footer-back-to-top',
  'site-header',
  'hamburger-btn',
  'primary-nav',
  'nav-overlay',
  'home',
  'mascot-portal-rings',
  'mascot-frame',
  'tilt-card',
  'filter-tabs',
  'course-card-flagship',
  'courses-grid-cards',
  'course-card-standard',
  'course-fill',
  'reveal',
  'sticky-cta',
  'theme-toggle',
  'mobile-theme-btn',
  'meta-theme-color',
  'btn-watch-demo',
  'video-modal-overlay',
  'video-modal-close',
  'demo-video-player',
  'mentor-stage',
  'mentor-pod',
  'mentor-orbit-arena',
  'instructors',
  'review-modal-backdrop',
  'modal-close-btn',
  'reviews-carousel-track',
  'faq-filter-row',
  'faq-accordion-stack',
  'campus-real-map'
)

foreach ($ms in $mainSelectors) {
  $found = $courseHtml.IndexOf($ms) -ge 0
  Write-Host "Token [$ms] : $(if ($found) {'EXISTS'} else {'NOT IN COURSE HTML'})"
}
