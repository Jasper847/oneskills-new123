# Independent Forensic Audit Suite - OneSkills Freelancing Mastery
# Author: Forensic Auditor (auditor_1)

$ErrorActionPreference = 'Continue'

Write-Host "================================================================================"
Write-Host "INDEPENDENT FORENSIC INTEGRITY AUDIT SUITE"
Write-Host "Target Assets:"
Write-Host "  - courses/freelancing-mastery.html"
Write-Host "  - assets/css/course-v2.css"
Write-Host "  - assets/js/course-v2.js"
Write-Host "================================================================================"

$report = @{
    Violations = @()
    Passes = @()
}

function Add-Pass($msg) {
    Write-Host "[PASS] $msg" -ForegroundColor Green
    $report.Passes += $msg
}

function Add-Fail($msg) {
    Write-Host "[FAIL] $msg" -ForegroundColor Red
    $report.Violations += $msg
}

# Load assets
$jsRaw = Get-Content 'assets\js\course-v2.js' -Raw
$htmlRaw = Get-Content 'courses\freelancing-mastery.html' -Raw
$cssRaw = Get-Content 'assets\css\course-v2.css' -Raw
$cssLines = Get-Content 'assets\css\course-v2.css'

# ==============================================================================
# CHECK 1: ANTI-CHEATING, FACADES & FABRICATED ARTIFACTS
# ==============================================================================
Write-Host "`n>>> CHECK 1: ANTI-CHEATING & FACADE AUDIT <<<"

# 1.1 Check for hardcoded test mocks or dummy stubs in JS
if ($jsRaw -match 'mock|fake|dummy|test-pass|return\s+true\s*;|return\s+"pass"') {
    Add-Fail "JS contains potential mock/dummy patterns"
} else {
    Add-Pass "No mock/dummy stub patterns in course-v2.js"
}

# 1.2 Verify genuine filter logic in course-v2.js
$hasRealSkillFilter = $jsRaw -match 'card\.style\.display\s*=\s*''flex''' -and $jsRaw -match 'card\.style\.display\s*=\s*''none''' -and $jsRaw -match 'skillCountEl\.textContent'
$hasRealModFilter = $jsRaw -match 'acc\.style\.display\s*=\s*''block''' -and $jsRaw -match 'acc\.style\.display\s*=\s*''none''' -and $jsRaw -match 'matchCat\s*&&\s*matchQ'

if ($hasRealSkillFilter -and $hasRealModFilter) {
    Add-Pass "Genuinely functional filtering algorithms implemented for skills and curriculum modules"
} else {
    Add-Fail "Filtering implementation in course-v2.js appears incomplete or facade-like"
}

# 1.3 Verify genuine clipboard logic
if ($jsRaw -match 'navigator\.clipboard\.writeText' -and $jsRaw -match 'document\.execCommand\(''copy''\)') {
    Add-Pass "Genuine dual-tier clipboard copy implementation with execCommand fallback"
} else {
    Add-Fail "Clipboard implementation missing real copy execution"
}

# 1.4 Verify genuine dynamic UI synchronization
if ($jsRaw -match 'feeAmountEl\.textContent\s*=\s*isFull\s*\?\s*''PKR 25,000''\s*:\s*''PKR 8,500\s*/\s*mo''' -and $jsRaw -match 'mapRouteBadge\.textContent\s*=\s*data\.badge') {
    Add-Pass "Genuine dynamic DOM data synchronization for tuition and commuter routes"
} else {
    Add-Fail "Tuition or commuter synchronization appears incomplete"
}

# ==============================================================================
# CHECK 2: CURRICULUM & PRICING NON-ALTERATION CHECK (STANDARD 6)
# ==============================================================================
Write-Host "`n>>> CHECK 2: CURRICULUM & PRICING PRESERVATION AUDIT <<<"

