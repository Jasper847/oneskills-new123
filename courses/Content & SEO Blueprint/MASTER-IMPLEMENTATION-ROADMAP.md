# ONESKILLS ACADEMY — MASTER IMPLEMENTATION ROADMAP
## Phased Engineering Plan, Work Breakdown Structure, Dependency Matrix & Acceptance Criteria

**Project:** OneSkills Academy (`https://oneskills.pk`)  
**Document Location:** `courses/Content & SEO Blueprint/MASTER-IMPLEMENTATION-ROADMAP.md`  
**Governing Standard:** Enterprise Digital Education / Zero-Downtime Migration / Controlled Phased Rollout  
**Author:** Antigravity Engineering Leadership & Release Management Team  
**Audit Date:** November 2026  
**Status:** **Approved Phased Execution Plan — Pending Owner Sign-Off**

---

## 1. Roadmap Architecture & Execution Principles

To prevent regressions, ensure zero downtime, and systematically replace all 8 broken legacy course pages with high-performance V3 pages, the rollout is structured into **Six Sequential Phases**:

```
┌────────────────────────────────────────────────────────────────────────────────────────┐
│                        ONESKILLS V3 ROLLOUT SEQUENCE                                   │
├─────────────┬──────────────────────────────────────────────────────────┬───────────────┤
│ Phase       │ Primary Milestone Focus                                  │ Duration / Seq│
├─────────────┼──────────────────────────────────────────────────────────┼───────────────┤
│ **PHASE 1** │ Design System Foundation & CSS Token Architecture        │ Step 1        │
├─────────────┼──────────────────────────────────────────────────────────┼───────────────┤
│ **PHASE 2** │ Master V3 Reference Template Engineering (`freelancing`) │ Step 2        │
├─────────────┼──────────────────────────────────────────────────────────┼───────────────┤
│ **PHASE 3** │ Tier 1 Flagship Course Rollout (Web Dev & AI Computer)   │ Step 3        │
├─────────────┼──────────────────────────────────────────────────────────┼───────────────┤
│ **PHASE 4** │ Tier 2 Financial & Automation Rollout (Forex, Crypto, AI)│ Step 4        │
├─────────────┼──────────────────────────────────────────────────────────┼───────────────┤
│ **PHASE 5** │ Tier 3 Specialized Rollout (Web3, C++/JS, Shopify, Hub)  │ Step 5        │
├─────────────┼──────────────────────────────────────────────────────────┼───────────────┤
│ **PHASE 6** │ Automated QA, Internal Link Silos & Production Launch    │ Step 6        │
└─────────────┴──────────────────────────────────────────────────────────┴───────────────┘
```

---

## 2. Phase-by-Phase Work Breakdown Structure (WBS)

---

### PHASE 1: Design System Foundation & CSS Token Architecture
- **Objective:** Establish the V3 CSS Custom Property foundations, the 8px spatial grid variables, and the 4 visual archetype modifier classes in shared stylesheets without breaking existing site pages.
- **Tasks:**
  1. Audit `assets/css/course-v2.css` and `assets/css/main.css`.
  2. Implement global spatial variables (`--space-1` through `--space-24`) and typography tokens.
  3. Implement the 4 Archetype color modifiers (`.archetype-marketing`, `.archetype-code`, `.archetype-trading`, `.archetype-ai`).
  4. Ensure 100% backward compatibility for existing classes used by `freelancing-mastery.html`.
- **Files Affected:**
  - `assets/css/course-v2.css`
  - `assets/css/refinement.css`
- **Dependencies:** None.
- **Risks & Mitigation:** Risk of style bleed into `index.html` or `about.html`. *Mitigation:* Scope all new rules under `body.course-v3-page` and archetype container classes.
- **Acceptance Criteria:**
  - CSS custom properties render correctly in both light (`data-theme="light"`) and dark (`data-theme="dark"`) modes.
  - Zero layout regressions on the live homepage and legal pages.

---

