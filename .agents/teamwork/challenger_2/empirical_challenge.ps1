# Empirical Challenge Suite for Challenger 2
# Tests: Content Integrity, 10 Dynamic DOM IDs, 8px Grid, Colors, Inline Styles

$ErrorActionPreference = 'Continue'

$report = [System.Collections.Generic.List[string]]::new()
function LogMsg($msg) {
    Write-Host $msg
    $report.Add($msg)
}

LogMsg "================================================================================"
LogMsg "EMPIRICAL CHALLENGER 2 ADVERSARIAL SUITE"
LogMsg "Target Page: courses/freelancing-mastery.html"
LogMsg "Target CSS:  assets/css/course-v2.css"
LogMsg "Target JS:   assets/js/course-v2.js"
LogMsg "Baseline:    .agents/teamwork/explorer_survey_html/analysis.md"
LogMsg "Timestamp:   $(Get-Date -Format 'yyyy-MM-ddTHH:mm:ssZ')"
LogMsg "================================================================================`n"

$htmlPath = "courses\freelancing-mastery.html"
$cssPath  = "assets\css\course-v2.css"
$jsPath   = "assets\js\course-v2.js"
$baselinePath = ".agents\teamwork\explorer_survey_html\analysis.md"

$htmlContent = Get-Content $htmlPath -Raw
$htmlLines   = Get-Content $htmlPath
$cssContent  = Get-Content $cssPath -Raw
$cssLines    = Get-Content $cssPath
$jsContent   = Get-Content $jsPath -Raw
$baselineContent = Get-Content $baselinePath -Raw

# ------------------------------------------------------------------------------
# 1. 10 DYNAMIC DOM IDs TEST
# ------------------------------------------------------------------------------
LogMsg "--- TEST 1: 10 DYNAMIC DOM IDs ---"
$dynamicIds = @(
    'batch-slot-title',
    'batch-seats-badge',
    'batch-audience-note',
    'card-wa-btn-text',
    'card-wa-cta',
    'fee-display-amount',
    'fee-display-sub',
    'map-route-badge',
    'town-commute-title',
    'town-commute-desc'
)

$domIdPass = $true
foreach ($id in $dynamicIds) {
    $matches = [regex]::Matches($htmlContent, "id\s*=\s*[`"']$([regex]::Escape($id))[`"']")
    if ($matches.Count -eq 1) {
        for ($i = 0; $i -lt $htmlLines.Length; $i++) {
            if ($htmlLines[$i] -match "id\s*=\s*[`"']$([regex]::Escape($id))[`"']") {
                LogMsg "[PASS] ID '$id' found on line $($i + 1) (exact 1 occurrence)."
                break
            }
        }
    } elseif ($matches.Count -eq 0) {
        LogMsg "[FAIL] ID '$id' MISSING from HTML!"
        $domIdPass = $false
    } else {
        LogMsg "[FAIL] ID '$id' has $($matches.Count) DUPLICATE occurrences!"
        $domIdPass = $false
    }
}
LogMsg "Dynamic DOM IDs Result: $(if ($domIdPass) {'ALL 10 PRESENT & UNIQUE - PASS'} else {'FAIL'})`n"

# ------------------------------------------------------------------------------
# 2. INLINE STYLES TEST
# ------------------------------------------------------------------------------
LogMsg "--- TEST 2: INLINE STYLES IN HTML ---"
$inlineMatches = @()
for ($i = 0; $i -lt $htmlLines.Length; $i++) {
    $line = $htmlLines[$i]
    if ($line -match 'style\s*=\s*["''][^"'']*["'']') {
        $inlineMatches += [PSCustomObject]@{
            Line = $i + 1
            Content = $line.Trim()
        }
    }
}

if ($inlineMatches.Count -eq 0) {
    LogMsg "[PASS] Exactly 0 inline style attributes found across all $($htmlLines.Length) lines."
} else {
    LogMsg "[FAIL] Found $($inlineMatches.Count) inline style attributes:"
    foreach ($m in $inlineMatches) {
        LogMsg "   Line $($m.Line): $($m.Content)"
    }
}
LogMsg "Inline Styles Result: $(if ($inlineMatches.Count -eq 0) {'PASS'} else {'FAIL'})`n"

