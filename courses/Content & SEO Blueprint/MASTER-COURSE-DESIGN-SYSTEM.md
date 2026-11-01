# ONESKILLS ACADEMY — MASTER COURSE DESIGN SYSTEM (V3)
## Technical Design Tokens, Component Hierarchy, Visual Archetypes & Accessibility Standards

**Project:** OneSkills Academy (`https://oneskills.pk`)  
**Document Location:** `courses/Content & SEO Blueprint/MASTER-COURSE-DESIGN-SYSTEM.md`  
**Governing Standard:** Enterprise Digital Education / Zero-Dependency Static Architecture / WCAG 2.2 AA Conformance  
**Author:** Antigravity UI/UX Architecture & Design System Team  
**Audit Date:** November 2026  
**Status:** **Approved Design System Specification — Ready for Template Engineering**

---

## 1. Design Philosophy: The Editorial Academy

OneSkills Academy is not an anonymous online course aggregator or a high-pressure sales funnel. It is a real physical academy with an air-conditioned classroom studio, power backup, fiber connectivity, and dedicated mentors in Sheikhupura, Pakistan.

The V3 Design System is built upon three foundational tenets:

1. **Restraint Over Decoration:** Eliminate excessive floating elements, gimmicky neon glows, decorative glassmorphism, and stacked marketing badges. Every visual container must earn its place by communicating substantive educational value.
2. **Discipline-Authentic Artifacts:** Rather than forcing an identical visual template onto every topic, each course must reflect the authentic artifacts of its industry:
   - *Code Courses* present syntax-highlighted terminal blocks, Git branch trees, and live API previews.
   - *Trading Courses* present high-contrast candlestick charts, economic calendar alerts, and transparent 1% risk management formulas.
   - *Marketing Courses* present verifiable campaign audits, ROAS dashboards, and client proposal frameworks.
   - *Office Productivity Courses* present keyboard shortcut matrices, Excel formula builders, and Copilot prompting templates.
3. **Flawless Ergonomics & Performance:** Zero build-step dependencies, pure CSS custom property theming (Light and Dark mode), strict adherence to an 8px spatial grid, and effortless keyboard/touch navigation.

---

## 2. Visual Archetypes & Color Architecture

To give each course its appropriate identity while maintaining institutional coherence, the V3 Design System organizes all 9 courses into **Four Distinct Visual Archetypes**:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        ONESKILLS V3 VISUAL ARCHETYPES                                  │
├─────────────────────┬──────────────────────────┬───────────────────────────────────────┤
│ Archetype           │ Assigned Courses         │ Palette & Visual Atmosphere           │
├─────────────────────┼──────────────────────────┼───────────────────────────────────────┤
│ **ARCHETYPE A**     │ • Freelancing & DM       │ • Primary: Refined Purple (`#6f42c1`)  │
│ *Agency & Growth*   │ • Shopify E-Commerce     │ • Accent: Warm Amber Gold (`#f59e0b`) │
│                     │                          │ • Theme: Editorial, proof, client ROI │
├─────────────────────┼──────────────────────────┼───────────────────────────────────────┤
│ **ARCHETYPE B**     │ • AI Web Development     │ • Primary: Cyber Teal (`#0d9488`)     │
│ *Code & Software*   │ • Programming (JS / C++) │ • Accent: Electric Slate (`#38bdf8`)  │
│                     │                          │ • Theme: Monospace, terminals, repos  │
├─────────────────────┼──────────────────────────┼───────────────────────────────────────┤
│ **ARCHETYPE C**     │ • Forex Trading Mastery  │ • Primary: Emerald Green (`#059669`)  │
│ *Financial Markets* │ • Crypto Trading Mastery │ • Accent: Gold/Warning (`#eab308`)    │
│                     │                          │ • Theme: Candlestick, risk math, VSA  │
├─────────────────────┼──────────────────────────┼───────────────────────────────────────┤
│ **ARCHETYPE D**     │ • AI Computer & Office   │ • Primary: Deep Indigo (`#4f46e5`)    │
│ *Productivity & AI* │ • AI Tools & Automation  │ • Accent: Bright Violet (`#8b5cf6`)   │
│                     │ • Web3 & Blockchain      │ • Theme: Workflow pipelines, tools    │
└─────────────────────┴──────────────────────────┴───────────────────────────────────────┘
```

### Global CSS Custom Properties (Theme Foundation)

```css
/* ==========================================================================
   ONESKILLS V3 MASTER DESIGN TOKENS
   ========================================================================== */

