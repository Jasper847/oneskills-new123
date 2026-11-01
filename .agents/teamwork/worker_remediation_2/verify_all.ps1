$ErrorActionPreference = 'Stop'

Write-Host "============================================================"
Write-Host "COMPREHENSIVE VERIFICATION SUITE - FREELANCING MASTERY AUDIT"
Write-Host "============================================================"

$allPassed = $true

# 1. HTML Verification
Write-Host "`n--- 1. HTML Verification (courses\freelancing-mastery.html) ---"
$html = Get-Content 'courses\freelancing-mastery.html' -Raw

# Standard 1: Semantic HTML5 Elements
$hasMain = $html -match '<main\b[^>]*id="main-content"'
$hasFigure = $html -match '<figure\b'
$hasDl = $html -match '<dl\b' -and $html -match '<dt\b' -and $html -match '<dd\b'
$hasTableA11y = $html -match '<table\b' -and $html -match '<caption\b' -and $html -match '<th\b[^>]*scope="col"' -and $html -match '<th\b[^>]*scope="row"'
$hasFooterH3 = $html -match '<h3\b[^>]*>Career Tracks</h3>' -and $html -match '<h3\b[^>]*>Sheikhupura Campus</h3>'

Write-Host "Semantic <main id='main-content'>: $(if ($hasMain) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Semantic <figure> elements: $(if ($hasFigure) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Semantic <dl>, <dt>, <dd> for metadata: $(if ($hasDl) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Accessible <table> (caption, col/row scopes): $(if ($hasTableA11y) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Footer column headers promoted to <h3>: $(if ($hasFooterH3) {'PASS'} else {$allPassed=$false; 'FAIL'})"

# Standard 2: Inline Styles Extraction (0 inline style attributes)
$inlineStyles = [regex]::Matches($html, '(?i)\bstyle\s*=\s*["''][^"'']*["'']')
Write-Host "Inline style attributes count (expected 0): $($inlineStyles.Count) $(if ($inlineStyles.Count -eq 0) {'PASS'} else {$allPassed=$false; 'FAIL'})"

# Standard 5: Clutter / Tagline Removal
$hasSwipeHint = $html -match 'Swipe horizontally to compare'
$hasLocationInstruction = $html -match 'Select Your Location for Route Details'
$hasStep1 = $html -match '1\.\s*Select Batch Slot'
$hasStep2 = $html -match '2\.\s*Tuition Payment Plan'
$hasFooterTagline = $html -match 'Skills Today, Brighter Tomorrows'
$hasStickyCtaDuplicate = $html -match 'class="sticky-cta"'
$hasRefinementJs = $html -match 'refinement\.js'

Write-Host "Swipe hint removed: $(if (-not $hasSwipeHint) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Location instruction removed: $(if (-not $hasLocationInstruction) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Numbered step labels removed: $(if (-not $hasStep1 -and -not $hasStep2) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Footer tagline removed: $(if (-not $hasFooterTagline) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Duplicate .sticky-cta mobile dock removed: $(if (-not $hasStickyCtaDuplicate) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Redundant refinement.js script removed: $(if (-not $hasRefinementJs) {'PASS'} else {$allPassed=$false; 'FAIL'})"

# Standard 6: Content Integrity
$moduleCount = ([regex]::Matches($html, 'Module \d\d')).Count
$lessonCount = ([regex]::Matches($html, 'class="c-lesson-item')).Count
$pkr25kCount = ([regex]::Matches($html, 'PKR 25,000')).Count
$pkr12kCount = ([regex]::Matches($html, '2 installments of PKR 12,500')).Count
$pkr8kCount = ([regex]::Matches($html, 'PKR 8,500\s*/\s*mo')).Count

Write-Host "Curriculum Modules count (expected 12): $moduleCount $(if ($moduleCount -eq 12) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Curriculum Lessons count (expected 84): $lessonCount $(if ($lessonCount -eq 84) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "PKR 25,000 pricing occurrences: $pkr25kCount $(if ($pkr25kCount -ge 4) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "PKR 12,500 installment occurrences: $pkr12kCount $(if ($pkr12kCount -ge 1) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "PKR 8,500 / mo occurrences: $pkr8kCount $(if ($pkr8kCount -ge 1) {'PASS'} else {$allPassed=$false; 'FAIL'})"

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
$missingIds = @()
foreach ($id in $dynamicIds) {
  if ($html -notmatch ('id="' + $id + '"')) {
    $missingIds += $id
  }
}
Write-Host "Dynamic element IDs present (10/10): $(if ($missingIds.Count -eq 0) {'PASS'} else {$allPassed=$false; 'FAIL'})"
if ($missingIds.Count -gt 0) {
  Write-Host "Missing IDs: $($missingIds -join ', ')"
}

# 2. CSS Verification
Write-Host "`n--- 2. CSS Verification (assets\css\course-v2.css) ---"
$cssLines = Get-Content 'assets\css\course-v2.css'
$propRegex = [regex]'(?i)^\s*(margin(?:-(?:top|bottom|left|right))?|padding(?:-(?:top|bottom|left|right))?|gap|row-gap|column-gap|top|bottom|left|right|width|height|min-width|min-height|max-width|max-height)\s*:\s*([^;]+);'
$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})|rgba?\([^)]+\))'

$spacingViolations = 0
$colorViolations = 0

