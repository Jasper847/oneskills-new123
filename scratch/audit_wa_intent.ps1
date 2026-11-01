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
    
    $matches = [regex]::Matches($c, 'href="(https://wa\.me/923176036127[^"]*)"')
    foreach ($m in $matches) {
        $decoded = [System.Uri]::UnescapeDataString($m.Groups[1].Value)
        Write-Host "  CTA: $decoded"
    }
}

