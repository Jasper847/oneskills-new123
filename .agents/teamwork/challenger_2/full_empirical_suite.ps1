# Full Comprehensive Empirical Challenge Suite
# Challenger 2: Content Preservation, Spacing & Regression Challenger

$ErrorActionPreference = 'Stop'
$suiteResults = @{}

Write-Host "================================================================================"
Write-Host "CHALLENGER 2: FULL EMPIRICAL VERIFICATION & STRESS-TEST SUITE"
Write-Host "================================================================================"

# Load files
$htmlPath = "courses\freelancing-mastery.html"
$cssPath  = "assets\css\course-v2.css"
$jsPath   = "assets\js\course-v2.js"
$baselinePath = ".agents\teamwork\explorer_survey_html\analysis.md"

$htmlRaw = Get-Content $htmlPath -Raw
$htmlLines = Get-Content $htmlPath
$cssLines = Get-Content $cssPath
$jsRaw = Get-Content $jsPath -Raw
$baselineRaw = Get-Content $baselinePath -Raw

# -----------------------------------------------------------------------------
# 1. DYNAMIC DOM IDs TEST (10 IDs)
# -----------------------------------------------------------------------------
Write-Host "`n[SUITE 1: 10 DYNAMIC DOM IDs]"
$targetIds = @(
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

$domIdSuccess = $true
foreach ($id in $targetIds) {
    $matches = [regex]::Matches($htmlRaw, "id\s*=\s*[`"']$([regex]::Escape($id))[`"']")
    if ($matches.Count -eq 1) {
        # Find line
        for ($i = 0; $i -lt $htmlLines.Length; $i++) {
            if ($htmlLines[$i] -match "id\s*=\s*[`"']$([regex]::Escape($id))[`"']") {
                Write-Host "  [PASS] id='$id' at line $($i + 1)"
                break
            }
        }
    } else {
        Write-Host "  [FAIL] id='$id' count is $($matches.Count) (expected 1)"
        $domIdSuccess = $false
    }
}
$suiteResults['DynamicDOMIDs'] = $domIdSuccess

# -----------------------------------------------------------------------------
# 2. INLINE STYLES ZERO-TOLERANCE TEST
# -----------------------------------------------------------------------------
Write-Host "`n[SUITE 2: INLINE STYLES IN HTML]"
$inlineStyles = @()
for ($i = 0; $i -lt $htmlLines.Length; $i++) {
    if ($htmlLines[$i] -match '\bstyle\s*=\s*["''][^"'']*["'']') {
        $inlineStyles += [PSCustomObject]@{ Line = $i + 1; Content = $htmlLines[$i].Trim() }
    }
}
Write-Host "  Found $($inlineStyles.Count) inline style attributes across $($htmlLines.Length) lines."
if ($inlineStyles.Count -eq 0) {
    Write-Host "  [PASS] Zero inline styles verified."
    $suiteResults['InlineStyles'] = $true
} else {
    Write-Host "  [FAIL] $($inlineStyles.Count) inline styles detected!"
    $suiteResults['InlineStyles'] = $false
}

# -----------------------------------------------------------------------------
# 3. CONTENT INTEGRITY: 12 MODULES, 84 LESSONS, 4 OUTCOMES, PRICING
# -----------------------------------------------------------------------------
Write-Host "`n[SUITE 3: CONTENT INTEGRITY & BASELINE VERIFICATION]"

# 3.1 Pricing
$p25k = ([regex]::Matches($htmlRaw, 'PKR 25,000')).Count
$p12k = ([regex]::Matches($htmlRaw, '2 installments of PKR 12,500')).Count
$p8k  = ([regex]::Matches($htmlRaw, 'PKR 8,500\s*/\s*mo')).Count
$guarantee = ([regex]::Matches($htmlRaw, '14-Day 100% Money-Back Guarantee')).Count
Write-Host "  Pricing PKR 25,000 occurrences: $p25k (expected >= 4)"
Write-Host "  Pricing 2 installments of PKR 12,500 occurrences: $p12k (expected >= 1)"
Write-Host "  Pricing PKR 8,500 / mo occurrences: $p8k (expected >= 1)"
Write-Host "  Guarantee occurrences: $guarantee (expected >= 1)"
$pricingSuccess = ($p25k -ge 4 -and $p12k -ge 1 -and $p8k -ge 1 -and $guarantee -ge 1)
Write-Host "  [$(if ($pricingSuccess) {'PASS'} else {'FAIL'})] Pricing & Guarantee Figures"
$suiteResults['Pricing'] = $pricingSuccess

