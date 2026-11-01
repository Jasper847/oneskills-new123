$raw = Get-Content 'assets\css\course-v2.css.bak' -Raw

# 1. Prepare new token header
$tokenHeader = @"
/* ============================================================
   ONESKILLS — SINGLE COURSE DETAIL DESIGN SYSTEM (V2)
   Scope: body.course-v2-page. Designed for all 8 OneSkills tracks.
   Inherits base design tokens from main.css & refinement.css.
   ============================================================ */

/* ------------------------------------------------------------
   Custom Properties & Foundations
   ------------------------------------------------------------ */

:root {
  --text-inverse: #ffffff;
  --accent-emerald-line: rgba(16, 185, 129, 0.3);
  --accent-emerald-alpha: rgba(16, 185, 129, 0.15);
  --accent-emerald-subtle: rgba(16, 185, 129, 0.04);
  --accent-amber-line: rgba(245, 158, 11, 0.35);
  --shadow-plum-subtle: 0 4px 16px rgba(35, 10, 80, 0.04);
  --shadow-plum-card: var(--shadow-card, 0 8px 24px -4px rgba(35, 10, 80, 0.06));
  --shadow-plum-float: var(--shadow-hover, 0 16px 32px -6px rgba(110, 68, 255, 0.12));
  --badge-gold-bg: #fef3c7;
  --badge-gold-text: #d97706;
  --badge-emerald-bg: #d1fae5;
  --badge-emerald-text: #059669;
  --badge-purple-bg: #ede9fe;
  --badge-purple-text: #7c3aed;
  --badge-amber-bg: #ffedd5;
  --badge-amber-text: #ea580c;
  --gradient-violet: linear-gradient(135deg, #6e44ff 0%, #9066ff 100%);
  --gradient-rose: linear-gradient(135deg, #f43f5e 0%, #fb7185 100%);
  --gradient-sky: linear-gradient(135deg, #0284c7 0%, #38bdf8 100%);
  --gradient-emerald: linear-gradient(135deg, #059669 0%, #34d399 100%);
  --tag-roas: #10b981;
  --tag-toprated: #6366f1;
  --tag-rails: #ec4899;
  --badge-cap: #ef4444;
}

html[data-theme="dark"] {
  --text-inverse: #ffffff;
  --badge-gold-bg: rgba(245, 158, 11, 0.18);
  --badge-gold-text: #fbbf24;
  --badge-emerald-bg: rgba(16, 185, 129, 0.18);
  --badge-emerald-text: #34d399;
  --badge-purple-bg: rgba(124, 58, 237, 0.22);
  --badge-purple-text: #c4b5fd;
  --badge-amber-bg: rgba(234, 88, 12, 0.18);
  --badge-amber-text: #fb923c;
  --tag-roas: #34d399;
  --tag-toprated: #818cf8;
  --tag-rails: #f472b6;
  --badge-cap: #f87171;
  --accent-emerald-line: rgba(52, 211, 153, 0.35);
  --accent-emerald-alpha: rgba(52, 211, 153, 0.2);
  --accent-emerald-subtle: rgba(52, 211, 153, 0.08);
  --accent-amber-line: rgba(251, 191, 36, 0.35);
}
"@

# Replace top comment header with token header
$headerRegex = [regex]'/\* ============================================================[\s\S]*?/\* ------------------------------------------------------------\s*Custom Properties & Foundations\s*------------------------------------------------------------ \*/'
$content = $headerRegex.Replace($raw, $tokenHeader, 1)

# 2. Extract HTML classes and semantic tokens to append
$extractedClasses = @"

/* ------------------------------------------------------------
   Semantic Classes Extracted from Inline Styles (Standard 2 & DX)
   ------------------------------------------------------------ */

body.course-v2-page .c-ethical-content {
  max-width: 784px;
}

body.course-v2-page .c-ethical-kicker {
  font-size: 0.75rem;
  font-weight: 800;
  color: var(--accent-amber, #f59e0b);
  letter-spacing: 0.08em;
  text-transform: uppercase;
  margin-bottom: 8px;
}

body.course-v2-page .c-ethical-body {
  font-size: 0.875rem;
  color: var(--text-2);
  line-height: 1.6;
  margin: 0;
}

body.course-v2-page .c-tag-success,
body.course-v2-page .c-roas-tag {
  color: var(--tag-roas, #10b981);
}

body.course-v2-page .c-tag-accent,
body.course-v2-page .c-accent-tag {
  color: var(--accent);
}

body.course-v2-page .c-tag-indigo,
body.course-v2-page .c-status-toprated {
  color: var(--tag-toprated, #6366f1);
}

body.course-v2-page .c-tag-pink,
body.course-v2-page .c-rails-tag {
  color: var(--tag-rails, #ec4899);
}

body.course-v2-page .c-table-scroll,
body.course-v2-page .c-comp-table-wrap {
  overflow-x: auto;
  -webkit-overflow-scrolling: touch;
}

body.course-v2-page .c-commuter-header {
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 8px;
  margin-bottom: 16px;
}

body.course-v2-page .c-map-frame {
  border-radius: 16px;
  overflow: hidden;
  border: 1px solid var(--line);
  background: var(--bg-card, var(--card));
  position: relative;
  margin-bottom: 16px;
}

body.course-v2-page .c-town-commute-title,
body.course-v2-page .c-town-title {
  color: var(--text);
  display: block;
  margin-bottom: 8px;
  font-size: 0.95rem;
}

body.course-v2-page .c-town-commute-desc,
body.course-v2-page .c-town-desc {
  color: var(--text-2);
  font-size: 0.85rem;
  line-height: 1.5;
  margin: 0;
}

body.course-v2-page .c-demo-card-head {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 16px;
}

body.course-v2-page .c-demo-card-title {
  font-size: 1.25rem;
  font-weight: 800;
  color: var(--text);
  margin: 0;
}

body.course-v2-page .c-status-open {
  color: var(--accent-emerald, #059669);
  border-color: var(--accent-emerald-line, rgba(16, 185, 129, 0.3));
}

body.course-v2-page .c-demo-card-sub {
  font-size: 0.85rem;
  color: var(--text-2);
  margin-bottom: 16px;
  line-height: 1.5;
}

body.course-v2-page .c-demo-form {
  display: flex;
  flex-direction: column;
  gap: 16px;
}

body.course-v2-page .c-form-label {
  font-size: 0.75rem;
  font-weight: 700;
  color: var(--text-3);
  display: block;
  margin-bottom: 8px;
}

body.course-v2-page .c-btn-submit {
  width: 100%;
  justify-content: center;
  margin-top: 8px;
}

body.course-v2-page .c-demo-card-footer {
  padding-top: 16px;
  margin-top: 16px;
  border-top: 1px solid var(--line);
  display: flex;
  flex-wrap: wrap;
  justify-content: space-between;
  align-items: center;
  gap: 8px;
  font-size: 0.8rem;
}

body.course-v2-page .c-card-loc-text {
  color: var(--text-3);
}

body.course-v2-page .c-maps-link {
  color: var(--accent);
  font-weight: 700;
}

body.course-v2-page .c-mentor-badge-inline {
  display: inline-block;
  vertical-align: -2px;
  margin-left: 8px;
}

body.course-v2-page .c-cohort-subtext {
  font-size: 12px;
  font-weight: 600;
  color: var(--text-3);
}

body.course-v2-page .c-batch-header {
  margin-top: 16px;
  margin-bottom: 8px;
  display: flex;
  justify-content: space-between;
  align-items: center;
}

body.course-v2-page .c-batch-days {
  font-size: 0.75rem;
  color: var(--accent);
  font-weight: 600;
}

body.course-v2-page .c-batch-info-box {
  margin: 16px 0;
  padding: 16px;
}

body.course-v2-page .c-batch-status-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

body.course-v2-page .c-slot-title {
  color: var(--text);
  font-size: 0.875rem;
}

body.course-v2-page .c-seats-badge {
  font-size: 0.75rem;
  padding: 4px 8px;
  color: var(--accent-emerald, #059669);
  border-color: var(--accent-emerald-line, rgba(16, 185, 129, 0.3));
}

body.course-v2-page .c-batch-note {
  color: var(--text-3);
  font-size: 0.75rem;
  line-height: 1.5;
  margin: 0;
}

body.course-v2-page .c-tuition-section {
  margin-bottom: 16px;
}

body.course-v2-page .c-tuition-header {
  display: flex;
  justify-content: space-between;
  align-items: center;
  margin-bottom: 8px;
}

body.course-v2-page .c-badge-cap {
  color: var(--badge-cap, #ef4444);
}

body.course-v2-page .c-btn-full {
  width: 100%;
  justify-content: center;
  gap: 8px;
}

body.course-v2-page .border-b-0 {
  border-bottom: 0 !important;
}

body.course-v2-page .mb-0 {
  margin-bottom: 0 !important;
}
"@

# 3. Comprehensive Reduced Motion Block Replacement
$reducedMotionBlock = @"
@media (prefers-reduced-motion: reduce) {
  body.course-v2-page *,
  body.course-v2-page *::before,
  body.course-v2-page *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    animation-delay: 0s !important;
    transition-duration: 0.01ms !important;
    transition-delay: 0s !important;
    scroll-behavior: auto !important;
  }

  /* Completely halt continuous keyframe loops */
  body.course-v2-page [class*="c-float-badge"] {
    animation: none !important;
    transform: none !important;
  }

  /* Suppress hover motion shifts while maintaining color/border feedback */
  body.course-v2-page :is(
    .c-btn-primary,
    .c-btn-secondary,
    .c-hero-video-cta,
    .c-outcome-card,
    .c-deliverable-card,
    .c-related-card,
    .c-brand-logo,
    .stage-card,
    .stage-number,
    .pillar-card,
    .batch-slot-card,
    .c-editorial-art-card,
    .c-video-thumb img
  ):hover {
    transform: none !important;
  }

  /* Preserve horizontal centering on toast */
  body.course-v2-page .c-toast {
    transform: translateX(-50%) translateY(0) !important;
    transition: none !important;
  }

  /* Motion-dampening for animated stickers */
  body.course-v2-page .vibe-asset {
    opacity: 0.75;
    filter: grayscale(15%);
  }
}
"@

# Replace the existing reduced motion block at the end
$rmRegex = [regex]'@media\s*\(prefers-reduced-motion:\s*reduce\)[\s\S]*?\}\s*\}'
if ($rmRegex.IsMatch($content)) {
    $content = $rmRegex.Replace($content, $reducedMotionBlock, 1)
} else {
    $content += "`n`n" + $reducedMotionBlock
}

# 4. Remove dead styles for .sticky-cta
$stickyCtaRegex = [regex]'/\* -+\s*Mobile Sticky Bottom Conversion Bar[\s\S]*?(?=\n\n|\n@media|\Z)'
$content = $stickyCtaRegex.Replace($content, '', 1)

# Also remove any remaining .sticky-cta selectors
$content = [regex]::Replace($content, '(?s)\tbody\.course-v2-page \.sticky-cta\b[^{]*\{[^}]*\}', '')
$content = [regex]::Replace($content, '(?s)\thtml\[data-theme="dark"\] body\.course-v2-page \.sticky-cta\b[^{]*\{[^}]*\}', '')

# Append extracted classes
$content += "`n" + $extractedClasses

# Write intermediate content
Set-Content -Path 'assets\css\course-v2.css' -Value $content -Encoding UTF8
Write-Host "Header, extracted classes, and reduced motion updated."
