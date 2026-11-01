# Comprehensive CSS & Design Token Audit Report
**Target Page**: `courses/freelancing-mastery.html`  
**Associated Stylesheets**: `assets/css/course-v2.css`, `assets/css/main.css`, `assets/css/refinement.css`  
**Auditor**: Explorer 2 (CSS & Design Token Auditor)  
**Date**: 2026-10-31  
**Integrity Mode**: Read-Only Survey

---

## 1. Executive Summary

This audit assesses all stylesheets associated with `courses/freelancing-mastery.html` against the project's standing design and engineering standards:
1. **Standard 2 (8px Grid Spacing)**: **238 spacing violations** detected in `course-v2.css`, **72 violations** in the global header/footer rules of `main.css`, and **22 violations** in `refinement.css`. Arbitrary values such as 6px, 10px, 12px, 14px, 18px, 20px, 22px, 28px, 36px, and 155px are pervasive across padding, margin, gap, and positioning offsets.
2. **Standard 3 (`prefers-reduced-motion`)**: While `course-v2.css` includes a baseline `@media (prefers-reduced-motion: reduce)` block (lines 3372–3385), critical gaps remain: animation and transition delays are not reset (allowing 1.1s delayed jumps), hover transforms (`translateY(-2px)`, `translateY(-3px)`, `scale(1.03)`, etc.) remain active on hover, and `.vibe-asset` animated images continue playing without static fallbacks or motion containment. Furthermore, global suppression rules inadvertently risk collapsing centering transforms (`translateX(-50%)` in `.c-toast`) if not scoped accurately.
3. **Standard 4 (CSS Variables for Colors & Theme Switching)**: **102 hardcoded color declarations** in `course-v2.css` directly use raw hex (`#ffffff`, `#f59e0b`, `#10b981`, `#fef3c7`, etc.) and hardcoded RGBA (`rgba(110, 68, 255, ...)`, `rgba(35, 27, 43, ...)`). In particular, box-shadows use hardcoded light-mode plum tint `rgba(35, 27, 43, 0.08)`, which appears muddy or invisible against dark backgrounds. Several sections have bespoke dark theme overrides with hardcoded rgba values instead of binding to semantic theme tokens (`--card`, `--line`, `--text-2`, `--surface-hover`).
4. **Standards 5 & 6 (Layout Hierarchy & Pruning of Secondary Labels)**: Section eyebrows (`.c-eyebrow`, 15 instances), helper subtitles (`.c-video-cta-sub`, `.c-float-badge-sub`), and gesture hints (`.c-swipe-hint`) currently clutter the visual hierarchy. Pruning them elevates readability, provided CSS vertical rhythm (`margin-bottom` on headings, padding on CTA buttons and badges) is adjusted to maintain balanced whitespace.

---

## 2. Standard 2: 8-Pixel Grid System Spacing Audit

### 2.1 Spacing Scale Reference
Per the project standards and `--s-...` scale in `main.css`:
- `--s-half`: `4px` (half-step, used only for tight inline elements/borders)
- `--s-1`: `8px`
- `--s-2`: `16px`
- `--s-3`: `24px`
- `--s-4`: `32px`
- `--s-5`: `40px`
- `--s-6`: `48px`
- `--s-7`: `56px`
- `--s-8`: `64px`
- `--s-10`: `80px`
- `--s-12`: `96px`

Any values such as 2px, 3px, 5px, 6px, 7px, 10px, 11px, 12px, 13px, 14px, 15px, 18px, 20px, 22px, 26px, 28px, 34px, 36px, 155px violate the grid.

### 2.2 Major Violations in `assets/css/course-v2.css`
A total of **238 property declarations** violate the 8px grid. The table below documents the most impactful structural violations by section, along with recommended replacements:

