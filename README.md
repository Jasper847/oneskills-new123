# OneSkills Academy — Official Web Platform & Course Systems

[![Status: Production Ready](https://img.shields.io/badge/Status-Production%20Ready-success?style=flat-square)](https://oneskills.pk/)
[![License: Proprietary](https://img.shields.io/badge/License-Proprietary-blue?style=flat-square)](LICENSE)
[![Accessibility: WCAG 2.2 AA](https://img.shields.io/badge/Accessibility-WCAG%202.2%20AA-purple?style=flat-square)](courses/freelancing-mastery.html)
[![Architecture: Zero-Build Static](https://img.shields.io/badge/Architecture-Vanilla%20HTML5%20%2F%20CSS%20%2F%20ES6+-black?style=flat-square)](PROJECT.md)

Welcome to the official repository for **OneSkills Academy** (Sheikhupura, Punjab, Pakistan). This platform delivers high-performance, accessible, and conversion-optimized web experiences for on-campus digital skills programs, physical classroom accelerators, and student admissions.

---

## 🏛️ About OneSkills Academy

**OneSkills Academy** is an on-campus digital education institution situated in Sheikhupura, Pakistan. The academy specializes in practical, workstation-guided training combining high-income digital capabilities with direct mentor supervision:

- **Campus Address:** Main Lahore–Sargodha Road, Opposite Mian Hospital, Near KIPS College, Sheikhupura, Punjab, Pakistan.
- **Founder & Lead Mentor:** Nisar Mehar (7+ years active digital marketing & agency experience).
- **Core Mission:** Bridge the gap between theoretical knowledge and real market outcomes (Upwork, Fiverr, Meta/Google Ads, Local SEO, and AI Automation) through small cohorts and live campaign execution.

---

## 🚀 Flagship Course: Freelancing & Digital Marketing Mastery

The flagship course page ([`courses/freelancing-mastery.html`](courses/freelancing-mastery.html)) is an enterprise-grade digital education experience designed according to strict forensic UX, accessibility, and conversion standards.

### Key Institutional Facts (Authoritative Source of Truth)

| Parameter | Official Specification |
| :--- | :--- |
| **Total Course Tuition** | **PKR 28,000** (Full Track) |
| **Flexible Installments** | **2 Payments of PKR 14,000** |
| **Duration** | **12 Weeks (3 Months)** — 36 on-campus sessions |
| **Practical Hands-On Hours** | **80+ Practical Training Hours** |
| **Cohort Size** | **Maximum 12 Students** per batch (strict direct mentor cap) |
| **Student Equipment** | **Bring Your Own Laptop (BYOL)** — personal laptops for live campaign setup |
| **Google Review Rating** | **5.0 / 5.0 Rating** (Verified Google Business Profile) |
| **Refund Policy** | **14-Day Full Refund Policy** calculated from the **fee payment date** |
| **Lead Instructor** | **Nisar Mehar** (7+ years experience · 160+ students mentored) |
| **Internship Program** | **1-Month Unpaid Internship** post-graduation (extendable up to 3 months) |
| **Classroom Infrastructure** | Modern, comfortable classroom studio with reliable power backup & high-speed internet |
| **Admissions Status** | **Admissions Open · Contact for next batch schedule** |

---

## 🛠️ System Architecture & Engineering Standards

The codebase is built on zero-dependency, ultra-fast static web engineering principles, prioritizing User Experience (UX), Developer Experience (DX), and Agent Experience (AX).

```
┌──────────────────────────────────────────────────────────────────────────────────┐
│                                CLIENT BROWSER                                    │
└────────────────────────────────────────┬─────────────────────────────────────────┘
                                         │
                 ┌───────────────────────┴───────────────────────┐
                 ▼                                               ▼
┌─────────────────────────────────┐             ┌──────────────────────────────────┐
│  Semantic HTML5 Architecture    │             │   Design Token & Style System    │
│  - <header class="site-header"> │             │   - assets/css/main.css          │
│  - <nav class="c-subnav">       │             │   - assets/css/course-v2.css     │
│  - <main id="main-content">     │             │   - CSS Custom Properties        │
│    * #hero (Hero Editorial)     │             │   - 8px Spatial Grid System      │
│    * #overview (21 Pillars)     │             │   - prefers-reduced-motion suite │
│    * #method (4-Stage Loop)     │             └────────────────┬─────────────────┘
│    * #curriculum (Blueprint)    │                              │
│    * #deliverables (HUD Grid)   │                              ▼
│    * #internship (3 Stages)     │             ┌──────────────────────────────────┐
│    * #comparison (Matrix)       │             │  Interactive UX & Logic System   │
│    * #specs (Campus Studio)     │             │  - assets/js/course-v2.js        │
│    * #reviews (Proof Cards)     │             │  - Filter Engine (Bento/Modules) │
│    * #admissions (Fee Switcher) │             │  - Interactive Fee Switcher      │
│    * #faq (Accessible Details)  │             │  - Batch Slot Selector           │
│  - <aside class="c-mobile-dock">│             │  - Commuter Route Matrix         │
│  - <footer class="site-footer"> │             │  - ARIA Live Announcements       │
└─────────────────────────────────┘             └──────────────────────────────────┘
```

### 1. Structural Layer (Semantic HTML5 & Accessibility)
- **Semantic Landmarks:** Full utilization of `<header>`, `<nav>`, `<main>`, `<section>`, `<article>`, `<aside>`, `<footer>`, `<figure>`, `<figcaption>`, `<dl>`, `<dt>`, `<dd>`, and `<ol>`.
- **Keyboard Navigation:** High-contrast skip-to-content bypass link (`.skip-link`) for immediate focus management.
- **W3C WAI-ARIA Conformance:** Live regions (`aria-live="polite"`), explicit toggle states (`aria-pressed`, `aria-selected`, `aria-expanded`), and accessible table semantics.
- **Accessible Motion:** Universal `@media (prefers-reduced-motion: reduce)` rules that automatically halt continuous floating loops, translations, and transitions for sensitive users.

### 2. Presentation Layer (8px Grid & Design Tokens)
- **Spatial Rhythm:** Strict 8-pixel spacing system (`8px`, `16px`, `24px`, `32px`, `48px`, `64px`, `80px`) across all padding, margins, and layout gaps.
- **Dual-Theme Tokenization:** Pure CSS custom properties (`--bg`, `--surface-card`, `--brand-purple`, `--text-primary`, `--border-default`) for flawless Light and Dark mode rendering without hardcoded color flashes.
- **Responsive Layout Engine:** Fluid CSS Grid and Flexbox systems supporting viewports from 320px mobile screens up to 4K ultra-wide monitors.

### 3. Behavioral Layer (Pure Vanilla ES6+)
- **Zero Third-Party JS Frameworks:** Zero React, Vue, or jQuery overhead for ultra-low latency and immediate Time to Interactive (TTI).
- **Interactive Fee Switcher:** Instant toggle between Full Track (`PKR 28,000`) and Installments (`2 × PKR 14,000`).
- **Interactive Batch Slot Selector:** Cohort selector (Morning, Afternoon, Evening, Weekend) updating admissions copy without fabricated countdowns.
- **Commuter Town Matrix:** Interactive route guide for students traveling from Sheikhupura, Farooqabad, Safdarabad, Muridke, and Nankana Sahib.

---

## 📁 Repository Directory Structure

```text
oneskills-new123/
├── .agents/                     # Specialized agent instructions, skills, and rule sets
├── assets/
│   ├── css/
│   │   ├── main.css             # Global site-wide stylesheet and CSS tokens
│   │   ├── refinement.css       # Layout refinement and polish layer
│   │   └── course-v2.css        # Enterprise V2 course component styling
│   ├── js/
│   │   ├── main.js              # Site-wide interactive scripts (nav, theme)
│   │   └── course-v2.js         # Course V2 interactive modules & state engines
│   └── images/
│       ├── brand/               # Official logos, favicons, and wordmarks
│       ├── campus/              # Authentic Sheikhupura classroom facility imagery
│       ├── courses/             # Course artwork and editorial illustrations
│       ├── reviews/             # Verified student and mentor profile avatars
│       └── vibegif/             # Optimized micro-interaction animated WebP assets
├── courses/
│   ├── ai-based-computer-course.html
│   ├── ai-tools-automation.html
│   ├── ai-web-development.html
│   ├── crypto-trading.html
│   ├── digital-marketing.html
│   ├── forex-trading.html
│   ├── freelancing-mastery.html # Primary flagship course page (V2 Architecture)
│   ├── programming-js-cpp.html
│   ├── shopify-ecommerce.html
│   └── web3-blockchain.html
├── guides/                      # Student reference guides, articles, and documentation
├── 404.html                     # Custom accessible 404 error page
├── about.html                   # Academy background, vision, and leadership
├── index.html                   # Main academy landing page
├── privacy-policy.html          # Student privacy & data compliance policy
├── terms-of-service.html        # Official terms of service & synchronized refund policy
├── sitemap.xml                  # Complete XML sitemap for search crawlers
├── robots.txt                   # Search crawler directives
├── serve.ps1                    # Lightweight PowerShell local development HTTP server
├── PROJECT.md                   # Complete architectural engineering specification
└── README.md                    # Platform documentation (this file)
```

---

## 💻 Local Development & Setup

This project requires **no `npm install`**, build steps, bundlers, or compilers. It runs natively in any standard modern web browser.

### Starting the Local Development Server

A dedicated, lightweight PowerShell HTTP server script is included in the project root:

```powershell
# Open terminal in the project directory
powershell -ExecutionPolicy Bypass -File serve.ps1
```

Once running, the local environment is accessible at:
- **Local URL:** `http://localhost:8080/`
- **Flagship Course:** `http://localhost:8080/courses/freelancing-mastery.html`

Alternatively, you can use any standard static web server:

```bash
# Python 3
python -m http.server 8080

# Node.js (npx)
npx serve -l 8080
```

---

## 🔍 SEO & Structured Data Architecture

Every course page incorporates verified [Schema.org](https://schema.org) JSON-LD structured data graphs:

1. **`@type: Course`**: Detailed curriculum breakdown, duration (`P12W`), price (`28000 PKR`), mode (`onsite`), and mentor information.
2. **`@type: AggregateRating`**: Verified 5.0/5.0 rating without fabricated review counts.
3. **`@type: BreadcrumbList`**: Full hierarchical navigation trail (`Home > Courses > Freelancing & Digital Marketing Mastery`).
4. **`@type: FAQPage`**: Direct synchronization with visible on-page FAQs (laptop requirements, 1-month internship opportunity, 14-day refund policy from payment date).

---

## 🧪 Testing & Quality Assurance

The codebase undergoes regular forensic testing across multiple viewports and rendering engines:

- **Desktop Formats:** 1920×1080 (Full HD), 1440×900 (Laptop), 1280×800 (Compact).
- **Tablet Formats:** 768×1024 (iPad / Tablet Portrait).
- **Mobile Formats:** 430×932 (iPhone Pro Max), 390×844 (Standard Phone), 375×667 (Compact Phone).
- **Key Validations:**
  - Zero horizontal overflow (`scrollWidth === clientWidth`).
  - Minimum touch target size of 44×44px on mobile devices.
  - Strict color contrast compliant with WCAG 2.2 AA.
  - Zero hardcoded color flashes during theme toggle.

---

## 📞 Admissions & Contact

For institutional inquiries, admissions, or physical campus visits:

- **WhatsApp / Phone:** [+92 317 603 6127](https://wa.me/923176036127)
- **Email:** [info@oneskills.pk](mailto:info@oneskills.pk)
- **Official Website:** [https://oneskills.pk](https://oneskills.pk/)
- **Campus:** Main Lahore–Sargodha Road, Opposite Mian Hospital, Near KIPS College, Sheikhupura, Punjab, Pakistan.

---

*© OneSkills Academy. All rights reserved.*