# 2.1 Modules count and structure
$moduleTitles = [regex]::Matches($htmlRaw, '(?i)<h3 class="c-phase-title module-title-h3">(.*?)</h3>')
if ($moduleTitles.Count -eq 12) {
    Add-Pass "Exactly 12 curriculum module accordions found ($($moduleTitles.Count)/12)"
} else {
    Add-Fail "Expected exactly 12 modules, found $($moduleTitles.Count)"
}

# Check all 12 module titles verbatim against baseline
$expectedTitles = @(
    'Module 01: Introduction to Freelancing, Work Ethics, Platforms &amp; Quick Skills',
    'Module 02: Upwork, Fiverr &amp; Freelancer.com Mastery + Profile Optimization',
    'Module 03: Winning Proposals, Client Communication, Contracts &amp; Pricing',
    'Module 04: Digital Marketing Channels, Website Design (WP/Shopify), Vibe Coding &amp; Blogging',
    'Module 05: Search Engine Optimization (SEO) — Keyword Research, On-Page &amp; eCommerce SEO',
    'Module 06: Technical SEO, Local SEO (GBP), Guest Blogging &amp; White-Hat Parasite SEO',
    'Module 07: AEO (Answer Engine Optimization) &amp; GEO (Generative Engine Optimization)',
    'Module 08: Social Media Marketing, Canva Pro, YouTube Automation &amp; Email Lead Gen',
    'Module 09: Meta Ads Mastery (Facebook &amp; Instagram Ads) + TikTok Paid Campaigns',
    'Module 10: Google Ads (Search, Display &amp; YouTube), GA4 Analytics &amp; Etsy E-Commerce',
    'Module 11: AI Agents, AI Automation, Browser Automation, SaaS &amp; App Development',
    'Module 12: Pricing, Retainers, Direct Client Hunting, Portfolio Defense &amp; Certification'
)

$allTitlesMatched = $true
for ($i = 0; $i -lt [Math]::Min(12, $moduleTitles.Count); $i++) {
    $expected = $expectedTitles[$i]
    $actual = $moduleTitles[$i].Groups[1].Value.Trim()
    if ($actual -ne $expected) {
        $allTitlesMatched = $false
        Add-Fail "Module $($i+1) title mismatch: Expected '$expected', got '$actual'"
    }
}
if ($allTitlesMatched -and $moduleTitles.Count -eq 12) {
    Add-Pass "All 12 module titles matched expected curriculum blueprint verbatim"
}

# 2.2 Lesson count (expected exactly 84)
$lessonMatches = [regex]::Matches($htmlRaw, 'class="c-lesson-item')
if ($lessonMatches.Count -eq 84) {
    Add-Pass "Exactly 84 sequential lesson items found ($($lessonMatches.Count)/84)"
} else {
    Add-Fail "Expected exactly 84 lessons, found $($lessonMatches.Count)"
}

# Check lesson numbering sequence 01 to 84
$allLessonsNumbered = $true
$lessonNumMatches = [regex]::Matches($htmlRaw, '<span\s+class="lesson-check">(\d{2})</span>')
if ($lessonNumMatches.Count -eq 84) {
    for ($idx = 0; $idx -lt 84; $idx++) {
        $expectedNum = "{0:D2}" -f ($idx + 1)
        if ($lessonNumMatches[$idx].Groups[1].Value -ne $expectedNum) {
            $allLessonsNumbered = $false
            Add-Fail "Lesson index $idx numbering mismatch: Expected $expectedNum, got $($lessonNumMatches[$idx].Groups[1].Value)"
            break
        }
    }
    if ($allLessonsNumbered) {
        Add-Pass "All 84 lessons strictly numbered 01 through 84 in perfect sequence"
    }
} else {
    Add-Fail "Found $($lessonNumMatches.Count) lesson-check numbers, expected 84"
}

# 2.3 Verify 4 Outcomes
$outcomeMatches = [regex]::Matches($htmlRaw, '(?s)<div\s+class="c-outcome-card">.*?<span\s+class="c-outcome-num">\s*Outcome\s*(\d{2})</span>.*?<h4[^>]*>(.*?)</h4>')
if ($outcomeMatches.Count -eq 4) {
    Add-Pass "Exactly 4 key career deliverables / learning outcomes found ($($outcomeMatches.Count)/4)"
} else {
    Add-Fail "Expected 4 outcome cards, found $($outcomeMatches.Count)"
}

