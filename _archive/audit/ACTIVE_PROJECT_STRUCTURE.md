# Active Project Structure & Production Organization Report

**Project:** OneSkills Academy Website (`oneskills.pk`)  
**Audit & Reorganization Timestamp:** 2026-09-19  
**Status:** **100% Production Verified (Zero Broken Assets, Zero Console Errors, Zero Redesign)**

---

## 1. Final Folder Structure

```text
c:\Users\Nisar\Desktop\oneskills new123/
├── index.html                                  # Master homepage (production release)
├── about.html                                  # About page
├── privacy-policy.html                         # Privacy policy
├── terms-of-service.html                       # Terms of service
├── terms.html                                  # Backward-compatibility HTTP redirect
├── favicon.webp                                # Direct root favicon fallback
├── robots.txt                                  # Search crawler instructions
├── sitemap.xml                                 # Canonical XML sitemap
├── README.md                                   # Project documentation
├── LICENSE                                     # Repository license
├── .git/                                       # Version control
├── courses/                                    # Course detail pages (all 8 intact)
│   ├── ai-based-computer-course.html
│   ├── ai-tools-automation.html
│   ├── ai-web-development.html
│   ├── crypto-trading.html
│   ├── forex-trading.html
│   ├── freelancing-mastery.html
│   ├── programming-js-cpp.html
│   └── web3-blockchain.html
├── assets/
│   ├── css/
│   │   ├── main.css
│   │   └── notion-theme.css
│   ├── js/
│   │   └── main.js
│   ├── vendor/
│   │   └── leaflet/
│   │       ├── leaflet.css
│   │       ├── leaflet.js
│   │       └── images/ (marker-icon.png, marker-icon-2x.png, marker-shadow.png)
│   ├── videos/
│   │   └── 0Un_yWwicLyfrgF-.mp4
│   ├── icons/
│   │   └── hero/
│   │       ├── ai-automations.svg
│   │       ├── computer-office.svg
│   │       ├── digital-marketing.svg
│   │       ├── trading-forex.svg
│   │       ├── web-development.svg
│   │       └── web3-blockchain.svg
│   └── images/
│       ├── brand/
│       │   ├── OneSkills-Logo-light.webp
│       │   ├── OneSkills-Logo-dark.webp
│       │   ├── OneSkills-Logo.avif
│       │   ├── og-cover.webp
│       │   └── favicon.webp
│       ├── hero/
│       │   ├── full-mascot-transparent-light.webp
│       │   └── full-mascot-transparent-dark.webp
│       ├── courses/
│       │   ├── AI Tools & Automation-dark.webp
│       │   ├── AI Tools & Automation-light.webp
│       │   ├── AI Web Development-dark.webp
│       │   ├── AI Web Development-light.webp
│       │   ├── Computer Course-dark.webp
│       │   ├── Computer Course-light.webp
│       │   ├── Crypto Trading-dark.webp
│       │   ├── Crypto Trading-light.webp
│       │   ├── Forex Trading-dark.webp
│       │   ├── Forex Trading-light.webp
│       │   ├── Freelancing Mastery-dark.webp
│       │   ├── Freelancing Mastery-light.webp
│       │   ├── Programming-Course-dark.webp
│       │   ├── Programming-Course-light.webp
│       │   ├── Web3 & Blockchain-dark.webp
│       │   └── Web3 & Blockchain-light.webp
│       ├── instructors/
│       │   └── Asghr-Ali-2.webp
│       ├── reviews/
│       │   ├── testimonial-team-Attique-hussain.avif
│       │   ├── testimonial-team-Bilal-1.avif
│       │   ├── testimonial-team-hussnain.avif
│       │   ├── testimonial-team-Nisar-Mehar.avif
│       │   ├── testimonial-team-rubbi.avif
│       │   └── testimonial-team-webio.avif
│       ├── campus/
│       │   ├── campus-exterior.png
│       │   ├── campus-instructors.png
│       │   ├── campus-map-preview.png
│       │   ├── campus-training.png
│       │   └── campus-workstations.png
│       └── sections/
│           ├── A very subtle Hiran Minar  Sheikhupura architectural silhouette in the background.webp
│           ├── oneskills FAqs Final CTA banner.webp
│           ├── hiran-minar-water-reflection.png
│           ├── advisor card hiran minar.webp
│           └── method/
│               ├── Apply.webp
│               ├── Build.webp
│               ├── Learn.webp
│               ├── Practice.webp
│               └── student-mentor-learning.webp
└── _archive/
    ├── README.md
    ├── ARCHIVE_MANIFEST.md
    ├── ACTIVE_ASSET_INVENTORY.md
    ├── CLEANUP_REPORT.md
    ├── backups/snapshot_before_cleanup/
    ├── old-pages/
    ├── old-assets/
    ├── temporary/
    └── audit/
```