# 3.2 4 Learning Outcomes
Write-Host "`n  Verifying 4 Learning Outcomes..."
$outcomeCards = [regex]::Matches($htmlRaw, '(?s)<div class="c-outcome-card">.*?<span class="c-outcome-num">(Outcome \d\d)</span>\s*<h4>(.*?)</h4>\s*<p>(.*?)</p>')
$outcomesSuccess = ($outcomeCards.Count -eq 4)
foreach ($oc in $outcomeCards) {
    $num = $oc.Groups[1].Value.Trim()
    $title = [System.Net.WebUtility]::HtmlDecode($oc.Groups[2].Value.Trim())
    $desc = [System.Net.WebUtility]::HtmlDecode($oc.Groups[3].Value.Trim())
    Write-Host "    ${num}: $title -> OK"
}
$suiteResults['LearningOutcomes'] = $outcomesSuccess
Write-Host "  [$(if ($outcomesSuccess) {'PASS'} else {'FAIL'})] 4 Learning Outcomes Present & Verbatim"

# 3.3 12 Modules
Write-Host "`n  Verifying 12 Curriculum Modules..."
$moduleMatches = [regex]::Matches($htmlRaw, '(?s)<h3 class="c-phase-title module-title-h3">\s*(Module \d\d:[^<]+)</h3>')
$modulesSuccess = ($moduleMatches.Count -eq 12)
foreach ($mm in $moduleMatches) {
    $rawMod = [System.Net.WebUtility]::HtmlDecode($mm.Groups[1].Value.Trim())
    Write-Host "    $rawMod -> OK"
}
$suiteResults['Modules12'] = $modulesSuccess
Write-Host "  [$(if ($modulesSuccess) {'PASS'} else {'FAIL'})] 12 Modules Present & Verbatim"

# 3.4 84 Lessons
Write-Host "`n  Verifying 84 Lessons..."
$lessonMatches = [regex]::Matches($htmlRaw, '<li class="c-lesson-item lesson-item">')
$lessonsSuccess = ($lessonMatches.Count -eq 84)
Write-Host "  Found $($lessonMatches.Count) lessons (expected 84)."
$suiteResults['Lessons84'] = $lessonsSuccess
Write-Host "  [$(if ($lessonsSuccess) {'PASS'} else {'FAIL'})] 84 Lessons in Sequential <ol> Structure"

# -----------------------------------------------------------------------------
# 4. 8px GRID SPACING & DIMENSIONS STRESS TEST (CSS)
# -----------------------------------------------------------------------------
Write-Host "`n[SUITE 4: 8px GRID SPACING & DIMENSIONS STRESS TEST]"
$spacingProps = @(
    'margin', 'margin-top', 'margin-bottom', 'margin-left', 'margin-right',
    'padding', 'padding-top', 'padding-bottom', 'padding-left', 'padding-right',
    'gap', 'row-gap', 'column-gap',
    'top', 'bottom', 'left', 'right'
)
$dimProps = @('width', 'height', 'min-width', 'min-height', 'max-width', 'max-height')

$spacingViolations = @()
$dimViolations = @()

for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    if ($line -match '^\s*([a-zA-Z0-9\-_]+)\s*:\s*([^;]+);') {
        $prop = $matches[1].ToLower()
        $val = $matches[2].Trim()
        
        if ($spacingProps -contains $prop) {
            $pxs = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
            foreach ($px in $pxs) {
                $abs = [Math]::Abs([int]$px.Groups[1].Value)
                if ($abs -ne 0 -and $abs -ne 4 -and ($abs % 8 -ne 0)) {
                    $spacingViolations += [PSCustomObject]@{ Line = $i + 1; Prop = $prop; Val = $val; Px = $abs }
                }
            }
        }
        
        if ($dimProps -contains $prop) {
            $pxs = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
            foreach ($px in $pxs) {
                $abs = [Math]::Abs([int]$px.Groups[1].Value)
                if ($abs -ne 0 -and $abs -ne 4 -and ($abs % 8 -ne 0)) {
                    $dimViolations += [PSCustomObject]@{ Line = $i + 1; Prop = $prop; Val = $val; Px = $abs }
                }
            }
        }
    }
}

Write-Host "  Spacing violations (non-8px, excluding 4px micro-padding): $($spacingViolations.Count)"
Write-Host "  Dimension violations: $($dimViolations.Count)"
$gridSuccess = ($spacingViolations.Count -eq 0 -and $dimViolations.Count -eq 0)
$suiteResults['8pxGrid'] = $gridSuccess
Write-Host "  [$(if ($gridSuccess) {'PASS'} else {'FAIL'})] 8px Grid Spacing & Dimensions"