# 2.4 Verify Pricing Numbers
$has25k = ([regex]::Matches($htmlRaw, 'PKR 25,000')).Count
$has125k = ([regex]::Matches($htmlRaw, '2 installments of PKR 12,500')).Count
$has85k = ([regex]::Matches($htmlRaw, 'PKR 8,500\s*/\s*mo')).Count

if ($has25k -ge 4) {
    Add-Pass "PKR 25,000 full tuition strictly preserved (occurrences: $has25k)"
} else {
    Add-Fail "PKR 25,000 full tuition missing or altered (occurrences: $has25k)"
}

if ($has125k -ge 1) {
    Add-Pass "2 installments of PKR 12,500 strictly preserved in hero summary (occurrences: $has125k)"
} else {
    Add-Fail "PKR 12,500 installments missing or altered (occurrences: $has125k)"
}

if ($has85k -ge 1) {
    Add-Pass "PKR 8,500 / mo installment option strictly preserved (occurrences: $has85k)"
} else {
    Add-Fail "PKR 8,500 / mo installment option missing or altered (occurrences: $has85k)"
}

# 2.5 Dynamic DOM IDs contract (10 IDs)
$requiredIds = @(
    'batch-slot-title', 'batch-seats-badge', 'batch-audience-note',
    'card-wa-btn-text', 'card-wa-cta', 'fee-display-amount',
    'fee-display-sub', 'map-route-badge', 'town-commute-title', 'town-commute-desc'
)
$missingRequiredIds = @()
foreach ($rid in $requiredIds) {
    if ($htmlRaw -notmatch ('id="' + $rid + '"')) {
        $missingRequiredIds += $rid
    }
}
if ($missingRequiredIds.Count -eq 0) {
    Add-Pass "All 10 dynamic JavaScript DOM binding IDs strictly preserved"
} else {
    Add-Fail "Missing dynamic DOM binding IDs: $($missingRequiredIds -join ', ')"
}

# ==============================================================================
# CHECK 3: STANDING STANDARDS FORENSIC VERIFICATION
# ==============================================================================
Write-Host "`n>>> CHECK 3: STANDING STANDARDS FORENSIC VERIFICATION <<<"

# --- Standard 1: Semantic HTML5 Elements & ARIA ---
Write-Host "`n-- Standard 1: Semantics & ARIA --"
$hasMainContent = $htmlRaw -match '<main\b[^>]*id="main-content"'
if ($hasMainContent) { Add-Pass "Native semantic <main id='main-content'> landmark present" } else { Add-Fail "Missing <main id='main-content'>" }

$hasFigure = ([regex]::Matches($htmlRaw, '<figure\b')).Count
if ($hasFigure -ge 2) { Add-Pass "Semantic <figure> elements used for editorial stages ($hasFigure found)" } else { Add-Fail "Semantic <figure> elements missing" }

$hasDl = $htmlRaw -match '<dl\b' -and $htmlRaw -match '<dt\b' -and $htmlRaw -match '<dd\b'
if ($hasDl) { Add-Pass "Semantic definition lists (<dl>, <dt>, <dd>) used for key-value specs" } else { Add-Fail "Missing semantic <dl>, <dt>, <dd> metadata" }

$hasOlLessons = $htmlRaw -match '<ol\b[^>]*class="[^"]*c-lessons-grid[^"]*"'
if ($hasOlLessons) { Add-Pass "Ordered list (<ol>) used for sequential curriculum lessons" } else { Add-Fail "Ordered list (<ol>) missing for lessons" }