| Line | Selector | Property | Current Value | Non-8px Values | Recommended 8px Value | Severity | Rationale |
|---|---|---|---|---|---|---|---|
| 54 | `body.course-v2-page .c-eyebrow` | `margin-bottom` | `12px` | 12px | `16px` (or `8px`) | Medium | Normalizes section head rhythm |
| 88 | `body.course-v2-page .c-breadcrumbs` | `padding` | `calc(var(--header-h, 72px) + 20px) 0 12px` | 20px, 12px | `calc(var(--header-h, 72px) + 24px) 0 16px` | High | Header clearance offset on 8px grid |
| 147 | `body.course-v2-page .c-badge-pill` | `padding` | `6px 14px` | 6px, 14px | `8px 16px` | Medium | Badge pill padding |
| 154 | `body.course-v2-page .c-badge-pill` | `margin-bottom` | `20px` | 20px | `16px` (or `24px`) | Medium | Separation before hero H1 |
| 171 | `body.course-v2-page .c-hero-h1` | `margin` | `0 0 18px` | 18px | `0 0 16px` | High | Hero heading vertical rhythm |
| 185 | `body.course-v2-page .c-hero-guarantee` | `gap` | `10px` | 10px | `8px` | Medium | Internal badge gap |
| 186 | `body.course-v2-page .c-hero-guarantee` | `padding` | `10px 16px` | 10px | `8px 16px` | Medium | Vertical padding normalization |
| 193 | `body.course-v2-page .c-hero-guarantee` | `margin-bottom` | `28px` | 28px | `24px` (or `32px`) | High | Space before hero CTA cluster |
| 210 | `body.course-v2-page .c-hero-ctas` | `margin-bottom` | `28px` | 28px | `32px` | High | Space before social proof row |
| 218 | `body.course-v2-page .c-btn-primary` | `padding` | `13px 24px` | 13px | `12px 24px` or `16px 24px` | High | Primary CTA button height |
| 241 | `body.course-v2-page .c-btn-secondary` | `padding` | `13px 20px` | 13px, 20px | `16px 24px` | High | Secondary CTA button height match |
| 261 | `body.course-v2-page .c-hero-video-cta` | `gap` | `12px` | 12px | `8px` (or `16px`) | Medium | Icon to text gap |
| 262 | `body.course-v2-page .c-hero-video-cta` | `padding` | `6px 18px 6px 6px` | 6px, 18px | `8px 16px 8px 8px` | High | Hero video pill padding |
| 324 | `body.course-v2-page .c-hero-proof` | `gap` | `14px` | 14px | `16px` | Medium | Avatar to rating gap |
| 353 | `body.course-v2-page .c-stars-row` | `gap` | `6px` | 6px | `8px` | Low | Star gap |
| 372 | `body.course-v2-page .c-hero-editorial-stage` | `margin` | `14px 0` | 14px | `16px 0` | Medium | Hero right column container |
| 414 | `body.course-v2-page .c-float-badge` | `gap` | `10px` | 10px | `8px` | Medium | Float badge icon gap |
| 415 | `body.course-v2-page .c-float-badge` | `padding` | `8px 14px` | 14px | `8px 16px` | Medium | Float badge padding |
| 434 | `body.course-v2-page .c-float-badge--top-left` | `top` | `-14px` | -14px | `-16px` | Medium | Position offset |
| 435 | `body.course-v2-page .c-float-badge--top-left` | `left` | `-18px` | -18px | `-16px` | Medium | Position offset |
| 440 | `body.course-v2-page .c-float-badge--top-right` | `top` | `18px` | 18px | `16px` | Medium | Position offset |
| 441 | `body.course-v2-page .c-float-badge--top-right` | `right` | `-22px` | -22px | `-24px` | Medium | Position offset |
| 446 | `body.course-v2-page .c-float-badge--bottom-left` | `bottom` | `155px` | 155px | `160px` | Medium | Position offset (160 = 20*8) |
| 452 | `body.course-v2-page .c-float-badge--bottom-right`| `bottom` | `-14px` | -14px | `-16px` | Medium | Position offset |
| 453 | `body.course-v2-page .c-float-badge--bottom-right`| `right` | `-14px` | -14px | `-16px` | Medium | Position offset |
| 513 | `body.course-v2-page .c-art-fact-item` | `padding` | `18px 20px` | 18px, 20px | `16px 24px` | Medium | Fact card padding |
| 546 | `body.course-v2-page .c-hero-wave-divider` | `margin-top` | `36px` | 36px | `32px` (or `40px`) | Medium | Wave divider top margin |
| 568 | `body.course-v2-page .c-philosophy-quote` | `padding` | `4px 0 4px 20px` | 20px | `8px 0 8px 24px` | Medium | Callout border offset |
| 588 | `body.course-v2-page .c-facts-strip` | `padding` | `28px 0` | 28px | `24px 0` (or `32px 0`) | High | Facts strip vertical rhythm |
| 603 | `body.course-v2-page .c-fact-node` | `gap` | `12px` | 12px | `16px` | Medium | Fact node gap |
| 699 | `body.course-v2-page .c-philosophy-quote` | `margin` | `0 0 20px` | 20px | `0 0 24px` | Medium | Philosophy quote margin |
| 740 | `body.course-v2-page .c-outcome-card` | `padding` | `26px 24px` | 26px | `24px` (or `32px 24px`) | High | Outcome card padding |
| 744 | `body.course-v2-page .c-outcome-card` | `gap` | `14px` | 14px | `16px` | Medium | Card item gap |
| 832 | `body.course-v2-page .c-curriculum-item` | `margin-bottom` | `14px` | 14px | `16px` | High | Accordion item spacing |
| 853 | `body.course-v2-page .c-curriculum-trigger` | `padding` | `18px 24px` | 18px | `16px 24px` | High | Accordion header touch target |
| 856 | `body.course-v2-page .c-curriculum-trigger` | `gap` | `14px` | 14px | `16px` | Medium | Trigger flex gap |
| 908 | `body.course-v2-page .c-curriculum-body` | `padding` | `0 24px 22px` | 22px | `0 24px 24px` | High | Accordion body padding |
| 918 | `body.course-v2-page .c-curriculum-meta` | `gap` | `18px` | 18px | `16px` (or `24px`) | Medium | Meta item spacing |
| 932 | `body.course-v2-page .c-curriculum-meta-item` | `gap` | `6px` | 6px | `8px` | Low | Icon to text gap |
| 947 | `body.course-v2-page .c-curriculum-badge` | `padding` | `4px 10px` | 10px | `4px 8px` or `4px 12px` | Low | Badge padding |
| 980 | `body.course-v2-page .c-deliverable-card` | `padding` | `22px` | 22px | `24px` | High | Deliverable card padding |
| 983 | `body.course-v2-page .c-deliverable-card` | `gap` | `14px` | 14px | `16px` | Medium | Deliverable card gap |
| 1059 | `body.course-v2-page .c-spec-card` | `padding` | `28px 24px` | 28px | `24px` or `32px 24px` | High | Hardware spec card padding |
| 1074 | `body.course-v2-page .c-spec-item` | `gap` | `12px` | 12px | `16px` | Medium | Spec item gap |
| 1077 | `body.course-v2-page .c-spec-item` | `padding` | `10px 0` | 10px | `8px 0` or `16px 0` | Medium | Spec item list item padding |
| 1143 | `body.course-v2-page .c-mentor-card` | `padding` | `28px` | 28px | `32px` (or `24px`) | High | Mentor card container padding |
| 1152 | `body.course-v2-page .c-mentor-grid` | `gap` | `28px` | 28px | `32px` | High | Mentor split grid gap |
| 1172 | `body.course-v2-page .c-mentor-stat` | `padding` | `14px 18px` | 14px, 18px | `16px 24px` | High | Mentor stat box padding |
| 1222 | `body.course-v2-page .c-review-card` | `padding` | `26px` | 26px | `24px` | High | Review card padding |
| 1225 | `body.course-v2-page .c-review-card` | `gap` | `14px` | 14px | `16px` | Medium | Review card gap |
| 1344 | `body.course-v2-page .c-admissions-card` | `padding` | `34px 30px` | 34px, 30px | `32px` | High | Admissions card padding |
| 1475 | `body.course-v2-page .c-faq-item` | `margin-bottom` | `14px` | 14px | `16px` | High | FAQ accordion gap |
| 1488 | `body.course-v2-page .c-faq-trigger` | `padding` | `18px 24px` | 18px | `16px 24px` | High | FAQ header touch target |
| 1502 | `body.course-v2-page .c-faq-trigger` | `gap` | `14px` | 14px | `16px` | Medium | FAQ header flex gap |
| 1526 | `body.course-v2-page .c-faq-body` | `padding` | `0 24px 22px` | 22px | `0 24px 24px` | High | FAQ body content padding |
| 1664 | `body.course-v2-page .c-brand-logos-row` | `gap` | `28px` | 28px | `32px` | Medium | Brand logos strip flex gap |
| 1705 | `body.course-v2-page .stage-card` | `padding` | `26px 22px` | 26px, 22px | `24px` | High | 4-Stage method card padding |
| 1748 | `body.course-v2-page .stage-step-item` | `gap` | `10px` | 10px | `8px` | Medium | Step list gap |
| 1912 | `body.course-v2-page .c-aeo-box` | `padding` | `28px 30px` | 28px, 30px | `32px` | High | AEO box padding |
| 1944 | `body.course-v2-page .c-aeo-item` | `padding` | `14px 18px` | 14px, 18px | `16px 24px` | High | AEO card item padding |
| 2024 | `body.course-v2-page .pillar-card` | `padding` | `22px 20px` | 22px, 20px | `24px` | High | 21 Skills bento card padding |
| 2138 | `body.course-v2-page .c-syllabus-week` | `margin-bottom` | `14px` | 14px | `16px` | High | Curriculum week item margin |
| 2154 | `body.course-v2-page .c-syllabus-trigger` | `padding` | `18px 22px` | 18px, 22px | `16px 24px` | High | Curriculum syllabus trigger |
| 2252 | `body.course-v2-page .blueprint-card` | `padding` | `26px 22px` | 26px, 22px | `24px` | High | Pedagogical blueprint card padding |
| 2322 | `body.course-v2-page .c-comp-table th, td` | `padding` | `14px 18px` | 14px, 18px | `16px 24px` | High | Comparison table cell padding |
| 2368 | `body.course-v2-page .c-commuter-card` | `padding` | `26px 22px` | 26px, 22px | `24px` | High | Commuter hub card padding |
| 2434 | `body.course-v2-page .c-batch-slot-btn` | `padding` | `14px 18px` | 14px, 18px | `16px 24px` | High | Batch selector button padding |
| 2442 | `body.course-v2-page .c-batch-slot-btn` | `gap` | `12px` | 12px | `16px` | Medium | Batch selector button gap |
| 2516 | `body.course-v2-page .c-fee-plan-btn` | `padding` | `10px 18px` | 10px, 18px | `8px 16px` or `12px 24px` | High | Fee plan switch button |
| 2537 | `body.course-v2-page .c-toast` | `padding` | `14px 22px` | 14px, 22px | `16px 24px` | High | Toast notification padding |
| 2539 | `body.course-v2-page .c-toast` | `bottom` | `28px` | 28px | `32px` | Medium | Toast viewport bottom offset |
| 2574 | `body.course-v2-page .c-mobile-dock` | `padding` | `10px 16px` | 10px | `8px 16px` | High | Mobile dock container padding |
| 2575 | `body.course-v2-page .c-mobile-dock` | `gap` | `10px` | 10px | `8px` | High | Mobile dock button gap |

