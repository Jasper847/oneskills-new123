# OneSkills.pk — Enterprise-Level Design Consistency Audit
Source reviewed: `index.html` (redesigned via Google Antigravity IDE)
Scope: Visual/UI consistency only (colors, typography, spacing, radius, shadows, buttons). Not a functional/SEO/performance audit.

---

## 1. Root Cause Summary

The stylesheet defines a clean, well-thought-out **design token system** at the top:
- Single accent: Notion Blue `--accent: #0075de`
- 8px spacing scale: `--s-half` (4px) through `--s-12` (96px)
- Radius scale: `--r-s` 8px, `--r-m` 12px, `--r-l` 16px, `--r-xl` 20px, `--r-pill` 9999px
- Typography tokens: `--font`, `--font-display`, `--font-editorial`

**The problem:** almost every section built after the hero abandons these tokens and hardcodes its own one-off colors, spacing, and radii. This is the classic signature of AI-assisted, section-by-section generation without a final consolidation pass. The fix is not a redesign — it's enforcing the tokens that already exist.

---

## 2. Color Inconsistencies (Critical)

Root defines ONE accent (`#0075de` Notion Blue) but the page actually uses 7+ competing "brand" colors:

| Color | Hex | Used in |
|---|---|---|
| Notion Blue (intended accent) | `#0075de` / `#097fe8` | header CTA, hero primary btn, active filter |
| Indigo/Violet | `#6366f1`, `#7042f8`, `#8b5cf6`, `#9d7bfd`, `#a78bfa` | hero ambient glow/grid/connector lines, stat-pod-1 gradient, founder quote emphasis, instructor orbit badges, tag-course chip |
| Coral/Orange | `#ff5e36` | FAQ active state, footer link hover, path-card bottom CTA, footer brand-name emphasis, testimonial strong-text |
| Cyan/Sky | `#06b6d4`, `#3b82f6`, `#38bdf8`, `#60a5fa` | stat-pod-2 gradient |
| Amber | `#f59e0b`, `#ffb110`, `#fbbf24` | star ratings, stat-pod-3 gradient, highlight-pill.yellow |
| Pink/Rose | `#ec4899`, `#f43f5e`, `#f472b6`, `#fb7185` | stat-pod-4 gradient |
| Google Blue | `#1a73e8` / `#1557b0` | review-verify button, "verified" tag |
| WhatsApp Green | `#25d366` / `#1eb954` | WhatsApp CTA buttons |
| Near-black | `#09090b` | "black pill" path CTA, directions button |

**Impact:** No dominant brand color; every section trains the eye differently. Best practice: the CTA color should appear nowhere else on the page except in CTAs, and only one accent color should be used for primary actions site-wide.

**Fix:**
- Keep `#0075de` as the ONLY primary CTA fill color across the entire site.
- Demote WhatsApp/Google/black-pill buttons to a shared "secondary" style (white/outline + small brand-colored icon only, not full-color fill).
- Reserve indigo/orange/amber/pink strictly for small semantic accents (ratings = amber only; stat-pod numbers can keep subtle gradient but should use ONE gradient family, not four different ones).
- Delete `--accent-purple: #0075de` (dead/mislabeled variable — declared as blue but named purple, never actually used for purple).

### Light vs Dark theme hue mismatch
- Light `--text-2: #615d59` (warm brownish-gray) vs Dark `--text-2: #94a3b8` (cool blue-gray). Different hue families make light/dark feel like two different products rather than one theme toggle.
- Light theme is "Warm Paper Notebook" (`#f6f5f4` bg); dark theme is "Sleek Midnight Obsidian" (`#070913` bg) — the CSS comments themselves reveal these were conceived as two separate aesthetic concepts, not one system with a dark variant.

**Fix:** Keep the same neutral hue temperature (pick either warm-neutral or cool-neutral grays) across both themes; only invert lightness, not hue family.

---

## 3. Typography Inconsistencies

