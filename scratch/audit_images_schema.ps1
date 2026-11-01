$pages = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/web3-blockchain.html",
    "courses/forex-trading.html",
    "courses/crypto-trading.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html"
)

foreach ($p in $pages) {
    $c = Get-Content $p -Raw
    $imgTags = [regex]::Matches($c, '<img\b[^>]*>')
    $missingAlt = 0
    $brokenImgLocal = 0
    foreach ($img in $imgTags) {
        $tag = $img.Value
        if ($tag -notmatch 'alt="[^"]*"') {
            $missingAlt++
        }
        if ($tag -match 'src="(\.\./[^"]+)"') {
            $src = $matches[1].Replace('../', '')
            if (-not (Test-Path $src)) {
                $brokenImgLocal++
            }
        }
    }
    
    $schemaValid = $false
    $schemaPrice = "N/A"
    $schemaRating = "N/A"
    $schemaRatingCount = "N/A"
    if ($c -match '(?s)<script type="application/ld\+json">(.*?)</script>') {
        try {
            $parsed = $matches[1].Trim() | ConvertFrom-Json
            $schemaValid = $true
            if ($parsed.'@graph') {
                $courseObj = $parsed.'@graph' | Where-Object { $_.'@type' -eq 'Course' }
                if ($courseObj) {
                    if ($courseObj.offers) {
                        $schemaPrice = $courseObj.offers.price
                    }
                    if ($courseObj.aggregateRating) {
                        $schemaRating = $courseObj.aggregateRating.ratingValue
                        $schemaRatingCount = $courseObj.aggregateRating.ratingCount
                    }
                }
            }
        } catch {
            $schemaValid = $false
        }
    }

    Write-Host "$((Split-Path $p -Leaf).PadRight(32)) | Imgs: $($imgTags.Count) (MissAlt: $missingAlt, Broken: $brokenImgLocal) | Schema: $schemaValid | Price: $schemaPrice | Rating: $schemaRating (Count: $schemaRatingCount)"
}