### 2.3 Non-8px Dimensions (Widths & Heights)
The audit identified 56 fixed non-8px dimensions in `course-v2.css`. Key instances to rectify:
- Line 59–60: `width: 6px; height: 6px;` on `.c-eyebrow::before` -> `8px` (or `4px` micro-dot).
- Line 278–279: `width: 42px; height: 42px;` on `.c-play-pulse` -> `40px` or `48px`.
- Line 297–298: `width: 14px; height: 14px;` on `.c-play-icon` -> `16px`.
- Line 607–608: `width: 36px; height: 36px;` on `.c-fact-node svg` -> `32px` or `40px`.
- Line 764–765: `width: 46px; height: 46px;` on `.c-outcome-card-icon` -> `48px`.
- Line 891–892: `width: 18px; height: 18px;` on `.c-curriculum-trigger svg` -> `16px` or `24px`.
- Line 1234–1235: `width: 44px; height: 44px;` on `.c-review-avatar` -> `48px` (or `40px`).
- Line 1499–1500: `width: 18px; height: 18px;` on `.c-faq-trigger svg` -> `16px` or `24px`.
- Line 1670: `height: 26px;` on `.c-brand-logo img` -> `24px` (or `32px`).

### 2.4 Header & Footer Spacing in `assets/css/main.css`
The elements present on `courses/freelancing-mastery.html` styled by `main.css` violate the 8px grid in several places:
- Line 808: `.btn-header-primary` has `padding: 8px 20px` (20px violates grid) -> replace with `8px 16px` or `8px 24px`.
- Line 818: `.btn-header-primary` has `gap: 6px` -> replace with `8px`.
- Line 871: `.hamburger` has `gap: 4px` -> acceptable as half-step, or `8px`.
- Line 8872: `.footer-top-grid` has `gap: clamp(24px, 2.4vw, 44px)` (44px violates grid) -> replace with `clamp(24px, 2.4vw, 48px)`.
- Line 8887: `.footer-brand-col` has `gap: 12px` -> replace with `16px`.
- Line 8925: `.footer-social-icons-grid` has `gap: 10px` -> replace with `8px` or `16px`.
- Line 8987: `.footer-col h4` has `margin: 0 0 18px 0` -> replace with `0 0 16px 0`.
- Line 8994: `.footer-links-list` has `gap: 12px` -> replace with `16px` (or `8px`).
- Line 9017: `.footer-nav-arrow` has `margin-left: 6px` -> replace with `8px`.
- Line 9103: `.footer-bottom-bar` has `padding: 18px clamp(36px, 4vw, 64px) 20px` (18px, 36px, 20px violate grid) -> replace with `16px clamp(32px, 4vw, 64px) 24px`.
- Line 9122: `.footer-legal-links` has `gap: 12px` -> replace with `16px`.