- `--font: Inter...` and `--font-display: Inter...` are set to the **same font** — pointless duplication that eliminates any heading-vs-body visual hierarchy signal from font family alone.
- `Plus Jakarta Sans` is preconnected, preloaded, and requested from Google Fonts but **no CSS rule uses it** — dead font weight/file bloat hurting load performance for zero visual benefit.
- `Source Serif 4` (`--font-editorial`) is applied to exactly ONE element (`.hero-sub.editorial-serif`) — an isolated serif touch with no repeating pattern elsewhere on the page, so it reads as accidental rather than an intentional editorial accent.
- Near-duplicate heading sizes that should be unified into one scale step:
  - `1.22rem` (founder-quote-body), `1.25rem` (panel-header h3), `1.28rem` (path-card-title, center-name), `1.15rem` (card-title, snapshot-title)
- Letter-spacing values scattered with no logic: `-0.01em, -0.015em, -0.02em, -0.03em, -0.035em, -0.04em, -0.06em` — used almost interchangeably on similar-weight headings.
- `.hero-h1` uses `clamp(2.6rem, 5.8vw, 4.8rem)`; `.section-head h2` uses `clamp(2.1rem, 4vw, 2.9rem)`; `.header-panel h2` uses `clamp(2rem, 3.5vw, 2.6rem)`; `.campus-headline` uses `clamp(2rem, 3.8vw, 3rem)` — four different H2-equivalent scales across sections that should visually match.

**Fix:**
- Reduce to 2 font families total: Inter (all UI/body/headings) + Source Serif 4 (repeated deliberately for testimonials/pull-quotes only, nowhere else).
- Remove the Plus Jakarta Sans font request entirely.
- Define one canonical type scale (e.g., 12 / 14 / 16 / 18 / 24 / 32 / 40 / 56px) and map every heading/label to the nearest step — no more one-off rem values.
- Standardize letter-spacing to 2 tiers only: `-0.02em` for headings ≥24px, `-0.01em` for everything smaller.

---

## 4. Spacing/Layout Inconsistencies

- The 8px spacing scale (`--s-1`...`--s-12`) exists but most components bypass it with arbitrary values: `44px 48px`, `13px 20px`, `14px 32px`, `9px 20px`, `16px 40px`, `15px 26px`, `10px 18px`, `5px 14px 5px 8px`, `34px 34px 30px`, `36px`, `38px 36px 32px`.
- **Duplicate/conflicting rule:** `.section-wrapper` is defined twice —
  1. `padding: var(--s-10) 0` (80px)
  2. Later, under "DOWNSTREAM SECTIONS" comment: `padding: 100px 0`
  Whichever wins by cascade order silently controls vertical rhythm — this is a bug, not a design choice, and produces uneven spacing between sections that both claim the same class.
- Card/section-internal padding varies without a pattern: `header-panel` = 44px 48px, `bento-card-clean` = 36px, `path-card` = 34px 34px 30px, `panel-card` = 32px, `g-review-modal-box` = 38px 36px 32px — none map to the `--s-*` scale.

**Fix:**
- Audit and remove the duplicate `.section-wrapper` rule; keep only the token-based one.
- Replace all hardcoded paddings with the nearest `--s-*` token (e.g., 34px → `--s-4` 32px + `--s-half`, or round to 32px cleanly).
- Standardize all "card" internal padding to one value (`--s-4`, 32px) regardless of section.

---

## 5. Border Radius Inconsistencies

Scale defined: `--r-s` 8px / `--r-m` 12px / `--r-l` 16px / `--r-xl` 20px / `--r-pill` 9999px. Actual usage bypasses tokens frequently:

| Component | Radius used | Should be |
|---|---|---|
| `.bento-card-clean` | 28px (hardcoded) | `--r-xl` 20px |
| `.review-marquee-card` / `.g-review-modal-box` | 28px (hardcoded) | `--r-xl` 20px |
| `details.faq-item` | 22px (hardcoded) | `--r-xl` 20px |
| `.outcome-chip` | 20px (hardcoded, matches r-xl but not referencing var) | use `var(--r-xl)` |
| `.path-card`, `.panel-card`, `.course-card` | `var(--r-l)` 16px | ✅ correct, keep as baseline |
| `.snapshot-location-footer` | 14px (hardcoded) | `--r-m` 12px |
| `.card-action-btn`, `.filter-btn` | 10px (hardcoded) | `--r-s` 8px |

**Impact:** Cards of similar visual weight sitting near each other (bento tiles at 28px vs. course cards at 16px) have visibly different corner roundness — reads as "unintentional" per standard QA checklists.