# ------------------------------------------------------------------------------
# 3. CONTENT INTEGRITY: 12 MODULES, 84 LESSONS, 4 OUTCOMES, PRICING
# ------------------------------------------------------------------------------
LogMsg "--- TEST 3: CONTENT INTEGRITY & BASELINE DIFF ---"

# 3.1 Pricing Figures
LogMsg "`n[Subtest 3.1: Pricing Figures]"
$pricingChecks = @(
    @{ Name = 'PKR 25,000'; Pattern = 'PKR 25,000'; MinExpected = 4 },
    @{ Name = '2 installments of PKR 12,500'; Pattern = '2 installments of PKR 12,500'; MinExpected = 1 },
    @{ Name = 'PKR 8,500 / mo'; Pattern = 'PKR 8,500\s*/\s*mo'; MinExpected = 1 },
    @{ Name = '14-Day 100% Money-Back Guarantee'; Pattern = '14-Day 100% Money-Back Guarantee'; MinExpected = 1 },
    @{ Name = 'PKR 30,000 to PKR 80,000'; Pattern = 'PKR 30,000\s*(?:to|–|-)\s*PKR 80,000'; MinExpected = 1 }
)

$pricingPass = $true
foreach ($p in $pricingChecks) {
    $c = ([regex]::Matches($htmlContent, $p.Pattern)).Count
    if ($c -ge $p.MinExpected) {
        LogMsg "[PASS] Pricing '$($p.Name)': $c occurrences (>= $($p.MinExpected))."
    } else {
        LogMsg "[FAIL] Pricing '$($p.Name)': $c occurrences (expected at least $($p.MinExpected))!"
        $pricingPass = $false
    }
}

# 3.2 4 Learning Outcomes
LogMsg "`n[Subtest 3.2: 4 Learning Outcomes]"
$outcomesBaseline = @(
    @{ Num = '01'; Title = 'Meta & Google Ads Mastery'; Desc = 'Build profitable lead generation and e-commerce campaigns using Meta Ads Manager, Meta Pixel, custom audiences, CBO/ABO budgets, and ROAS tracking.' },
    @{ Num = '02'; Title = 'AI Content & Video Engine'; Desc = 'Generate scroll-stopping ad creatives, direct-response copy, and viral short-form video ads using ChatGPT, Canva Magic Studio, and CapCut AI.' },
    @{ Num = '03'; Title = 'Local SEO & Google Maps Rank'; Desc = 'Set up and optimize Google Business Profiles to rank Sheikhupura and Pakistani businesses #1 in local Google Search and Google Maps.' },
    @{ Num = '04'; Title = 'Client Monetization & Dual Income'; Desc = 'Close $500–$1,500 Upwork/Fiverr freelance contracts and sign PKR 30,000–80,000/mo local retainers with Payoneer, Wise, and Pakistani bank wire setups.' }
)

$outcomesPass = $true
$normHtml = [regex]::Replace($htmlContent, '\s+', ' ')
foreach ($o in $outcomesBaseline) {
    $hasTitle = $htmlContent.IndexOf($o.Title) -ge 0
    $normDesc = [regex]::Replace($o.Desc, '\s+', ' ')
    $hasDesc = $normHtml.IndexOf($normDesc) -ge 0
    if (-not $hasDesc) {
        # Check dash variant
        $hasDesc = $normHtml.IndexOf($normDesc.Replace('–', '-')) -ge 0
    }
    if ($hasTitle -and $hasDesc) {
        LogMsg "[PASS] Outcome $($o.Num) ('$($o.Title)') verified verbatim."
    } else {
        LogMsg "[FAIL] Outcome $($o.Num) ('$($o.Title)') mismatch! Title: $hasTitle, Desc: $hasDesc"
        $outcomesPass = $false
    }
}

