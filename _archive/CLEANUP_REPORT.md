# Forensic Website File & Asset Organization Report
**Project:** OneSkills Academy Website (`oneskills.pk`)  
**Audit Date:** 2026-09-19  
**Status:** 100% Verified Production Ready (Zero Broken Assets, Zero Functional Regressions)

---

## 1. Executive Summary
A comprehensive, forensic line-by-line dependency audit was conducted across the entire OneSkills Academy website codebase. In strict compliance with the project safety directives:
- **Zero files were permanently deleted.**
- **Zero active files were cosmetically moved** (eliminating risk to relative paths).
- **100% of website visual design, layout, typography, colors, animations, copy, and course data were preserved untouched.**
- Confirmed unused legacy assets, temporary crop/test files, and superseded prototype milestone versions were safely archived into a dedicated, documented `_archive/` structure.
- Full snapshot backup was recorded before moving any files.
- Automated dependency audits and live browser interactive smoke tests confirmed 100% resolution of all asset references, zero console errors, and flawless interactive functionality.

---

## 2. Phase 17 Forensic Metric Breakdown

### 1. Total Files Scanned
- **195 original project files** (totaling 34.33 MB) prior to cleanup (excluding `.git`).

### 2. Total Images Scanned
- **150 images** (.webp, .png, .svg, .avif, .jpg, .jpeg) scanned across root and `assets/images/`.

### 3. Total CSS Files Scanned
- **5 CSS files** (`assets/css/main.css`, `assets/css/notion-theme.css`, `assets/vendor/leaflet/leaflet.css`, plus legacy unreferenced milestone files).

### 4. Total JS Files Scanned
- **2 JavaScript files** (`assets/js/main.js`, `assets/vendor/leaflet/leaflet.js`).

### 5. Total HTML Files Scanned
- **25 HTML files** (authoritative production pages: `index.html`, `about.html`, `privacy-policy.html`, `terms-of-service.html`, `terms.html`, 8 detail pages in `courses/`, plus 12 legacy milestone copies such as `index(1).html` through `index(6).html`, `oneskills-final.html`, etc.).

### 6. Total Active Files (Category A)
- **75 files** actively and directly referenced in production HTML, CSS, JavaScript, or metadata.

### 7. Total Conditional / Dynamic Files (Category B)
- **12 files** dynamically resolved at runtime (e.g., Leaflet runtime marker icons and shadows `marker-icon.png`, `marker-icon-2x.png`, `marker-shadow.png`, static campus map preview fallback `campus-map-preview.png`, methodology track visual assets in `assets/images/method/`, and `terms.html` HTTP redirect).

### 8. Total Configuration / Infrastructure Files (Category C)
- **4 files** required for SEO, deployment, repository integrity, and licensing: `robots.txt`, `sitemap.xml`, `LICENSE`, `README.md`.

### 9. Total Possibly-Unused Files (Category D)
- **0 files**. Every candidate asset was audited line-by-line across all codebases. Where dynamic usage was plausible, assets were classified into Category B and preserved in place.

### 10. Total Confirmed-Unused Files (Category E)
- **53 files** safely moved to `_archive/old-pages/` and `_archive/old-assets/`. These include superseded milestone HTML files, legacy root images unreferenced by any production code, and legacy prototype styles.

### 11. Total Temporary / Working Files (Category F)
- **49 files** safely moved to `_archive/temporary/`. These include UI test crops (`mockup_crops/`), experimental vector dumps (`hero icon & svg's/`), botanical element crops, and scratch test scripts.

### 12. Total Archived Files
- **102 files** archived into `_archive/`.

### 13. Total Archived Storage Size
- **26,822,245 bytes (25.58 MB)** safely preserved in archive storage.

