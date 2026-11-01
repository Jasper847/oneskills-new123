# Comprehensive Audit & Remediation Plan: Freelancing Mastery Course Page

**Target Page**: `courses/freelancing-mastery.html`  
**Associated Stylesheets**: `assets/css/course-v2.css`, `assets/css/main.css`, `assets/css/refinement.css`  
**Associated Scripts**: `assets/js/course-v2.js`, `assets/js/main.js`, `assets/js/refinement.js`  
**Auditors**: Teamwork Explorer Agents (Explorer 1: HTML/Semantics, Explorer 2: CSS/Tokens, Explorer 3: JS/UX)  
**Consolidation & Remediation Lead**: Remediation Worker (`teamwork_worker`)  
**Audit Date**: 2026-10-31  
**Status**: Authoritative Action Plan for Milestone M2

---

## Executive Summary

A comprehensive, evidence-led audit of `courses/freelancing-mastery.html` and its associated stylesheets and scripts was conducted across all six standing engineering and design standards.

### Summary of Audit Discoveries
1. **Standard 1 (Semantic HTML5 & ARIA)**: 12 structural findings including invalid `aria-label` attributes on non-interactive `<div>` elements, broken heading hierarchy skipping levels in Section `#overview`, Section `#method`, and `<footer>`, raw emojis within `<h3>` headings, non-semantic table markup lacking `<caption>` and `<th scope="col/row">`, unassociated filter groups acting as tablists without tabpanels, and unannounced state changes across tuition toggles.
2. **Standard 2 (8-Pixel Grid System Spacing)**: 238 spacing property declarations in `course-v2.css` violating the 8px grid (using 6px, 10px, 12px, 14px, 18px, 20px, 22px, 28px, 34px, 36px), 56 fixed non-8px dimensions (widths/heights), and 54 inline `style="..."` attributes scattered across `courses/freelancing-mastery.html`.
3. **Standard 3 (`prefers-reduced-motion`)**: Gaps in motion containment: `animation-delay` and `transition-delay` are not zeroed, allowing 1.1s delayed keyframe snaps; hover transforms remain active on 12 interactive card/button classes; infinite floating keyframes (`os-float-a`, `os-float-b`) continue running; skip-link smooth-scroll hijacks native keyboard focus.
4. **Standard 4 (CSS Variables for Colors)**: 102 hardcoded color declarations in `course-v2.css` using raw hex (`#ffffff`, `#f59e0b`, `#10b981`), raw `rgba(110,68,255,...)`, and hardcoded plum shadows `rgba(35,27,43,...)` which degrade into mud or disappear in dark mode; pastel badge backgrounds (`#fef3c7`, `#ede9fe`, etc.) lacking dark mode counter-tokens.
5. **Standard 5 (Cut Taglines, Helper Text & Secondary Labels)**: Pervasive UI clutter including 15 instances of `.c-eyebrow`, table swipe instruction ("Swipe horizontally..."), town selector instruction ("Select Your Location..."), numbered form step tags ("1. Select Batch Slot:", "2. Tuition Payment Plan:"), corporate tagline ("Skills Today, Brighter Tomorrows."), brand subtitle ("ACADEMY"), and redundant Google review disclaimers.
6. **Standard 6 (UX/DX/AX Elevation & Content Integrity)**: Two Critical (P0) selector mismatch bugs that completely disable the 21-Skill Filter and 12-Week Curriculum Filter; a High (P1) duplicate copy listener clobbering clipboard data; a High (P1) dual mobile dock collision; and an imperative directive to preserve all 12 modules, 84 lessons, learning outcomes, and pricing figures (`PKR 25,000`, `2 installments of PKR 12,500`, `PKR 8,500 / mo`).

---

## Detailed Findings Matrix by Standard

```
+-------------------------------------------------------------------------------------------------------------------------+
| Standard 1: Semantic HTML5 Elements, Landmarks, Heading Hierarchy & ARIA                                                |
+-------------------------------------------------------------------------------------------------------------------------+
```