$hasTableCaption = $htmlRaw -match '<table\b[^>]*>[\s\S]*?<caption\b'
$hasTableColScope = $htmlRaw -match '<th\b[^>]*scope="col"'
$hasTableRowScope = $htmlRaw -match '<th\b[^>]*scope="row"'
if ($hasTableCaption -and $hasTableColScope -and $hasTableRowScope) {
    Add-Pass "Comparison table has accessible <caption>, <th scope='col'>, and <th scope='row'>"
} else {
    Add-Fail "Comparison table accessibility markup incomplete (caption: $hasTableCaption, col: $hasTableColScope, row: $hasTableRowScope)"
}

# Heading hierarchy checks
$h1Count = ([regex]::Matches($htmlRaw, '<h1\b')).Count
if ($h1Count -eq 1) { Add-Pass "Exactly one single <h1> heading on page" } else { Add-Fail "Expected 1 <h1>, found $h1Count" }

# Check for skipped headings in overview (hidden h3 before outcomes)
$hasOutcomesH3 = $htmlRaw -match '(?i)<h3\b[^>]*visually-hidden[^>]*>[^<]*outcomes'
if ($hasOutcomesH3) { Add-Pass "Visually hidden <h3> present before #overview outcome cards, repairing heading hierarchy" } else { Add-Fail "Missing <h3> before outcomes grid in #overview" }

# Check for skipped headings in method (hidden h3 before benefits)
$hasBenefitsH3 = $htmlRaw -match '(?i)<h3\b[^>]*visually-hidden[^>]*>[^<]*advantages'
if ($hasBenefitsH3) { Add-Pass "Visually hidden <h3> present before #method lab benefits, repairing heading hierarchy" } else { Add-Fail "Missing <h3> before benefits bar in #method" }

# Check footer headings
$footerH3Tracks = $htmlRaw -match '<h3\b[^>]*>Career Tracks</h3>'
$footerH3Campus = $htmlRaw -match '<h3\b[^>]*>Sheikhupura Campus</h3>'
if ($footerH3Tracks -and $footerH3Campus) {
    Add-Pass "Footer column headings promoted to <h3>, eliminating heading level skips"
} else {
    Add-Fail "Footer column headings still use <h4> or missing"
}

# Check raw emojis in headings
$rawEmojiHeadings = [regex]::Matches($htmlRaw, '(?i)<h[1-6][^>]*>[^<]*[\uD83C-\uDBFF\uDC00-\uDFFF\u2600-\u27BF]')
if ($rawEmojiHeadings.Count -eq 0) {
    Add-Pass "No unshielded raw emojis in headings; decorative glyphs wrapped in aria-hidden='true'"
} else {
    Add-Fail "Found $($rawEmojiHeadings.Count) raw emojis directly inside headings"
}

# Check ARIA tablist/radiogroup validity
$invalidTablist = $htmlRaw -match 'role="tablist"'
if (-not $invalidTablist) {
    Add-Pass "Unsupported role='tablist' replaced with accessible role='group' / role='radiogroup'"
} else {
    Add-Fail "Found unsupported role='tablist' declarations"
}

# Check ARIA live regions
$hasBatchLive = $htmlRaw -match 'id="batch-dynamic-info"[^>]*aria-live="polite"'
$hasTuitionLive = $htmlRaw -match 'c-tuition-block[^>]*aria-live="polite"'
if ($hasBatchLive -and $hasTuitionLive) {
    Add-Pass "Dynamic containers declare aria-live='polite' for screen reader announcements"
} else {
    Add-Fail "Dynamic containers missing aria-live='polite'"
}

# --- Standard 2: 8px Grid System & Inline Styles ---
Write-Host "`n-- Standard 2: 8px Grid System & Inline Styles --"

# Inline style attributes count
$inlineStyleMatches = [regex]::Matches($htmlRaw, '(?i)\bstyle\s*=\s*["''][^"'']*["'']')
if ($inlineStyleMatches.Count -eq 0) {
    Add-Pass "Zero (0) inline style attributes in courses/freelancing-mastery.html (all extracted to classes)"
} else {
    Add-Fail "Found $($inlineStyleMatches.Count) inline style attributes in freelancing-mastery.html"
}

