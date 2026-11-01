# independent_victory_test.ps1
# Independent Verification Suite by Victory Auditor

$ErrorActionPreference = "Continue"
$root = "c:\Users\Nisar\Desktop\oneskills new123"
$htmlPath = Join-Path $root "courses\freelancing-mastery.html"
$cssPath = Join-Path $root "assets\css\course-v2.css"
$jsPath = Join-Path $root "assets\js\course-v2.js"
$auditMdPath = Join-Path $root "audit-freelancing-mastery.md"
$projectMdPath = Join-Path $root "PROJECT.md"
$backupHtmlPath = Join-Path $root "_archive\courses\freelancing-mastery-legacy-backup.html"

Write-Host "============================================================" -ForegroundColor Cyan
Write-Host "INDEPENDENT VICTORY AUDITOR EMPIRICAL TEST SUITE" -ForegroundColor Cyan
Write-Host "============================================================" -ForegroundColor Cyan

$results = [System.Collections.Generic.List[PSObject]]::new()

function Add-TestResult($name, $passed, $details) {
    $obj = [PSCustomObject]@{
        Name = $name
        Passed = $passed
        Details = $details
    }
    $results.Add($obj)
    $status = if ($passed) { "PASS" } else { "FAIL" }
    $color = if ($passed) { "Green" } else { "Red" }
    Write-Host "[$status] $name - $details" -ForegroundColor $color
}

# ------------------------------------------------------------------
# Test Group 1: Required Project Artifacts
# ------------------------------------------------------------------
Write-Host "`n--- Checking Required Artifacts ---" -ForegroundColor Yellow

$auditExists = Test-Path $auditMdPath
$auditLen = if ($auditExists) { (Get-Item $auditMdPath).Length } else { 0 }
Add-TestResult "Artifact: audit-freelancing-mastery.md exists" ($auditExists -and $auditLen -gt 1000) "Size: $auditLen bytes"

$projectExists = Test-Path $projectMdPath
$projectLen = if ($projectExists) { (Get-Item $projectMdPath).Length } else { 0 }
Add-TestResult "Artifact: PROJECT.md exists" ($projectExists -and $projectLen -gt 1000) "Size: $projectLen bytes"

if ($auditExists) {
    $auditContent = Get-Content $auditMdPath -Raw
    $hasS1 = $auditContent -match "(?i)Standard 1|Semantic HTML"
    $hasS2 = $auditContent -match "(?i)Standard 2|8-Pixel Grid|Spacing"
    $hasS3 = $auditContent -match "(?i)Standard 3|prefers-reduced-motion"
    $hasS4 = $auditContent -match "(?i)Standard 4|CSS Variables|Theme"
    $hasS5 = $auditContent -match "(?i)Standard 5|Taglines|Clutter"
    $hasS6 = $auditContent -match "(?i)Standard 6|Curriculum|Outcomes|Pricing"
    $all6Standards = $hasS1 -and $hasS2 -and $hasS3 -and $hasS4 -and $hasS5 -and $hasS6
    Add-TestResult "audit-freelancing-mastery.md covers all 6 standards" $all6Standards "S1:$hasS1 S2:$hasS2 S3:$hasS3 S4:$hasS4 S5:$hasS5 S6:$hasS6"
    
    $hasRemediationSteps = $auditContent -match "(?i)remediation|action plan|proposed fix"
    $hasLineSelector = $auditContent -match "(?i)line\s+\d+|selector"
    Add-TestResult "audit-freelancing-mastery.md contains specific remediation & selectors" ($hasRemediationSteps -and $hasLineSelector) "Found actionable specifics"
}

# ------------------------------------------------------------------
# Test Group 2: HTML Semantics, Structure & A11y
# ------------------------------------------------------------------
Write-Host "`n--- Checking HTML Semantics & Structure ---" -ForegroundColor Yellow

$htmlContent = Get-Content $htmlPath -Raw

# 2.1 Landmark tags
$hasMain = $htmlContent -match '<main[^>]*id=["'']main-content["'']'
$hasHeader = $htmlContent -match '<header[^>]*>'
$hasNav = $htmlContent -match '<nav[^>]*>'
$hasFooter = $htmlContent -match '<footer[^>]*>'
$hasSection = ([regex]::Matches($htmlContent, '<section\b')).Count
$hasArticle = ([regex]::Matches($htmlContent, '<article\b')).Count
$hasAside = ([regex]::Matches($htmlContent, '<aside\b')).Count
Add-TestResult "HTML: Semantic Landmarks" ($hasMain -and $hasHeader -and $hasNav -and $hasFooter -and $hasSection -ge 10) "main:$hasMain, header:$hasHeader, nav:$hasNav, footer:$hasFooter, sections:$hasSection, articles:$hasArticle, asides:$hasAside"