| ID | Target File & Line/Selector | Severity | Standard Violated | Description of Issue | Actionable Proposed Fix |
|---|---|---|---|---|---|
| **S1-01** | `courses/freelancing-mastery.html:303`<br>`.c-hero-editorial-stage` | Moderate | Standard 1 (ARIA Spec) | `<div class="c-hero-editorial-stage" aria-label="...">` has `aria-label` on generic `<div>` without landmark/widget role. | Convert to semantic `<figure class="c-hero-editorial-stage" aria-label="Course Overview and Verified Proof Badges">` or remove `aria-label`. |
| **S1-02** | `courses/freelancing-mastery.html:387`<br>`.c-brand-logos-card` | Moderate | Standard 1 (ARIA Spec) | Generic `<div>` carries `aria-label="Platforms covered in the course"`. | Wrap inside `<figure class="c-brand-logos-card">` with accessible `role="region"` and accessible label. |
| **S1-03** | `courses/freelancing-mastery.html:750`<br>`.c-benefits-bar` | Moderate | Standard 1 (ARIA Spec) | Generic `<div>` carries `aria-label="OneSkills Lab Strengths"`. | Convert to `<aside class="c-benefits-bar" aria-label="OneSkills Lab Strengths">` or provide an accessible heading. |
| **S1-04** | `courses/freelancing-mastery.html:2328`<br>`.footer-social-icons-grid` | Low | Standard 1 (ARIA Spec) | `<div>` has `aria-label="OneSkills Social Media Profiles"` without landmark/group role. | Add `role="group"` or `aria-label` to the enclosing navigation element. |
| **S1-05** | `courses/freelancing-mastery.html:564-642`<br>`#overview .c-outcomes-grid` | High | Standard 1 (WCAG 1.3.1, 2.4.6) | Heading hierarchy skip: `<h2>` is followed by `<h3>Who will thrive:</h3>`, followed by 4 `<h4>` outcome cards. The outcomes are perceived as children of the suitability list. | Add `<h3 class="visually-hidden">Key Learning Outcomes</h3>` directly preceding the outcome cards grid, or promote cards to `<h3>`. |
| **S1-06** | `courses/freelancing-mastery.html:654-803`<br>`#method .c-benefits-bar` | High | Standard 1 (WCAG 1.3.1, 2.4.6) | Heading hierarchy skip: 4 benefit cards (`<h4>`) appear immediately following Stage 04 (`<h3>`), rendering benefits as sub-items of Stage 04. | Insert `<h3 class="visually-hidden">OneSkills Practical Lab Advantages</h3>` immediately preceding the benefits bar. |
| **S1-07** | `courses/freelancing-mastery.html:2351, 2367, 2379`<br>`footer .footer-col h4` | High | Standard 1 (WCAG 1.3.1) | Skipped heading levels in `<footer>`: column titles are marked as `<h4>` with no preceding `<h2>` or `<h3>` inside the footer landmark. | Promote footer column headings to `<h3>` (`<h3>Career Tracks</h3>`, `<h3>Essential Guides</h3>`, `<h3>Sheikhupura Campus</h3>`). |
| **S1-08** | `courses/freelancing-mastery.html:1498, 1509, 1521, 1533`<br>`#curriculum .blueprint-card h3` | Moderate | Standard 1 (WCAG 1.1.1) | Raw emojis inside heading text (`✨ What Makes...`, `📦 Material...`, `💻 Course...`, `👥 Who Should...`). Screen readers verbalize emoji names. | Wrap emojis in `<span aria-hidden="true">✨</span>` so they are decorative and screen readers announce clean text. |
| **S1-09** | `courses/freelancing-mastery.html:1658-1701`<br>`#comparison table.c-comp-table` | Serious | Standard 1 (WCAG 1.3.1) | Comparison table lacks `<caption>`, column headers lack `scope="col"`, and row headers in `<tbody>` are plain `<td><strong>` cells instead of `<th scope="row">`. | Add `<caption class="visually-hidden">Comparison between OneSkills Practical Lab and Traditional Institutes</caption>`, add `scope="col"` to header `<th>`s, and change row labels to `<th scope="row">`. |
| **S1-10** | `courses/freelancing-mastery.html:1086, 1120, etc.`<br>`#curriculum .c-lessons-grid` | Moderate | Standard 1 (Semantics) | Numbered lessons (01 through 84) are sequential instructional steps currently represented as plain `<div>`s instead of ordered list items. | Wrap lesson items in `<ol class="c-lessons-grid module-lessons-grid">` with `<li class="c-lesson-item lesson-item">`. |
| **S1-11** | `courses/freelancing-mastery.html:1725, 2115`<br>`.c-specs-rows`, `.c-dates-list` | Moderate | Standard 1 (Semantics) | Key-value pairs (Hardware node, Power backup, Schedule, Batch Cap) are plain `<div>`s. | Refactor into semantic `<dl class="c-specs-rows">` with `<dt>` and `<dd>`. |
| **S1-12** | `courses/freelancing-mastery.html:849, 1048, 1780`<br>`#skill-pillar-tabs`, `#curriculum-filter-tabs` | Serious | Standard 1 (WAI-ARIA) | Filter bars declare `role="tablist"` and buttons declare `role="tab"` but omit `role="tabpanel"`, `aria-controls`, and arrow-key roving navigation. | Convert filter pills to `<div class="filter-tabs" role="group" aria-label="...">` with `aria-pressed="true|false"` buttons. |
| **S1-13** | `courses/freelancing-mastery.html:2098-2101`<br>`.fee-plan-btns` | High | Standard 1 (WCAG 4.1.2) | Tuition toggle buttons (`#btn-fee-full`, `#btn-fee-install`) lack `aria-pressed` synchronization. Screen readers cannot detect active plan. | Add `aria-pressed="true"` to active plan and `aria-pressed="false"` to inactive plan, toggled by JS. |
| **S1-14** | `courses/freelancing-mastery.html:2065`<br>`.c-batch-slots-grid` | Moderate | Standard 1 (WAI-ARIA) | Time slot picker declared as tablist without tabpanels. | Convert to `<div class="c-batch-slots-grid" role="radiogroup" aria-label="Select Batch Time Slot">` with `role="radio"` and `aria-checked="true|false"`. |
| **S1-15** | `courses/freelancing-mastery.html:2084, 2095, 1834`<br>`#batch-dynamic-info`, `.c-tuition-block` | Moderate | Standard 1 (WCAG 4.1.3) | Dynamic updates to batch seats, tuition prices, and town routes lack live announcement. | Add `aria-live="polite"` and `aria-atomic="true"` to container elements. |