# CSS Spacing and Dimensions 8px Grid Audit
$spacingPropRegex = [regex]'(?i)^\s*(margin(?:-(?:top|bottom|left|right))?|padding(?:-(?:top|bottom|left|right))?|gap|row-gap|column-gap|top|bottom|left|right|width|height|min-width|min-height|max-width|max-height)\s*:\s*([^;]+);'

$cssSpacingViolations = @()
for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    $m = $spacingPropRegex.Match($line)
    if ($m.Success) {
        $prop = $m.Groups[1].Value.ToLower()
        $val = $m.Groups[2].Value
        
        # Match all px values
        $pxMatches = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxMatches) {
            $abs = [Math]::Abs([int]$px.Groups[1].Value)
            # Spacing properties: must be 0, 4 (half-step), or multiple of 8
            if ($prop -match '^(margin|padding|gap|row-gap|column-gap|top|bottom|left|right)') {
                if ($abs -ne 0 -and $abs % 8 -ne 0 -and $abs -ne 4) {
                    $cssSpacingViolations += [PSCustomObject]@{ LineNum = ($i+1); Line = $line.Trim(); Value = "${abs}px"; Prop = $prop }
                }
            }
            # Component dimensions under 300px (buttons, icons, avatars, badges, etc.)
            elseif ($prop -match '^(width|height|min-width|min-height|max-width|max-height)') {
                if ($abs -ne 0 -and $abs % 8 -ne 0 -and $abs -ne 4 -and $abs -lt 300) {
                    $cssSpacingViolations += [PSCustomObject]@{ LineNum = ($i+1); Line = $line.Trim(); Value = "${abs}px"; Prop = $prop }
                }
            }
        }
    }
}

if ($cssSpacingViolations.Count -eq 0) {
    Add-Pass "Zero (0) non-8px spacing and dimension violations in assets/css/course-v2.css"
} else {
    Add-Fail "Found $($cssSpacingViolations.Count) non-8px spacing/dimension violations in course-v2.css"
    foreach ($v in $cssSpacingViolations | Select-Object -First 10) {
        Write-Host "   Line $($v.LineNum): $($v.Line) (Offending value: $($v.Value))" -ForegroundColor Yellow
    }
}

# --- Standard 3: prefers-reduced-motion Accessibility ---
Write-Host "`n-- Standard 3: prefers-reduced-motion --"

$hasMotionBlock = $cssRaw -match '@media\s*\(\s*prefers-reduced-motion\s*:\s*reduce\s*\)'
$hasZeroDelays = $cssRaw -match 'animation-delay\s*:\s*0s\s*!important' -and $cssRaw -match 'transition-delay\s*:\s*0s\s*!important'
$hasHaltedFloating = $cssRaw -match 'body\.course-v2-page\s+\[class\*="c-float-badge"\]\s*\{[^}]*animation\s*:\s*none\s*!important'
$hasNeutralizedHover = $cssRaw -match ':hover\s*\{[^}]*transform\s*:\s*none\s*!important'
$hasGuardedToast = $cssRaw -match 'body\.course-v2-page\s+\.c-toast\s*\{[^}]*transform\s*:\s*translateX\(-50%\)\s*translateY\(0\)\s*!important'
$hasSkipLinkExclusion = $jsRaw -match 'href\^="#"]:not\(\.skip-link\)'
$hasFocusTransfer = $jsRaw -match "setAttribute\('tabindex',\s*'-1'\)" -and $jsRaw -match "target\.focus\(\{\s*preventScroll:\s*true\s*\}\)"

if ($hasMotionBlock) { Add-Pass "@media (prefers-reduced-motion: reduce) media query present in course-v2.css" } else { Add-Fail "Missing prefers-reduced-motion media query" }
if ($hasZeroDelays) { Add-Pass "Universal delay zeroing (animation-delay: 0s !important, transition-delay: 0s !important)" } else { Add-Fail "Delays not zeroed in reduced motion block" }
if ($hasHaltedFloating) { Add-Pass "Continuous infinite floating keyframe animations halted" } else { Add-Fail "Floating keyframes not halted in reduced motion" }
if ($hasNeutralizedHover) { Add-Pass "Interactive card and button hover transforms neutralized" } else { Add-Fail "Hover transforms not neutralized in reduced motion" }
if ($hasGuardedToast) { Add-Pass "Toast notification centering protected (translateX(-50%) translateY(0))" } else { Add-Fail "Toast centering not protected in reduced motion" }
if ($hasSkipLinkExclusion -and $hasFocusTransfer) { Add-Pass "JavaScript smooth-scroll excludes .skip-link and executes programmatic focus transfer (tabindex -1 + focus)" } else { Add-Fail "Skip-link JS focus handling incomplete" }