---

## 3. Standard 3: `prefers-reduced-motion` Accessibility Audit

### 3.1 Inventory of Dynamic Effects
1. **Keyframe Animations**:
   - `@keyframes os-float-a`: Vertical float `0%, 100% { transform: translateY(0); } 50% { transform: translateY(-7px); }` (lines 457–460 in `course-v2.css`).
   - `@keyframes os-float-b`: Vertical float `0%, 100% { transform: translateY(0); } 50% { transform: translateY(7px); }` (lines 462–465 in `course-v2.css`).
   - Applied to `.c-float-badge--top-left` (3.8s infinite), `.c-float-badge--top-right` (4.4s infinite + 0.3s delay), `.c-float-badge--bottom-left` (4.1s infinite + 0.7s delay), `.c-float-badge--bottom-right` (4.5s infinite + 1.1s delay).
2. **Hover Transforms & Transitions**:
   - Line 232: `.c-btn-primary:hover` -> `transform: translateY(-2px);`
   - Line 273: `.c-btn-secondary:hover` -> `transform: translateY(-2px);`
   - Line 292: `.c-video-thumb:hover img` -> `transform: scale(1.08);`
   - Line 755: `.c-outcome-card:hover` -> `transform: translateY(-4px);`
   - Line 987: `.c-deliverable-card:hover` -> `transform: translateY(-3px);`
   - Line 1540: `.c-related-card:hover` -> `transform: translateY(-3px);`
   - Line 1677: `.c-brand-logo:hover` -> `transform: translateY(-2px);`
   - Line 1720: `.stage-card:hover` -> `transform: scale(1.03);`
   - Line 1784: `.stage-number:hover` -> `transform: translateY(-3px);`
   - Line 2065: `.pillar-card:hover` -> `transform: translateY(-3px);`
   - Line 3088: `.batch-slot-card:hover` -> `transform: translateY(-2px);`
   - Line 3139: `.c-editorial-art-card:hover` -> `transform: translateY(-3px);`