---

```
+-------------------------------------------------------------------------------------------------------------------------+
| Standard 2: Layout Spacing & 8-Pixel Grid System                                                                        |
+-------------------------------------------------------------------------------------------------------------------------+
```

| ID | Target File & Line/Selector | Severity | Standard Violated | Description of Issue | Actionable Proposed Fix |
|---|---|---|---|---|---|
| **S2-01** | `courses/freelancing-mastery.html`<br>54 inline `style="..."` attributes | High | Standard 2 (8px Grid & DX) | 54 inline styles contain non-8px spacing (`margin-bottom: 12px; gap: 12px; margin-bottom: 4px; margin-bottom: 14px; margin-bottom: 10px; margin-top: 6px; padding-top: 14px;`). | Extract all inline styles into semantic CSS classes conforming to 8px multiples (8px, 16px, 24px, 32px) in `course-v2.css`. |
| **S2-02** | `assets/css/course-v2.css:54`<br>`.c-eyebrow` | Medium | Standard 2 (8px Grid) | `margin-bottom: 12px;` violates 8px grid. | Update to `margin-bottom: 16px;`. |
| **S2-03** | `assets/css/course-v2.css:88`<br>`.c-breadcrumbs` | High | Standard 2 (8px Grid) | `padding: calc(var(--header-h, 72px) + 20px) 0 12px;` uses 20px and 12px. | Update to `padding: calc(var(--header-h, 72px) + 24px) 0 16px;`. |
| **S2-04** | `assets/css/course-v2.css:147, 154`<br>`.c-badge-pill` | Medium | Standard 2 (8px Grid) | `padding: 6px 14px; margin-bottom: 20px;` use 6px, 14px, 20px. | Update to `padding: 8px 16px; margin-bottom: 16px;` (or `24px`). |
| **S2-05** | `assets/css/course-v2.css:171`<br>`.c-hero-h1` | High | Standard 2 (8px Grid) | `margin: 0 0 18px;` violates 8px grid. | Update to `margin: 0 0 16px;`. |
| **S2-06** | `assets/css/course-v2.css:185-186, 193`<br>`.c-hero-guarantee` | High | Standard 2 (8px Grid) | `gap: 10px; padding: 10px 16px; margin-bottom: 28px;` use 10px, 28px. | Update to `gap: 8px; padding: 8px 16px; margin-bottom: 32px;`. |
| **S2-07** | `assets/css/course-v2.css:210, 218, 241`<br>`.c-hero-ctas`, `.c-btn-primary`, `.c-btn-secondary` | High | Standard 2 (8px Grid) | `margin-bottom: 28px; padding: 13px 24px; padding: 13px 20px;` use 28px, 13px, 20px. | Update to `margin-bottom: 32px; padding: 16px 24px;`. |
| **S2-08** | `assets/css/course-v2.css:261-262`<br>`.c-hero-video-cta` | High | Standard 2 (8px Grid) | `gap: 12px; padding: 6px 18px 6px 6px;` use 6px, 12px, 18px. | Update to `padding: 8px 24px 8px 8px; gap: 8px;`. |
| **S2-09** | `assets/css/course-v2.css:414-415, 434-453`<br>`.c-float-badge` & positioning | High | Standard 2 (8px Grid) | `gap: 10px; padding: 8px 14px; top: -14px; left: -18px; right: -22px; bottom: 155px;` use non-8px offsets. | Update to `gap: 8px; padding: 8px 16px; min-height: 48px; top: -16px; left: -16px; right: -24px; bottom: 160px;`. |
| **S2-10** | `assets/css/course-v2.css:588, 603`<br>`.c-facts-strip`, `.c-fact-node` | High | Standard 2 (8px Grid) | `padding: 28px 0; gap: 12px;` use 28px, 12px. | Update to `padding: 32px 0; gap: 16px;`. |
| **S2-11** | `assets/css/course-v2.css:740, 744`<br>`.c-outcome-card` | High | Standard 2 (8px Grid) | `padding: 26px 24px; gap: 14px;` use 26px, 14px. | Update to `padding: 24px; gap: 16px;`. |
| **S2-12** | `assets/css/course-v2.css:832, 853, 908`<br>`.c-curriculum-item`, `.c-curriculum-trigger`, `.c-curriculum-body` | High | Standard 2 (8px Grid) | `margin-bottom: 14px; padding: 18px 24px; padding: 0 24px 22px;` use 14px, 18px, 22px. | Update to `margin-bottom: 16px; padding: 16px 24px; padding: 0 24px 24px;`. |
| **S2-13** | `assets/css/course-v2.css:1344, 1475, 1488, 1526`<br>`.c-admissions-card`, `.c-faq-item`, `.c-faq-trigger` | High | Standard 2 (8px Grid) | `padding: 34px 30px; margin-bottom: 14px; padding: 18px 24px; padding: 0 24px 22px;` violate grid. | Normalize to `padding: 32px; margin-bottom: 16px; padding: 16px 24px; padding: 0 24px 24px;`. |
| **S2-14** | `assets/css/course-v2.css:1705, 2024, 2138, 2252, 2322, 2368, 2434, 2516, 2574`<br>Stage, pillar, table, commuter, dock | High | Standard 2 (8px Grid) | 238 total declarations across all components contain 10px, 14px, 18px, 22px, 26px, 28px, 30px. | Batch normalize all 238 property declarations to exact 8px multiples (8px, 16px, 24px, 32px, 48px). |
| **S2-15** | `assets/css/course-v2.css:56 fixed dimensions`<br>`.c-play-pulse`, `.c-fact-node svg`, `.c-outcome-card-icon`, etc. | Medium | Standard 2 (8px Grid) | 56 fixed dimensions (`42px`, `14px`, `36px`, `46px`, `18px`, `44px`, `26px`) violate 8px grid. | Adjust dimensions to nearest 8px values (`40px` or `48px`, `16px`, `32px`, `48px`, `24px`). |
| **S2-16** | `assets/css/main.css:808, 8987, 8994, 9103`<br>Header CTA, footer headings, footer bottom bar | Medium | Standard 2 (8px Grid) | Global header button (`padding: 8px 20px`), footer headings (`margin-bottom: 18px`), footer bottom bar (`padding: 18px ... 20px`). | Provide course page overrides in `course-v2.css` or normalize in `main.css` to 8px multiples (`8px 16px`, `16px`, `16px ... 24px`). |