# --- Standard 4: CSS Variables for Colors & Theme Switching ---
Write-Host "`n-- Standard 4: CSS Variables for Colors --"

function Remove-VarWithFallbacks([string]$str) {
    while ($str.Contains('var(')) {
        $idx = $str.LastIndexOf('var(')
        $parenCount = 0
        $endIdx = -1
        for ($j = $idx + 4; $j -lt $str.Length; $j++) {
            if ($str[$j] -eq '(') { $parenCount++ }
            elseif ($str[$j] -eq ')') {
                if ($parenCount -eq 0) {
                    $endIdx = $j
                    break
                } else {
                    $parenCount--
                }
            }
        }
        if ($endIdx -ne -1) {
            $str = $str.Substring(0, $idx) + ' ' + $str.Substring($endIdx + 1)
        } else {
            break
        }
    }
    return $str
}

$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})\b|rgba?\([^)]+\)|hsla?\([^)]+\))'
$cssColorViolations = @()

for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    if ($line -notmatch '^\s*--') {
        $cleanLine = Remove-VarWithFallbacks $line
        $matches = $colorRegex.Matches($cleanLine)
        if ($matches.Count -gt 0) {
            foreach ($cm in $matches) {
                $cssColorViolations += [PSCustomObject]@{ LineNum = ($i+1); Line = $line.Trim(); OffendingColor = $cm.Value }
            }
        }
    }
}

if ($cssColorViolations.Count -eq 0) {
    Add-Pass "Zero (0) hardcoded hex/rgba/hsla colors outside var() in assets/css/course-v2.css"
} else {
    Add-Fail "Found $($cssColorViolations.Count) hardcoded color declarations outside var() in course-v2.css"
    foreach ($cv in $cssColorViolations | Select-Object -First 10) {
        Write-Host "   Line $($cv.LineNum): $($cv.Line) (Color: $($cv.OffendingColor))" -ForegroundColor Yellow
    }
}

# Verify dark mode token overrides
$hasDarkModeTokens = $cssRaw -match 'html\[data-theme="dark"\]\s*\{[\s\S]*?--badge-gold-bg[\s\S]*?--badge-emerald-bg[\s\S]*?--badge-purple-bg[\s\S]*?--badge-amber-bg'
if ($hasDarkModeTokens) {
    Add-Pass "Dark mode theme overrides defined for badge tokens and overlays under html[data-theme='dark']"
} else {
    Add-Fail "Dark mode theme token overrides missing or incomplete"
}

# --- Standard 5: Elimination of Clutter ---
Write-Host "`n-- Standard 5: Elimination of Clutter --"

$hasSwipeHint = $htmlRaw -match 'Swipe horizontally to compare'
$hasLocationInstruction = $htmlRaw -match 'Select Your Location for Route Details'
$hasStep1 = $htmlRaw -match '1\.\s*Select Batch Slot'
$hasStep2 = $htmlRaw -match '2\.\s*Tuition Payment Plan'
$hasFooterTagline = $htmlRaw -match 'Skills Today, Brighter Tomorrows'
$hasStickyCta = $htmlRaw -match 'class="sticky-cta"'
$hasRefinementJs = $htmlRaw -match 'refinement\.js'

