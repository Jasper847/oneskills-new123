# Comprehensive Verification Script for JS & UX Audit
$html = Get-Content 'courses/freelancing-mastery.html' -Raw
$js = Get-Content 'assets/js/course-v2.js' -Raw

Write-Host "=== 1. PREFERS-REDUCED-MOTION IN JS ==="
# Check window.matchMedia in course-v2.js
$mqlMatches = [regex]::Matches($js, 'matchMedia\([^)]+\)')
foreach ($m in $mqlMatches) {
  Write-Host "Found media query in JS: $($m.Value)"
}

Write-Host "`n=== 2. SELECTOR AUDIT & BROKEN FILTER BUTTONS ==="
# Check #skill-pillar-tabs buttons
if ($html -match 'id="skill-pillar-tabs"[\s\S]*?</div>') {
  $block = $matches[0]
  $hasCFilterBtn = $block.Contains('c-filter-btn')
  $hasFilterBtn = $block.Contains('filter-btn')
  Write-Host "#skill-pillar-tabs button classes: has 'c-filter-btn' = $hasCFilterBtn, has 'filter-btn' = $hasFilterBtn"
}

# Check #curriculum-filter-tabs buttons
if ($html -match 'id="curriculum-filter-tabs"[\s\S]*?</div>') {
  $block = $matches[0]
  $hasCFilterBtn = $block.Contains('c-filter-btn')
  $hasFilterBtn = $block.Contains('filter-btn')
  Write-Host "#curriculum-filter-tabs button classes: has 'c-filter-btn' = $hasCFilterBtn, has 'filter-btn' = $hasFilterBtn"
}

Write-Host "`n=== 3. ARIA STATE SYNC IN JS ==="
# Check townBtns aria-selected
$townBtnBlock = [regex]::Match($js, 'townBtns\.forEach\(\(btn\)[\s\S]*?\}\);')
Write-Host "townBtns click handler contains 'aria-selected': $($townBtnBlock.Value.Contains('aria-selected'))"

# Check fee buttons aria-pressed
$feeBtnBlock = [regex]::Match($js, 'btnFeeFull\.addEventListener[\s\S]*?btnFeeInstall\.addEventListener[\s\S]*?\}\);')
Write-Host "feeBtns click handler contains 'aria-pressed': $($feeBtnBlock.Value.Contains('aria-pressed'))"

# Check toast aria attributes
$toastBlock = [regex]::Match($js, 'showToast\s*=\s*\([\s\S]*?toast\.classList\.add\(''show''\);')
Write-Host "showToast contains 'role' or 'aria-live': $($toastBlock.Value.Contains('role') -or $toastBlock.Value.Contains('aria-live'))"

# Check duplicate btn-copy-full-curriculum
$copyMatches = [regex]::Matches($js, 'btn-copy-full-curriculum')
Write-Host "Occurrences of 'btn-copy-full-curriculum' in course-v2.js: $($copyMatches.Count)"

Write-Host "`n=== 4. DUAL MOBILE BOTTOM CTA BARS ==="
$hasDock = $html.Contains('class="c-mobile-dock"')
$hasSticky = $html.Contains('class="sticky-cta"')
Write-Host "HTML contains c-mobile-dock: $hasDock"
Write-Host "HTML contains sticky-cta: $hasSticky"