3. **State Transitions (Accordions & Overlays)**:
   - Line 894 & 898: Chevron rotation `transform: rotate(180deg);`
   - Line 1503 & 1507: FAQ plus icon `transform: rotate(45deg);`
   - Line 2538 & 2552: `.c-toast` slide transition:
     `transform: translateX(-50%) translateY(120px);` -> `transform: translateX(-50%) translateY(0);`
4. **Animated VibeGif Assets**:
   - Multiple animated `.webp` files linked from `assets/images/vibegif/`: `verified-badge.webp`, `trophy-shine.webp`, `rocket-launch.webp`, `thumbs-up.webp`.

### 3.2 Analysis of Current Reduced-Motion Coverage
Current rule in `course-v2.css` (lines 3372–3385):
```css
@media (prefers-reduced-motion: reduce) {
  body.course-v2-page *,
  body.course-v2-page *::before,
  body.course-v2-page *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }

  body.course-v2-page .vibe-asset {
    opacity: 0.85;
  }
}
```

### 3.3 Critical Flaws & Missing Coverage
1. **Missing Delay Suppression (`animation-delay`, `transition-delay`)**:
   Because `animation-delay` is not zeroed out, badges with delays (e.g. `0.3s`, `0.7s`, `1.1s` in lines 442, 448, 454) wait in the background and snap abruptly after the delay period, creating disruptive visual jitter.
2. **Hover Transforms Leak**:
   When users with vestibular disorders move their mouse across the page, interactive cards (`.stage-card`, `.pillar-card`, `.c-outcome-card`, `.c-btn-primary`, etc.) still execute physical displacements (`translateY(-4px)`, `scale(1.08)`). Hover transforms should be suppressed under reduced-motion.
3. **Centering Protection (CRITICAL)**:
   A blanket `transform: none !important;` must **NOT** be applied to `*` because elements using transform for horizontal alignment (specifically `.c-toast` which relies on `transform: translateX(-50%)`) would jump off-center to the right side of the screen. Hover transforms must be neutralized specifically or resetting `transform` must preserve translateX(-50%) on toast.
4. **Continuous Background/Float Keyframes**:
   Setting `animation: none !important;` on `.c-float-badge--top-left, .c-float-badge--top-right, .c-float-badge--bottom-left, .c-float-badge--bottom-right` is much cleaner than relying on `0.01ms` iteration.

