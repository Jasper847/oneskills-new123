# OneSkills Academy - Comprehensive Forensic Scanner across 10 Audit Dimensions
$root = Get-Location

$courseFiles = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/ai-tools-automation.html",
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/web3-blockchain.html",
    "courses/ai-based-computer-course.html",
    "courses/programming-js-cpp.html",
    "courses/shopify-ecommerce.html"
)
$otherHtmlFiles = @(
    "index.html",
    "courses/index.html",
    "about.html",
    "privacy-policy.html",
    "terms-of-service.html",
    "404.html"
)
$allHtmlFiles = $courseFiles + $otherHtmlFiles

Write-Host "==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 1: JSON-LD SCHEMA & AGGREGATERATING CHECK" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    $hasAggregateRating = $content -match '"@type":\s*"AggregateRating"'
    $hasRatingCount = $content -match '"ratingCount":'
    $hasDuration = $content -match '"duration":\s*"(P\d+W)"'
    $durationVal = if ($matches) { $matches[1] } else { "MISSING" }
    $hasPostalCode = $content -match '"postalCode":\s*"39350"'
    $hasCourseMode = $content -match '"courseMode":\s*"onsite"'
    
    # Check for copy paste bleed
    $bleed = @()
    if ($cf -eq "courses/freelancing-mastery.html") {
        if ($content -match "Vibe Coding|AI Agents") { $bleed += "Contains Vibe Coding / AI Agents" }
        if ($content -notmatch "LinkedIn") { $bleed += "Missing LinkedIn" }
        if ($content -notmatch "Email Marketing") { $bleed += "Missing Email Marketing" }
    }
    
    Write-Host "$cf : AggregateRating=$hasAggregateRating | ratingCount=$hasRatingCount | Duration=$durationVal | PostalCode=$hasPostalCode | BleedIssues=$($bleed -join ', ')"
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 2: ACADEMY OPERATIONAL POLICIES & HARDWARE (BYOL)" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    $hasByol = $content -match "Bring Your Own Laptop|BYOL"
    $hasLabWorkstationsClaim = $content -match "12 Lab Workstations provided|Academy PCs provided|dedicated.*workstation nodes"
    $hasRefund14 = $content -match "14-Day|14 calendar days|2-Week"
    $hasInternship = $content -match "1-Month.*Internship|1-month.*internship|Trading Floor"
    
    Write-Host "$cf : BYOL=$hasByol | BadHardwareClaim=$hasLabWorkstationsClaim | Refund14=$hasRefund14 | Internship/Trading=$hasInternship"
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 3: WHATSAPP NUMBERS & BODY ATTRIBUTES" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$allFilesToScan = Get-ChildItem -Path . -Recurse -Include *.html,*.js | Where-Object { $_.FullName -notmatch '\\\.git|node_modules|scratch' }

$badNumbers = @()
foreach ($f in $allFilesToScan) {
    $content = Get-Content $f.FullName -Raw
    # Find any phone patterns or wa.me patterns
    $waMatches = [regex]::Matches($content, 'wa\.me/(\d+)')
    foreach ($m in $waMatches) {
        if ($m.Groups[1].Value -ne "923176036127") {
            $badNumbers += "$($f.Name): wa.me/$($m.Groups[1].Value)"
        }
    }
    $telMatches = [regex]::Matches($content, 'tel:([^\"]+)')
    foreach ($m in $telMatches) {
        $clean = $m.Groups[1].Value -replace '[^\d]', ''
        if ($clean -ne "923176036127" -and $clean -ne "03176036127") {
            $badNumbers += "$($f.Name): tel:$($m.Groups[1].Value)"
        }
    }
}
Write-Host "Non-standard phone/wa numbers: $($badNumbers.Count)"
$badNumbers | Select-Object -Unique | ForEach-Object { Write-Host " - $_" -ForegroundColor Yellow }

foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    $hasCourseTitle = $content -match 'data-course-title="([^"]+)"'
    $titleVal = if ($matches) { $matches[1] } else { "MISSING" }
    $hasFeeFull = $content -match 'data-fee-full="([^"]+)"'
    $feeVal = if ($matches) { $matches[1] } else { "MISSING" }
    $hasFeeInstall = $content -match 'data-fee-install="([^"]+)"'
    $installVal = if ($matches) { $matches[1] } else { "MISSING" }
    
    Write-Host "$cf : Title=$titleVal | Fee=$feeVal | Install=$installVal"
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 4: LEGACY SYLLABUS PARITY CHECK" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

# Check crypto-trading for "Description" typos
$cryptoContent = Get-Content "courses/crypto-trading.html" -Raw
$cryptoDescMatches = [regex]::Matches($cryptoContent, '\bDescription\b')
Write-Host "courses/crypto-trading.html : 'Description' matches count = $($cryptoDescMatches.Count)"

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 5: REVIEWS & GOOGLE MAPS LINK" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    $hasMapsLink = $content -match '0x3918c3c2f1923d9f:0x9af4e30249f95916'
    Write-Host "$cf : Google Maps Review Link = $hasMapsLink"
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 6: INTERNAL LINKS & ASSETS" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$guidesIndexExists = Test-Path "guides/index.html"
Write-Host "guides/index.html exists: $guidesIndexExists"

# Check og:image absolute vs relative
foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    if ($content -match '<meta property="og:image" content="([^"]+)"') {
        $ogImg = $matches[1]
        $isAbs = $ogImg -match '^https://oneskills\.pk/'
        Write-Host "$cf : og:image = $ogImg (Absolute: $isAbs)"
    }
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 7: ARIA ATTRIBUTES & SEMANTICS" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    $badRadio = $content -match 'role="radio"[^>]*aria-selected' -or $content -match 'aria-selected[^>]*role="radio"'
    $badTab = $content -match 'role="tab"[^>]*aria-pressed' -or $content -match 'aria-pressed[^>]*role="tab"'
    Write-Host "$cf : BadRadioAriaSelected=$badRadio | BadTabAriaPressed=$badTab"
}

# Check course-v3-core.js for aria-selected on radio
$jsContent = Get-Content "assets/js/course-v3-core.js" -Raw
$jsRadioAriaSelected = $jsContent -match 'aria-selected.*radio|radio.*aria-selected'
Write-Host "assets/js/course-v3-core.js sets aria-selected on radio: $jsRadioAriaSelected"

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 9: CORE WEB VITALS & FONTS" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    $hasSourceSerif = $content -match "Source Serif 4"
    Write-Host "$cf : References 'Source Serif 4': $hasSourceSerif"
}

Write-Host "`n==========================================================" -ForegroundColor Cyan
Write-Host "DIMENSION 10: REDIRECTS FILE" -ForegroundColor Cyan
Write-Host "==========================================================" -ForegroundColor Cyan

$htaccessExists = Test-Path ".htaccess"
$redirectsExists = Test-Path "_redirects"
Write-Host ".htaccess exists: $htaccessExists | _redirects exists: $redirectsExists"