---

```
+-------------------------------------------------------------------------------------------------------------------------+
| Standard 3: prefers-reduced-motion Accessibility Compliance                                                             |
+-------------------------------------------------------------------------------------------------------------------------+
```

| ID | Target File & Line/Selector | Severity | Standard Violated | Description of Issue | Actionable Proposed Fix |
|---|---|---|---|---|---|
| **S3-01** | `assets/css/course-v2.css:3372-3385`<br>`@media (prefers-reduced-motion: reduce)` | High | Standard 3 (WCAG 2.3.3) | Existing reduced-motion block does NOT reset `animation-delay` and `transition-delay`. Floating badges with `1.1s` delays trigger abrupt, sudden shifts. | Add `animation-delay: 0s !important;` and `transition-delay: 0s !important;` to universal reset block. |
| **S3-02** | `assets/css/course-v2.css:457-465`<br>`@keyframes os-float-a`, `os-float-b` | High | Standard 3 (WCAG 2.3.3) | Continuous infinite translation loops (`translateY(-7px)` / `translateY(7px)`) remain active under `0.01ms` rapid iteration. | Explicitly stop floating animations: `body.course-v2-page [class*="c-float-badge"] { animation: none !important; transform: none !important; }`. |
| **S3-03** | `assets/css/course-v2.css:232, 755, 987, 1222, 1720, 2065`<br>Hover transforms | High | Standard 3 (WCAG 2.3.3) | 12 interactive component classes retain physical hover translations (`translateY(-2px)`, `translateY(-3px)`, `scale(1.03)`), causing dizziness for users with vestibular sensitivity. | Neutralize hover transforms: `body.course-v2-page :is(.c-btn-primary, .c-btn-secondary, .c-hero-video-cta, .c-outcome-card, .c-deliverable-card, .c-related-card, .c-brand-logo, .stage-card, .stage-number, .pillar-card, .batch-slot-card, .c-editorial-art-card, .c-video-thumb img):hover { transform: none !important; }`. |
| **S3-04** | `assets/css/course-v2.css:2538, 2552`<br>`.c-toast` centering protection | Critical | Standard 3 & UX | A blanket `transform: none !important;` resets `translateX(-50%)`, throwing the toast notification completely off-center to the far right. | Explicitly protect `.c-toast`: `transform: translateX(-50%) translateY(0) !important; transition: none !important;`. |
| **S3-05** | `assets/css/course-v2.css:3382`<br>`.vibe-asset` animated stickers | Low | Standard 3 (Motion) | Animated WebP stickers continue playback. | Apply motion-dampening: `opacity: 0.75; filter: grayscale(15%);`. |
| **S3-06** | `assets/js/course-v2.js:84-107`<br>`anchorLinks` smooth scroll | High | Standard 1 & 3 (WCAG 2.4.1) | Smooth scroll intercepts `<a href="#main-content" class="skip-link">`, preventing keyboard focus relocation to `<main id="main-content">`. | Exclude `.skip-link` from JS smooth scroll handler and set programmatic focus: `target.setAttribute('tabindex', '-1'); target.focus({ preventScroll: true });`. |

