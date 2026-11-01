$ErrorActionPreference = 'Stop'

$html = Get-Content 'courses\freelancing-mastery.html' -Raw

Write-Host "============================================================"
Write-Host "INDEPENDENT STANDARD 5 (CLUTTER REDUCTION) AUDIT"
Write-Host "============================================================"

# 1. Table swipe hints
Write-Host "`n1. Table Swipe Hint Checks:"
$swipeMatches = [regex]::Matches($html, '(?i)(swipe|horizontal).*?(table|scroll|compare)')
Write-Host "Matches for swipe hints: $($swipeMatches.Count)"
foreach ($m in $swipeMatches) { Write-Host "  Found: $($m.Value)" }
$swipeClassMatches = [regex]::Matches($html, '(?i)c-swipe-hint')
Write-Host "c-swipe-hint class matches: $($swipeClassMatches.Count)"

# 2. Location helper text
Write-Host "`n2. Location Helper Text Checks:"
$locMatches = [regex]::Matches($html, '(?i)select your location for route details')
Write-Host "Matches for 'select your location for route details': $($locMatches.Count)"
foreach ($m in $locMatches) { Write-Host "  Found: $($m.Value)" }

# 3. Numbered form step tags
Write-Host "`n3. Numbered Form Step Labels:"
$step1Matches = [regex]::Matches($html, '(?i)1\.\s*select batch slot')
Write-Host "Matches for '1. Select Batch Slot': $($step1Matches.Count)"
$step2Matches = [regex]::Matches($html, '(?i)2\.\s*tuition payment plan')
Write-Host "Matches for '2. Tuition Payment Plan': $($step2Matches.Count)"
$generalStepMatches = [regex]::Matches($html, '(?i)\b(step\s*\d|1\.\s*select|2\.\s*tuition)\b')
Write-Host "General step matches: $($generalStepMatches.Count)"
foreach ($m in $generalStepMatches) { Write-Host "  Found: $($m.Value)" }

# 4. Footer corporate tagline
Write-Host "`n4. Footer Corporate Tagline & Brand Subtitle:"
$taglineMatches = [regex]::Matches($html, '(?i)skills today,\s*brighter tomorrows')
Write-Host "Matches for 'Skills Today, Brighter Tomorrows': $($taglineMatches.Count)"
$academySubtitle = [regex]::Matches($html, '<span class="logo-sub">ACADEMY</span>')
Write-Host "Matches for '<span class=\"logo-sub\">ACADEMY</span>': $($academySubtitle.Count)"

# 5. Duplicate second bottom conversion dock
Write-Host "`n5. Duplicate Mobile Conversion Dock:"
$stickyCta = [regex]::Matches($html, 'class=[\x22\x27][^\x22\x27]*sticky-cta[^\x22\x27]*[\x22\x27]')
Write-Host "Matches for class='sticky-cta': $($stickyCta.Count)"
$mobileDock = [regex]::Matches($html, 'class=[\x22\x27][^\x22\x27]*c-mobile-dock[^\x22\x27]*[\x22\x27]')
Write-Host "Matches for class='c-mobile-dock': $($mobileDock.Count)"
foreach ($m in $mobileDock) { Write-Host "  Found mobile dock: $($m.Value)" }

# 6. Check .c-eyebrow clutter reduction
Write-Host "`n6. Eyebrow Clutter Check:"
$eyebrows = [regex]::Matches($html, 'class=[\x22\x27][^\x22\x27]*c-eyebrow[^\x22\x27]*[\x22\x27]')
Write-Host "Remaining c-eyebrow count: $($eyebrows.Count)"

# 7. Check platform logos heading clutter
Write-Host "`n7. Brand Logos Heading Clutter Check:"
$logoHeadings = [regex]::Matches($html, '(?i)platforms & marketing ecosystems you will master')
Write-Host "Brand logos heading matches: $($logoHeadings.Count)"

# 8. Check Google review disclaimer clutter
Write-Host "`n8. Google Review Disclaimer Clutter Check:"
$proofDisclaimer = [regex]::Matches($html, 'c-proof-disclaimer')
Write-Host "c-proof-disclaimer matches: $($proofDisclaimer.Count)"