# 3.3 12 Module Titles
LogMsg "`n[Subtest 3.3: 12 Module Titles]"
$modulesBaseline = @(
    @{ Num = '01'; Title = 'Introduction to Freelancing, Work Ethics, Platforms & Quick Skills' },
    @{ Num = '02'; Title = 'Upwork, Fiverr & Freelancer.com Mastery + Profile Optimization' },
    @{ Num = '03'; Title = 'Winning Proposals, Client Communication, Contracts & Pricing' },
    @{ Num = '04'; Title = 'Digital Marketing Channels, Website Design (WP/Shopify), Vibe Coding & Blogging' },
    @{ Num = '05'; Title = 'Search Engine Optimization (SEO) — Keyword Research, On-Page & eCommerce SEO' },
    @{ Num = '06'; Title = 'Technical SEO, Local SEO (GBP), Guest Blogging & White-Hat Parasite SEO' },
    @{ Num = '07'; Title = 'AEO (Answer Engine Optimization) & GEO (Generative Engine Optimization)' },
    @{ Num = '08'; Title = 'Social Media Marketing, Canva Pro, YouTube Automation & Email Lead Gen' },
    @{ Num = '09'; Title = 'Meta Ads Mastery (Facebook & Instagram Ads) + TikTok Paid Campaigns' },
    @{ Num = '10'; Title = 'Google Ads (Search, Display & YouTube), GA4 Analytics & Etsy E-Commerce' },
    @{ Num = '11'; Title = 'AI Agents, AI Automation, Browser Automation, SaaS & App Development' },
    @{ Num = '12'; Title = 'Pricing, Retainers, Direct Client Hunting, Portfolio Defense & Certification' }
)

$modulesPass = $true
foreach ($m in $modulesBaseline) {
    $hasMod = ($normHtml.IndexOf($m.Title) -ge 0)
    if (-not $hasMod) {
        # Try dash replace
        $hasMod = ($normHtml.IndexOf($m.Title.Replace('—', '-').Replace('–', '-')) -ge 0)
    }
    if ($hasMod) {
        LogMsg "[PASS] Module $($m.Num): '$($m.Title)' found verbatim."
    } else {
        LogMsg "[FAIL] Module $($m.Num): '$($m.Title)' NOT FOUND verbatim!"
        $modulesPass = $false
    }
}

# 3.4 84 Lessons Inventory
LogMsg "`n[Subtest 3.4: 84 Lessons Check]"
$baselineLines = Get-Content $baselinePath
$baselineLessons = @()
foreach ($line in $baselineLines) {
    if ($line -match '^\s*-\s*\*Lesson\s+(\d\d)\*:\s*(.+)$') {
        $num = $matches[1]
        $rest = $matches[2].Trim()
        $parts = $rest -split ':\s*', 2
        $name = $parts[0].Trim()
        $desc = if ($parts.Length -gt 1) { $parts[1].Trim() } else { '' }
        $baselineLessons += [PSCustomObject]@{
            Num = $num
            Name = $name
            Desc = $desc
            Full = $rest
        }
    }
}
LogMsg "Total lessons extracted from frozen baseline: $($baselineLessons.Count)"

$lessonsPass = $true
$missingLessons = @()

foreach ($bl in $baselineLessons) {
    $normName = [regex]::Replace($bl.Name, '\s+', ' ')
    $hasName = ($normHtml.IndexOf($normName) -ge 0) -or ($normHtml.IndexOf($normName.Replace('&', '&amp;')) -ge 0)
    
    $descCheck = $true
    if ($bl.Desc -ne '') {
        $normDesc = [regex]::Replace($bl.Desc, '\s+', ' ')
        $hasDesc = ($normHtml.IndexOf($normDesc) -ge 0)
        if (-not $hasDesc) {
            $relaxedDesc = $normDesc.Replace('&', '&amp;').Replace('–', '-').Replace('—', '-')
            $hasDesc = ($normHtml.IndexOf($relaxedDesc) -ge 0) -or ($normHtml.Replace('&amp;', '&').Replace('–', '-').Replace('—', '-').IndexOf($normDesc.Replace('–', '-').Replace('—', '-')) -ge 0)
        }
        $descCheck = $hasDesc
    }
    
    if ($hasName -and $descCheck) {
        # pass
    } else {
        $lessonsPass = $false
        $missingLessons += [PSCustomObject]@{
            Num = $bl.Num
            Name = $bl.Name
            HasName = $hasName
            HasDesc = $descCheck
        }
    }
}