---

```
+-------------------------------------------------------------------------------------------------------------------------+
| Standard 4: CSS Variables for Colors & Theme Switching                                                                 |
+-------------------------------------------------------------------------------------------------------------------------+
```

| ID | Target File & Line/Selector | Severity | Standard Violated | Description of Issue | Actionable Proposed Fix |
|---|---|---|---|---|---|
| **S4-01** | `assets/css/course-v2.css:220, 282, 770, 2395, 2527, 2541`<br>Hardcoded `#ffffff` | High | Standard 4 (Theme Switching) | 8 declarations of raw `color: #ffffff !important` or `#ffffff` without CSS variable binding. | Replace with `var(--accent-convert-text, #ffffff)` or introduce `--text-inverse: #ffffff;`. |
| **S4-02** | `assets/css/course-v2.css:150, 226, 253, 754, 840, 986, 2341`<br>Hardcoded `rgba(110,68,255,...)` | High | Standard 4 (Theme Switching) | 18 declarations use raw `rgba(110, 68, 255, ...)` for borders, glows, and hover surfaces. In dark mode, purple accent hue changes, but hardcoded values remain light-theme fixed. | Map to `var(--line-strong)`, `var(--accent-line)`, `var(--accent-glow)`, `var(--surface-hover)`, and `var(--accent-alpha)`. |
| **S4-03** | `assets/css/course-v2.css:267, 381, 419, 645, 749, 841, 2373, 2580`<br>Plum shadows `rgba(35,27,43,...)` | High | Standard 4 (Theme Switching) | 24 box-shadow declarations use raw light-mode plum tint `rgba(35, 27, 43, ...)`. Renders muddy or completely invisible in dark mode (`#090614`). | Replace with `var(--shadow-card)` and `var(--shadow-hover)` which are defined in `main.css` with dark mode values (`rgba(0,0,0,0.45)`). |
| **S4-04** | `assets/css/course-v2.css:477-480`<br>Pastel badge backgrounds | High | Standard 4 (Theme Switching) | Pastel backgrounds `#fef3c7`, `#d1fae5`, `#ede9fe`, `#ffedd5` glare harshly against dark backgrounds without dark mode tokens. | Introduce semantic CSS tokens in `:root` and dark overrides in `html[data-theme="dark"]` (`--badge-gold-bg`, `--badge-gold-text`, `--badge-emerald-bg`, etc.). |
| **S4-05** | `assets/css/course-v2.css:780, 784, 788, 792`<br>Outcome card gradients | Medium | Standard 4 (Theme Switching) | Hardcoded linear-gradient color stops (`#6e44ff`, `#f43f5e`, `#0284c7`, `#059669`). | Map to CSS variables (`var(--gradient-violet)`, `var(--gradient-rose)`, `var(--gradient-sky)`, `var(--gradient-emerald)`). |
| **S4-06** | `assets/css/course-v2.css:102 declarations total` | High | Standard 4 (Theme Switching) | 102 total hardcoded color declarations scattered across components. | Systematically replace every raw color declaration with custom property bindings. |

