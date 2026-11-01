# OneSkills Detailed Audit Script
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

Write-Host "--- 1. SCHEMA COURSE DETAILS ---" -ForegroundColor Yellow
foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    Write-Host "`n>>> $cf <<<" -ForegroundColor Green
    if ($content -match '<script type="application/ld\+json">([\s\S]*?)</script>') {
        $jsonStr = $matches[1]
        try {
            $json = $jsonStr | ConvertFrom-Json
            Write-Host "JSON parsed successfully"
            # Extract Course object
            $courseObj = $null
            if ($json -is [array]) {
                $courseObj = $json | Where-Object { $_.'@type' -eq 'Course' }
            } elseif ($json.'@graph') {
                $courseObj = $json.'@graph' | Where-Object { $_.'@type' -eq 'Course' }
            } elseif ($json.'@type' -eq 'Course') {
                $courseObj = $json
            }
            if ($courseObj) {
                Write-Host " Course Name: $($courseObj.name)"
                Write-Host " Description: $($courseObj.description)"
                Write-Host " Instructor: $(if ($courseObj.instructor) { $courseObj.instructor.name } else { 'NONE' })"
                Write-Host " Duration: $($courseObj.hasCourseInstance.duration)"
                Write-Host " Price: $($courseObj.offers.price) $($courseObj.offers.priceCurrency)"
                Write-Host " Address: $($courseObj.hasCourseInstance.location.address.streetAddress), $($courseObj.hasCourseInstance.location.address.addressLocality), $($courseObj.hasCourseInstance.location.address.postalCode)"
                Write-Host " AggregateRating: ratingValue=$($courseObj.aggregateRating.ratingValue), ratingCount=$($courseObj.aggregateRating.ratingCount)"
            } else {
                Write-Host " NO Course object found!" -ForegroundColor Red
            }
        } catch {
            Write-Host " JSON parse failed: $_" -ForegroundColor Red
        }
    } else {
        Write-Host " NO JSON-LD script found!" -ForegroundColor Red
    }
}

Write-Host "`n--- 2. BODY ATTRIBUTES ---" -ForegroundColor Yellow
foreach ($cf in $courseFiles) {
    $content = Get-Content $cf -Raw
    if ($content -match '<body([^>]*)>') {
        Write-Host "$cf -> body attrs: $($matches[1].Trim())"
    }
}

Write-Host "`n--- 3. SYLLABUS KEYWORD PARITY ---" -ForegroundColor Yellow
$keywords = @{
    "courses/freelancing-mastery.html" = @("LinkedIn", "B2B Outbound", "Email Marketing", "Local SEO", "Upwork", "Fiverr", "Vibe Coding")
    "courses/ai-web-development.html" = @("Three.js", "GSAP", "Next.js", "WordPress", "Custom AI Plugin", "WooCommerce", "Shopify", "React Native", "Flutter", "Flippa", "Motion Invest")
    "courses/ai-tools-automation.html" = @("YouTube", "TikTok", "Faceless", "No-Code", "Make.com", "Zapier", "n8n", "Midjourney", "Claude")
    "courses/crypto-trading.html" = @("TradingView", "Order Blocks", "VSA", "Liquidity Gap", "Fibonacci", "Meme Coin", "ICO/IDO", "Pine Script", "Trading Floor")
    "courses/forex-trading.html" = @("90-90-90", "PKT Session", "Pips", "MT4", "MT5", "1% Risk Rule", "BOS", "CHoCH", "Prop Firm", "Funded Account")
    "courses/web3-blockchain.html" = @("3-Wallet", "Anti-Drainer", "Revoke.cash", "DEX", "Airdrop Farming", "Anti-Sybil", "Kaito", "Galxe", "Zealy")
    "courses/ai-based-computer-course.html" = @("Hardware", "BIOS", "Windows Installation", "Touch Typing", "InPage", "MS Word", "Advanced Excel", "XLOOKUP", "Pivot", "Copilot", "Gamma", "Fiverr")
}
foreach ($kv in $keywords.GetEnumerator()) {
    $content = Get-Content $kv.Key -Raw
    Write-Host "`n>>> $($kv.Key) <<<" -ForegroundColor Green
    foreach ($kw in $kv.Value) {
        $found = $content -match [regex]::Escape($kw)
        Write-Host "  Keyword '$kw': $found"
    }
}

