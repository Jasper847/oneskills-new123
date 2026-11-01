# OneSkills Academy — Real-Time SEO Audit & Fix Plan
Researched live against Google's current index and competitor sites, August 12, 2026. Every competitor and ranking claim below is sourced from an actual search result, not inferred.

---

## The one finding that matters more than everything else below

Your live site at oneskills.pk is **already indexed and already ranking** for its own brand terms. Right now, searching "Sheikhupura digital skills academy" surfaces oneskills.pk directly, and course pages like Forex Trading Mastery and Freelancing & Digital Marketing Mastery show up with real snippets pulled from live content. That's not nothing — that's accumulated Google trust you can't buy back overnight.

The problem: the live site's URLs and the new HTML files' URLs don't match. At all.

| Course | Live URL (indexed today) | New file's intended URL (from its own JSON-LD) |
|---|---|---|
| Freelancing | `/courses/freelancing-digital-marketing-mastery/` | `/courses/freelancing-mastery.html` |
| Forex | `/courses/forex-trading-mastery/` | `/courses/forex-trading.html` |
| Homepage | `/` | canonical still says `/` — but the file itself is literally named `oneskills-final.html`, and internal nav links point to `../oneskills-final.html` |

Every internal link in `ai-tools-automation.html`, `forex-trading.html`, and the rest points to sibling files like `freelancing-mastery.html` — plain filenames, not the clean WordPress permalinks Google has indexed. If these files go live as-is, in that folder structure, you're not updating your site — you're launching a second site next to a dead one, and every backlink, bookmark, and ranking position pointing at the old URLs 404s.

This is fixable, but it has to happen **before** launch, not after. See the Migration Plan section below — it's the first thing in the 30-day plan, ahead of every keyword and content item.

---

## Competitive Landscape — Who You're Actually Fighting, By Course

I pulled this from live search results today, not from a list of "presumed competitors." Some of what's here will surprise you.

### Freelancing & Digital Marketing — your most contested vertical
Three real competitors are actively targeting Sheikhupura by name:
- **PNY Trainings** runs a dedicated page listing Sheikhupura, Saggian, Shahdara, and Johar Town as service areas for digital marketing — they're a large multi-branch Lahore chain with 251+ course listings site-wide, so their domain authority dwarfs yours, but their Sheikhupura targeting is thin (one line in a branch list, not a dedicated local page).
- **ShortCourse.pk** has gone further than PNY: a genuinely Sheikhupura-specific landing page (`/sheikhupura/courses/digital-skills-freelancing-course-sheikhupura.html`) with local FAQ content, weekend batch messaging, and 12-week program structure — this is the closest thing to a direct structural clone of what you're building.
- **Hamza Iftikhar**, an independent trainer, ranks on a local Sheikhupura blog (realsheikhupura.com) for "best freelancing course in Sheikhupura" — a single-person operation beating you organically because that blog post exists and nothing of yours currently outranks it for that exact phrase.
- **NexSkill** (Lahore, Arfa Karim Tower) is bigger league — 200+ industry partners, NAVTTC/PSDF/TEVTA certification backing, job placement claims. Not hyper-local to Sheikhupura but shows up broadly for Punjab-wide "digital marketing course" searches.

**Verdict:** this is your most crowded lane. You will not out-authority PNY or NexSkill. You can out-specificity ShortCourse.pk and Hamza Iftikhar by being more locally concrete than they are — more Sheikhupura place-names, more physical-campus detail, more locally-dated content.

### Forex & Crypto Trading — a real niche opening, with one sharp competitor
- **bamstraining.com** is teaching the exact same curriculum language you use — SMC, ICT, order blocks, liquidity voids, FVG, breaker blocks, market structure shift — in Lahore. This is your closest content-level competitor anywhere in Punjab, and it's worth reading their page directly, because a prospective student comparing you two will see near-identical vocabulary and decide on trust signals, not curriculum novelty.
- **Nexskill** and **PNY** both run generic forex/crypto courses without SMC/ICT specialization — broader but shallower.
- **Zero competitors found targeting "forex trading course Sheikhupura" specifically.** Every forex result that mentions Sheikhupura is a Lahore institute listing it as one of six branch cities in passing. Nobody has built a dedicated Sheikhupura forex page. That's a genuinely open local-SEO lane if you claim it properly.