---

```
+-------------------------------------------------------------------------------------------------------------------------+
| Standard 5: Cut Taglines, Helper Text & Secondary Labels                                                               |
+-------------------------------------------------------------------------------------------------------------------------+
```

| ID | Target File & Line/Selector | Severity | Standard Violated | Description of Issue | Actionable Proposed Fix |
|---|---|---|---|---|---|
| **S5-01** | `courses/freelancing-mastery.html:388`<br>`.c-brand-logos-heading` | Medium | Standard 5 (Clutter) | All-caps label `PLATFORMS & MARKETING ECOSYSTEMS YOU WILL MASTER IN LAB` clutters top of world-famous logos. | Delete `<p class="c-brand-logos-heading">`. Separate logo row with clean border (`margin-top: 24px; padding-top: 16px; border-top: 1px solid var(--line);`). |
| **S5-02** | `courses/freelancing-mastery.html:846, 858-860`<br>Skill counter note & eyebrow | Medium | Standard 5 (Clutter) | Redundant eyebrow `21 Core Capabilities` and sentence `Showing 21 specialized skill modules included in your 3-month practical training:` repeat H2 and filter count. | Remove the eyebrow and helper sentence. Category filter pills (`All 21 Skills`, `SEO (8)`, etc.) clearly communicate count and categories. |
| **S5-03** | `courses/freelancing-mastery.html:1654-1657`<br>`.c-swipe-hint` | Medium | Standard 5 (Clutter) | Explaining how to swipe a table (`Swipe horizontally to compare all features →`) indicates lack of visual affordance. | Remove `.c-swipe-hint` completely. Provide intrinsic affordance via right column peek and subtle gradient shadow fade on scroll container. |
| **S5-04** | `courses/freelancing-mastery.html:1776`<br>Town selector helper instruction | Medium | Standard 5 (Clutter) | Label `Select Your Location for Route Details:` above 5 town pills is instructional noise. | Remove the label. Present town selector as a clean segmented pill bar with `margin-bottom: 16px;`. |
| **S5-05** | `courses/freelancing-mastery.html:2061, 2097`<br>Numbered form step labels | Medium | Standard 5 (Clutter) | `1. Select Batch Slot:` and `2. Tuition Payment Plan:` treat users like an old form wizard. | Delete both step labels. The visual grouping and active pill state provide immediate comprehension. |
| **S5-06** | `courses/freelancing-mastery.html:2325, 2343-2346`<br>Footer brand sub & tagline | Low | Standard 5 (Clutter) | Generic corporate slogan `Skills Today, Brighter Tomorrows.` and badge `ACADEMY` add zero value. | Remove tagline container and sub-label, leaving clean brand mark and descriptive statement. |
| **S5-07** | `courses/freelancing-mastery.html:1990`<br>`.c-proof-disclaimer` | Low | Standard 5 (Clutter) | Redundant micro-disclaimer under Google rating badge. | Remove `.c-proof-disclaimer`; rating card title already specifies "Verified Google Reviews · Sheikhupura Campus". |
| **S5-08** | `courses/freelancing-mastery.html:15 instances`<br>`.c-eyebrow` across sections | Medium | Standard 5 (Clutter) | Eyebrow badges above section titles ("Program Architecture", "The OneSkills Method", "Proof of Learning") clutter layout hierarchy. | Prune redundant `.c-eyebrow` elements so `h2.c-title` immediately anchors the section. Adjust parent `margin-bottom` to 32px. |
| **S5-09** | `courses/freelancing-mastery.html:279, 314, 328, 341, 355`<br>Subtitles on hero video and float badges | Medium | Standard 5 (Clutter) | Helper subtitles (`.c-video-cta-sub`, `.c-float-badge-sub`) crowd the hero stage. | Prune subtitles. Update `.c-hero-video-cta` to `padding: 8px 24px 8px 8px; gap: 8px;` and `.c-float-badge` to `padding: 8px 16px; min-height: 48px;`. |
| **S5-10** | `courses/freelancing-mastery.html:2410-2422`<br>Duplicate mobile dock `<div class="sticky-cta">` | High | Standard 5 & 6 (UX) | Two mobile sticky docks (`.c-mobile-dock` and `.sticky-cta`) stack on mobile screens. | Delete duplicate `<div class="sticky-cta">` block, retaining `<aside class="c-mobile-dock">`. |

