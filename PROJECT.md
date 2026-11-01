# OneSkills Academy — Freelancing Mastery Course Project Specification

**Target Document**: `courses/freelancing-mastery.html`  
**Associated Assets**: `assets/css/course-v2.css`, `assets/js/course-v2.js`, `assets/css/main.css`, `assets/css/refinement.css`  
**Audience**: Students, Freelancers, Digital Marketers, Assistive Technology Users, Agency Apprentices  
**Campus Location**: OneSkills Practical Lab, Lahore-Sargodha Road, Sheikhupura, Punjab, Pakistan  
**Specification Version**: 2.0 (Post-Remediation Architecture)

---

## 1. System Architecture

The OneSkills Course Detail system is a high-performance, accessible, responsive static web experience delivering rich educational blueprints and conversion pathways.

```
+------------------------------------------------------------------------------------+
|                                    Client Browser                                  |
+------------------------------------------------------------------------------------+
                                         |
               +-------------------------+-------------------------+
               |                                                   |
               v                                                   v
+-------------------------------+               +------------------------------------+
|  Semantic HTML5 Architecture  |               |    Design Token & Style System     |
|  - <header class="site-header">|               |    - main.css (Global tokens)     |
|  - <nav class="c-subnav-sticky">              |    - course-v2.css (Component V2)  |
|  - <main id="main-content">   |               |    - CSS Custom Properties         |
|    * <section id="hero">      |               |    - 8px Spatial Grid System       |
|    * <section id="overview">  |               |    - prefers-reduced-motion Suite  |
|    * <section id="method">    |               +------------------------------------+
|    * <section id="skills">    |                                  |
|    * <section id="curriculum">|                                  v
|    * <section id="campus">    |               +------------------------------------+
|    * <section id="mentor">    |               |    Interactive UX & Logic System   |
|    * <section id="reviews">   |               |    - course-v2.js                  |
|    * <section id="admissions">|               |    - Filter Engine (Skills/Modules)|
|    * <section id="faq">       |               |    - Interactive Tuition Switcher  |
|  - <footer class="site-footer">               |    - Batch Slot Picker             |
|  - <aside class="c-mobile-dock">              |    - Commuter Belt Route Selector  |
+-------------------------------+               |    - ARIA Live Announcements       |
                                                +------------------------------------+
```

### 1.1 Structural Layer (HTML5 & Accessibility)
- Native semantic HTML5 landmarks: `<header>`, `<nav>`, `<main id="main-content">`, `<section>`, `<article>`, `<aside>`, `<footer>`, `<figure>`, `<dl>`, `<ol>`, `<li>`.
- Complete bypass blocks with `<a href="#main-content" class="skip-link">` ensuring accessible keyboard focus handoff.
- Strict heading hierarchy from `<h1>` (single hero topic) down through nested `<h2>` section landmarks, logical `<h3>` subsections, and `<h4>` structural cards, eliminating skipped levels and raw emoji characters.
- W3C WAI-ARIA conformance: accessible button states (`aria-pressed`, `aria-expanded`), live region status updates (`role="status"`, `aria-live="polite"`), and accessible table semantics (`<caption>`, `<th scope="col">`, `<th scope="row">`).

### 1.2 Presentation Layer (CSS Tokens & 8px Grid System)
- Strict adherence to an 8-pixel spatial rhythm across all margins, paddings, gaps, and structural dimensions (4px half-step for micro-delimiters only).
- Theme-aware CSS custom properties (`--bg`, `--card`, `--line`, `--text-1`, `--accent`, `--shadow-card`, `--shadow-hover`, `--badge-...-bg`, `--badge-...-text`) supporting seamless light and dark mode switching.
- Comprehensive `prefers-reduced-motion: reduce` coverage zeroing delays, halting infinite floating loops, suppressing hover translations, and protecting critical centering transforms.

