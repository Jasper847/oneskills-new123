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
    Write-Host "`n>>> $cf <<<" -ForegroundColor Green
    $prices = [regex]::Matches($c, 'PKR\s*[\d,]+')
    $uniquePrices = $prices | ForEach-Object { $_.Value } | Select-Object -Unique
    Write-Host "Prices found: $($uniquePrices -join ', ')"
}