# 2.2 Heading hierarchy
$headingMatches = [regex]::Matches($htmlContent, '<h([1-6])\b[^>]*>')
$headings = @()
$headingSkips = 0
$prevLevel = 0
foreach ($m in $headingMatches) {
    $level = [int]$m.Groups[1].Value
    if ($prevLevel -gt 0 -and $level -gt ($prevLevel + 1)) {
        $headingSkips++
    }
    $prevLevel = $level
    $headings += $level
}
Add-TestResult "HTML: Heading hierarchy 0 skips" ($headingSkips -eq 0) "Total headings: $($headings.Count), Skips: $headingSkips (Levels: $($headings[0..9] -join '->')...)"

# 2.3 Table Accessibility
$tableHasCaption = $htmlContent -match '<caption\b[^>]*>'
$colThCount = ([regex]::Matches($htmlContent, '<th\b[^>]*scope=["'']col["'']')).Count
$rowThCount = ([regex]::Matches($htmlContent, '<th\b[^>]*scope=["'']row["'']')).Count
$unscopedTh = ([regex]::Matches($htmlContent, '<th\b(?![^>]*scope=)[^>]*>')).Count
Add-TestResult "HTML: Comparison Table Accessibility" ($tableHasCaption -and $colThCount -ge 4 -and $rowThCount -ge 4 -and $unscopedTh -eq 0) "caption:$tableHasCaption, colTh:$colThCount, rowTh:$rowThCount, unscopedTh:$unscopedTh"

# 2.4 Zero Inline Styles
# Match style="..." attributes on HTML tags
$inlineStyles = [regex]::Matches($htmlContent, '<\w+[^>]*\bstyle\s*=\s*["''][^"'']*["''][^>]*>')
Add-TestResult "HTML: Zero inline styles" ($inlineStyles.Count -eq 0) "Inline style count: $($inlineStyles.Count)"

# 2.5 Clutter Elimination Check
$hasTableSwipeText = $htmlContent -match 'Swipe horizontally to compare'
$hasCommuteInstruction = $htmlContent -match 'Select Your Location for Route Details'
$hasFooterTagline = $htmlContent -match 'Skills Today, Brighter Tomorrows'
$hasStep1Tag = $htmlContent -match '1\.\s*Select Batch Slot'
$hasStep2Tag = $htmlContent -match '2\.\s*Tuition Payment Plan'
$hasStickyCta = $htmlContent -match '<div class=["'']sticky-cta["'']'
$hasRefinementScript = $htmlContent -match 'refinement\.js'
$clutterPresent = $hasTableSwipeText -or $hasCommuteInstruction -or $hasFooterTagline -or $hasStep1Tag -or $hasStep2Tag -or $hasStickyCta -or $hasRefinementScript
Add-TestResult "HTML: Clutter elimination (taglines, helper text, redundant elements)" (-not $clutterPresent) "tableSwipe:$hasTableSwipeText, commuteInstr:$hasCommuteInstruction, footerTagline:$hasFooterTagline, step1:$hasStep1Tag, step2:$hasStep2Tag, stickyCta:$hasStickyCta, refinementScript:$hasRefinementScript"

# ------------------------------------------------------------------
# Test Group 3: Curriculum & Content Preservation
# ------------------------------------------------------------------
Write-Host "`n--- Checking Curriculum & Content Preservation ---" -ForegroundColor Yellow

# Count modules
$moduleMatches = [regex]::Matches($htmlContent, '(?i)<details\b[^>]*class=["''][^"'']*c-phase-item[^"'']*["'']')
Add-TestResult "Content: 12 Modules Present" ($moduleMatches.Count -eq 12) "Found $($moduleMatches.Count) modules"

# Count lessons
$lessonMatches = [regex]::Matches($htmlContent, '(?i)<li\b[^>]*class=["''][^"'']*lesson-item[^"'']*["'']')
Add-TestResult "Content: 84 Lessons Present" ($lessonMatches.Count -eq 84) "Found $($lessonMatches.Count) lessons"

