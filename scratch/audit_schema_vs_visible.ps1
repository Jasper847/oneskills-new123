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
    Write-Host "=== $p ===" -ForegroundColor Cyan
    $c = Get-Content $p -Raw
    
    # Visible H1
    $h1 = if ($c -match '(?s)<h1[^>]*>(.*?)</h1>') { ($matches[1] -replace '<[^>]+>', ' ') -replace '\s+', ' ' } else { "" }
    
    # Extract JSON-LD
    if ($c -match '(?s)<script type="application/ld\+json">(.*?)</script>') {
        $json = $matches[1].Trim() | ConvertFrom-Json
        $courseObj = $null
        if ($json.'@graph') {
            $courseObj = $json.'@graph' | Where-Object { $_.'@type' -eq 'Course' }
        } elseif ($json.'@type' -eq 'Course') {
            $courseObj = $json
        }

        if ($courseObj) {
            Write-Host "  Course Name (Schema): $($courseObj.name)"
            Write-Host "  Course H1 (Visible):   $($h1.Trim())"
            Write-Host "  Price (Schema):        $($courseObj.offers.price)"
            Write-Host "  Rating (Schema):       $($courseObj.aggregateRating.ratingValue) (Count: $($courseObj.aggregateRating.ratingCount))"
            $instNames = @()
            if ($courseObj.instructor) {
                if ($courseObj.instructor -is [array]) {
                    $instNames = $courseObj.instructor | ForEach-Object { $_.name }
                } else {
                    $instNames = @($courseObj.instructor.name)
                }
            }
            Write-Host "  Instructors (Schema):  $($instNames -join ', ')"
        } elseif ($json.'@graph') {
            $itemList = $json.'@graph' | Where-Object { $_.'@type' -eq 'ItemList' }
            if ($itemList) {
                Write-Host "  ItemList (Schema): $($itemList.name) with $($itemList.itemListElement.Count) items"
            }
        }
    }
}