### PHASE 2: Master V3 Reference Template Engineering (`freelancing-mastery.html`)
- **Objective:** Refine `freelancing-mastery.html` into the authoritative V3 benchmark, streamlining DOM node count by ~40% while preserving its depth and verified factual truth.
- **Tasks:**
  1. Streamline Hero section: merge floating badges into a crisp, unified telemetry pill row.
  2. Optimize curriculum DOM: implement clean tabbed view for 12 weeks to eliminate massive node trees.
  3. Standardize campus studio section to the restrained infrastructure wording.
  4. Verify all confirmed institutional facts (PKR 28,000, 12 weeks, 80+ hours, BYOL personal laptop rule, 14-day refund from fee payment date, 7+ years mentor experience, 1-month unpaid internship with 3-month extension).
- **Files Affected:**
  - `courses/freelancing-mastery.html`
  - `assets/js/course-v2.js`
- **Dependencies:** Phase 1 completion.
- **Risks & Mitigation:** Risk of breaking interactive batch selectors or fee toggles. *Mitigation:* Run automated CDP interaction scripts (`scratch/verify_interactions.ps1`) before and after edits.
- **Acceptance Criteria:**
  - Total HTML line count reduced from 2,612 to ~1,400–1,600 lines.
  - Zero console errors; 100% keyboard accessibility; zero horizontal overflow across 375px–1920px viewports.

---

### PHASE 3: Tier 1 Flagship Course Rollout (Web Dev & AI Computer)
- **Objective:** Rebuild the two highest-volume, highest-ROI legacy course pages into complete V3 implementations based on their researched blueprints.
- **Courses:**
  1. **AI-Powered Web Development** (`courses/ai-web-development.html`):  
     - Apply **Archetype B** (Cyber Teal / Electric Slate).  
     - Implement 8-module, 12-week Next.js, React, Tailwind, and Cursor IDE syllabus.  
     - Replace Tutor LMS placeholder thumbnails with authentic code editor previews.  
     - Add interactive code block previews and Git branch roadmap.
  2. **AI-Based Computer & Office Management** (`courses/ai-based-computer-course.html`):  
     - Apply **Archetype D** (Deep Indigo / Violet).  
     - Implement 9-module, 12-weekend MS Office, Touch Typing, and Copilot AI syllabus.  
     - Add English & Urdu typing speed goal markers and Excel formula showcases.  
     - Target high-volume After-Matric and job-seeker search intent.
- **Files Affected:**
  - `courses/ai-web-development.html`
  - `courses/ai-based-computer-course.html`
  - `assets/images/courses/` (WebP banners)
- **Dependencies:** Phase 2 master template stability; owner confirmation of tuition fees.
- **Risks & Mitigation:** Legacy URLs indexed in Google. *Mitigation:* Retain identical file paths and canonical tags; implement 301 redirects from old Tutor LMS category query strings.
- **Acceptance Criteria:**
  - All Tutor LMS `Price: Free` and `0 Students` leaks completely eradicated.
  - Schema.org `Course` and `FAQPage` match visible copy with 100% fidelity.

---

### PHASE 4: Tier 2 Financial Markets & AI Automation Rollout
- **Objective:** Modernize Forex Trading, Crypto Trading, and AI Tools courses into authoritative, high-trust learning portals.
- **Courses:**
  1. **Forex Trading Mastery** (`courses/forex-trading.html`):  
     - Apply **Archetype C** (Emerald Green / Deep Slate).  
     - Implement 16-module, 3-phase Price Action, SMC, and MT4/MT5 syllabus.  
     - Add prominent 1% Risk Rule calculator and Prop Firm challenge roadmap.  
     - Feature mandatory financial risk disclaimers.
  2. **Crypto Trading Mastery** (`courses/crypto-trading.html`):  
     - Apply **Archetype C** (Emerald Green / Amber Gold).  
     - Remove raw template placeholder text (`Description`) from all 14 lesson titles.  
     - Add TradingView volume analysis, DEX trading safety, and tokenomics audit modules.
  3. **AI Tools, Automation & No-Code Software** (`courses/ai-tools-automation.html`):  
     - Apply **Archetype D** (Deep Indigo / Bright Violet).  
     - Replace broken `emptystate.svg` thumbnail in Google SERPs with custom WebP banner.  
     - Expand from 350-word thin page to 2,500-word comprehensive syllabus (Sora, Kling AI, Zapier, Make.com).