### Web3 & Blockchain — near-zero local competition
Every Web3/blockchain/crypto result I found was either Lahore-generic (PNY's Ethereum development course) or international (Knowledge Academy's Karachi/Lahore corporate training pages). **Nobody is targeting "Web3 course Sheikhupura" or anything close to it.** This is the lowest-competition, highest-opportunity course page you have — worth disproportionate SEO investment relative to its current traffic, because you can own this term outright rather than fight for it.

### AI Tools & Automation — same story, wide open locally
Searched directly for "AI tools course Sheikhupura" and "AI based computer course Sheikhupura" — nothing local came back except your own live page. The AI course competition that does exist (Techfly in Jodhpur, Simba Institute in Surat, TCCI in Ahmedabad) is all India, not even Pakistan. **This is your second wide-open lane.**

### AI Web Development — moderate national competition, no local
No Sheikhupura-specific competitor. National/Lahore-wide web development bootcamps exist but none are contesting this specific geography.

---

## Keyword Opportunity Map

Ranked by how contested the term is, based on what actually showed up in live search results — not a volume tool, since none is connected here, but real SERP crowding is itself the signal that matters for a local single-campus institute.

### High competition — fight smart, don't fight head-on
- "digital marketing course Sheikhupura" — PNY, ShortCourse.pk, and a local blog post all present
- "freelancing course Sheikhupura" — same three, plus Hamza Iftikhar's independent listing
- "SEO course Sheikhupura" / "SEO training Sheikhupura" — PNY explicitly lists Sheikhupura as an SEO training branch

For these, your play isn't out-ranking PNY's domain authority — it's winning the "near me, right now" intent with sharper local proof: actual campus photos, actual Sheikhupura street-level directions (you already have "Opp. Mian Hospital, Near KIPS College" — that's excellent, keep using it verbatim in body copy, not just schema), and a Google Business Profile with real reviews (see Local SEO below).

### Medium competition — winnable with consistent effort
- "forex trading course Sheikhupura" — no dedicated local competitor page exists yet, but Lahore-wide forex content is dense enough that generic "forex course" terms will stay hard
- "crypto trading course Sheikhupura" — similarly open locally, contested regionally

### Low/near-zero competition — claim these now
- "AI tools course Sheikhupura"
- "AI automation training Sheikhupura"
- "web3 course Sheikhupura" / "blockchain course Sheikhupura"
- "SMC ICT trading course Sheikhupura" (nobody combines the specific trading methodology with the specific city anywhere)

These four terms should get first-priority content investment: dedicated FAQ expansion, more internal links pointing at them from the homepage and from each other, and — cheapest win available — literally repeating the exact phrase "AI Tools course in Sheikhupura" or "Web3 course in Sheikhupura" as an H2 or bolded phrase somewhere in the first 300 words of each respective page, since nothing else on the internet is doing that specific pairing yet.

---

## Semantic & NLP-Level Findings

Google's ranking systems today lean heavily on topical entity coverage and natural language patterns, not raw keyword density. Checked the course pages against that lens:

### Strong: your differentiation language is genuinely distinct
The forex page's "❌ No signals or copy trading / ✅ Demo trading until consistency / ✅ Maximum 1% risk per trade" framing is unusual phrasing that no competitor page in this research used. That's good for semantic differentiation — Google's helpful-content systems reward pages that don't read like every other trading-course template, and this doesn't.