### 1.3 Behavioral Layer (JavaScript & UX Integrity)
- Pure vanilla ECMAScript (ES6+) with zero third-party framework dependencies.
- Defensive DOM querying and robust event binding with multi-class fallbacks.
- Complete clipboard integration with accessible visual/screen-reader toasts.
- Dynamic DOM synchronization for batch scheduling, tuition plans, and regional transportation routes.

---

## 2. Feature Inventory

| Feature Component | Container ID / Class | Interactive Behaviors & Responsibilities |
|---|---|---|
| **Header & Primary Navigation** | `.site-header`, `#primary-nav` | Responsive desktop navigation, mobile drawer toggle, theme toggle, and phone contact affordances. |
| **Sticky Course Subnav** | `.c-subnav-sticky`, `#subnav` | Scroll-spy with `IntersectionObserver`, active section tracking with `aria-current="true"`, and smooth keyboard-aware section jumping. |
| **Hero Editorial Stage** | `#hero`, `.c-hero-editorial-stage` | Value proposition, fee summary pill, money-back guarantee badge, CTA buttons, verified review avatar row, and 4 floating metric chips. |
| **Facts & Metrics Strip** | `.c-facts-strip` | Program highlights: 12-week duration, 36 physical lab sessions, 84 practical lessons, and 10–12 workstation cap. |
| **Program Blueprint & Outcomes** | `#overview`, `.c-outcomes-grid` | 4 core career deliverables: Meta & Google Ads, AI Content Engine, Local SEO & Maps, Client Monetization. |
| **4-Stage Practice Method** | `#method`, `.c-stages-grid` | Four sequential stages from Beginner to Freelancer: Learn Funnels -> Practice on Nodes -> Build Case Studies -> Win Clients. |
| **21-Skill Pillar Bento Grid** | `#skills`, `#skills-21-grid` | Interactive category filtering (`All`, `SEO, Local & AEO`, `Ads & Media Buying`, `AI & Automation`, `Web, SaaS & Freelancing`) with dynamic count readout. |
| **12-Week Curriculum Syllabus** | `#curriculum`, `.c-syllabus-list` | 12 weekly modules containing 84 individual lessons, interactive category filtering, and global "Expand All" / "Collapse All" triggers. |
| **Agency Practical Comparison** | `#comparison`, `.c-comp-table` | Semantic comparison table contrasting OneSkills hands-on lab training against traditional lecture-based institutes. |
| **Hardware & Campus Lab Specs** | `#campus`, `.c-specs-rows` | Intel Core i7 PC nodes, dual fiber gigabit internet, uninterruptible solar/UPS power continuity, Sheikhupura campus address. |
| **Regional Commuter Route Selector**| `.c-commuter-hub`, `.commuter-town-pills` | Interactive town selector (Sheikhupura City, Farooqabad, Safdarabad, Muridke, Nankana Sahib) updating route badges, travel times, and directions. |
| **Instructor & Mentorship Card** | `#mentor`, `.c-mentor-card` | Lead mentor profile (Nisar Mehar), credentials, 10+ years agency experience, verified Upwork client track record. |
| **Verified Graduate Reviews** | `#reviews`, `.c-reviews-grid` | 4.9-star average rating, Google Review verification, student case studies with earnings outcomes. |
| **Admissions & Tuition Desk** | `#admissions`, `.c-admissions-card` | Dynamic batch slot selector (Morning, Afternoon, Evening, Weekend) and interactive tuition plan toggle (Full PKR 25,000 vs 3 Installments of PKR 8,500/mo). |
| **Curriculum FAQ Accordion** | `#faq`, `.c-faq-list` | Accessible `<details>` and `<summary>` components answering prerequisites, software access, refunds, and attendance policies. |
| **Mobile Conversion Dock** | `.c-mobile-dock` | Fixed bottom mobile conversion bar (<=900px) with single-tap demo booking and direct WhatsApp enrollment channel. |

---

## 3. Milestones & Delivery Schedule