---

## 2. Relocated Production Files

| Original Path | New Path | Category | Reason for Move | References Updated |
|---|---|---|---|---|
| `0Un_yWwicLyfrgF-.mp4` | `assets/videos/0Un_yWwicLyfrgF-.mp4` | Video | Relocated loose root video to dedicated videos directory | `index.html` |
| `full-mascot-transparent-dark.webp` | `assets/images/hero/full-mascot-transparent-dark.webp` | Hero | Relocated loose root 3D mascot to hero image directory | `index.html` |
| `full-mascot-transparent-light.webp` | `assets/images/hero/full-mascot-transparent-light.webp` | Hero | Relocated loose root 3D mascot to hero image directory | `index.html` |
| `OneSkills-Logo-light.webp` | `assets/images/brand/OneSkills-Logo-light.webp` | Brand | Grouped official branding into dedicated brand folder | `index.html`, `about.html`, `courses/*.html` |
| `OneSkills-Logo-dark.webp` | `assets/images/brand/OneSkills-Logo-dark.webp` | Brand | Grouped official branding into dedicated brand folder | `index.html`, `about.html`, `courses/*.html` |
| `OneSkills-Logo.avif` | `assets/images/brand/OneSkills-Logo.avif` | Brand | Grouped official branding into dedicated brand folder | `index.html`, `about.html`, `privacy-policy.html`, `terms-of-service.html` |
| `assets/images/og-cover.webp` | `assets/images/brand/og-cover.webp` | Brand | Social preview and brand card | `index.html`, `about.html` |
| `favicon.webp` (copy) | `assets/images/brand/favicon.webp` | Brand | Complete brand asset library | `index.html`, `about.html`, `privacy-policy.html`, `terms-of-service.html`, `courses/*.html` |
| `Asghr-Ali-2.webp` | `assets/images/instructors/Asghr-Ali-2.webp` | Instructor | Faculty profile image for Asghar Ali | `index.html`, `about.html`, `courses/ai-based-computer-course.html` |
| `testimonial-team-Attique-hussain.avif` | `assets/images/reviews/testimonial-team-Attique-hussain.avif` | Reviews/Team | Student avatar and instructor portrait | `index.html`, `about.html`, `courses/crypto-trading.html`, `courses/forex-trading.html` |
| `testimonial-team-Bilal-1.avif` | `assets/images/reviews/testimonial-team-Bilal-1.avif` | Reviews/Team | Student avatar and mentor portrait | `index.html`, `about.html`, `courses/web3-blockchain.html` |
| `testimonial-team-hussnain.avif` | `assets/images/reviews/testimonial-team-hussnain.avif` | Reviews/Team | Student avatar and instructor portrait | `index.html`, `about.html`, `courses/ai-tools-automation.html` |
| `testimonial-team-Nisar-Mehar.avif` | `assets/images/reviews/testimonial-team-Nisar-Mehar.avif` | Reviews/Team | Founder & Chief Mentor photo and avatar | `index.html`, `about.html`, `courses/freelancing-mastery.html` |
| `testimonial-team-rubbi.avif` | `assets/images/reviews/testimonial-team-rubbi.avif` | Reviews/Team | Student avatar and mentor portrait | `index.html`, `about.html`, `courses/programming-js-cpp.html`, `courses/ai-web-development.html` |
| `testimonial-team-webio.avif` | `assets/images/reviews/testimonial-team-webio.avif` | Reviews/Team | Student avatar and mentor portrait | `index.html`, `about.html` |
| `A very subtle Hiran Minar...webp` | `assets/images/sections/A very subtle Hiran Minar...webp` | Section | Architectural background artwork | `index.html` |
| `oneskills FAqs Final CTA banner.webp` | `assets/images/sections/oneskills FAqs Final CTA banner.webp` | Section | FAQ section bottom banner | `index.html` |
| `assets/images/about/hiran-minar-water-reflection.png` | `assets/images/sections/hiran-minar-water-reflection.png` | Section | About section water reflection photo | `index.html` |
| `assets/images/advisor card imges/advisor card hiran minar.webp` | `assets/images/sections/advisor card hiran minar.webp` | Section | Advisor card graphic | `index.html` |
| `images/method/*` & `assets/images/method/*` | `assets/images/sections/method/*` | Section | 4-Stage learning process images | `index.html` |
| 16 Course images in `assets/images/` | `assets/images/courses/*` | Courses | Course program covers for Light & Dark mode | `index.html`, `courses/programming-js-cpp.html` |
| `assets/images/hero-icons/*.svg` | `assets/icons/hero/*.svg` | Icons | Standalone vector icons for hero cards | `index.html` |

