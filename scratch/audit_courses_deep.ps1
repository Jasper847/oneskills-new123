# Deep audit of all 9 courses for pricing, WhatsApp, reviews, and ARIA
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

foreach ($cf in $courseFiles) {
    $c = Get-Content $cf -Raw
    Write-Host "==========================================================" -ForegroundColor Cyan
    Write-Host $cf -ForegroundColor Green
    Write-Host "==========================================================" -ForegroundColor Cyan
    
    # 1. Body attributes
    if ($c -match '<body([^>]*)>') {
        Write-Host "BODY: $($matches[1].Trim())"
    }
    
    # 2. WhatsApp links
    $waLinks = [regex]::Matches($c, 'href="(https://wa\.me/[^"]+)"')
    Write-Host "WhatsApp links count: $($waLinks.Count)"
    foreach ($w in $waLinks) {
        $url = [System.Uri]::UnescapeDataString($w.Groups[1].Value)
        Write-Host "  -> $url"
    }
    
    # 3. Batch slot radios / ARIA
    $radios = [regex]::Matches($c, '<[^>]+role="radio"[^>]*>')
    Write-Host "Radios count: $($radios.Count)"
    foreach ($r in $radios) {
        Write-Host "  Radio: $($r.Value)"
    }
    
    # 4. Tab buttons / ARIA
    $tabs = [regex]::Matches($c, '<[^>]+role="tab"[^>]*>')
    Write-Host "Tabs count: $($tabs.Count)"
    foreach ($t in $tabs) {
        if ($t.Value -match 'aria-pressed') {
            Write-Host "  Bad Tab: $($t.Value)" -ForegroundColor Red
        }
    }
    
    # 5. Reviews
    $reviewers = @("Usman Joyia", "Ashfaq Ahmad", "FAIZZAN Cheema", "Hamza Rajpoot", "Wajeeha", "Maliha Asif", "Ali Raza", "Awais")
    $foundReviewers = @()
    foreach ($r in $reviewers) {
        if ($c -match [regex]::Escape($r)) {
            $foundReviewers += $r
        }
    }
    Write-Host "Reviewers found: $($foundReviewers -join ', ')"
    
    # 6. Google review link
    $hasMapsReviewLink = $c -match '0x3918c3c2f1923d9f:0x9af4e30249f95916'
    Write-Host "Google Maps Review Link present: $hasMapsReviewLink"
    
    # 7. BYOL format check
    $byolHero = $c -match "BYOL|Bring Your Own Laptop"
    Write-Host "BYOL mentioned: $byolHero"
}

