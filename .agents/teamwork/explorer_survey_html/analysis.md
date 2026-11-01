# HTML, Semantic Accessibility, Spacing & Content Audit: `courses/freelancing-mastery.html`

**Target File**: `courses/freelancing-mastery.html` (2,426 lines)  
**Associated Files Analyzed**: `assets/js/course-v2.js`, `assets/css/course-v2.css`, `assets/css/main.css`  
**Auditor**: Explorer 1 (HTML & Semantic Accessibility Auditor)  
**Audit Date**: 2026-10-31  

---

## 1. Executive Summary

A comprehensive, line-by-line investigation of `courses/freelancing-mastery.html` was conducted against the project's standing engineering and design standards, specifically focusing on **Standard 1** (Semantic HTML5 elements, proper landmarks, heading hierarchy, and ARIA attributes), **Standard 2** (Layout spacing and 8px grid alignment across inline styles and classes), **Standard 5** (Removal of taglines, helper text, and secondary labels in favor of improved visual layout), and **Standard 6** (Strict preservation and freezing of all course curriculum, learning outcomes, and pricing numbers).

### Key Audit Highlights
1. **Semantic Landmarks & ARIA Violations**: Multiple generic `<div>` elements inappropriately carry `aria-label` attributes without landmark or widget roles (violating W3C ARIA specs). Tabs in filter bars (`#skill-pillar-tabs`, `#curriculum-filter-tabs`, `.commuter-town-pills`, `.c-batch-slots-grid`) declare `role="tablist"` and `role="tab"` but omit `role="tabpanel"`, `aria-controls`, and keyboard arrow handling. Button plan switchers lack `aria-pressed`.
2. **Heading Hierarchy Flaws**:
   - In Section `#overview`, learning outcome cards jump to `<h4>` directly below `<h3>Who will thrive in this cohort:</h3>` without an enclosing `<h3>` or peer relationship.
   - In Section `#method`, the 4 benefit cards jump to `<h4>` directly below `<h3>04 · Apply & Win Clients</h3>` without an overarching `<h3>`.
   - In `<footer>`, column titles jump directly to `<h4>` with no preceding `<h2>` or `<h3>` in the footer landmark.
   - Raw emojis are embedded inside `<h3>` titles in the blueprint cards, causing screen readers to announce them as words ("sparkles", "package", "laptop", "busts in silhouette").
3. **54 Inline Style Attributes & 8px Grid Violations**: 54 inline `style="..."` attributes are scattered across the document. Numerous values violate the 8px grid system (`margin-bottom: 12px`, `margin-bottom: 4px`, `margin-bottom: 14px`, `margin-bottom: 10px`, `gap: 12px`, `margin-top: 6px`, `padding-top: 14px`). These must be extracted into semantic CSS classes conforming to 8px multiples (8px, 16px, 24px, 32px).
4. **JS Selector Class Mismatch**: `assets/js/course-v2.js` queries `#skill-pillar-tabs .c-filter-btn` and `#curriculum-filter-tabs .c-filter-btn`, whereas `courses/freelancing-mastery.html` specifies `class="filter-btn"` (lacking `c-filter-btn`), causing potential filter event listener detachment.
5. **Redundant Duplicate Mobile Docks**: The markup contains both `<aside class="c-mobile-dock">` (line 2306) and `<div class="sticky-cta">` (line 2410).
6. **Interface Clutter**: Helper text (such as `"Swipe horizontally to compare all features →"`, `"Select Your Location for Route Details:"`, `"1. Select Batch Slot:"`, `"2. Tuition Payment Plan:"`, and corporate taglines) clutters the UI and can be eliminated through better layout and affordance.
7. **Frozen Content Asset**: A complete, verbatim inventory of all 12 modules, 84 lessons, 21 skill pillars, 4 learning outcomes, and all pricing figures was captured and frozen below.

---

## 2. Standard 1: Semantic HTML5 Elements, Landmarks, Heading Hierarchy & ARIA Audit

### 2.1 Landmark Regions & Semantic Elements

| Location / Line(s) | Current Element / Attribute | Issue Description | Severity | Suggested Remediation |
|---|---|---|---|---|
| **Lines 178–181** | `<a class="logo" aria-label="OneSkills Academy home"><img class="logo-light-img" alt="OneSkills Academy"><img class="logo-dark-img" alt="OneSkills Academy"></a>` | Both logo images have identical alt text within an anchor that already has `aria-label`, causing redundant announcement in screen readers. | Moderate | Set `alt=""` or `aria-hidden="true"` on the logo images since the parent link has an accessible `aria-label`. |
| **Line 303** | `<div class="c-hero-editorial-stage" aria-label="Course Overview &amp; Verified Proof Badges">` | `aria-label` on generic `<div>` without landmark/widget role violates W3C ARIA conformance. | Moderate | Convert to `<figure class="c-hero-editorial-stage" aria-label="Course Overview and Verified Proof Badges">` or remove `aria-label` and let child cards provide structure. |
| **Line 360–383** | `<div class="c-editorial-art-card">` | Editorial artwork card containing course imagery and key facts should be a semantic figure with caption. | Low | Wrap image and fact badges inside `<figure class="c-editorial-art-card">` with `<figcaption class="c-art-facts-panel">`. |
| **Line 387** | `<div class="c-brand-logos-card" aria-label="Platforms covered in the course">` | Generic `<div>` with `aria-label` without a role. | Moderate | Convert to `<figure class="c-brand-logos-card">` or `<div role="region" aria-label="Platforms covered in the course">`. |
| **Line 473** | `<section class="c-facts-strip" aria-label="Course quick facts">` | Section lacks a heading element (`aria-labelledby`). Sections without headings reduce navigational clarity. | Moderate | Add visually hidden `<h2>Key Program Metrics</h2>` (using `.visually-hidden`) or link `aria-labelledby`. |
| **Lines 660–666** | `<div class="c-portrait-card">` with `<img>` and quote | Campus lab portrait card with founder quotation. | Low | Convert to `<figure class="c-portrait-card">` with `<figcaption class="c-portrait-quote">`. |
| **Line 750** | `<div class="c-benefits-bar" aria-label="OneSkills Lab Strengths">` | Generic `<div>` with `aria-label`. | Moderate | Convert to `<div class="c-benefits-bar" role="region" aria-label="OneSkills Lab Strengths">` or provide an accessible heading. |
| **Lines 862–1030** | `<div class="c-skills-21-grid">` with 21 skill cards | The 21 skill pillars are styled `<div>` elements with `<span class="c-skill-pillar-title">` instead of semantic items or headings. | Moderate | Mark up cards as `<article class="c-skill-pillar-card">` and promote title to `<h4 class="c-skill-pillar-title">`. |
| **Lines 1086, 1120, 1154, 1188, 1228, 1262, 1296, 1330, 1370, 1404, 1438, 1472** | `<div class="c-lessons-grid module-lessons-grid">` with 7 lesson divs | Numbered lessons (01 through 84) are sequential instructional steps currently represented as plain `<div>`s instead of ordered list items. | Moderate | Wrap lessons in `<ol class="c-lessons-grid module-lessons-grid">` with `<li class="c-lesson-item lesson-item">` for proper assistive tech list semantics. |
| **Lines 1658–1701** | `<table class="c-comp-table comp-table">` | Comparison table lacks `<caption>`, column headers lack `scope="col"`, and row headers in `<tbody>` (lines 1670, 1676, 1682, 1688, 1694) are plain `<td><strong>` instead of `<th scope="row">`. | Serious | Add `<caption class="visually-hidden">Comparison between OneSkills Academy and other training options</caption>`, add `scope="col"` to `<th>`, and change row headers to `<th scope="row">`. |
| **Lines 1725–1756** | `<div class="c-specs-rows">` with `.c-spec-row` | Key-value technical specifications (Workstation Node, Power Continuity, Network Backbone, Campus Location) are generic `<div>`s. | Moderate | Convert to semantic definition list `<dl class="c-specs-rows">`, with `<dt class="c-spec-key">` and `<dd class="c-spec-val">`. |
| **Line 1790** | `<svg ... aria-label="Sheikhupura Lahore-Sargodha Road Campus Corridor Map">` | SVG has `aria-label` but lacks `role="img"`. | Low | Add `role="img"` to the `<svg>`. |
| **Lines 1966–1977, 1996–2022** | `<div class="c-featured-review">`, `<div class="c-mini-review-card">` | Student testimonials are plain `<div>`s. | Low | Convert to `<figure>` with `<blockquote>` and `<figcaption class="c-reviewer-info">`. |
| **Lines 2115–2132** | `<div class="c-dates-list">` with `.c-date-row` | Cohort administrative specifications (Batch Start Date, Schedule, Workstation, Batch Cap) are key-value pairs in `<div>`s. | Moderate | Convert to `<dl class="c-dates-list">` with `<dt class="c-date-label">` and `<dd class="c-date-value">`. |
| **Line 2284** | `<section class="c-section" style="border-bottom: 0;">` | Final conversion CTA section lacks `aria-labelledby` or `aria-label`. | Moderate | Add `id="final-cta"` and `aria-labelledby="final-cta-title"`, pointing to `<h2 id="final-cta-title">`. |
| **Line 2410** | `<div class="sticky-cta" aria-label="Quick actions">` | Redundant second sticky bottom mobile bar duplicated below footer while `.c-mobile-dock` is already active. | Serious | Remove duplicate `.sticky-cta` element or unify with `.c-mobile-dock`. |