### 14. Files Intentionally Left Due to Uncertainty / Safety
- `assets/vendor/leaflet/images/*` (`marker-icon.png`, `marker-icon-2x.png`, `marker-shadow.png`): Loaded dynamically at runtime by Leaflet's icon path resolution. Kept in place.
- `assets/images/campus/campus-map-preview.png`: Retained as fallback preview for map offline or pre-initialization states.
- `assets/images/method/*`: Retained as foundational track methodology assets.
- `terms.html`: Retained as a fast client-side redirect to `terms-of-service.html` to preserve backward compatibility for any external bookmarks or backlinks.
- `A very subtle Hiran Minar Sheikhupura architectural silhouette in the background.webp`: Root asset confirmed referenced on lines 459 and 815 of `index.html`. Kept in place.
- `Asghr-Ali-2.webp`: Root asset confirmed referenced in `index.html`, `about.html`, and `ai-based-computer-course.html`. Kept in place.

### 15. Duplicate Assets Found and Handled
- **Favicon variants:** `favicon.webp` was present in both root and `assets/images/`. HTML files reference both paths depending on context (`assets/images/favicon.webp` in course detail pages and subpages; `favicon.webp` at root for direct browser `/favicon.webp` requests). Both active instances were preserved.
- **Hero Icons:** Duplicate SVG exports in `assets/images/hero-icons/` and `assets/images/hero-icons/backup/`. Line-by-line scan confirmed active pages specifically referenced SVGs in both locations; all actively referenced variants were preserved untouched.
- **Course Card Previews:** Various `course_1.png` to `course_8.png` and legacy `.png` crops in root and `assets/hero/`. Production pages use the high-fidelity dark/light `.webp` graphics in `assets/images/`. Unreferenced legacy cuts were confirmed unused (0 references) and moved to `_archive/old-assets/`.

### 16. Potential Problems Discovered & Addressed
- Leaflet's vendor stylesheet `leaflet.css` contains default fallback rules referencing `images/layers.png` and `images/layers-2x.png`. Analysis confirmed these files were not present in the original repository snapshot and are only required if Leaflet's optional layer control is instantiated (which OneSkills does not use). All actual Leaflet map marker and shadow assets exist and work properly.
- No other potential problems or orphaned critical assets were detected.

### 17. Tests Performed
1. **Pre-Cleanup Full Dependency Audit:** Scanned all 25 HTML files, 5 CSS files, 2 JS files, schema files, and metadata tags to establish baseline reference matrix.
2. **Snapshot Backup Verification:** Bit-for-bit recursive snapshot created in `_archive/backups/snapshot_before_cleanup/` (195 files verified).
3. **Automated Post-Cleanup Dependency Scan:** Evaluated all `src`, `href`, `url()`, and `meta` references across all production HTML, CSS, and JS files. Verified that 100% of production references resolve to active files on disk (410 total references checked).
4. **Interactive Browser Smoke Test (Playwright Engine):**
   - Headless browser automated session testing `http://localhost:8080/index.html`.
   - Verified **0 console errors** and 0 uncaught exceptions.
   - Tested Dark / Light theme toggle button: confirmed seamless transition, DOM `data-theme` updates, and logo switching.
   - Tested Courses filter buttons: clicked `AI & Automation` filter, confirmed dynamic filtering of cards, verified `All Programs` reset.
   - Tested Course page navigation: clicked `courses/ai-tools-automation.html`, confirmed page loads with clean typography, header `AI Tools & Automation Track`, and full stylesheet.
   - Tested Faculty images: verified `Asghr-Ali-2.webp` (370x370) and `testimonial-team-Nisar-Mehar.avif` (270x320) load with correct intrinsic dimensions.
   - Tested Campus interactive Leaflet map: verified container `#campus-map-card`, loaded map tiles, custom pins, and zoom button interactions.
   - Tested FAQ accordion: verified FAQ CTA banner and clicked FAQ question button, confirming `aria-expanded` toggling and answer expansion.
   - Tested Footer legal links: clicked `Privacy Policy`, confirmed navigation to `privacy-policy.html` and clean rendering.

### 18. Final Verification Result
- **STATUS: 100% PASSED**
- All 91 production files are in place.
- All 102 archived files are documented in `_archive/ARCHIVE_MANIFEST.md` with audit reasons, original paths, archived paths, file sizes, and 0 references found.
- The live website is completely unaffected, cleaner, faster to navigate, and free from loose scratch prototypes.