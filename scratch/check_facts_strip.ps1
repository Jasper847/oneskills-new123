$courses = @(
    "crypto-trading.html",
    "forex-trading.html",
    "web3-blockchain.html",
    "shopify-ecommerce.html"
)

foreach ($c in $courses) {
    $content = Get-Content "courses/$c" -Raw
    $hasFacts = $content -match 'c-facts-strip'
    Write-Host "$c has c-facts-strip: $hasFacts"
}

