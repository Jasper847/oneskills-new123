# Master Forensic Verification Script for OneSkills Freelancing Mastery Remediation
# Strict adherence to all 6 Standing Standards

$htmlPath = "courses/freelancing-mastery.html"
$cssPath = "assets/css/course-v2.css"
$jsPath = "assets/js/course-v2.js"

$html = [System.IO.File]::ReadAllText($htmlPath)
$css = [System.IO.File]::ReadAllText($cssPath)
$js = [System.IO.File]::ReadAllText($jsPath)

$failures = 0

Write-Host "================================================================="
Write-Host "1. VERIFYING HTML SEMANTICS, STRUCTURE & CONTENT INTEGRITY"
Write-Host "================================================================="

# 1.1 Dynamic Element IDs (Must all exist)
$requiredIds = @(
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
foreach ($id in $requiredIds) {
    if ($html -match "id=['""]$([regex]::Escape($id))['""]") {
        Write-Host " [PASS] Dynamic ID present: #$id" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] Missing dynamic ID: #$id" -ForegroundColor Red
        $failures++
    }
}

# 1.2 Zero Inline Styles
$inlineStyles = [regex]::Matches($html, 'style\s*=\s*"[^"]*"')
if ($inlineStyles.Count -eq 0) {
    Write-Host " [PASS] Zero inline style attributes found ($($inlineStyles.Count) remaining)" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Inline styles still exist: $($inlineStyles.Count)" -ForegroundColor Red
    $failures++
}

# 1.3 Immutable Pricing Content Preservation
$pricingExpected = @(
    'PKR 25,000',
    '2 installments of PKR 12,500',
    'PKR 8,500 / mo'
)
foreach ($price in $pricingExpected) {
    if ($html.Contains($price)) {
        Write-Host " [PASS] Certified pricing preserved: '$price'" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] Missing pricing string: '$price'" -ForegroundColor Red
        $failures++
    }
}

# 1.4 Module and Lesson Counts
$moduleCount = [regex]::Matches($html, 'class="c-phase-item module-accordion"').Count
if ($moduleCount -eq 12) {
    Write-Host " [PASS] Curriculum Module count: 12 (expected 12)" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Module count mismatch: $moduleCount (expected 12)" -ForegroundColor Red
    $failures++
}

$lessonCount = [regex]::Matches($html, 'class="c-lesson-item lesson-item"').Count
if ($lessonCount -eq 84) {
    Write-Host " [PASS] Practical Lesson count: 84 (expected 84)" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Lesson count mismatch: $lessonCount (expected 84)" -ForegroundColor Red
    $failures++
}

# 1.5 Semantic Landmark Tags
if ($html.Contains('<main id="main-content">') -and $html.Contains('</main>')) {
    Write-Host " [PASS] Semantic landmark <main id=""main-content""> present" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Missing semantic <main id=""main-content"">" -ForegroundColor Red
    $failures++
}

if ($html.Contains('<caption class="visually-hidden">') -and $html.Contains('<th scope="col"') -and $html.Contains('<th scope="row"')) {
    Write-Host " [PASS] Semantic accessible comparison table markup verified (caption, scope col, scope row)" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Table accessibility incomplete" -ForegroundColor Red
    $failures++
}

if ($html.Contains('<aside class="c-mobile-dock"') -and -not $html.Contains('class="sticky-cta"')) {
    Write-Host " [PASS] Single mobile dock preserved; duplicate sticky-cta pruned" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Mobile dock conflict not resolved" -ForegroundColor Red
    $failures++
}

if (-not $html.Contains('refinement.js')) {
    Write-Host " [PASS] Redundant refinement.js script tag removed" -ForegroundColor Green
} else {
    Write-Host " [FAIL] refinement.js script tag still present" -ForegroundColor Red
    $failures++
}