:root {
  /* Spatial System: 8-Pixel Rhythm */
  --space-1: 4px;   /* Micro-delimiters only */
  --space-2: 8px;   /* Base unit */
  --space-3: 12px;
  --space-4: 16px;  /* Standard component padding */
  --space-5: 20px;
  --space-6: 24px;  /* Grid gutter */
  --space-8: 32px;  /* Card padding */
  --space-10: 40px;
  --space-12: 48px; /* Section sub-gap */
  --space-16: 64px; /* Major container gap */
  --space-20: 80px; /* Section vertical padding (Desktop) */
  --space-24: 96px;

  /* Typography Scale */
  --font-display: 'Source Serif 4', Georgia, serif;
  --font-body: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
  --font-mono: 'JetBrains Mono', 'Fira Code', Menlo, monospace;
  --font-script: 'Caveat', cursive;

  /* Container Max-Widths */
  --container-max: 1240px;
  --container-prose: 740px;
  --container-narrow: 980px;

  /* Border Radii */
  --radius-sm: 6px;
  --radius-md: 10px;
  --radius-lg: 16px;
  --radius-full: 9999px;
}

/* Light Theme (Default) */
[data-theme="light"], :root:not([data-theme="dark"]) {
  --bg-page: #fbfaf8;
  --surface-card: #ffffff;
  --surface-alt: #f4f3ef;
  --surface-hover: #ebe9e3;
  --border-subtle: #e6e4dc;
  --border-card: #d9d6cb;
  --text-primary: #17151f;
  --text-secondary: #57534e;
  --text-muted: #78716c;
  --text-inverse: #ffffff;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.05);
  --shadow-card: 0 4px 12px rgba(0, 0, 0, 0.04), 0 1px 3px rgba(0, 0, 0, 0.02);
  --shadow-hover: 0 12px 24px rgba(0, 0, 0, 0.08), 0 4px 8px rgba(0, 0, 0, 0.04);
}

/* Dark Theme */
[data-theme="dark"] {
  --bg-page: #090714;
  --surface-card: #131024;
  --surface-alt: #1a1630;
  --surface-hover: #231e3d;
  --border-subtle: #242042;
  --border-card: #322c59;
  --text-primary: #f5f3ff;
  --text-secondary: #a7a3c2;
  --text-muted: #747094;
  --text-inverse: #090714;
  --shadow-sm: 0 1px 2px rgba(0, 0, 0, 0.3);
  --shadow-card: 0 4px 16px rgba(0, 0, 0, 0.4), 0 1px 4px rgba(0, 0, 0, 0.2);
  --shadow-hover: 0 12px 28px rgba(0, 0, 0, 0.5), 0 4px 8px rgba(0, 0, 0, 0.3);
}