### 3.4 Recommended Remediation
Replace lines 3372–3385 of `course-v2.css` with:
```css
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

  /* Completely stop infinite floating animations */
  body.course-v2-page [class*="c-float-badge"] {
    animation: none !important;
    transform: none !important;
  }

  /* Suppress hover motion shifts while maintaining visual feedback via color/border */
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

  /* Preserve centering transform on toast */
  body.course-v2-page .c-toast {
    transform: translateX(-50%) translateY(0) !important;
    transition: none !important;
  }

  /* Fade down animated stickers/badges */
  body.course-v2-page .vibe-asset {
    opacity: 0.75;
    filter: grayscale(15%);
  }
}
```

---

## 4. Standard 4: CSS Variables for Colors & Theme Switching Audit

### 4.1 Audit Summary
- **102 declarations** in `course-v2.css` contain raw, hardcoded hex, rgb, or rgba values outside of CSS custom property fallbacks.
- **22 declarations** in `refinement.css` contain hardcoded values outside token definitions.
- The course detail page currently implements dark mode through fragmented overrides (`html[data-theme="dark"] body.course-v2-page ...`) rather than systemic token consumption.

### 4.2 Categories of Color Token Violations & Mapping

#### A. Primary Text on High-Contrast Elements (`#ffffff`)
- **Violations**:
  - Line 220: `.c-btn-primary { color: #ffffff !important; }`
  - Line 282: `.c-play-disc { color: #ffffff; }`
  - Line 770: `.c-outcome-icon-disc { color: #ffffff; }`
  - Line 2395: `.c-town-btn:hover { color: #ffffff; }`
  - Line 2527: `.c-fee-plan-btn.active { color: #ffffff; }`
  - Line 2541: `.c-toast { color: #ffffff; }`
  - Line 3350: `.sticky-cta .btn-sticky-primary { color: #ffffff; }`
  - Line 3365: `.sticky-cta .btn-sticky-wa { color: #ffffff; }`
- **Remediation**: Use `var(--accent-convert-text, #ffffff)` or introduce `--text-inverse: #ffffff;` token.

#### B. Brand Violet & Purple Accents (`rgba(110, 68, 255, ...)`)
- **Violations**:
  - Line 150: `.c-badge-pill { border: 1px solid rgba(110, 68, 255, 0.2); }` -> `var(--line-strong, rgba(110, 68, 255, 0.2))`
  - Line 226, 233: `.c-btn-primary box-shadow` -> `var(--accent-convert-shadow)` or `var(--shadow-hover)`
  - Line 253, 272: `border-color: rgba(110, 68, 255, 0.3)` -> `var(--accent-line)`
  - Line 286: `.c-play-disc box-shadow` -> `var(--accent-glow)`
  - Line 754: `.c-outcome-card:hover border-color` -> `var(--accent-line)`
  - Line 840: `.c-curriculum-item:hover border-color` -> `var(--line-strong)`
  - Line 986: `.c-deliverable-card:hover border-color` -> `var(--line-strong)`
  - Line 2341, 2352: `.c-comp-table th.col-oneskills, td.col-oneskills background` -> `var(--surface-hover)` and `var(--surface-subtle)`
  - Line 2464: `.c-batch-slot-btn.active background` -> `var(--accent-alpha)`
  - Line 3156: `.c-annotation-local border` -> `var(--accent-line)`
- **Problem**: When dark mode switches `--accent` from `#6e44ff` to `#7b52ff` and changes border opacities, hardcoded `rgba(110, 68, 255, ...)` stays fixed at the light theme's tone, creating inconsistent tinting.

#### C. Light Plum Shadows (`rgba(35, 27, 43, ...)`)
- **Violations**:
  - Line 267: `.c-hero-video-cta box-shadow: 0 4px 14px rgba(35, 27, 43, 0.05);`
  - Line 381: `.c-editorial-art-card box-shadow: 0 16px 44px rgba(35, 27, 43, 0.08);`
  - Line 419: `.c-float-badge box-shadow: 0 14px 30px -4px rgba(35, 27, 43, 0.13), 0 4px 10px rgba(35, 27, 43, 0.06);`
  - Line 645: `.c-subnav-sticky box-shadow: 0 4px 16px rgba(35, 27, 43, 0.04);`
  - Line 749, 756: `.c-outcome-card box-shadow`
  - Line 841: `.c-curriculum-item box-shadow`
  - Line 2373: `.c-commuter-card box-shadow`
  - Line 2580: `.c-mobile-dock box-shadow`
  - Line 3329: `.sticky-cta box-shadow: 0 -4px 24px rgba(35, 27, 43, 0.08);`