# 1.6 Pruned Clutter (Standard 5)
$clutterPhrases = @(
    'Swipe horizontally to compare full features',
    'Select Your Location for Direct Directions',
    '1. Select Batch Slot:',
    '2. Tuition Payment Plan:',
    'Skills Today, Brighter Tomorrows.'
)
foreach ($clutter in $clutterPhrases) {
    if (-not $html.Contains($clutter)) {
        Write-Host " [PASS] Clutter pruned: '$clutter'" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] Clutter still present in markup: '$clutter'" -ForegroundColor Red
        $failures++
    }
}

Write-Host "`n================================================================="
Write-Host "2. VERIFYING CSS 8PX GRID, DESIGN TOKENS & REDUCED MOTION"
Write-Host "================================================================="

$cssLines = Get-Content $cssPath
$spacingViolations = @()
$dimViolations = @()
$colorViolations = @()

for ($i = 0; $i -lt $cssLines.Count; $i++) {
    $line = $cssLines[$i]
    $lineNum = $i + 1
    
    # Check spacing
    if ($line -match '^\s*(margin(?:-top|-bottom|-left|-right)?|padding(?:-top|-bottom|-left|-right)?|gap|column-gap|row-gap|top|bottom|left|right)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        $pxMatches = [regex]::Matches($val, '(-?\d+(?:\.\d+)?)px')
        foreach ($m in $pxMatches) {
            $n = [double]$m.Groups[1].Value
            $abs = [Math]::Abs($n)
            if ($abs -ne 0 -and ($abs % 8) -ne 0) {
                $spacingViolations += "Line $lineNum : $prop : $val"
                break
            }
        }
    }

    # Check dimensions
    if ($line -match '^\s*(width|height|min-width|min-height)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        if ($val -notmatch 'calc|%|vw|ch|em|rem|auto|none|max-content|min-content') {
            $pxMatches = [regex]::Matches($val, '(\d+(?:\.\d+)?)px')
            foreach ($m in $pxMatches) {
                $n = [double]$m.Groups[1].Value
                if ($n -gt 0 -and ($n % 8) -ne 0 -and $n -lt 500) {
                    $dimViolations += "Line $lineNum : $prop : $val"
                    break
                }
            }
        }
    }

    # Check hardcoded colors outside token declarations
    if ($line -match '^\s*(color|background|background-color|border|border-color|border-top|border-bottom|border-left|border-right|box-shadow)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        $stripped = [regex]::Replace($val, 'var\([^)]+\)', '')
        if ($stripped -match '#[0-9a-fA-F]{3,8}|rgba?\([^)]+\)') {
            if ($line -notmatch '--[a-zA-Z0-9_-]+:') {
                $colorViolations += "Line $lineNum : $prop : $val"
            }
        }
    }
}

if ($spacingViolations.Count -eq 0) {
    Write-Host " [PASS] 8px Grid Spacing Violations: 0" -ForegroundColor Green
} else {
    Write-Host " [FAIL] 8px Grid Spacing Violations: $($spacingViolations.Count)" -ForegroundColor Red
    $spacingViolations | Select-Object -First 5 | ForEach-Object { Write-Host "   $_" -ForegroundColor Yellow }
    $failures++
}

if ($dimViolations.Count -eq 0) {
    Write-Host " [PASS] 8px Grid Dimension Violations: 0" -ForegroundColor Green
} else {
    Write-Host " [FAIL] 8px Grid Dimension Violations: $($dimViolations.Count)" -ForegroundColor Red
    $dimViolations | Select-Object -First 5 | ForEach-Object { Write-Host "   $_" -ForegroundColor Yellow }
    $failures++
}

if ($colorViolations.Count -eq 0) {
    Write-Host " [PASS] Hardcoded Color Declarations: 0 (All colors use var(--...))" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Hardcoded Color Declarations: $($colorViolations.Count)" -ForegroundColor Red
    $colorViolations | Select-Object -First 5 | ForEach-Object { Write-Host "   $_" -ForegroundColor Yellow }
    $failures++
}