**Fix:** Pick 3 radius tiers max — buttons/pills (`--r-pill`), cards (`--r-l` 16px), large feature panels (`--r-xl` 20px) — and remap every hardcoded radius to the nearest token.

---

## 6. Shadow Inconsistencies

Nearly every component defines its own bespoke `box-shadow` with a different tint:
- Indigo-tinted: `0 20px 50px rgba(0,0,0,.25)` + `0 0 30px var(--accent-glow)` on `.panel-card`
- Coral-tinted: `0 16px 44px -8px rgba(224,140,100,.14)` on `.path-card`
- Purple-tinted: `0 16px 40px -10px rgba(112,66,248,.08)` on `.bento-card-clean`
- Neutral black: `0 4px 16px rgba(0,0,0,.04)` on `.course-card`

No shared shadow scale exists (e.g., `--shadow-sm/md/lg`), so elevation feels random rather than systematic across the page.

**Fix:** Define 2-3 shadow tokens (`--shadow-card`, `--shadow-hover`, `--shadow-modal`) using a single neutral tint, and apply universally. Reserve colored/glow shadows only for the primary CTA button (to reinforce it as *the* action).

---

## 7. Button/CTA Hierarchy Has No Logic

At least six visually "primary-weight" buttons compete on one page:

| Button | Color | Class |
|---|---|---|
| Header/Hero primary | Notion Blue `#0075de` | `.btn-header-primary`, `.btn-primary` |
| WhatsApp CTA | Green `#25d366` | `.btn-cta-wa`, `.btn-ask-wa` |
| Black pill CTA | Near-black `#09090b` | `.path-black-pill-cta`, `.btn-directions` |
| Google verify | Google Blue `#1a73e8` | `.btn-verify-gmb` |
| Founder WhatsApp | Purple `#7042f8` → hover orange `#ff5e36` | `.btn-founder-wa` |
| Course card solid | `var(--accent)` | `.btn-solid` |

**Fix — 3-tier hierarchy:**
1. **Primary** (solid Notion Blue, largest, used once per section max): enrollment / book-a-demo actions only.
2. **Secondary** (white/outline with border, same radius/height as primary): "learn more," "view course," "call us."
3. **Tertiary** (text link, no fill): footer links, "see all," inline navigation.
Channel-brand colors (WhatsApp green, Google blue) should only appear as a small icon inside a secondary-style button, never as the full button fill — this keeps one consistent visual system while still signaling "this opens WhatsApp."

---

## 8. Tonal/Illustrative Mismatch

- `header-panel` decorative elements (`.deco-star`, `.deco-cloud`, `.deco-heart`) introduce a playful, sticker-like visual language.
- This directly conflicts with the CSS's own stated design intent ("Notion-Inspired Design System," "Inter Display Typography," "Editorial Accents") which implies a clean, minimal, editorial tone.
- Combined with neon gradient stat-pods, orbiting instructor avatars, and glow effects, different sections feel like they were designed under different creative briefs.

**Fix:** Remove cartoon/sticker decorations (stars, clouds, hearts) or replace with a consistent minimal iconography style (thin-line icons, single accent color) that matches the Notion-editorial direction stated in the code comments.

---

## 9. Prioritized Action Plan

1. **Color:** Lock `#0075de` as the only primary action color; strip other "full button" colors to secondary/outline treatment. (Highest visual impact, lowest effort.)
2. **Spacing bug:** Remove the duplicate/conflicting `.section-wrapper` rule (100px vs `var(--s-10)`).
3. **Tokenization pass:** Search-and-replace hardcoded px values for radius and spacing with existing `--r-*` / `--s-*` variables.
4. **Typography:** Cut to 2 font families; remove unused Plus Jakarta Sans; consolidate near-duplicate heading sizes into one scale.
5. **Shadows:** Introduce 2-3 shared shadow tokens; stop bespoke per-component shadow tinting.
6. **Card radius unification:** Standardize all cards to `--r-l` (16px), large panels to `--r-xl` (20px).
7. **Remove decorative stickers** or replace with a single consistent icon style.
8. **Theme parity:** Align light/dark neutral hue family so both themes feel like one brand.

Completing steps 1-3 alone will resolve the majority of the "unprofessional / inconsistent" perception, since they touch every section of the page simultaneously.
