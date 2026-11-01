$courses = @(
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

$results = @()
$allPassed = $true

foreach ($file in $courses) {
    $content = Get-Content $file -Raw
    
    # 1. Schema JSON-LD parsing
    $jsonMatches = [regex]::Matches($content, '<script\s+type="application/ld\+json">([\s\S]*?)</script>')
    $jsonErrors = 0
    foreach ($m in $jsonMatches) {
        $jsonStr = $m.Groups[1].Value.Trim()
        try {
            $parsed = $jsonStr | ConvertFrom-Json
        } catch {
            $jsonErrors++
            $allPassed = $false
        }
    }

    # 2. Key attributes
    $hasPostal = [regex]::IsMatch($content, '"postalCode":\s*"39350"')
    $hasRatingCount = [regex]::IsMatch($content, '"ratingCount":\s*"15"')
    $hasMapsReview = [regex]::IsMatch($content, '0x3918c3c2f1923d9f:0x9af4e30249f95916')
    $radioAriaSelected = [regex]::Matches($content, 'role="radio"[^>]*aria-selected').Count
    $tabAriaPressed = [regex]::Matches($content, 'role="tab"[^>]*aria-pressed').Count
    
    # Check BYOL & Refund & Batch
    $hasBYOL = [regex]::IsMatch($content, 'Bring Your Own Laptop|BYOL')
    $hasRefund14 = [regex]::IsMatch($content, '14-Day|14-day|14 calendar days')
    $hasBatch12 = [regex]::IsMatch($content, 'Max 12|12 Seats|12 Trade Desks|12 students')

    $status = if ($jsonErrors -eq 0 -and $hasPostal -and $hasRatingCount -and $hasMapsReview -and $radioAriaSelected -eq 0 -and $tabAriaPressed -eq 0 -and $hasBYOL -and $hasRefund14 -and $hasBatch12) { "PASS" } else { "FAIL" }
    if ($status -eq "FAIL") { $allPassed = $false }

    $results += [PSCustomObject]@{
        Course = (Split-Path $file -Leaf)
        JsonValid = ($jsonErrors -eq 0)
        PostalCode = $hasPostal
        RatingCount15 = $hasRatingCount
        GMBReviewLink = $hasMapsReview
        RadioAriaSelected = $radioAriaSelected
        TabAriaPressed = $tabAriaPressed
        BYOL = $hasBYOL
        Refund14d = $hasRefund14
        Batch12 = $hasBatch12
        Status = $status
    }
}

$results | Format-Table -AutoSize
Write-Host "Overall Verification Status:" (if ($allPassed) { "ALL CHECKS PASSED (100% HEALTHY)" } else { "SOME CHECKS FAILED" })