/* Archetype Accent Token Overrides */
.archetype-marketing {
  --brand-primary: #6f42c1;
  --brand-accent: #f59e0b;
  --brand-tint: rgba(111, 66, 193, 0.08);
}
.archetype-code {
  --brand-primary: #0d9488;
  --brand-accent: #38bdf8;
  --brand-tint: rgba(13, 148, 136, 0.08);
}
.archetype-trading {
  --brand-primary: #059669;
  --brand-accent: #eab308;
  --brand-tint: rgba(5, 150, 105, 0.08);
}
.archetype-ai {
  --brand-primary: #4f46e5;
  --brand-accent: #8b5cf6;
  --brand-tint: rgba(79, 70, 229, 0.08);
}
```

---

## 3. Typographic Hierarchy & Scale

Readability and optical calm are restored by limiting font families to strict functional roles:

| Element | Font Family | Size (Desktop / Mobile) | Weight | Line Height | Role |
| :--- | :--- | :--- | :--- | :--- | :--- |
| **Hero H1** | `var(--font-display)` | `42px / 32px` | `700` | `1.15` | Authoritative academic statement with course name & city |
| **Section H2** | `var(--font-display)` | `32px / 26px` | `600` | `1.25` | Section landmark headings |
| **Card H3** | `var(--font-body)` | `20px / 18px` | `600` | `1.35` | Component and module titles |
| **Subtitle / Lead** | `var(--font-body)` | `18px / 16px` | `400` | `1.6` | Contextual narrative below H1/H2 |
| **Body Text** | `var(--font-body)` | `16px / 15px` | `400` | `1.65` | High-legibility paragraph content (max 75ch) |
| **UI Badges / Tags** | `var(--font-mono)` | `12px / 11px` | `500` | `1.0` | Telemetry chips, duration, batch caps, tool pills |
| **Code / Data** | `var(--font-mono)` | `14px / 13px` | `400` | `1.5` | Code snippets, terminal commands, price calculations |
| **Editorial Notes** | `var(--font-script)` | `20px / 18px` | `700` | `1.2` | Hand-annotated notes, mentor signatures, trust highlights |

---

## 4. Component Evaluation: Shared Standard vs. Course-Specific Optional

To prevent template bloat, the 20 potential course page components are rigorously classified into **12 Mandatory Core Components** and **8 Course-Specific Optional Modules**:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        COMPONENT SPECIFICATION INVENTORY                               │
├────┬─────────────────────────────┬───────────┬────────────────────────────────────────┤
│ No │ Component Name              │ Status    │ Purpose & Behavioral Specification     │
├────┼─────────────────────────────┼───────────┼────────────────────────────────────────┤
│ 01 │ **Global Header & Nav**     │ Mandatory │ Shared site header, logo, theme toggle │
│ 02 │ **Breadcrumb Navigation**   │ Mandatory │ Schema-backed hierarchy for SEO        │
│ 03 │ **Course Hero (Refined)**   │ Mandatory │ H1, value prop, fee pill, primary CTA  │
│ 04 │ **Core Facts Strip**        │ Mandatory │ 12 Weeks, 80+ Hrs, Max 12, BYOL Laptop │
│ 05 │ **Sticky Section Subnav**   │ Mandatory │ Smooth scroll-spy across 5–6 anchors   │
│ 06 │ **4-Stage Learning Method** │ Mandatory │ Proven hands-on pedagogical progression│
│ 07 │ **Interactive Curriculum**  │ Mandatory │ Tabbed/accordion module roadmap        │
│ 08 │ **Campus Studio & BYOL**    │ Mandatory │ Power backup, fiber, AC, desk photo    │
│ 09 │ **Mentor & Instructor Bio** │ Mandatory │ Proven trainer bio with E-E-A-T proof  │
│ 10 │ **Reviews & Proof Card**    │ Mandatory │ Verified 5.0 rating & local quote      │
│ 11 │ **Admissions & Fee Box**    │ Mandatory │ Transparent tuition, slots & WhatsApp  │
│ 12 │ **Structured FAQ Accordion**│ Mandatory │ 6–8 high-intent local objection Q&As   │
├────┼─────────────────────────────┼───────────┼────────────────────────────────────────┤
│ 13 │ *21-Pillar Bento Grid*      │ Optional  │ Used only for multi-skill flagships    │
│ 14 │ *Interactive Code Sandbox*  │ Optional  │ Used exclusively for Code / Web Dev    │
│ 15 │ *TradingView Chart Card*    │ Optional  │ Used exclusively for Trading courses   │
│ 16 │ *Copilot Prompt Showcase*   │ Optional  │ Used exclusively for AI Tools/Office   │
│ 17 │ *3-Stage Post-Internship*   │ Optional  │ Used where internship is confirmed     │
│ 18 │ *Institutional Matrix*      │ Optional  │ Used where competitor contrast is vital│
│ 19 │ *Commuter Belt Transit Hub* │ Optional  │ Highlighted for regional cohorts       │
│ 20 │ *Mobile Conversion Dock*    │ Mandatory │ Floating bottom bar for mobile screens │
└────┴─────────────────────────────┴───────────┴────────────────────────────────────────┘
```

---

## 5. Architectural Improvements Over Reference Template (`freelancing-mastery.html`)

While preserving the visual excellence and technical rigor of `freelancing-mastery.html`, the V3 architecture implements 6 critical improvements:

```
┌───────────────────────────────────────┬────────────────────────────────────────┐
│ Existing V2 Reference Implementation  │ Proposed V3 Master Course Architecture │
├───────────────────────────────────────┼────────────────────────────────────────┤
│ • 2,612 lines of HTML per page       │ • Streamlined to ~1,200–1,500 lines    │
│ • 4 floating badge cards in Hero      │ • Clean integrated telemetry pill row  │
│ • Identical purple palette on all pages│ • 4 discipline-specific color themes  │
│ • Massive 84-lesson DOM tree rendered │ • Interactive phase tabs with lazy DOM │
│ • Static ad screenshots on all courses│ • Industry-authentic live visual cards │
│ • Heavy repetitive promotional text   │ • Dense, informative editorial copy    │
└───────────────────────────────────────┴────────────────────────────────────────┘
```

---

## 6. Interaction & Accessibility Standards (WCAG 2.2 AA)

1. **Touch Target Size:** Every interactive trigger (buttons, tabs, accordions, links) has a minimum touch footprint of `48px × 48px` with at least `8px` separation.
2. **Contrast Ratios:**
   - Text against background exceeds `4.5:1` for regular text and `3:1` for large headings across both Light and Dark themes.
   - Interactive focus rings display a high-contrast `2px solid var(--brand-primary)` with a `2px` offset (`:focus-visible`).
3. **Motion Sensitivity:**
   - Animations respect `@media (prefers-reduced-motion: reduce)`. All continuous CSS animations (pulse, float, drift) are immediately halted.
4. **Zero Layout Shifts (CLS < 0.05):**
   - Explicit `width` and `height` dimensions are defined on all images and SVGs.
   - Web fonts use `font-display: swap` with system fallback metrics calibrated to prevent text reflow.

---

*End of Design System Specification. Proceed to `COURSE-BY-COURSE-IMPLEMENTATION-ROADMAP.md` for individual course blueprints.*