---

```
+-------------------------------------------------------------------------------------------------------------------------+
| Standard 6: UX, DX, AX Elevation & Strict Content Integrity                                                             |
+-------------------------------------------------------------------------------------------------------------------------+
```

| ID | Target File & Line/Selector | Severity | Standard Violated | Description of Issue | Actionable Proposed Fix |
|---|---|---|---|---|---|
| **S6-01** | `assets/js/course-v2.js:198`<br>`courses/freelancing-mastery.html:850` | **CRITICAL (P0)** | Standard 6 (UX/AX) | Selector `#skill-pillar-tabs .c-filter-btn` evaluates to `0` elements because HTML has `class="filter-btn"`. Skill category filter is dead. | Update selector in `course-v2.js` to `#skill-pillar-tabs .c-filter-btn, #skill-pillar-tabs .filter-btn`. Also add `c-filter-btn` in HTML. |
| **S6-02** | `assets/js/course-v2.js:244`<br>`courses/freelancing-mastery.html:1049` | **CRITICAL (P0)** | Standard 6 (UX/AX) | Selector `#curriculum-filter-tabs .c-filter-btn` evaluates to `0` elements. Module filter is completely dead. | Update selector in `course-v2.js` to `#curriculum-filter-tabs .c-filter-btn, #curriculum-filter-tabs .filter-btn`. Also add `c-filter-btn` in HTML. |
| **S6-03** | `assets/js/course-v2.js:186-193, 231-239`<br>`#btn-copy-full-curriculum` | **HIGH (P1)** | Standard 6 (UX/DX) | Two conflicting event listeners attached to `#btn-copy-full-curriculum`. Listener 2 overwrites clipboard with 20KB raw text and flashes duplicate toasts. | Remove duplicate listener block (lines 231-239) in `course-v2.js` so clicking cleanly copies the overview. |
| **S6-04** | `courses/freelancing-mastery.html:2410-2422`<br>`assets/js/main.js:305`<br>`assets/js/course-v2.js:112` | **HIGH (P1)** | Standard 6 (UX) | Dual mobile bottom CTA bars collide and overlap on mobile viewports. | Remove `<div class="sticky-cta">` from HTML. Retain `<aside class="c-mobile-dock">`. |
| **S6-05** | `assets/js/course-v2.js:417-440`<br>`courses/freelancing-mastery.html:1780` | Medium | Standard 6 (UX/AX) | Commuter town click handler updates `.active` but fails to update `aria-selected`. Sheikhupura City remains announced as selected forever. | Synchronize `aria-selected="true/false"` alongside `.active` on all town buttons in `course-v2.js`. |
| **S6-06** | `assets/js/course-v2.js:366-384`<br>`courses/freelancing-mastery.html:2098` | Medium | Standard 6 (UX/AX) | Tuition switcher toggles `.active` but fails to update `aria-pressed`. | Add `btnFeeFull.setAttribute('aria-pressed', String(isFull))` and `btnFeeInstall.setAttribute('aria-pressed', String(!isFull))`. |
| **S6-07** | `assets/js/course-v2.js:60-70`<br>`subnavLinks` scroll-spy | Medium | Standard 6 (UX/AX) | Subnavigation IntersectionObserver updates `.active` but does not set `aria-current="true"`. | Set `link.setAttribute('aria-current', 'true')` on the active link and remove from others. |
| **S6-08** | `assets/js/course-v2.js:140-153`<br>`.c-toast` notification | Medium | Standard 6 (AX) | Dynamically created `.c-toast` lacks `role="status"` and `aria-live="polite"`. | Add `toast.setAttribute('role', 'status')` and `toast.setAttribute('aria-live', 'polite')`. |
| **S6-09** | `assets/js/course-v2.js:21-43`<br>`.c-tab-btn`, `.c-studio-pane` | Low | Standard 6 (DX) | Orphaned dead prototype code querying non-existent classes. | Remove orphaned block from `course-v2.js`. |
| **S6-10** | `courses/freelancing-mastery.html:2406`<br>`refinement.js` reference | Low | Standard 6 (DX/Perf) | `refinement.js` only executes on `.home-page`. Loading it on `.course-v2-page` is a wasted HTTP request. | Remove `<script src="../assets/js/refinement.js" defer></script>` from `courses/freelancing-mastery.html`. |
| **S6-11** | **IMMUTABLE CONTENT PRESERVATION DIRECTIVE** | **MANDATORY** | Standard 6 (Integrity) | All 12 modules, 84 lessons, learning outcomes, and pricing figures must be strictly preserved without modification. All 10 dynamic element IDs used by JS must be retained. | Strictly protect all educational copy and pricing numbers (`PKR 25,000`, `2 installments of PKR 12,500`, `PKR 8,500 / mo`) and IDs `#batch-slot-title`, `#batch-seats-badge`, `#batch-audience-note`, `#card-wa-btn-text`, `#card-wa-cta`, `#fee-display-amount`, `#fee-display-sub`, `#map-route-badge`, `#town-commute-title`, `#town-commute-desc`. |