# Pricing preservation
$hasPkr25k = $htmlContent -match '25,000'
$hasPkr125k = $htmlContent -match '12,500'
$hasPkr85k = $htmlContent -match '8,500'
Add-TestResult "Content: Pricing numbers preserved" ($hasPkr25k -and $hasPkr125k -and $hasPkr85k) "25k:$hasPkr25k, 12.5k:$hasPkr125k, 8.5k:$hasPkr85k"

# Compare lessons against backup if available
if (Test-Path $backupHtmlPath) {
    $backupContent = Get-Content $backupHtmlPath -Raw
    $backupLessons = [regex]::Matches($backupContent, '(?i)<li\b[^>]*class=["''][^"'']*lesson-item[^"'']*["''][^>]*>(.*?)</li>')
    $currentLessons = [regex]::Matches($htmlContent, '(?i)<li\b[^>]*class=["''][^"'']*lesson-item[^"'']*["''][^>]*>(.*?)</li>')
    
    $mismatches = 0
    for ($i = 0; $i -lt [Math]::Min($backupLessons.Count, $currentLessons.Count); $i++) {
        # Strip all HTML tags and whitespace to compare raw text content
        $bText = [regex]::Replace($backupLessons[$i].Groups[1].Value, '<[^>]+>', ' ').Trim() -replace '\s+', ' '
        $cText = [regex]::Replace($currentLessons[$i].Groups[1].Value, '<[^>]+>', ' ').Trim() -replace '\s+', ' '
        if ($bText -ne $cText) {
            $mismatches++
        }
    }
    Add-TestResult "Content: Lesson text verbatim match with backup" ($mismatches -eq 0 -and $currentLessons.Count -eq 84) "Backup: $($backupLessons.Count) lessons, Current: $($currentLessons.Count) lessons, Mismatches: $mismatches"
}

# ------------------------------------------------------------------
# Test Group 4: CSS Standards (8px Grid, Colors, Motion, Dark Mode)
# ------------------------------------------------------------------
Write-Host "`n--- Checking CSS Standards ---" -ForegroundColor Yellow

$cssContent = Get-Content $cssPath -Raw

# 4.1 Reduced Motion media query
$hasReducedMotion = $cssContent -match '@media\s*\(\s*prefers-reduced-motion\s*:\s*reduce\s*\)'
$hasAnimationNone = $cssContent -match '(?i)animation\s*:\s*none\s*!important'
$hasTransitionNone = $cssContent -match '(?i)transition\s*:\s*none|transition-duration\s*:\s*0\.?0*1?m?s'
Add-TestResult "CSS: Comprehensive prefers-reduced-motion block" ($hasReducedMotion -and ($hasAnimationNone -or $hasTransitionNone)) "Media query: $hasReducedMotion, Animation halt: $hasAnimationNone"

# 4.2 8-Pixel Spacing Check
# Scan declarations of margin, padding, gap for non-8px px values
# Allowed: 0, 0px, calc(...), 1px/2px (only if border/outline, not spacing)
# We test all margin, padding, gap lines
$cssLines = $cssContent -split "`n"
$non8pxSpacing = @()
$lineNum = 0
foreach ($line in $cssLines) {
    $lineNum++
    if ($line -match '^\s*(margin|padding|gap|row-gap|column-gap)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        # Match any px values in the declaration
        $pxMatches = [regex]::Matches($val, '(\d+)px')
        foreach ($pxm in $pxMatches) {
            $num = [int]$pxm.Groups[1].Value
            if ($num -ne 0 -and ($num % 8) -ne 0) {
                # Flag unless it's inside calc or special
                $non8pxSpacing += "Line $($lineNum): $($prop): $($val) (found ${num}px)"
            }
        }
    }
}
$spacingViolationsCount = $non8pxSpacing.Count
Add-TestResult "CSS: 0 non-8px spacing violations (margin/padding/gap)" ($spacingViolationsCount -eq 0) "Violations count: $spacingViolationsCount"
if ($spacingViolationsCount -gt 0) {
    $non8pxSpacing[0..4] | ForEach-Object { Write-Host "   Violation: $_" -ForegroundColor Red }
}