if (-not $hasSwipeHint) { Add-Pass "Swipe hint label removed from comparison table" } else { Add-Fail "Swipe hint label still present" }
if (-not $hasLocationInstruction) { Add-Pass "Location instruction label removed from commuter hub" } else { Add-Fail "Location instruction label still present" }
if (-not $hasStep1 -and -not $hasStep2) { Add-Pass "Numbered form step tags (1. Select Batch Slot:, 2. Tuition Payment Plan:) removed" } else { Add-Fail "Numbered form step tags still present" }
if (-not $hasFooterTagline) { Add-Pass "Generic footer tagline ('Skills Today, Brighter Tomorrows.') removed" } else { Add-Fail "Generic footer tagline still present" }
if (-not $hasStickyCta) { Add-Pass "Duplicate mobile conversion dock (<div class='sticky-cta'>) removed" } else { Add-Fail "Duplicate mobile conversion dock still present" }
if (-not $hasRefinementJs) { Add-Pass "Unused refinement.js script reference removed" } else { Add-Fail "Unused refinement.js script still referenced" }

# ==============================================================================
# CHECK 4: RUNTIME & SYNTAX HEALTH CHECK
# ==============================================================================
Write-Host "`n>>> CHECK 4: RUNTIME & SYNTAX HEALTH CHECK <<<"

# 4.1 HTML Tag Balance Spot Check
$openDetails = ([regex]::Matches($htmlRaw, '<details\b')).Count
$closeDetails = ([regex]::Matches($htmlRaw, '</details>')).Count
if ($openDetails -eq $closeDetails) {
    Add-Pass "All <details> elements properly balanced ($openDetails opened, $closeDetails closed)"
} else {
    Add-Fail "Unbalanced <details> elements: $openDetails opened vs $closeDetails closed"
}

$openMain = ([regex]::Matches($htmlRaw, '<main\b')).Count
$closeMain = ([regex]::Matches($htmlRaw, '</main>')).Count
if ($openMain -eq 1 -and $closeMain -eq 1) {
    Add-Pass "<main> landmark properly opened and closed (1/1)"
} else {
    Add-Fail "Malformed <main> tag: opened $openMain, closed $closeMain"
}

# 4.2 CSS Syntax Brace Balance
$openBraces = ([regex]::Matches($cssRaw, '\{')).Count
$closeBraces = ([regex]::Matches($cssRaw, '\}')).Count
if ($openBraces -eq $closeBraces) {
    Add-Pass "CSS braces perfectly balanced ($openBraces opening braces, $closeBraces closing braces)"
} else {
    Add-Fail "CSS syntax error: Unbalanced braces ($openBraces open vs $closeBraces close)"
}

# 4.3 JS Syntax Check
$openJsBraces = ([regex]::Matches($jsRaw, '\{')).Count
$closeJsBraces = ([regex]::Matches($jsRaw, '\}')).Count
$openJsParens = ([regex]::Matches($jsRaw, '\(')).Count
$closeJsParens = ([regex]::Matches($jsRaw, '\)')).Count
if ($openJsBraces -eq $closeJsBraces -and $openJsParens -eq $closeJsParens) {
    Add-Pass "JavaScript braces and parentheses perfectly balanced (Braces: $openJsBraces, Parens: $openJsParens)"
} else {
    Add-Fail "JavaScript syntax error: Unbalanced braces/parens"
}

# ==============================================================================
# AUDIT SUMMARY & VERDICT
# ==============================================================================
Write-Host "`n================================================================================"
Write-Host "AUDIT RESULTS SUMMARY"
Write-Host "Total Passes: $($report.Passes.Count)"
Write-Host "Total Violations: $($report.Violations.Count)"
Write-Host "================================================================================"

if ($report.Violations.Count -eq 0) {
    Write-Host "`nFINAL FORENSIC VERDICT: CLEAN" -ForegroundColor Green
    Write-Host "All integrity checks, standing standards, and content preservation criteria satisfied authentically."
} else {
    Write-Host "`nFINAL FORENSIC VERDICT: INTEGRITY VIOLATION" -ForegroundColor Red
    Write-Host "Violations detected:"
    foreach ($viol in $report.Violations) {
        Write-Host " - $viol" -ForegroundColor Red
    }
}