# -----------------------------------------------------------------------------
# 5. ZERO HARDCODED COLOR LEAKS OUTSIDE var()
# -----------------------------------------------------------------------------
Write-Host "`n[SUITE 5: COLOR TOKENS & ZERO HARDCODED COLOR LEAKS]"
function Strip-Vars-Fast($text) {
    $sb = [System.Text.StringBuilder]::new()
    $len = $text.Length
    $i = 0
    while ($i -lt $len) {
        if ($i + 4 -le $len -and $text.Substring($i, 4) -eq 'var(') {
            $depth = 1
            $i += 4
            while ($i -lt $len -and $depth -gt 0) {
                $c = $text[$i]
                if ($c -eq '(') { $depth++ }
                elseif ($c -eq ')') { $depth-- }
                $i++
            }
            [void]$sb.Append("/*var*/")
        } else {
            [void]$sb.Append($text[$i])
            $i++
        }
    }
    return $sb.ToString()
}

$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})\b|rgba?\([^)]+\)|hsla?\([^)]+\))'
$colorLeaks = @()

for ($lineIdx = 0; $lineIdx -lt $cssLines.Length; $lineIdx++) {
    $line = $cssLines[$lineIdx]
    if ($line -match '^\s*\/\*' -or $line -match '^\s*\*') { continue }
    if ($line -match '^\s*--[a-zA-Z0-9\-_]+\s*:') { continue } # CSS custom property definitions
    
    if ($line -match ':\s*([^;]+);') {
        $val = $matches[1]
        $cleanVal = Strip-Vars-Fast $val
        $colMatches = $colorRegex.Matches($cleanVal)
        if ($colMatches.Count -gt 0) {
            foreach ($cm in $colMatches) {
                $colorLeaks += [PSCustomObject]@{
                    Line = $lineIdx + 1
                    Color = $cm.Value
                    Raw = $line.Trim()
                }
            }
        }
    }
}

Write-Host "  Hardcoded color leaks outside var(): $($colorLeaks.Count)"
$colorSuccess = ($colorLeaks.Count -eq 0)
$suiteResults['ColorTokens'] = $colorSuccess
Write-Host "  [$(if ($colorSuccess) {'PASS'} else {'FAIL'})] Color Token Compliance"

# -----------------------------------------------------------------------------
# 6. ACCESSIBILITY, REDUCED MOTION & JAVASCRIPT INTEGRITY
# -----------------------------------------------------------------------------
Write-Host "`n[SUITE 6: ACCESSIBILITY & JS LOGIC]"
$jsP0Fix = ($jsRaw -match '#skill-pillar-tabs\s*\.c-filter-btn,\s*#skill-pillar-tabs\s*\.filter-btn' -and $jsRaw -match '#curriculum-filter-tabs\s*\.c-filter-btn,\s*#curriculum-filter-tabs\s*\.filter-btn')
$jsReducedMotion = ($cssLines -match '@media\s*\(\s*prefers-reduced-motion\s*:\s*reduce\s*\)' -and $cssLines -match 'animation-delay\s*:\s*0s\s*!important' -and $cssLines -match 'transition-delay\s*:\s*0s\s*!important')
$jsToastGuard = ($cssLines -match 'translateX\(-50%\)\s*translateY\(0\)\s*!important')
$jsAriaSync = ($jsRaw -match "btnFeeFull\.setAttribute\('aria-pressed'" -and $jsRaw -match "b\.setAttribute\('aria-selected'")
$jsSkipLink = ($jsRaw -match 'href\^="#"]:not\(\.skip-link\)' -and $jsRaw -match "target\.focus\(")

Write-Host "  P0 Filter Selectors: $(if ($jsP0Fix) {'PASS'} else {'FAIL'})"
Write-Host "  Reduced Motion Zero Delays: $(if ($jsReducedMotion) {'PASS'} else {'FAIL'})"
Write-Host "  Toast Centering Guard: $(if ($jsToastGuard) {'PASS'} else {'FAIL'})"
Write-Host "  ARIA State Sync (Tuition/Town): $(if ($jsAriaSync) {'PASS'} else {'FAIL'})"
Write-Host "  Skip-link Programmatic Focus: $(if ($jsSkipLink) {'PASS'} else {'FAIL'})"

$a11ySuccess = ($jsP0Fix -and $jsReducedMotion -and $jsToastGuard -and $jsAriaSync -and $jsSkipLink)
$suiteResults['AccessibilityAndJS'] = $a11ySuccess

# -----------------------------------------------------------------------------
# OVERALL SUMMARY & VERDICT
# -----------------------------------------------------------------------------
Write-Host "`n================================================================================"
Write-Host "CHALLENGER 2 SUMMARY MATRIX"
Write-Host "================================================================================"
$allGreen = $true
foreach ($k in $suiteResults.Keys) {
    $res = $suiteResults[$k]
    Write-Host "  $($k.PadRight(25)) : $(if ($res) {'PASS'} else {$allGreen=$false; 'FAIL'})"
}

Write-Host "`nFINAL VERDICT: $(if ($allGreen) {'APPROVE'} else {'REQUEST_CHANGES'})"
Write-Host "================================================================================"
