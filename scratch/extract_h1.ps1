$files = @(
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

foreach ($f in $files) {
    $c = Get-Content $f -Raw
    if ($c -match '(?s)<h1[^>]*>(.*?)</h1>') {
        $clean = ($matches[1] -replace '<[^>]+>', ' ') -replace '\s+', ' '
        Write-Host "$f => $($clean.Trim())"
    }
}

