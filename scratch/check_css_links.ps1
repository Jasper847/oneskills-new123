$pages = @(
    "index.html",
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/ai-tools-automation.html",
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/web3-blockchain.html",
    "courses/ai-based-computer-course.html",
    "courses/programming-js-cpp.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html",
    "about.html",
    "privacy-policy.html",
    "terms-of-service.html",
    "404.html"
)

foreach ($p in $pages) {
    if (Test-Path $p) {
        $content = Get-Content $p -Raw
        $cssMatches = [regex]::Matches($content, '<link[^>]+rel=["'']stylesheet["''][^>]*>')
        Write-Output "=== $p ==="
        foreach ($m in $cssMatches) {
            Write-Output "  $($m.Value)"
        }
    }
}