### Gap: thin entity coverage around named tools and platforms
Your AI Tools course targets ChatGPT/Claude/Midjourney/NotebookLM-type tooling (per the course description language used elsewhere), but I'd want to verify the actual course page names specific tools by name in body copy, not just a generic "premium AI automation tools" phrase. Competitors like Simba Institute explicitly list "ChatGPT, Midjourney, Canva AI, ElevenLabs, Notion AI, Zapier" — naming real tools is a stronger topical-relevance signal than category language, and it matches what people actually type into Google ("chatgpt course near me" beats "ai tools course near me" in raw search frequency almost everywhere).

**Fix:** in ai-tools-automation.html, replace generic phrases like "premium AI automation tools" with an actual named-tool list wherever the course genuinely covers those tools. Don't list tools you don't teach — that's the fastest way to create a page Google's helpful-content classifier flags as keyword-stuffed rather than genuinely informative.

### Gap: no FAQ schema on individual course pages
The homepage has a strong FAQPage schema block. None of the six course pages appear to carry their own FAQ schema (worth double-checking against the live files, but the pattern in the reviewed source didn't show it). Course-level FAQs are exactly where "how much does the forex course cost in Sheikhupura," "is the crypto course beginner friendly," and "do you offer weekend batches" — real, specific, long-tail queries — get answered and indexed as rich results.

**Fix:** add a 4-6 question FAQPage schema block to each course page, written in the actual language a prospective Sheikhupura student would type, not marketing copy reformatted as questions.

### Gap: no structured comparison or "why choose us" entity signals against named competitors
You don't need to name PNY or NexSkill on the page — that would look defensive — but semantic search increasingly rewards pages that answer the comparison question implicitly: batch size, live-vs-recorded, physical-vs-online, certification body. You already have "max 12 students" repeated consistently (good), but "small batch" alone doesn't answer the comparison Google increasingly tries to serve directly in AI Overviews. Consider one dedicated section per course page: format, batch size, certification, refund policy, all in a scannable structure — you already have this content in the Terms modal, it just needs to also live in visible, indexable page body copy, not only inside a JS-rendered modal that crawlers may not fully credit.

---

## Technical & On-Page SEO — New Findings Beyond the Prior Audit

The earlier production audit covered code/accessibility/performance. These are SEO-specific findings not covered there.

### 🔴 BLOCKER — URL structure migration (see top of document)
Already detailed above. Every internal link and every JSON-LD `url` field needs to resolve to the final production path before this goes live, and a 301 redirect map needs to exist from every currently-indexed live URL to its new equivalent.

### 🟠 HIGH — No sitemap.xml or robots.txt reference found in source
- **Where:** oneskills-final.html — only a `<meta name="robots">` tag exists; no `<link rel="sitemap">` reference, and none of the 8 files reference a robots.txt.
- **Impact:** Without a submitted sitemap, Google discovers new/changed URLs through crawling and internal links alone — slower discovery, and on a migration this scale, slower discovery means a longer window where old URLs are dead and new ones aren't yet indexed.
- **Fix:** Generate a sitemap.xml listing the final production URLs (homepage + 6 course pages + about), submit it in Google Search Console the same day the new URL structure goes live, and add a robots.txt that explicitly allows crawling and references the sitemap location.

### 🟡 MEDIUM — og:image at 200×200 (carried over from the production audit, restated here because it's an SEO/CTR issue as much as a visual one)
A small square OG image directly suppresses click-through from any Facebook/WhatsApp/LinkedIn share — and given the stated ad strategy runs Meta campaigns to this exact domain, this is actively costing ad-spend efficiency, not just organic polish.

### 🟢 LOW — Structured data quality
Already verified clean in the production audit: EducationalOrganization, LocalBusiness, BreadcrumbList, WebSite, and FAQPage schema all present and syntactically valid, with real address/geo data rather than placeholders. This is a genuine asset — most local competitors found in this research (ShortCourse.pk, realsheikhupura.com, Hamza Iftikhar's listing) show no comparable structured-data depth from what's visible in their search snippets.

### 🟢 LOW — Meta descriptions across course pages
Verified in the prior audit: all six course pages carry distinct, non-duplicated meta descriptions with real course-specific detail (tools named, week counts stated). Clean.

---

## Local SEO

### Unverified — Google Business Profile presence
Searching directly for "OneSkills Academy Sheikhupura reviews" returned no Google Business Profile, review count, or star rating in results — only the website's own pages. This doesn't prove a GBP doesn't exist (GBP listings don't always surface in generic web search the way they do in Maps/local pack), but it's worth manually confirming in Google Business Profile Manager directly, because a claimed, active, review-collecting GBP is very often the single highest-leverage local SEO asset available to a single-campus institute — it competes in the Maps local pack independent of your domain's organic authority, which matters enormously against a bigger domain like PNY or NexSkill.

**If a GBP doesn't exist or isn't active:** creating one, verifying the Sheikhupura address, and collecting even 10-15 genuine student reviews would likely move the needle faster than any on-page change in this document, because your competitors — VentureTech aside, which does show real Google reviews in its own search results — mostly don't have strong review presence either.

### Strong — physical address specificity
"Lahore – Sargodha Road, Opp. Mian Hospital, Near KIPS College" is exactly the kind of hyper-local landmark language that helps both users and Google confirm a real physical presence. Keep this exact phrasing consistent everywhere it appears — schema, footer, contact section, and GBP if you set one up — rather than varying the wording between pages.

---

## Fix Plan — 30 / 60 / 90 Day

### First 30 days — migration and foundations, nothing else matters until this is done
1. Build the full URL redirect map: every live indexed URL → its new equivalent. Implement as 301s at the server level before the new site goes live, not after.
2. Fix every internal link and JSON-LD `url` field across all 8 files to point at final production paths, not local filenames.
3. Generate and submit sitemap.xml + robots.txt in Google Search Console the same day the new site goes live.
4. Manually verify Google Business Profile status; claim/create/verify if missing.
5. Export and swap the OG image to 1200×630.

### Days 30-60 — close the FAQ/schema gap, fix entity coverage
6. Add FAQPage schema (4-6 questions each, real student-language phrasing) to all six course pages.
7. Rewrite the AI Tools course page to name specific tools taught, replacing generic "premium AI tools" language.
8. Add a visible, indexable "Format & Certification" section to each course page (batch size, live/physical, refund policy) — pull this out of the JS modal and into crawlable body copy.
9. Publish one dedicated content push toward each of the four low-competition terms identified above (AI Tools, AI Automation, Web3/Blockchain, SMC/ICT trading) — even a strong 400-500 word section with the exact phrase as an H2 is enough to start claiming ground nobody else is contesting.

### Days 60-90 — competitive differentiation, sustained local signal
10. Start a lightweight review-collection habit tied to demo classes or graduation — ask every graduating batch for a Google review; even 2-3 a month compounds over a quarter.
11. Monitor Search Console weekly during this window specifically for 404s on the old live URLs — the redirect map from step 1 needs live verification, not a one-time setup.
12. Revisit the freelancing/digital-marketing page specifically against ShortCourse.pk's Sheikhupura page and Hamza Iftikhar's ranking post — these are your two most beatable local competitors in your most contested category, worth a direct content refresh once the technical foundation is solid.

---

## Priority Matrix

| Priority | Item | Impact | Effort |
|---|---|---|---|
| 1 | URL redirect map + internal link fixes | Prevents losing all existing rankings | L |
| 2 | Sitemap.xml + robots.txt + GSC submission | Speeds re-indexing after migration | S |
| 3 | Google Business Profile verification/creation | Highest-leverage local ranking lever available | M |
| 4 | og:image resize to 1200×630 | Direct ad and social CTR impact | S |
| 5 | FAQ schema on 6 course pages | Long-tail query capture, rich results | M |
| 6 | Named-tool rewrite on AI Tools page | Stronger topical relevance signal | S |
| 7 | Format/certification section per course page | Semantic comparison-query coverage | M |
| 8 | Content push on 4 low-competition terms | Claims open local-SEO ground before competitors notice | M |
| 9 | Review-collection habit | Compounds local trust signal over time | S (ongoing) |