---

## Action Plan & Remediation Sequence

1. **Step 1: JS Remediation (`assets/js/course-v2.js`)**:
   - Update filter button selectors for skill pillars (line 198) and curriculum modules (line 244) to support both `.c-filter-btn` and `.filter-btn`.
   - Remove duplicate copy listener on `#btn-copy-full-curriculum` (lines 231-239).
   - Exclude `.skip-link` from smooth scroll and implement programmatic focus transfer to target section with `tabindex="-1"`.
   - Synchronize `aria-selected` on commuter town buttons, `aria-pressed` on tuition toggle buttons, and `aria-current="true"` on subnavigation links.
   - Add `role="status"` and `aria-live="polite"` to dynamically created `.c-toast`.
   - Remove orphaned studio tabs prototype code.

2. **Step 2: HTML Remediation (`courses/freelancing-mastery.html`)**:
   - Replace generic `<div>` with semantic `<figure>`, `<article>`, `<dl>`, `<dt>`, `<dd>`, `<ol>`, `<li>`.
   - Normalize heading hierarchy: add visually hidden `<h3>` before outcomes and benefits, promote footer column headings to `<h3>`, wrap raw emojis in `<span aria-hidden="true">`.
   - Accessible table: add `<caption>`, `<th scope="col">` on table headers, `<th scope="row">` on row headers.
   - WAI-ARIA conformance: replace tablist with button groups / radiogroups, add `aria-live="polite"` to dynamic containers (`#batch-dynamic-info`, `.c-tuition-block`, town route box).
   - Prune clutter: remove table swipe hint, town instruction label, form step labels, footer tagline, brand sub-badge, and redundant `.c-eyebrow` instances.
   - Delete duplicate mobile bottom bar (`<div class="sticky-cta">`) and redundant `refinement.js` script tag.
   - Extract all 54 inline style attributes into semantic CSS classes conforming to 8px grid.
   - Strictly verify all 12 modules, 84 lessons, and pricing numbers remain 100% identical.

3. **Step 3: CSS Remediation (`assets/css/course-v2.css`)**:
   - Normalize all 238 spacing property declarations and 56 fixed dimensions to strict multiples of the 8px grid (8px, 16px, 24px, 32px, 48px, etc.).
   - Rewrite reduced-motion media query to zero delays, disable continuous float keyframes, neutralize hover transforms, and protect `.c-toast` centering.
   - Replace 102 hardcoded color declarations with CSS variables, adding theme-aware badge and gradient token definitions with dark mode overrides.
   - Adjust `.c-hero-video-cta` padding/gap (`padding: 8px 24px 8px 8px; gap: 8px;`) and `.c-float-badge` (`padding: 8px 16px; gap: 8px; min-height: 48px;`).

4. **Step 4: Automated Verification & Testing**:
   - PowerShell scripts verifying 0 non-8px spacing violations and 0 hardcoded colors in `course-v2.css`.
   - Content integrity diff verifying 0 alterations to curriculum text or pricing figures.
   - Reduced-motion and ARIA state verification.
   - Final Hard Handoff documentation in `handoff.md`.