# Verify prefers-reduced-motion block
if ($css.Contains('prefers-reduced-motion: reduce')) {
    $hasDelayReset = $css.Contains('animation-delay: 0s !important') -and $css.Contains('transition-delay: 0s !important')
    $hasFloatStop = $css.Contains('c-float-badge') -and $css.Contains('animation: none !important')
    $hasToastCentering = $css.Contains('transform: translateX(-50%) translateY(0) !important')
    
    if ($hasDelayReset) {
        Write-Host " [PASS] prefers-reduced-motion zeros animation-delay and transition-delay" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] prefers-reduced-motion missing delay resets" -ForegroundColor Red
        $failures++
    }
    if ($hasFloatStop) {
        Write-Host " [PASS] prefers-reduced-motion stops floating animations" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] prefers-reduced-motion floating animations not stopped" -ForegroundColor Red
        $failures++
    }
    if ($hasToastCentering) {
        Write-Host " [PASS] prefers-reduced-motion guards toast centering transform" -ForegroundColor Green
    } else {
        Write-Host " [FAIL] prefers-reduced-motion toast centering missing" -ForegroundColor Red
        $failures++
    }
} else {
    Write-Host " [FAIL] Missing prefers-reduced-motion media query" -ForegroundColor Red
    $failures++
}

Write-Host "`n================================================================="
Write-Host "3. VERIFYING JAVASCRIPT BEHAVIORS, FILTERS & ACCESSIBILITY SYNC"
Write-Host "================================================================="

# 3.1 Dual-class filter selector matches
if ($js.Contains('#skill-pillar-tabs .c-filter-btn, #skill-pillar-tabs .filter-btn')) {
    Write-Host " [PASS] Skill pillar filter selector supports both .c-filter-btn and .filter-btn" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Skill pillar filter selector broken" -ForegroundColor Red
    $failures++
}

if ($js.Contains('#curriculum-filter-tabs .c-filter-btn, #curriculum-filter-tabs .filter-btn')) {
    Write-Host " [PASS] Curriculum filter selector supports both .c-filter-btn and .filter-btn" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Curriculum filter selector broken" -ForegroundColor Red
    $failures++
}

# 3.2 Duplicate copy listener
$copyMatches = [regex]::Matches($js, 'btn-copy-full-curriculum')
if ($copyMatches.Count -eq 1) {
    Write-Host " [PASS] Exactly 1 copy listener on #btn-copy-full-curriculum (no duplication)" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Duplicate copy listeners on #btn-copy-full-curriculum: $($copyMatches.Count)" -ForegroundColor Red
    $failures++
}

# 3.3 Skip-link exclusion and programmatic focus
if ($js.Contains(':not(.skip-link)') -and $js.Contains('target.setAttribute(''tabindex'', ''-1'')') -and $js.Contains('preventScroll: true')) {
    Write-Host " [PASS] Skip-link excluded from smooth-scroll; programmatic focus management implemented" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Skip-link focus management missing or incomplete" -ForegroundColor Red
    $failures++
}

# 3.4 ARIA state updates in JS
if ($js.Contains("aria-selected") -and $js.Contains("aria-pressed") -and $js.Contains("role', 'status'") -and $js.Contains("aria-live', 'polite'")) {
    Write-Host " [PASS] Dynamic ARIA state sync implemented (aria-selected, aria-pressed, role=status, aria-live)" -ForegroundColor Green
} else {
    Write-Host " [FAIL] Dynamic ARIA state synchronization incomplete" -ForegroundColor Red
    $failures++
}

Write-Host "`n================================================================="
Write-Host "VERIFICATION SUMMARY"
Write-Host "================================================================="
if ($failures -eq 0) {
    Write-Host " ALL CHECKS PASSED PERFECTLY (0 FAILURES)! REMEDIATION 100% COMPLETE." -ForegroundColor Green
} else {
    Write-Host " $failures CHECKS FAILED. PLEASE REVIEW LOG ABOVE." -ForegroundColor Red
}
Write-Host "================================================================="