---

### 2.2 Heading Hierarchy Audit

```
Current Heading Progression:
h1 : Freelancing & Digital Marketing Mastery with Modern AI Tools [Line 248]
  h2 : The Complete Digital Marketing & Freelance Blueprint for 2026 [Line 564]
    h3 : Who will thrive in this cohort: [Line 582]
      h4 : Meta & Google Ads Mastery [Line 604]  <-- VIOLATION: Not sub-items of suitability!
      h4 : AI Content & Video Engine [Line 614]
      h4 : Local SEO & Google Maps Rank [Line 626]
      h4 : Client Monetization & Dual Income [Line 638]
  h2 : How You Go From Beginner to Active Freelancer [Line 654]
    h3 : 01 · Learn Core Funnels & SEO [Line 680]
    h3 : 02 · Practice on Workstations [Line 699]
    h3 : 03 · Build 4 Client Case Studies [Line 719]
    h3 : 04 · Apply & Win Clients [Line 738]
      h4 : Live Practitioner Mentorship [Line 759]  <-- VIOLATION: Not sub-items of Stage 04!
      h4 : 1 Workstation Per Student [Line 773]
      h4 : AI-Augmented Workflows [Line 786]
      h4 : Payoneer & Payout Rails [Line 799]
  h2 : Special 2026-2027 Skill Stack You Will Master [Line 814]
    h3 : 21 Pillars of Modern Agency Practice [Line 847]
  h2 : Complete 12-Week Digital Marketing & Freelancing Curriculum [Line 1042]
    h3 : Module 01 through Module 12 [Lines 1078, 1112, 1146, 1180, 1220, 1254, 1288, 1322, 1362, 1396, 1430, 1464]
    h3 : ✨ What Makes This Course Different? [Line 1498]  <-- VIOLATION: Raw emoji in heading
    h3 : 📦 Material & Support Included [Line 1509]       <-- VIOLATION: Raw emoji in heading
    h3 : 💻 Course Requirements & Class Format [Line 1521] <-- VIOLATION: Raw emoji in heading
    h3 : 👥 Who Should Join This Course? (Audience) [Line 1533] <-- VIOLATION: Raw emoji in heading
  h2 : 4 Production Assets You Will Build & Launch [Line 1570]
    h3 : 4 Deliverable titles [Lines 1581, 1597, 1613, 1629]
  h2 : OneSkills Practical Lab vs. Traditional Theory Academies [Line 1649]
  h2 : Dedicated Lab Workstations at Sheikhupura Campus [Line 1711]
    h3 : 100% Dedicated Workstation Nodes [Line 1720]
  h2 : Sheikhupura Campus & Feeder Belt Transport Routes [Line 1768]
    h3 : Book Free On-Campus Demo [Line 1847]
  h2 : Learn from verified digital marketing & client mentors. [Line 1919]
    h3 : Nisar Mehar [Line 1930]
  h2 : Real results from our Sheikhupura lab cohorts. [Line 1960]
  h2 : Cohort Brief & Enrollment Details [Line 2032]
    h3 : How Admissions Works [Line 2038]
      h4 : 14-Day Zero-Risk Trial Policy [Line 2044]
  h2 : Concrete answers to common questions. [Line 2157]
  h2 : Related Programs at OneSkills [Line 2230]
    h3 : 3 Related course cards [Lines 2241, 2256, 2271]
  h2 : Launch Your Digital Marketing & Freelance Career in Sheikhupura [Line 2289]
  [Footer landmark starts - Line 2318]
    h4 : Career Tracks [Line 2351]       <-- VIOLATION: Skipped heading levels (h2, h3 missing)
    h4 : Essential Guides [Line 2367]    <-- VIOLATION: Skipped heading levels
    h4 : Sheikhupura Campus [Line 2379]  <-- VIOLATION: Skipped heading levels
```

#### Remediation Plan for Heading Hierarchy:
1. **Section `#overview`**: Add `<h3 class="visually-hidden">Key Learning Outcomes</h3>` above `.c-outcomes-grid` (or elevate the 4 outcome titles to `<h3>` so they sit as siblings to `<h3>Who will thrive in this cohort:</h3>`).
2. **Section `#method`**: Add `<h3 class="visually-hidden">OneSkills Lab Strengths & Core Benefits</h3>` above `.c-benefits-bar` so the 4 benefit cards (`h4`) have an explicit, logical parent.
3. **Curriculum Blueprint Cards**: Remove raw emoji characters from `<h3>` tags (`✨`, `📦`, `💻`, `👥`). Wrap emojis in `<span aria-hidden="true">✨</span>` so screen readers do not verbalize them as words.
4. **Footer Landmark**: Change `<h4>Career Tracks</h4>`, `<h4>Essential Guides</h4>`, and `<h4>Sheikhupura Campus</h4>` to `<h3>` elements, resolving the skipped heading level violation (WCAG 1.3.1).