```
+-------------------------------------------------------------------------------+
| M1: Survey & Exploration (Complete)                                           |
| - Explorer 1: HTML, semantics, heading hierarchy, 54 inline styles, clutter.  |
| - Explorer 2: CSS 8px grid (238 violations), motion gaps, 102 color tokens.   |
| - Explorer 3: JS filter bugs, copy clobbering, mobile dock collision, ARIA.  |
+-------------------------------------------------------------------------------+
                                        |
                                        v
+-------------------------------------------------------------------------------+
| M2: Remediation Implementation (Current Milestone)                            |
| - T1: Author PROJECT.md & audit-freelancing-mastery.md.                       |
| - T2: Remediate assets/js/course-v2.js (Fix filters, ARIA, focus, cleanup).   |
| - T3: Remediate courses/freelancing-mastery.html (HTML5, ARIA, prune clutter).|
| - T4: Remediate assets/css/course-v2.css (8px grid, motion block, variables). |
+-------------------------------------------------------------------------------+
                                        |
                                        v
+-------------------------------------------------------------------------------+
| M3: Forensic Verification & Quality Assurance                                 |
| - Run automated test suite: 0 non-8px spacing, 0 hardcoded colors, motion.   |
| - Verify content integrity diff: 12 modules, 84 lessons, pricing unchanged.  |
| - Validate W3C markup, CSS syntax, and runtime console hygiene.              |
+-------------------------------------------------------------------------------+
                                        |
                                        v
+-------------------------------------------------------------------------------+
| M4: Hard Handoff & Orchestrator Attestation                                   |
| - Compile handoff.md with full evidence chains and commands.                  |
| - Transmit final completion message to caller agent.                          |
+-------------------------------------------------------------------------------+
```

---

## 4. Interface Contracts

### 4.1 HTML-to-JavaScript DOM Binding Contract
`assets/js/course-v2.js` relies strictly upon the following immutable DOM element IDs and class hooks. These hooks must NEVER be removed or altered during markup refactoring:

| Target Element ID / Selector | Event / Binding | Purpose / Contract |
|---|---|---|
| `#skill-pillar-tabs` | Click Event Delegation | Container for 21-skill filter buttons (`.c-filter-btn`, `.filter-btn`). |
| `#skills-21-grid` | DOM Filtering | Grid of `.c-skill-pillar-card` elements filtered by `data-skill-cat`. |
| `#skill-pillar-count` | TextContent Update | Displays currently visible skill card count. |
| `#curriculum-filter-tabs`| Click Event Delegation | Container for module filter buttons (`.c-filter-btn`, `.filter-btn`). |
| `.c-syllabus-week` | Class / State Toggle | Module containers filtered by `data-category`. |
| `#btn-curriculum-expand` | Click Event | Expands all 12 syllabus accordions simultaneously. |
| `#btn-curriculum-collapse`| Click Event | Collapses all syllabus accordions. |
| `#btn-copy-full-curriculum`| Click Event | Copies `.c-aeo-summary-text` to clipboard with toast confirmation. |
| `.commuter-town-pills button`| Click Event | Commuter town selector updating route display. |
| `#map-route-badge` | TextContent Update | Displays travel duration (e.g. `12 mins · Direct Wagon`). |
| `#town-commute-title` | TextContent Update | Displays commuter town route header. |
| `#town-commute-desc` | TextContent Update | Displays detailed route stops and commute instructions. |
| `.c-batch-slot-btn` | Click Event | Batch time slot selector (Morning, Afternoon, Evening, Weekend). |
| `#batch-slot-title` | TextContent Update | Displays selected slot title (e.g., `Morning Cohort · 10:00 AM`). |
| `#batch-seats-badge` | TextContent Update | Displays remaining seat status (e.g., `3 Seats Left`). |
| `#batch-audience-note` | TextContent Update | Displays target demographic for selected batch. |
| `#card-wa-btn-text` | TextContent Update | Updates CTA text with selected batch time. |
| `#card-wa-cta` | Href Attribute Update | Updates direct WhatsApp enrollment URL with pre-filled batch info. |
| `#btn-fee-full` | Click Event / Toggle | Switches tuition display to Full Track (`PKR 25,000`). |
| `#btn-fee-install` | Click Event / Toggle | Switches tuition display to Installments (`PKR 8,500 / mo`). |
| `#fee-display-amount` | TextContent Update | Updates tuition price headline (`PKR 25,000` or `PKR 8,500 / mo`). |
| `#fee-display-sub` | TextContent Update | Updates tuition payment explanation and guarantee terms. |
| `.c-mobile-dock` | Scroll / Navigation Spy| Toggles `.visible` class when viewport `scrollY > 350px`. |