if ($lessonsPass) {
    LogMsg "[PASS] All 84 Lessons (names and descriptions) verified 100% VERBATIM against baseline!"
} else {
    LogMsg "[FAIL] $($missingLessons.Count) lessons had discrepancies:"
    foreach ($ml in $missingLessons) {
        LogMsg "   Lesson $($ml.Num) ('$($ml.Name)') -> NameMatch: $($ml.HasName), DescMatch: $($ml.HasDesc)"
    }
}

# ------------------------------------------------------------------------------
# 4. 8px GRID SPACING & DIMENSIONS STRESS TEST
# ------------------------------------------------------------------------------
LogMsg "`n--- TEST 4: 8px GRID SYSTEM STRESS-TEST (CSS) ---"
$spacingProps = @(
    'margin', 'margin-top', 'margin-bottom', 'margin-left', 'margin-right',
    'padding', 'padding-top', 'padding-bottom', 'padding-left', 'padding-right',
    'gap', 'row-gap', 'column-gap',
    'top', 'bottom', 'left', 'right'
)
$dimProps = @('width', 'height', 'min-width', 'min-height', 'max-width', 'max-height')

$spacingViolations = @()
$dimViolations = @()
$halfGrid4pxCount = 0

for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    if ($line -match '^\s*([a-zA-Z0-9\-_]+)\s*:\s*([^;]+);') {
        $prop = $matches[1].ToLower()
        $val = $matches[2].Trim()
        
        # Check spacing
        if ($spacingProps -contains $prop) {
            $pxs = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
            foreach ($px in $pxs) {
                $abs = [Math]::Abs([int]$px.Groups[1].Value)
                if ($abs -eq 0) { continue }
                if ($abs -eq 4) {
                    $halfGrid4pxCount++
                } elseif ($abs % 8 -ne 0) {
                    $spacingViolations += [PSCustomObject]@{
                        Line = $i + 1
                        Property = $prop
                        Value = $val
                        Px = $abs
                    }
                }
            }
        }
        
        # Check dimensions
        if ($dimProps -contains $prop) {
            $pxs = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
            foreach ($px in $pxs) {
                $abs = [Math]::Abs([int]$px.Groups[1].Value)
                if ($abs -eq 0) { continue }
                if ($abs -eq 4) {
                    $halfGrid4pxCount++
                } elseif ($abs % 8 -ne 0) {
                    $dimViolations += [PSCustomObject]@{
                        Line = $i + 1
                        Property = $prop
                        Value = $val
                        Px = $abs
                    }
                }
            }
        }
    }
}

LogMsg "Spacing property non-8px violations (excluding 4px half-grid): $($spacingViolations.Count)"
if ($spacingViolations.Count -gt 0) {
    foreach ($v in $spacingViolations) {
        LogMsg "   Line $($v.Line): $($v.Property): $($v.Value) (found $($v.Px)px)"
    }
}
LogMsg "Dimension property non-8px violations: $($dimViolations.Count)"
if ($dimViolations.Count -gt 0) {
    foreach ($v in $dimViolations) {
        LogMsg "   Line $($v.Line): $($v.Property): $($v.Value) (found $($v.Px)px)"
    }
}
LogMsg "Half-grid 4px occurrences in micro-badges/gaps: $halfGrid4pxCount"

# ------------------------------------------------------------------------------
# 5. HARDCODED COLOR LEAKS STRESS TEST (CSS)
# ------------------------------------------------------------------------------
LogMsg "`n--- TEST 5: HARDCODED COLOR LEAKS (CSS) ---"
$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})\b|rgba?\([^)]+\)|hsla?\([^)]+\))'
$colorLeaks = @()