---

### 2.3 ARIA Attributes & Widget Conformance

| Element / Selector | Current ARIA Markup | Issue | Severity | Proposed Fix |
|---|---|---|---|---|
| `#skill-pillar-tabs` (Line 849) | `role="tablist"` with buttons `role="tab"` | Filter bar is marked as a tablist without `role="tabpanel"`, without `aria-controls`, and lacking arrow-key navigation. | Serious | Either implement true tabpanels with keyboard arrow handling, or convert to a filter toolbar/group: `<div class="filter-tabs" role="group" aria-label="Filter skills by category">` with `<button type="button" class="filter-btn c-filter-btn" aria-pressed="true/false">`. |
| `#curriculum-filter-tabs` (Line 1048) | `role="tablist"` with buttons `role="tab"` | Filter buttons masquerading as tabs without tabpanels. | Serious | Convert to `<div class="filter-tabs" role="group" aria-label="Filter curriculum by module type">` with `aria-pressed="true/false"` buttons. |
| `.commuter-town-pills` (Line 1780) | `role="tablist"` with buttons `role="tab"` | Town switcher marked as tablist without tabpanel associations. | Serious | Provide `aria-controls="town-commute-box"` or convert to a button group with `aria-pressed`. |
| `.c-batch-slots-grid` (Line 2065) | `role="tablist"` with buttons `role="tab"` | Time slot picker marked as tablist. | Moderate | Convert to a radio group (`role="radiogroup" aria-label="Select batch time slot"`) with `role="radio"` and `aria-checked="true/false"`, which matches the semantics of selecting one slot. |
| `.fee-plan-btns` (Line 2098–2101) | `<button type="button" class="fee-plan-btn active">` | Active button lacks `aria-pressed="true"` (and sibling lacks `aria-pressed="false"`). Screen readers cannot detect which payment plan is selected. | Serious | Add `aria-pressed="true"` to active plan button and `aria-pressed="false"` to inactive button, toggled dynamically by JS. |
| `button.hamburger` (Line 214) | `aria-expanded="false" aria-controls="primary-nav"` | When clicked, JS must toggle `aria-expanded="true"`. | Low | Verify `main.js` correctly toggles `aria-expanded` upon menu open/close. |

---

### 2.4 JavaScript Event Hook & Markup Class Mismatch

**Location**: `assets/js/course-v2.js` vs `courses/freelancing-mastery.html`

- **Observation**:
  - In `assets/js/course-v2.js` line 198:
    ```javascript
    const skillTabs = Array.from(document.querySelectorAll('#skill-pillar-tabs .c-filter-btn'));
    ```
  - In `courses/freelancing-mastery.html` lines 850–854:
    ```html
    <button type="button" class="filter-btn active" data-skill-cat="all" ...>All 21 Skills</button>
    ```
  - In `assets/js/course-v2.js` line 244:
    ```javascript
    const modFilterBtns = Array.from(document.querySelectorAll('#curriculum-filter-tabs .c-filter-btn'));
    ```
  - In `courses/freelancing-mastery.html` lines 1049–1053:
    ```html
    <button type="button" class="filter-btn active" data-mod-filter="all" ...>All 12 Weeks (6 Modules)</button>
    ```
- **Impact**: Because the HTML buttons use `filter-btn` and omit `c-filter-btn`, the selectors `#skill-pillar-tabs .c-filter-btn` and `#curriculum-filter-tabs .c-filter-btn` in `course-v2.js` evaluate to empty arrays! The tab filtering for 21 skills and 12 modules silently fails to bind!
- **Severity**: Critical (Breaks core interactive functionality).
- **Remediation**: Add `c-filter-btn` to the buttons in HTML (`class="filter-btn c-filter-btn active"`), or update the JS selector to support `.filter-btn, .c-filter-btn`.

---

## 3. Standard 2: Layout Spacing & 8-Pixel Grid System Violations

### 3.1 Inline Styles Inventory (54 Instances) & Spacing Audit

Every inline `style="..."` attribute in `courses/freelancing-mastery.html` was audited. The table below lists all instances with line numbers, non-8px violations, and remediation targets:

| Line Number | Current Inline Style | 8px Grid Violation | Remediation Target |
|---|---|---|---|
| **Line 844** | `display: flex; flex-wrap: wrap; align-items: flex-end; justify-content: space-between; gap: 12px; margin-bottom: 12px;` | `gap: 12px` and `margin-bottom: 12px` violate 8px grid (should be 8px or 16px). | Move to CSS class `.c-skills-header-row` with `gap: 16px; margin-bottom: 16px;`. |
| **Line 846** | `margin-bottom: 4px;` | 4px is not a multiple of 8px. | Set `margin-bottom: 8px;` or `0;`. |
| **Line 847** | `font-size: 1.25rem; font-weight: 800; color: var(--text-1); margin: 0;` | Inline typographic and color declarations. | Move to class `.c-skills-heading`. |
| **Line 858** | `font-size: 0.8rem; color: var(--text-3); font-weight: 600; margin-bottom: 16px;` | Inline typography (16px spacing is valid). | Move to class `.c-skills-count-note`. |
| **Line 859** | `color: var(--accent);` | Inline color style. | Move to class `.c-accent-val`. |
| **Line 1548** | `max-width: 780px;` | Inline container max-width. | Move to class `.c-ethical-text-wrap`. |
| **Line 1549** | `font-size: 0.74rem; font-weight: 800; color: #f59e0b; letter-spacing: 0.08em; text-transform: uppercase; margin-bottom: 4px;` | Hardcoded hex color (`#f59e0b`), non-8px margin (`4px`). | Move to class `.c-ethical-kicker` with `color: var(--warning, #f59e0b); margin-bottom: 8px;`. |
| **Line 1552** | `font-size: 0.84rem; color: var(--text-2); line-height: 1.58; margin: 0;` | Inline typography. | Move to class `.c-ethical-body`. |
| **Line 1578** | `color: #10b981;` | Hardcoded hex color. | Move to class `.c-roas-tag` using `color: var(--success, #10b981);`. |
| **Line 1594** | `color: var(--accent);` | Inline color. | Move to class `.c-accent-tag`. |
| **Line 1610** | `color: #6366f1;` | Hardcoded hex color. | Move to class `.c-status-toprated` using `color: var(--indigo, #6366f1);`. |
| **Line 1626** | `color: #ec4899;` | Hardcoded hex color. | Move to class `.c-rails-tag` using `color: var(--pink, #ec4899);`. |
| **Line 1658** | `overflow-x: auto;` | Inline scroll wrapper. | Move to class `.c-table-scroll`. |
| **Line 1775** | `display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 8px; margin-bottom: 12px;` | `margin-bottom: 12px` violates 8px grid (gap 8px is valid). | Move to class `.c-commuter-header` with `gap: 8px; margin-bottom: 16px;`. |
| **Line 1776** | `font-size: 0.76rem; font-weight: 800; text-transform: uppercase; color: var(--text-3);` | Inline typography. (Identified as clutter to cut). | Remove label completely. |
| **Line 1789** | `border-radius: 14px; overflow: hidden; border: 1px solid var(--line); background: var(--bg-card); position: relative; margin-bottom: 14px;` | `margin-bottom: 14px` violates 8px grid; hardcoded radius 14px. | Move to class `.c-map-frame` with `margin-bottom: 16px; border-radius: 16px;`. |
| **Line 1835** | `color: var(--text-1); display: block; margin-bottom: 4px; font-size: 0.95rem;` | `margin-bottom: 4px` violates 8px grid. | Move to class `.c-town-title` with `margin-bottom: 8px;`. |
| **Line 1838** | `color: var(--text-2); font-size: 0.84rem; line-height: 1.5; margin: 0;` | Inline typography. | Move to class `.c-town-desc`. |
| **Line 1846** | `display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;` | `margin-bottom: 10px` violates 8px grid. | Move to class `.c-demo-card-head` with `margin-bottom: 16px;`. |
| **Line 1847** | `font-size: 1.2rem; font-weight: 800; color: var(--text-1); margin: 0;` | Inline typography. | Move to class `.c-demo-card-title`. |
| **Line 1848** | `color: #10b981; border-color: rgba(16, 185, 129, 0.3);` | Hardcoded hex & rgba colors. | Move to class `.c-status-open` using CSS variables. |
| **Line 1850** | `font-size: 0.82rem; color: var(--text-2); margin-bottom: 14px; line-height: 1.5;` | `margin-bottom: 14px` violates 8px grid. | Move to class `.c-demo-card-sub` with `margin-bottom: 16px;`. |
| **Line 1855** | `display: flex; flex-direction: column; gap: 12px;` | `gap: 12px` violates 8px grid. | Move to class `.c-demo-form` with `gap: 16px;`. |
| **Lines 1857, 1864, 1874, 1885** | `font-size: 0.74rem; font-weight: 700; color: var(--text-3); display: block; margin-bottom: 4px;` | `margin-bottom: 4px` violates 8px grid. | Move to class `.c-form-label` with `margin-bottom: 8px;`. |
| **Lines 1858, 1865, 1875, 1886** | `width: 100%;` | Inline width. | Handled by `.c-search-input` class in CSS. |
| **Line 1894** | `width: 100%; justify-content: center; margin-top: 6px;` | `margin-top: 6px` violates 8px grid. | Move to class `.c-btn-submit` with `margin-top: 8px;`. |
| **Line 1902** | `padding-top: 14px; margin-top: 14px; border-top: 1px solid var(--line); display: flex; flex-wrap: wrap; justify-content: space-between; align-items: center; gap: 8px; font-size: 0.78rem;` | `padding-top: 14px` and `margin-top: 14px` violate 8px grid. | Move to class `.c-demo-card-footer` with `padding-top: 16px; margin-top: 16px; gap: 8px;`. |
| **Line 1903** | `color: var(--text-3);` | Inline color. | Move to class `.c-card-loc-text`. |
| **Line 1905** | `color: var(--accent); font-weight: 700;` | Inline color & weight. | Move to class `.c-maps-link`. |
| **Line 1931** | `display: inline-block; vertical-align: -2px; margin-left: 6px;` | `margin-left: 6px` violates 8px grid. | Move to class `.c-mentor-badge-inline` with `margin-left: 8px;`. |
| **Line 1982** | `display: flex; align-items: center; justify-content: center; gap: 8px;` | Inline flex styles (gap 8px is valid). | Move to class `.c-g-score`. |
| **Line 2055** | `margin-bottom: 0;` | Valid 8px grid multiple (0). | Keep in utility class `.mb-0`. |
| **Line 2056** | `font-size: 12px; font-weight: 600; color: var(--text-3);` | Inline typography. | Move to class `.c-cohort-subtext`. |
| **Line 2060** | `margin-top: 14px; margin-bottom: 6px; display: flex; justify-content: space-between; align-items: center;` | `margin-top: 14px` and `margin-bottom: 6px` violate 8px grid. | Move to class `.c-batch-header` with `margin-top: 16px; margin-bottom: 8px;`. |
| **Line 2061** | `font-size: 0.74rem; font-weight: 700; color: var(--text-3); text-transform: uppercase;` | Clutter label (1. Select Batch Slot:). | Cut label; move layout to CSS. |
| **Line 2062** | `font-size: 0.72rem; color: var(--accent); font-weight: 600;` | Inline typography. | Move to class `.c-batch-days`. |
| **Line 2084** | `margin-top: 10px; margin-bottom: 12px; padding: 10px 12px;` | `margin-top: 10px`, `margin-bottom: 12px`, `padding: 10px 12px` violate 8px grid. | Move to class `.c-batch-info-box` with `margin: 16px 0; padding: 16px;`. |
| **Line 2085** | `display: flex; justify-content: space-between; align-items: center; margin-bottom: 4px;` | `margin-bottom: 4px` violates 8px grid. | Move to class `.c-batch-status-row` with `margin-bottom: 8px;`. |
| **Line 2086** | `color: var(--text-1); font-size: 0.85rem;` | Inline typography. | Move to class `.c-slot-title`. |
| **Line 2087** | `font-size: 0.68rem; padding: 2px 8px; color: #10b981; border-color: rgba(16,185,129,0.3);` | Non-standard padding, hardcoded colors. | Move to class `.c-seats-badge` with `padding: 4px 8px;` using CSS tokens. |
| **Line 2089** | `color: var(--text-3); font-size: 0.74rem; line-height: 1.4; margin: 0;` | Inline typography. | Move to class `.c-batch-note`. |
| **Line 2095** | `margin-bottom: 10px;` | `margin-bottom: 10px` violates 8px grid. | Move to class `.c-tuition-section` with `margin-bottom: 16px;`. |
| **Line 2096** | `display: flex; justify-content: space-between; align-items: center; margin-bottom: 6px;` | `margin-bottom: 6px` violates 8px grid. | Move to class `.c-tuition-header` with `margin-bottom: 8px;`. |
| **Line 2097** | `font-size: 0.74rem; font-weight: 700; color: var(--text-3); text-transform: uppercase;` | Clutter label (2. Tuition Payment Plan:). | Cut label; move layout to CSS. |
| **Line 2130** | `color: #ef4444;` | Hardcoded red hex color. | Move to class `.c-badge-cap` using `color: var(--danger, #ef4444);`. |
| **Lines 2135, 2141** | `width: 100%; justify-content: center; gap: 8px;` | Inline flex layout (gap 8px is valid). | Move to class `.c-btn-full` in CSS. |
| **Line 2284** | `border-bottom: 0;` | Inline border override. | Move to class `.border-b-0` in CSS. |

---

## 4. Standard 5: Clutter Reduction (Taglines, Helper Text & Secondary Labels)