for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    $m = $propRegex.Match($line)
    if ($m.Success) {
        $prop = $m.Groups[1].Value.ToLower()
        $val = $m.Groups[2].Value
        $pxMatches = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxMatches) {
            $abs = [Math]::Abs([int]$px.Groups[1].Value)
            if ($prop -match '^(margin|padding|gap|row-gap|column-gap|top|bottom|left|right)') {
                if ($abs -ne 0 -and $abs % 8 -ne 0 -and $abs -ne 4) {
                    $spacingViolations++
                }
            } elseif ($prop -match '^(width|height|min-width|min-height|max-width|max-height)') {
                if ($abs -ne 0 -and $abs % 8 -ne 0 -and $abs -ne 4 -and $abs -lt 300) {
                    $spacingViolations++
                }
            }
        }
    }
    if ($line -notmatch '^\s*--') {
        $lineWithoutVars = [regex]::Replace($line, 'var\([^)]+\)', '')
        while ($lineWithoutVars -match 'var\(') {
            $lineWithoutVars = [regex]::Replace($lineWithoutVars, 'var\([^()]*\)', '')
        }
        $colMatches = $colorRegex.Matches($lineWithoutVars)
        if ($colMatches.Count -gt 0) {
            $colorViolations += $colMatches.Count
        }
    }
}

Write-Host "Non-8px spacing / dimension violations (expected 0): $spacingViolations $(if ($spacingViolations -eq 0) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Hardcoded colors outside var() (expected 0): $colorViolations $(if ($colorViolations -eq 0) {'PASS'} else {$allPassed=$false; 'FAIL'})"

$cssRaw = Get-Content 'assets\css\course-v2.css' -Raw
$hasReducedMotionBlock = $cssRaw -match '@media\s*\(\s*prefers-reduced-motion\s*:\s*reduce\s*\)'
$hasReducedMotionDelays = $cssRaw -match 'animation-delay\s*:\s*0s\s*!important' -and $cssRaw -match 'transition-delay\s*:\s*0s\s*!important'
$hasToastCenteringGuard = $cssRaw -match 'transform\s*:\s*translateX\(-50%\)\s*translateY\(0\)\s*!important'

Write-Host "prefers-reduced-motion media query present: $(if ($hasReducedMotionBlock) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Reduced motion zeros delays & disables continuous animations: $(if ($hasReducedMotionDelays) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Toast centering guarded in reduced motion: $(if ($hasToastCenteringGuard) {'PASS'} else {$allPassed=$false; 'FAIL'})"

# 3. JavaScript Verification
Write-Host "`n--- 3. JavaScript Verification (assets\js\course-v2.js) ---"
$jsRaw = Get-Content 'assets\js\course-v2.js' -Raw

$hasBothFilterClasses = $jsRaw -match '#skill-pillar-tabs\s*\.c-filter-btn,\s*#skill-pillar-tabs\s*\.filter-btn' -and $jsRaw -match '#curriculum-filter-tabs\s*\.c-filter-btn,\s*#curriculum-filter-tabs\s*\.filter-btn'
$hasSkipLinkExclusion = $jsRaw -match 'href\^="#"]:not\(\.skip-link\)'
$hasProgrammaticFocus = $jsRaw -match "setAttribute\('tabindex',\s*'-1'\)" -and $jsRaw -match "target\.focus\(\{\s*preventScroll:\s*true\s*\}\)"
$hasToastStatus = $jsRaw -match "toast\.setAttribute\('role',\s*'status'\)" -and $jsRaw -match "toast\.setAttribute\('aria-live',\s*'polite'\)"
$hasAriaPressedSync = $jsRaw -match "btnFeeFull\.setAttribute\('aria-pressed'" -and $jsRaw -match "btnFeeInstall\.setAttribute\('aria-pressed'"
$hasTownCommuteAria = $jsRaw -match "b\.setAttribute\('aria-selected',\s*String\(isTarget\)\)" -and $jsRaw -match "b\.setAttribute\('aria-pressed',\s*String\(isTarget\)\)"
$hasNoOrphanedTabs = -not ($jsRaw -match '\.c-tab-btn' -or $jsRaw -match '\.c-studio-pane')

Write-Host "Filter buttons support both .c-filter-btn and .filter-btn: $(if ($hasBothFilterClasses) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Smooth scroll excludes .skip-link: $(if ($hasSkipLinkExclusion) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Smooth scroll transfers keyboard focus (tabindex -1 + focus): $(if ($hasProgrammaticFocus) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Toast notifications have role='status' and aria-live='polite': $(if ($hasToastStatus) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Tuition switchers sync aria-pressed state: $(if ($hasAriaPressedSync) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Town buttons sync accessible active state: $(if ($hasTownCommuteAria) {'PASS'} else {$allPassed=$false; 'FAIL'})"
Write-Host "Orphaned prototype code (.c-tab-btn, .c-studio-pane) removed: $(if ($hasNoOrphanedTabs) {'PASS'} else {$allPassed=$false; 'FAIL'})"

Write-Host "`n============================================================"
if ($allPassed) {
    Write-Host "ALL VERIFICATION CHECKS PASSED PERFECTLY!" -ForegroundColor Green
} else {
    Write-Host "SOME CHECKS FAILED! REVIEW OUTPUT ABOVE." -ForegroundColor Red
}
Write-Host "============================================================"