- **Problem**: `rgba(35, 27, 43, ...)` is an ink/plum tint calibrated exclusively for the `#faf8ff` canvas. In dark mode (`#090614`), this plum shadow is imperceptible or renders as a dirty hue.
- **Remediation**: Map to standard design tokens `var(--shadow-card)` and `var(--shadow-hover)` defined in `main.css`, which adapt dynamically in dark mode.

#### D. Floating Badge Icon Backgrounds & Accents
- **Violations**:
  - Line 477: `.c-float-icon--gold { background: #fef3c7; color: #d97706; }`
  - Line 478: `.c-float-icon--emerald { background: #d1fae5; color: #059669; }`
  - Line 479: `.c-float-icon--purple { background: #ede9fe; color: #7c3aed; }`
  - Line 480: `.c-float-icon--amber { background: #ffedd5; color: #ea580c; }`
  - Line 359: `.c-stars-gold { color: #f59e0b; }`
  - Line 2499–2500: `.c-seats-pill { background: rgba(16, 185, 129, 0.15); color: #10b981; }`
- **Problem**: The pastel backgrounds (`#fef3c7`, `#ede9fe`, etc.) create blinding, high-contrast white-hot glare against dark mode.
- **Remediation**: Define semantic tokens in `:root` and override in `html[data-theme="dark"]`:
  ```css
  /* Light defaults */
  :root {
    --badge-gold-bg: #fef3c7;
    --badge-gold-text: #d97706;
    --badge-emerald-bg: #d1fae5;
    --badge-emerald-text: #059669;
    --badge-purple-bg: #ede9fe;
    --badge-purple-text: #7c3aed;
    --badge-amber-bg: #ffedd5;
    --badge-amber-text: #ea580c;
  }
  /* Dark mode overrides */
  html[data-theme="dark"] {
    --badge-gold-bg: rgba(245, 158, 11, 0.18);
    --badge-gold-text: #fbbf24;
    --badge-emerald-bg: rgba(16, 185, 129, 0.18);
    --badge-emerald-text: #34d399;
    --badge-purple-bg: rgba(124, 58, 237, 0.22);
    --badge-purple-text: #c4b5fd;
    --badge-amber-bg: rgba(234, 88, 12, 0.18);
    --badge-amber-text: #fb923c;
  }
  ```

#### E. Outcome Card Gradients
- Lines 780, 784, 788, 792:
  ```css
  background: linear-gradient(135deg, #6e44ff 0%, #9066ff 100%);
  background: linear-gradient(135deg, #f43f5e 0%, #fb7185 100%);
  background: linear-gradient(135deg, #0284c7 0%, #38bdf8 100%);
  background: linear-gradient(135deg, #059669 0%, #34d399 100%);
  ```
  Should be mapped to variables:
  `var(--gradient-violet, linear-gradient(135deg, #6e44ff 0%, #9066ff 100%))`
  `var(--gradient-rose, linear-gradient(135deg, #f43f5e 0%, #fb7185 100%))`
  `var(--gradient-sky, linear-gradient(135deg, #0284c7 0%, #38bdf8 100%))`
  `var(--gradient-emerald, linear-gradient(135deg, #059669 0%, #34d399 100%))`

---

## 5. Standards 5 & 6: Impact of Pruning Secondary Labels & Taglines on Layout Hierarchy

### 5.1 Elements Identified for Pruning
1. **Section Eyebrows (`.c-eyebrow`)**: 15 occurrences (e.g. "Program Architecture", "The OneSkills Method", "Proof of Learning", "Regional Commuter Hub", "Ready to Begin?").
2. **Hero Secondary Helper Texts**:
   - `.c-video-cta-sub`: "Curriculum & Live Campaign Floor ↓" (inside hero video button).
   - `.c-rating-sub`: "Based on 160+ verified Sheikhupura graduates" (under 5-star rating).
   - `.c-float-badge-sub`: 4 occurrences ("Live Campaigns & High ROAS", "Upwork + Local Retainers", "ChatGPT, Canva & CapCut", "100% Money-Back Guarantee").
3. **Gesture Helper Texts**:
   - `.c-swipe-hint`: "← Swipe horizontally to compare all features →" above comparison table.
4. **Footer Tagline**:
   - `.footer-brand-tagline`: "Skills Today, Brighter Tomorrows."

### 5.2 Layout & Styling Impact Analysis