---

### 4.2 CSS Token Contract
`assets/css/course-v2.css` must inherit and consume tokens defined in `main.css`, complemented by scoped Course V2 design tokens:

```css
/* Core Spatial Tokens */
--s-half: 4px;
--s-1: 8px;
--s-2: 16px;
--s-3: 24px;
--s-4: 32px;
--s-5: 40px;
--s-6: 48px;
--s-7: 56px;
--s-8: 64px;

/* Semantic Color Tokens */
--bg: #ffffff;             /* Light canvas */
--card: #faf8ff;           /* Light surface */
--line: #ede8fc;           /* Light border */
--text-1: #181126;         /* Primary headline */
--text-2: #4a4060;         /* Secondary body */
--text-3: #756a8d;         /* Subdued tertiary */
--accent: #6e44ff;         /* Brand violet */
--accent-hover: #5b32ea;
--accent-convert-text: #ffffff;
--shadow-card: 0 4px 20px rgba(35, 27, 43, 0.06);
--shadow-hover: 0 12px 32px rgba(35, 27, 43, 0.12);

/* Semantic Badge Tokens (Light Defaults) */
--badge-gold-bg: #fef3c7;
--badge-gold-text: #d97706;
--badge-emerald-bg: #d1fae5;
--badge-emerald-text: #059669;
--badge-purple-bg: #ede9fe;
--badge-purple-text: #7c3aed;
--badge-amber-bg: #ffedd5;
--badge-amber-text: #ea580c;

/* Dark Mode Overrides (html[data-theme="dark"]) */
--bg: #090614;
--card: #130d24;
--line: #271d42;
--text-1: #f3f0fa;
--text-2: #b5a9cc;
--text-3: #82769c;
--accent: #7b52ff;
--shadow-card: 0 4px 24px rgba(0, 0, 0, 0.45);
--shadow-hover: 0 12px 36px rgba(0, 0, 0, 0.65);
--badge-gold-bg: rgba(245, 158, 11, 0.18);
--badge-gold-text: #fbbf24;
--badge-emerald-bg: rgba(16, 185, 129, 0.18);
--badge-emerald-text: #34d399;
--badge-purple-bg: rgba(124, 58, 237, 0.22);
--badge-purple-text: #c4b5fd;
--badge-amber-bg: rgba(234, 88, 12, 0.18);
--badge-amber-text: #fb923c;
```

---

## 5. Frozen Educational & Commercial Assets (Standard 6)

The following content parameters represent legally binding commitments and certified academic curriculum:

1. **Tuition Structure**: Full Course Tuition is strictly **PKR 25,000**. The installment plan is strictly **3 monthly installments of PKR 8,500 / mo** (or 2 installments of PKR 12,500 in hero summary).
2. **Lab Constraints**: Workstation capacity is strictly capped at **10–12 students maximum per cohort** with 1 student per Intel Core i7 PC node.
3. **Guarantees**: **14-day 100% money-back guarantee** without question.
4. **Curriculum Scope**: Exactly **12 Weekly Modules**, **36 Physical Lab Sessions**, and **84 Practical Lessons**.
5. **Key Earning Benchmarks**:
   - Local SEO & Marketing Retainers: `PKR 30,000 to PKR 80,000 / month per client`
   - Upwork / Fiverr Freelance Contracts: `$500 to $1,500 per project`