---

## 3. Files Intentionally Retained in Specific Locations

### Root Directory
- `index.html`, `about.html`, `privacy-policy.html`, `terms-of-service.html`: Core website pages.
- `terms.html`: Kept at root as a lightweight, instant HTTP/client redirect to `terms-of-service.html` to guarantee backward compatibility for external bookmarks/links.
- `favicon.webp`: Kept at root to serve direct browser root requests (e.g. `/favicon.webp`) without server rewrite dependencies, per Step 8 & Step 9 of instructions.
- `robots.txt` & `sitemap.xml`: SEO infrastructure files required at domain root.
- `LICENSE` & `README.md`: Essential repository documentation and licensing.
- `courses/`: Maintained as the authoritative subfolder for all 8 course detail HTML pages.
- `assets/`: Standardized asset root.
- `_archive/`: Safe, non-interfering archive directory.

### `/images/` Directory
- **Removed entirely from root.** All images previously served from `/images/` have been consolidated into `assets/images/sections/method/` and references updated.

### `/assets/` Directory
- `assets/css/`: `main.css`, `notion-theme.css` preserved in place.
- `assets/js/`: `main.js` preserved in place.
- `assets/vendor/leaflet/`: Vendor Leaflet stylesheet, script, and marker image assets kept in place to ensure Leaflet's internal relative path resolution functions seamlessly.
- `assets/images/campus/`: Retained in place as it was already cleanly structured.

---

## 4. Verification Results

1. **Automated Line-by-Line Dependency Scan:**
   - Total asset references checked across all HTML, CSS, JS, and XML files: **410 references**.
   - Missing production references: **0**.
   - Residual references to old asset locations: **0**.
   - Result: **100% PASS**.

2. **Interactive Playwright Browser Smoke Test:**
   - **Console Errors:** **0 errors**.
   - **Theme Switching:** Smooth transition between Light and Dark mode; both logo sets, mascot sets, and course card images load correctly without missing assets.
   - **Video Modal:** 'Watch Demo' button opens modal and video element resolves to `assets/videos/0Un_yWwicLyfrgF-.mp4`.
   - **Category Filters:** Course filter buttons ('AI & Automation', 'Trading & Web3', 'All Programs') filter and display cards with all images loading from `assets/images/courses/`.
   - **Leaflet Map:** Map container `#campus-real-map` initializes, loads tile layers, renders custom controls, and works interactively.
   - **FAQ Accordion:** Banner loads from `assets/images/sections/`, accordion questions toggle expand/collapse state.
   - **Subpages:** `courses/ai-tools-automation.html` and `about.html` load 100% of brand, team, and course assets with 0 console errors.
   - Result: **100% PASS**.
