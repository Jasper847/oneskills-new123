$pages = @(
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
        $matches = [regex]::Matches($content, '(?s)<footer\b[^>]*>.*?</footer>')
        Write-Output "$p : Count=$($matches.Count)"
        if ($matches.Count -eq 1) {
            $len = $matches[0].Value.Length
            $startTag = $matches[0].Value.Substring(0, [Math]::Min(35, $len))
            $endTag = $matches[0].Value.Substring([Math]::Max(0, $len - 15))
            Write-Output "   Start: $startTag ... End: $endTag (Length: $len)"
        }
    } else {
        Write-Output "$p : NOT FOUND"
    }
}