- **Files Affected:**
  - `courses/forex-trading.html`
  - `courses/crypto-trading.html`
  - `courses/ai-tools-automation.html`
- **Dependencies:** Phase 3 completion; owner confirmation of trading instructors and fees.
- **Risks & Mitigation:** Misleading earning claims risk. *Mitigation:* Prominent ethical disclaimers banning all guaranteed profit, get-rich-quick, or signal-service promises.
- **Acceptance Criteria:**
  - Trading pages feature prominent, unambiguous risk disclaimers.
  - All 14 syllabus placeholder bugs resolved.
  - New WebP featured thumbnails verified in SERP preview tools.

---

### PHASE 5: Tier 3 Specialized Tech, E-Commerce & Catalog Hub
- **Objective:** Complete the portfolio rollout with Web3, C++/JS Programming, the new standalone Shopify course, and the master catalog directory.
- **Courses:**
  1. **Web3, Blockchain & Airdrop Farming** (`courses/web3-blockchain.html`):  
     - Apply **Archetype D** (Deep Indigo).  
     - Fix swapped *Material Includes / Requirements / Audience* Tutor LMS content fields.  
     - Position uncontested national search advantage for safe airdrop farming and anti-drainer wallet security.
  2. **Programming in C++ & JavaScript** (`courses/programming-js-cpp.html`):  
     - Apply **Archetype B** (Cyber Teal).  
     - Implement 2-phase curriculum: C++ algorithmic fundamentals/OOP followed by modern JavaScript ES6+.  
     - Emphasize university exam alignment (PU, VU, GCUF) and 1-on-1 lab debugging.
  3. **Shopify & E-Commerce Dropshipping** (`courses/shopify-ecommerce.html`):  
     - Apply **Archetype A** (Editorial Purple).  
     - Launch standalone landing page capturing Blue Ocean local e-commerce queries.  
     - Include Pakistani COD courier integration (Trax, Call Courier) and Meta/TikTok video ad workflows.
  4. **All Courses Directory Hub** (`courses/index.html`):  
     - Upgrade to V3 layout with multi-category filtering (`All`, `AI & Code`, `Digital Marketing`, `Financial Trading`, `Productivity`).  
     - Ensure synchronized tuition, schedules, and direct WhatsApp counseling CTAs.
- **Files Affected:**
  - `courses/web3-blockchain.html`
  - `courses/programming-js-cpp.html`
  - `courses/shopify-ecommerce.html`
  - `courses/index.html`
- **Dependencies:** Phase 4 completion; owner sign-off on C++/JS and Shopify tuition.
- **Acceptance Criteria:**
  - All 9 course pages and the catalog hub share unified V3 header, subnav, and footer styling.
  - Category filters on `courses/index.html` operate instantly without page reloads.

---

### PHASE 6: Automated QA, Internal Link Silos & Production Launch
- **Objective:** Execute exhaustive automated cross-browser, responsive, accessibility, and SEO audits across all 10 pages before public launch.
- **Tasks:**
  1. Run automated Edge CDP responsive testing across all 7 standard viewports (375px, 390px, 430px, 768px, 1024px, 1280px, 1440px, 1920px).
  2. Verify zero horizontal overflow (`scrollWidth === clientWidth`) site-wide.
  3. Validate JSON-LD structured data on all pages via Schema.org validator.
  4. Update `sitemap.xml` with updated `<lastmod>` timestamps and clean priority weighting.
  5. Deploy exact-match contextual internal links from blog posts and guides to the 9 course pages.
- **Files Affected:**
  - `sitemap.xml`
  - `robots.txt`
  - All course and guide pages (internal links)
- **Dependencies:** Phases 1–5 complete.
- **Acceptance Criteria:**
  - 100% automated test pass rate.
  - Zero broken links, missing assets, or console errors.
  - Clean Search Console crawl readiness.

---

*End of Implementation Roadmap. Proceed to `OWNER-DECISIONS-REQUIRED.md` for the fact-validation register and decision checklist.*