#### 1. Section Headers (`.c-section-head`)
- **Current Behavior**: The `.c-eyebrow` has `margin-bottom: 12px;` and `.c-title` has `margin: 0 0 16px;`.
- **When Pruned**: Removing `.c-eyebrow` elevates `h2.c-title` to the top of `.c-section-head`. The layout becomes more confident, direct, and editorial.
- **CSS Adjustment Required**:
  Ensure `.c-title` has sufficient breathing room above it. The parent `.c-section-head` should maintain `margin-bottom: 32px` (standard 8px multiple) and `.c-title` should use `margin: 0 0 16px;`. No empty spacing collapse will occur.

#### 2. Hero Video CTA Button (`.c-hero-video-cta`)
- **Current Behavior**:
  Pill layout containing an icon disc, a bold title, and a small sublabel ("Curriculum & Live Campaign Floor ↓").
  Padding is `6px 18px 6px 6px;` and gap is `12px;`.
- **When Pruned**: Removing `.c-video-cta-sub` leaves just the title: `Inspect 12-Week Roadmap`.
- **CSS Adjustment Required**:
  Update padding to `8px 24px 8px 8px;` and gap to `8px;`. This transforms the element into a clean, balanced pill button that sits symmetrically beside `.c-btn-primary` without feeling lopsided.

#### 3. Floating Badges (`.c-float-badge`)
- **Current Behavior**:
  Each floating badge on the hero right column contains a 32px icon disc, a title, and a subtitle (`.c-float-badge-sub`).
  Padding is `8px 14px;` and gap is `10px;`.
- **When Pruned**:
  Removing the subtitle turns each badge into a clean, single-line micro-chip: `[Icon] Title`.
- **CSS Adjustment Required**:
  Update `.c-float-badge` to `gap: 8px; padding: 8px 16px; min-height: 48px; border-radius: var(--r-pill);`.
  This delivers a modern, compact badge that doesn't obscure the hero artwork behind it.

#### 4. Comparison Matrix & Mobile Swipe Hint (`.c-swipe-hint`)
- **Current Behavior**:
  Displays a label "← Swipe horizontally to compare all features →" on mobile viewports (`display: inline-flex`).
- **When Pruned**:
  The label is cut completely.
- **CSS Adjustment Required**:
  Instead of relying on instructions, provide visual affordance by letting the right-most column naturally peek out past the viewport edge (`padding-right: 24px; scroll-padding-right: 24px;`), or add a subtle right edge gradient fade on the table scroll container (`.c-comp-table-wrap`) so users immediately see that more columns exist.

---

## 6. Implementation Blueprint & Prioritized Remediation Plan

### Priority 1: High — Systemic Tokenization & Spacing Grid Replacement
1. **Define Core Semantic Tokens in `main.css` / `course-v2.css`**:
   - Add theme-aware `--badge-...` and `--gradient-...` custom properties to `:root` and `html[data-theme="dark"]`.
   - Map all 102 hardcoded color instances in `course-v2.css` to `var(--accent)`, `var(--line)`, `var(--card)`, `var(--shadow-card)`, and semantic tokens.
2. **Replace All Non-8px Spacing Declarations in `course-v2.css`**:
   - Execute the 238 replacements specified in Section 2.2 and Section 2.3.
   - Update responsive breakpoint rules (lines 2605–3370) to eliminate 6px, 10px, 12px, 14px, 18px, 20px, 22px values.

### Priority 2: High — Motion & Accessibility Hardening
1. **Rewrite `@media (prefers-reduced-motion: reduce)` in `course-v2.css`**:
   - Add `animation-delay: 0s !important;` and `transition-delay: 0s !important;`.
   - Neutralize hover transforms on all interactive cards.
   - Explicitly disable keyframe float loops (`animation: none !important;`).
   - Guard centering on `.c-toast`.

### Priority 3: Medium — Layout Hierarchy Refinement
1. **Adjust Container and Heading Rhythm**:
   - Update `.c-section-head` to `margin-bottom: 32px` or `40px`.
   - Update `.c-hero-video-cta` to `padding: 8px 24px 8px 8px; gap: 8px;`.
   - Update `.c-float-badge` to `padding: 8px 16px; gap: 8px;`.
   - Remove `.c-swipe-hint` display rules and ensure comparison table scroll wrapper provides visible peek.

### Priority 4: Low — Global Header & Footer Cleanup in `main.css`
1. Normalize `.btn-header-primary` padding from `8px 20px` to `8px 16px` or `8px 24px`.
2. Normalize footer column heading margin from `18px` to `16px`.
3. Normalize footer bottom bar padding to `16px clamp(32px, 4vw, 64px) 24px`.