Standard 5 mandates: *"Cut taglines, helper text and secondary labels. If a screen needs them to make sense, fix the layout."*

### 4.1 Clutter Inventory & Remediation Strategy

| Line Number | Clutter Element & Verbatim Text | Category | Rationale & Root Issue | Proposed Remediation & Layout Adjustment |
|---|---|---|---|---|
| **Line 388** | `<p class="c-brand-logos-heading">PLATFORMS &amp; MARKETING ECOSYSTEMS YOU WILL MASTER IN LAB</p>` | Secondary all-caps label | Unnecessary text clutter above world-famous corporate brand logos (Upwork, Fiverr, Google, Meta, Shopify, YouTube). The logos immediately communicate the platform ecosystem. | Remove this `<p>` entirely. Position the logo strip cleanly below the hero with subtle border separation (`margin-top: 24px; padding-top: 16px; border-top: 1px solid var(--line);`). Add an accessible `aria-label="Supported platform ecosystems"` to the container. |
| **Lines 846, 858–860** | 1) `<span class="c-eyebrow">21 Core Capabilities</span>`<br>2) `Showing 21 specialized skill modules included in your 3-month practical training:` | Redundant eyebrow and helper counter text | Massive redundancy: the section title already states "21 High-Income Skill Pillars", the bento head states "21 Pillars of Modern Agency Practice", and a helper line repeats "Showing 21 specialized skill modules...". | Cut the helper sentence ("Showing 21 specialized skill modules...") and the redundant eyebrow. Let the H3 and category filter pills (`All 21 Skills`, `SEO, Local & AEO (8)`, etc.) clearly communicate the count without textual noise. |
| **Lines 1654–1657** | `<div class="c-swipe-hint"><span>Swipe horizontally to compare all features &rarr;</span></div>` | Instructional helper text | Explaining to users how to scroll an HTML table indicates inadequate responsive visual affordance. | Remove the swipe hint text. Replace with an intrinsic CSS visual affordance: subtle shadow fade on the right scroll container (`background: linear-gradient(to right, transparent, var(--bg-card)) right / 24px 100% no-repeat`), making scrollability intuitive without words. |
| **Line 1776** | `<span ...>Select Your Location for Route Details:</span>` | Instructional helper text | Placed directly above 5 interactive town buttons (`Sheikhupura City`, `Farooqabad`, `Safdarabad`, etc.). The button pills already have clear interactive affordance. | Remove the instructional text. Elevate the town selector buttons as a standalone segmented bar with `margin-bottom: 16px;`. |
| **Lines 2061, 2097** | 1) `1. Select Batch Slot:`<br>2) `2. Tuition Payment Plan:` | Numbered form step helper labels | Micro-labels that treat the user like a form wizard from decades past. The grid of time cards and payment toggle buttons are self-explanatory product choices. | Remove `1. Select Batch Slot:` and `2. Tuition Payment Plan:`. The visual card grouping and active selection state provide immediate comprehension. |
| **Lines 2325, 2343–2346** | 1) `<div class="footer-brand-sub">ACADEMY</div>`<br>2) `<span class="footer-brand-tagline">Skills Today, Brighter Tomorrows.</span>` | Corporate taglines / secondary labels | Generic corporate slogan and redundant brand subtitle that add zero informational value. | Cut the tagline container and sub-label entirely, leaving the clean brand name and descriptive sentence. |
| **Line 1990** | `<span class="c-proof-disclaimer">General Academy &amp; Course Graduate Reviews</span>` | Micro-disclaimer label | Redundant disclaimer tucked under Google reviews card, cluttering the bottom edge of the badge. | Remove the disclaimer; the rating title "Verified Google Reviews · Sheikhupura Campus" already states provenance clearly. |

---

## 5. Standard 6: Frozen Curriculum, Outcomes & Pricing Content Inventory

> **CRITICAL FREEZE DIRECTIVE**: Under Standard 6, all course curriculum titles, module descriptions, lesson texts, learning outcomes, and pricing numbers are **strictly frozen**. Not a single number, word, or outcome may be altered or deleted during the remediation process.

### 5.1 Official Pricing, Tuition & Guarantee Numbers (FROZEN)

- **Total Course Tuition**: `PKR 25,000` (Full 12-week / 3-month practical on-campus program)
- **Installment Option 1**: `2 installments of PKR 12,500` (Hero & FAQ)
- **Installment Option 2**: `3 easy monthly installments of PKR 8,500 / mo` (Admissions interactive switcher)
- **Satisfaction Guarantee**: `14-Day 100% Money-Back Guarantee` (Zero-risk trial policy)
- **Lab Hardware Capacity**: `Strictly 10–12 Workstations Maximum` (1 student per Intel Core i7 PC node)
- **Graduate Earning Benchmarks**:
  - Local Business Marketing Retainers: `PKR 30,000 to PKR 80,000 / month per client`
  - Upwork / Fiverr Freelance Contracts: `$500 to $1,500 per project`
  - Featured Graduate Milestone: `$600 monthly client on Upwork` (Attique Hussain review)
  - Agency Upsell Pipeline: `$50 projects into $300–$1,000/month recurring retainers` (Module 12)

---

### 5.2 4 Key Learning Outcomes (FROZEN)

1. **Outcome 01: Meta & Google Ads Mastery**  
   *Description*: Build profitable lead generation and e-commerce campaigns using Meta Ads Manager, Meta Pixel, custom audiences, CBO/ABO budgets, and ROAS tracking.
2. **Outcome 02: AI Content & Video Engine**  
   *Description*: Generate scroll-stopping ad creatives, direct-response copy, and viral short-form video ads using ChatGPT, Canva Magic Studio, and CapCut AI.
3. **Outcome 03: Local SEO & Google Maps Rank**  
   *Description*: Set up and optimize Google Business Profiles to rank Sheikhupura and Pakistani businesses #1 in local Google Search and Google Maps.
4. **Outcome 04: Client Monetization & Dual Income**  
   *Description*: Close $500–$1,500 Upwork/Fiverr freelance contracts and sign PKR 30,000–80,000/mo local retainers with Payoneer, Wise, and Pakistani bank wire setups.

---

### 5.3 21 Core Skill Pillars (FROZEN)