# 4.3 Color Definitions Outside var()
# Prohibited: hex (#123, #123456), rgb(...), rgba(...), hsl(...) outside var() in rules
# Allow inside :root or custom property definitions --name: #...
$colorViolations = @()
$lineNum = 0
$inRoot = $false
foreach ($line in $cssLines) {
    $lineNum++
    # Trim comments
    $trimmed = $line.Trim()
    if ($trimmed.StartsWith('/*') -or $trimmed.StartsWith('*')) { continue }
    if ($trimmed -match '^\s*--[a-zA-Z0-9_-]+\s*:') {
        # Custom property definition (allowed)
        continue
    }
    
    # Check if line has a property declaration other than custom property
    if ($trimmed -match ':\s*([^;]+);') {
        $val = $matches[1]
        
        # Remove any var(...) invocations from $val to see what is left outside var()
        $outsideVar = [regex]::Replace($val, 'var\s*\([^)]+\)', '')
        
        # Check for hex colors outside var()
        if ($outsideVar -match '#([0-9a-fA-F]{3,8})\b') {
            $colorViolations += "Line $($lineNum): Hex color outside var(): $($line)"
        }
        # Check for rgb/rgba outside var()
        if ($outsideVar -match '\b(rgb|rgba|hsl|hsla)\s*\(') {
            $colorViolations += "Line $($lineNum): Color function outside var(): $($line)"
        }
    }
}
$colorViolationsCount = $colorViolations.Count
Add-TestResult "CSS: 0 hardcoded colors outside var()" ($colorViolationsCount -eq 0) "Violations count: $colorViolationsCount"
if ($colorViolationsCount -gt 0) {
    $colorViolations[0..4] | ForEach-Object { Write-Host "   Violation: $_" -ForegroundColor Red }
}

# 4.4 Dark mode theme tokens
$hasDarkModeTokens = $cssContent -match 'html\[data-theme=["'']dark["'']\]'
Add-TestResult "CSS: Dark mode tokens defined" $hasDarkModeTokens "html[data-theme='dark'] selector present: $hasDarkModeTokens"

# ------------------------------------------------------------------
# Test Group 5: JS Functionality & Interactivity Fixes
# ------------------------------------------------------------------
Write-Host "`n--- Checking JS Interactivity & Bug Fixes ---" -ForegroundColor Yellow

$jsContent = Get-Content $jsPath -Raw

# 5.1 Dual-class filter button selector
$hasFilterSelector = $jsContent -match '\.c-filter-btn' -and $jsContent -match '\.filter-btn'
Add-TestResult "JS: Dual filter button selector (.c-filter-btn, .filter-btn)" $hasFilterSelector "Both selectors present in querySelectorAll"

# 5.2 Single event listener on copy button
$copyBtnListeners = ([regex]::Matches($jsContent, 'copyCurriculumBtn\.addEventListener')).Count
Add-TestResult "JS: No duplicate event listener on copy button" ($copyBtnListeners -eq 1) "Found $copyBtnListeners event listeners"

# 5.3 Skip-link accessible focus transfer
$hasSkipLinkExclusion = $jsContent -match ':not\(\.skip-link\)'
$hasTargetFocus = $jsContent -match 'target\.focus\('
Add-TestResult "JS: Accessible skip-link focus management" ($hasSkipLinkExclusion -and $hasTargetFocus) "skip-link excluded from JS hijacking, focus transferred on in-page navigation"

# 5.4 ARIA state updates in JS
$hasAriaSelected = $jsContent -match 'setAttribute\s*\(\s*["'']aria-selected["'']'
$hasAriaPressed = $jsContent -match 'setAttribute\s*\(\s*["'']aria-pressed["'']'
$hasAriaChecked = $jsContent -match 'setAttribute\s*\(\s*["'']aria-checked["'']'
Add-TestResult "JS: Dynamic ARIA state synchronization" ($hasAriaSelected -and $hasAriaPressed -and $hasAriaChecked) "aria-selected: $hasAriaSelected, aria-pressed: $hasAriaPressed, aria-checked: $hasAriaChecked"

# ------------------------------------------------------------------
# SUMMARY
# ------------------------------------------------------------------
Write-Host "`n============================================================" -ForegroundColor Cyan
$passedCount = ($results | Where-Object { $_.Passed }).Count
$totalCount = $results.Count
$allPassed = ($passedCount -eq $totalCount)
$overallVerdict = if ($allPassed) { "VICTORY CONFIRMED" } else { "VICTORY REJECTED" }
$verdictColor = if ($allPassed) { "Green" } else { "Red" }

Write-Host "TESTS PASSED: $passedCount / $totalCount" -ForegroundColor Cyan
Write-Host "OVERALL VERDICT: $overallVerdict" -ForegroundColor $verdictColor
Write-Host "============================================================" -ForegroundColor Cyan

return $allPassed