for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    
    if ($line -match '^\s*\/\*' -or $line -match '^\s*\*') { continue }
    if ($line -match '^\s*--[a-zA-Z0-9\-_]+\s*:') { continue }
    
    if ($line -match ':\s*([^;]+);') {
        $val = $matches[1]
        $valWithoutVar = $val
        while ($valWithoutVar -match 'var\(') {
            $prev = $valWithoutVar
            $valWithoutVar = [regex]::Replace($valWithoutVar, 'var\([^()]*\)', '')
            if ($prev -eq $valWithoutVar) { break }
        }
        
        $matchesCol = $colorRegex.Matches($valWithoutVar)
        foreach ($cm in $matchesCol) {
            $colorLeaks += [PSCustomObject]@{
                Line = $i + 1
                Snippet = $line.Trim()
                RawColor = $cm.Value
            }
        }
    }
}

LogMsg "Hardcoded color leaks outside var(): $($colorLeaks.Count)"
if ($colorLeaks.Count -gt 0) {
    foreach ($cl in $colorLeaks) {
        LogMsg "   Line $($cl.Line): $($cl.RawColor) in: $($cl.Snippet)"
    }
} else {
    LogMsg "[PASS] ZERO hardcoded colors exist outside var() across all $($cssLines.Length) lines of course-v2.css!"
}

# ------------------------------------------------------------------------------
# 6. ADVERSARIAL UX & JAVASCRIPT REGRESSION AUDIT
# ------------------------------------------------------------------------------
LogMsg "`n--- TEST 6: ADVERSARIAL JS & ACCESSIBILITY AUDIT ---"
$jsChecks = @(
    @{ Name = 'Skill tabs selector supports both .c-filter-btn and .filter-btn'; Pattern = '#skill-pillar-tabs\s*\.c-filter-btn,\s*#skill-pillar-tabs\s*\.filter-btn' },
    @{ Name = 'Curriculum tabs selector supports both .c-filter-btn and .filter-btn'; Pattern = '#curriculum-filter-tabs\s*\.c-filter-btn,\s*#curriculum-filter-tabs\s*\.filter-btn' },
    @{ Name = 'Skip link excluded from smooth scroll'; Pattern = 'href\^="#"]:not\(\.skip-link\)' },
    @{ Name = 'Programmatic focus transferred on anchor jump'; Pattern = "setAttribute\('tabindex',\s*'-1'\)" },
    @{ Name = 'Toast accessible role status & polite live'; Pattern = "toast\.setAttribute\('role',\s*'status'\)" },
    @{ Name = 'Tuition switcher aria-pressed sync'; Pattern = "btnFeeFull\.setAttribute\('aria-pressed'" },
    @{ Name = 'Commuter town aria-selected sync'; Pattern = "b\.setAttribute\('aria-selected'" }
)

$jsPass = $true
foreach ($jc in $jsChecks) {
    $ok = [regex]::IsMatch($jsContent, $jc.Pattern)
    if ($ok) {
        LogMsg "[PASS] $($jc.Name)"
    } else {
        LogMsg "[FAIL] $($jc.Name)"
        $jsPass = $false
    }
}

LogMsg "`n================================================================================"
$overallPass = ($domIdPass -and ($inlineMatches.Count -eq 0) -and $pricingPass -and $outcomesPass -and $modulesPass -and $lessonsPass -and ($spacingViolations.Count -eq 0) -and ($dimViolations.Count -eq 0) -and ($colorLeaks.Count -eq 0) -and $jsPass)

LogMsg "OVERALL EMPIRICAL VERDICT: $(if ($overallPass) {'ALL SUITES PASSED -> APPROVE'} else {'FAILURES DETECTED -> REQUEST_CHANGES'})"
LogMsg "================================================================================"

$report | Out-File ".agents\teamwork\challenger_2\test_results.txt" -Encoding utf8