1. **01 · SEO Fundamentals**: Master Search Engine Optimization fundamentals to help websites rank higher on Google and attract free, consistent organic traffic. (Tag: Organic Rank)
2. **02 · Blogging Mastery**: Learn how to start, grow, and monetize a successful niche blog with helpful, high-quality content, Google AdSense, and affiliate strategies. (Tag: Content & AdSense)
3. **03 · Local SEO & GBP**: Use geo-targeting techniques, local citations, and Google Business Profile optimization to dominate local markets in Sheikhupura and worldwide. (Tag: Google Maps #1)
4. **04 · AEO & GEO (AI SEO)**: Master Answer Engine Optimization (AEO) and Generative Engine Optimization (GEO) to rank brands in ChatGPT, Google Gemini, Perplexity, and AI Overviews. (Tag: ChatGPT & Gemini)
5. **05 · AI Agents**: Create and deploy intelligent AI agents and Custom GPTs to automate your SEO audits, content creation, client reports, and business workflows. (Tag: Autonomous AI)
6. **06 · SaaS Development**: Build simple Software as a Service (SaaS) web products, free SEO calculators, and interactive micro-tools to generate leads and recurring revenue. (Tag: Micro-Tools)
7. **07 · Vibe Coding**: Learn modern AI-assisted coding techniques (Cursor, Claude, Antigravity) to build landing pages and web applications quickly without being a senior developer. (Tag: AI-Assisted Code)
8. **08 · App Development**: Design and develop scalable web and mobile-ready business applications tailored for modern user needs and freelance client briefs. (Tag: Web & Mobile)
9. **09 · AI Automation**: Streamline business processes and scale marketing operations using no-code AI automation workflows across Make, Zapier, n8n, Sheets, and WhatsApp. (Tag: Make & Zapier)
10. **10 · Browser Automation**: Learn ethical browser-based automation to eliminate repetitive manual tasks, organize market research, and audit competitor listings efficiently. (Tag: Workflow Speed)
11. **11 · YouTube Automation**: Build faceless YouTube channels and social video reels with AI-powered scriptwriting, Canva Pro visuals, voiceovers, and automated publishing systems. (Tag: AI Video & Reels)
12. **12 · Etsy E-Commerce**: Learn how to launch, optimize, and grow an Etsy store selling digital products and print-on-demand items with Etsy SEO for sustainable online revenue. (Tag: Digital & POD)
13. **13 · Google Ads (PPC)**: Manage high-converting PPC campaigns on Google Search, Display, and YouTube Ads with negative keyword control and a strong focus on maximizing ROI. (Tag: Search & YouTube)
14. **14 · Meta & TikTok Ads**: Run targeted advertising campaigns on Facebook, Instagram, and TikTok with Pixel & CAPI tracking to scale traffic, WhatsApp leads, and online sales. (Tag: FB / IG / TikTok)
15. **15 · Website Design**: Build, customize, and optimize beautiful, responsive websites and online stores using modern CMS platforms like WordPress and Shopify. (Tag: WordPress & Shopify)
16. **16 · Technical SEO**: Enhance site architecture, loading speed, XML sitemaps, JSON-LD schema markup, and crawlability to meet Google's highest technical standards. (Tag: Core Web Vitals)
17. **17 · eCommerce SEO**: Optimize Shopify and WooCommerce online stores to rank product pages and category collections higher for ready-to-buy searchers. (Tag: Store Ranking)
18. **18 · Parasite SEO (White-Hat)**: Leverage high-authority platforms (LinkedIn Pulse, Medium, Reddit, Quora, and YouTube) with helpful content to rank on Page 1 for tough keywords. (Tag: Authority Platforms)
19. **19 · Guest Blogging & PR**: Build high-authority white-hat backlinks, niche placements, and brand mentions through strategic guest posting outreach and digital PR. (Tag: High-DR Backlinks)
20. **20 · Freelancing: Upwork & Fiverr**: Create top-ranking Fiverr gigs and Upwork profiles, write winning proposals, manage client contracts, and scale long-term monthly retainers. (Tag: Global Clients)
21. **21 · Quick Skills Bootcamp**: Master high-demand, easy-to-deliver digital services (Canva branding, GBP setup, SEO audits, AI content editing) to start offering services in Month 1. (Tag: Fast Monetization)

---

### 5.4 Complete 12-Week Curriculum & 84 Lessons Inventory (FROZEN)

#### MONTH 01 (Weeks 1–4): Beginner Foundation, Freelancing Platforms, Quick Skills & Website Design (12 Labs · Lessons 01–28)

- **Module 01: Introduction to Freelancing, Work Ethics, Platforms & Quick Skills** (Week 01 · 3 Labs)
  - *Deliverable*: Skill Path Map + Quick-Skill Samples
  - *Lesson 01*: What is Freelancing & How It Works: Global online service markets and remote hiring workflows
  - *Lesson 02*: Freelancing vs. Traditional Jobs: Honest comparison of effort, discipline, timelines, and career growth
  - *Lesson 03*: Online Work Ethics & Professional Mindset: Honest client communication, meeting deadlines, avoiding shortcuts
  - *Lesson 04*: Overview of Freelancing Platforms: How Upwork, Fiverr, Freelancer.com, LinkedIn & Etsy operate for Pakistanis
  - *Lesson 05*: Choosing Your Skill Path: Selecting a high-demand digital marketing or AI sub-niche based on strengths
  - *Lesson 06*: Quick Skills Bootcamp: Fast-to-deliver services (Canva graphics, social creatives, short reels & AI copy)
  - *Lesson 07*: Platform Rules, Safety & Payoneer: IP hygiene, KYC verification, avoiding bans, Payoneer account setup
  - *Proof of Work*: Personal Niche & Skill Roadmap + Verified Payoneer Setup + 3 Quick-Skill Practice Assets

- **Module 02: Upwork, Fiverr & Freelancer.com Mastery + Profile Optimization** (Week 02 · 3 Labs)
  - *Deliverable*: Live Fiverr Gigs + Approved Upwork Profile
  - *Lesson 08*: Upwork Platform Deep Dive: Connects economy, Job Success Score (JSS), specialized profiles, project catalog
  - *Lesson 09*: Fiverr Platform Mastery: Seller levels, Fiverr Gig SEO keyword research, search tags & 3-tier pricing
  - *Lesson 10*: Freelancer.com Overview: Navigating contests, milestone escrow payments, entry-level international projects
  - *Lesson 11*: Creating a Professional Freelance Profile: High-trust photo guidelines, headline formulas & bio copy
  - *Lesson 12*: Writing Strong Profile Descriptions: Client-focused copywriting that addresses pain points and solutions
  - *Lesson 13*: Portfolio Creation Basics & Personal Branding: Assembling real sample assets before pitching clients
  - *Lesson 14*: The 25-Point Profile Optimization Checklist: Live 1-on-1 workstation audit of your Fiverr Gigs & Upwork profile
  - *Proof of Work*: 3 SEO-Optimized Fiverr Gigs with Canva Thumbnails + 100% Complete Upwork Profile

- **Module 03: Winning Proposals, Client Communication, Contracts & Pricing** (Week 03 · 3 Labs)
  - *Deliverable*: 5 Custom Proposal & Contract Kits
  - *Lesson 15*: Understanding Client Job Posts: Reading between lines, client hire history, vetting scam red flags
  - *Lesson 16*: Writing Winning Proposals: The 4-paragraph personalized hook formula + recording 60-second Loom audits
  - *Lesson 17*: Proposal Mistakes to Avoid: Why generic copy-pasted AI proposals fail and how to stand out naturally
  - *Lesson 18*: Client Communication & Negotiation: Confident English templates for inbox chats, Zoom calls & deal closing
  - *Lesson 19*: Handling Contracts, Milestones & Revisions: Scope definition, milestone releases, handling revisions politely
  - *Lesson 20*: Pricing Your Services Correctly: Hourly vs. fixed-price packages and avoiding race-to-the-bottom rates
  - *Lesson 21*: Using ChatGPT for Proposal Research: Analyzing client websites and drafting custom action plans in minutes
  - *Proof of Work*: 5 Niche Proposal Templates + Loom Video Audit Script + Client Onboarding Checklist

- **Module 04: Digital Marketing Channels, Website Design (WP/Shopify), Vibe Coding & Blogging** (Week 04 · 3 Labs)
  - *Deliverable*: Live Website + Blog + Vibe-Coded Tool
  - *Lesson 22*: Introduction to Digital Marketing & Buyer Journey: Search, social media, funnels, email & paid channels
  - *Lesson 23*: Website Design Fundamentals (WordPress): Domain, hosting, SSL setup, building responsive business pages
  - *Lesson 24*: Shopify Store & Landing Page Design: Product pages, collections, theme customizations & WhatsApp/COD setup
  - *Lesson 25*: Vibe Coding for Marketers: Using AI-assisted coding (Cursor, Claude, Antigravity) to build calculators and web tools
  - *Lesson 26*: Blogging Mastery: Setting up, structuring, and monetizing a niche blog via Google AdSense & affiliates
  - *Lesson 27*: Content Strategy & Writing Basics: Writing clear, helpful, 100% human-grade content solving reader search queries
  - *Lesson 28*: AI Tools for Content Creation: ChatGPT & Claude for research briefs while preserving natural voice and ethics
  - *Proof of Work*: Live WordPress/Shopify Site + Published Pillar Blog Post + 1 Vibe-Coded Interactive Calculator

---

#### MONTH 02 (Weeks 5–8): SEO Mastery, Local SEO, AEO/GEO (AI Search), Social Media & YouTube Automation (12 Labs · Lessons 29–56)

- **Module 05: Search Engine Optimization (SEO) — Keyword Research, On-Page & eCommerce SEO** (Week 05 · 3 Labs)
  - *Deliverable*: 50-Keyword Map + On-Page Optimization
  - *Lesson 29*: What is SEO & How Search Engines Work: Crawling, indexing, ranking algorithms, Google Search Essentials
  - *Lesson 30*: Keyword Research Fundamentals: Finding low-competition commercial, local & informational search volume
  - *Lesson 31*: On-Page SEO Mastery: Title tags, meta descriptions, H1–H6 hierarchy, URL slugs, image alt text, internal links
  - *Lesson 32*: Semantic SEO & Topical Authority: Topic clusters, supporting entities & Google E-E-A-T quality compliance
  - *Lesson 33*: eCommerce SEO for Shopify & WooCommerce: Category silo structure, product titles, schema, buyer-intent pages
  - *Lesson 34*: SEO Tools Hands-On: Google Search Console, Keyword Planner, Ahrefs, SEMrush & RankMath setups
  - *Lesson 35*: Outranking Competitors Ethically: SERP gap analysis, content expansion, building superior helpfulness
  - *Proof of Work*: Complete Niche Keyword Matrix + 100/100 On-Page Optimized Service & Product Pages

- **Module 06: Technical SEO, Local SEO (GBP), Guest Blogging & White-Hat Parasite SEO** (Week 06 · 3 Labs)
  - *Deliverable*: 45-Point Technical Audit + GBP Setup
  - *Lesson 36*: Technical SEO Foundations: Site architecture, XML sitemaps, robots.txt, canonical tags & 404 redirects
  - *Lesson 37*: Page Speed & Core Web Vitals: WebP asset compression, caching, mobile responsiveness, JSON-LD schema
  - *Lesson 38*: Local SEO & Google Business Profile (GBP): Ranking local businesses #1 in Google Maps 3-Pack
  - *Lesson 39*: Geo-Targeting & Citations: NAP consistency, Pakistani & global business directories, review workflows
  - *Lesson 40*: Guest Blogging & Digital PR: Pitching niche editors, building high-authority white-hat editorial backlinks
  - *Lesson 41*: White-Hat Parasite SEO: Ranking fast on Google using LinkedIn Pulse, Medium, Reddit & Quora authority
  - *Lesson 42*: Professional Client SEO Auditing: Delivering full 45-point Technical + Local SEO audit reports for clients
  - *Proof of Work*: 45-Point Technical SEO Audit Report + Optimized Google Business Profile + 3 Authority Placements

- **Module 07: AEO (Answer Engine Optimization) & GEO (Generative Engine Optimization)** (Week 07 · 3 Labs)
  - *Deliverable*: AI Search & Gemini Citation Blueprint
  - *Lesson 43*: What is AEO & GEO (AI SEO)?: How ChatGPT, Google Gemini, Perplexity & AI Overviews choose sources
  - *Lesson 44*: Answer-First Content Formatting: Direct-answer blocks, structured tables & FAQs cited directly by AI
  - *Lesson 45*: Entity SEO & Knowledge Graph Signals: Building brand identity, author credentials & factual consistency
  - *Lesson 46*: Advanced Schema Markup for AI: Implementing Course, FAQPage, LocalBusiness, Organization & Product JSON-LD
  - *Lesson 47*: Brand Citation Engineering: Getting cited in authoritative roundups, digital PR & community discussions
  - *Lesson 48*: AI Visibility Auditing: Testing and monitoring brand presence inside ChatGPT Search, Gemini & Perplexity
  - *Lesson 49*: Selling AEO & GEO on Upwork/Fiverr: Packaging modern AI SEO retainers to stand out from old-school sellers
  - *Proof of Work*: AEO/GEO Optimized Landing Page + Verified JSON-LD Schema Graph + AI Visibility Audit

- **Module 08: Social Media Marketing, Canva Pro, YouTube Automation & Email Lead Gen** (Week 08 · 3 Labs)
  - *Deliverable*: 30-Day Social Kit + Faceless Video Funnel
  - *Lesson 50*: Social Media Algorithms & Strategies: Facebook, Instagram, TikTok & LinkedIn organic engagement rules
  - *Lesson 51*: Canva Pro for Marketers: Designing high-CTR ad banners, carousel graphics, thumbnails & client brand kits
  - *Lesson 52*: Short-Form Video & Reels Creation: High-hook scripts, captions, and mobile editing for maximum retention
  - *Lesson 53*: YouTube Automation Mastery: Building faceless channels with AI scriptwriting, voiceovers & YouTube SEO
  - *Lesson 54*: LinkedIn for Freelance B2B Outreach: Optimizing profiles and publishing authority content for inbound client leads
  - *Lesson 55*: Email Marketing & Lead Generation: Building lead magnets, opt-in funnels, and automated email nurture flows
  - *Lesson 56*: Email Platforms & Compliance: Using Brevo/Mailchimp, avoiding spam filters, crafting high-response B2B emails
  - *Proof of Work*: 30-Day Social Content Calendar + Canva Brand Kit + Automated YouTube/Reels Video + Email Sequence

---

#### MONTH 03 (Weeks 9–12): Paid Ads (Meta & Google), Etsy, AI Agents, Automation & Career Launch (12 Labs · Lessons 57–84)

- **Module 09: Meta Ads Mastery (Facebook & Instagram Ads) + TikTok Paid Campaigns** (Week 09 · 3 Labs)
  - *Deliverable*: Full-Funnel Meta & WhatsApp Ad Setup
  - *Lesson 57*: Facebook & Instagram Ads Structure: Meta Business Suite, Ads Manager accounts, billing & asset security
  - *Lesson 58*: Meta Pixel & Conversions API (CAPI): Tracking setup on WordPress/Shopify to track leads and purchase ROAS
  - *Lesson 59*: Budget & Audience Targeting: Custom audiences, Lookalikes, Advantage+ targeting, ABO vs. CBO budgeting
  - *Lesson 60*: High-Converting Creative Testing: Urdu & English direct-response sales copy, video ads vs. carousels
  - *Lesson 61*: WhatsApp Lead Gen & E-Commerce Ads: Deploying local lead funnels and online store conversion campaigns
  - *Lesson 62*: TikTok Paid Advertising Fundamentals: TikTok Ads Manager, Spark Ads & short-form video audience targeting
  - *Lesson 63*: Campaign Scaling & ROAS Analytics: Interpreting CTR, CPC, CPA & ROAS to scale profitable ad sets
  - *Proof of Work*: Complete Meta Ads Campaign Build + Pixel Event Verification + Client ROAS Report

- **Module 10: Google Ads (Search, Display & YouTube), GA4 Analytics & Etsy E-Commerce** (Week 10 · 3 Labs)
  - *Deliverable*: Google PPC Blueprint + Etsy Store Setup
  - *Lesson 64*: Google Search Ads (PPC) Architecture: Auction dynamics, Quality Score calculation & Ad Rank formulas
  - *Lesson 65*: Match Types & Negative Keywords: Exact, phrase & broad targeting while eliminating wasted budget
  - *Lesson 66*: Responsive Search Ads (RSAs): Headlines, descriptions, sitelinks, callout extensions & location assets
  - *Lesson 67*: YouTube Video Ads & Display Remarketing: Re-engaging past store visitors across Google and YouTube
  - *Lesson 68*: Google Analytics 4 (GA4) & Tag Manager: Measuring traffic sources, phone calls, WhatsApp clicks & form leads
  - *Lesson 69*: Etsy E-Commerce Setup: Launching an Etsy store for digital printables and Print-on-Demand (POD) items
  - *Lesson 70*: Etsy SEO & International Sales: Optimizing Etsy titles, 13 keyword tags, mockups & Etsy Ads scaling
  - *Proof of Work*: Google Search Campaign Blueprint + GA4 Conversion Dashboard + Optimized Etsy Product Listing

- **Module 11: AI Agents, AI Automation, Browser Automation, SaaS & App Development** (Week 11 · 3 Labs)
  - *Deliverable*: Custom AI Agent + Automated Workflow + Web App
  - *Lesson 71*: AI Agents in Marketing: Building Custom GPTs and assistants for automated SEO audits & client support
  - *Lesson 72*: AI Automation with Make & Zapier: Connecting lead forms automatically to Google Sheets, Email & WhatsApp
  - *Lesson 73*: Browser Automation: Automating repetitive data formatting, market research & competitor SERP monitoring
  - *Lesson 74*: Micro-SaaS & Web Calculators: Creating interactive ROI tools and lead-generating utility calculators
  - *Lesson 75*: App Development with Vibe Coding: Packaging marketing tools and client dashboards into modern web apps
  - *Lesson 76*: Project Management Workflows: Organizing client deliverables with Notion, Trello, Slack & Loom updates
  - *Lesson 77*: Monetizing AI Workflows: Selling automated lead-routing pipelines and AI assistants as high-ticket services
  - *Proof of Work*: Deployed Custom AI Agent + Live Make/Zapier Lead Automation + Vibe-Coded Micro-SaaS Tool

- **Module 12: Pricing, Retainers, Direct Client Hunting, Portfolio Defense & Certification** (Week 12 · 3 Labs)
  - *Deliverable*: Capstone: 1-on-1 Review + OneSkills Certificate
  - *Lesson 78*: Real Client Case Studies: Transforming classroom projects into client-ready before-and-after proof
  - *Lesson 79*: Retainer Upselling Strategies: Converting $50 projects into $300–$1,000/month recurring SEO/ad retainers
  - *Lesson 80*: Client Retention & Reporting: Professional monthly reporting, proactive communication & 5-star reviews
  - *Lesson 81*: Direct Client Hunting: Winning high-ticket local & global clients via GBP audits, LinkedIn & cold outreach
  - *Lesson 82*: Agency Scaling Roadmap: Building a specialized freelance team and boutique agency in Sheikhupura
  - *Lesson 83*: 1-on-1 Capstone Portfolio Defense: Personal project audit and profile review with Founder Nisar Mehar
  - *Lesson 84*: Graduation & Certification: Official OneSkills Academy Certificate award ceremony & lifetime alumni network
  - *Proof of Work*: Published 4-Project Portfolio + Final Profile Sign-Off + Official OneSkills Academy Certificate

---

## 6. Actionable Implementation Recommendations

1. **Markup Refactor**:
   - Clean up heading tree: Introduce `<h3 class="visually-hidden">` parents in `#overview` and `#method`; convert footer headings to `<h3>`.
   - Remove emojis from headings in `#curriculum` blueprint cards or wrap them in `<span aria-hidden="true">`.
   - Convert comparison table row headers to `<th scope="row">` and table column headers to `<th scope="col">`.
   - Convert specs and dates lists to semantic `<dl>`, `<dt>`, `<dd>`.
   - Convert lesson grids to semantic `<ol class="c-lessons-grid">` with `<li>`.
   - Remove generic `aria-label` attributes from plain `<div>` elements.
2. **Interactive Controls & JS Fix**:
   - Add `c-filter-btn` to all filter buttons in `#skill-pillar-tabs` and `#curriculum-filter-tabs` so `assets/js/course-v2.js` attaches listeners successfully.
   - Add `aria-pressed="true|false"` to the fee toggle buttons (`#btn-fee-full`, `#btn-fee-install`) and sync with JS.
   - Convert time slot picker to `role="radiogroup"` with `role="radio"`.
3. **8px Grid & CSS Migration**:
   - Replace all 54 inline styles with semantic classes in `assets/css/course-v2.css`.
   - Ensure all margins, paddings, and gaps conform to multiples of 8px (8px, 16px, 24px, 32px).
4. **Clutter Elimination**:
   - Cut platform ecosystem all-caps tagline (`Line 388`).
   - Cut redundant skill counter text and eyebrow (`Lines 846, 858–860`).
   - Cut table swipe hint helper text (`Lines 1654–1657`) and use CSS fade affordance.
   - Cut commuter route helper label (`Line 1776`).
   - Cut numbered wizard labels in cohort card (`Lines 2061, 2097`).
   - Cut footer tagline and sub-label (`Lines 2325, 2343–2346`).
   - Cut reviews disclaimer (`Line 1990`).
   - Remove redundant second sticky conversion bar (`Line 2410`).
