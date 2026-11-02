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

$results = @()
foreach ($p in $pages) {
    if (Test-Path $p) {
        $content = Get-Content $p -Raw
        $hasFooter = $content -match '(?s)(<footer[^>]*>.*?</footer>)'
        $footerTag = if ($content -match '<footer([^>]*)>') { "<footer" + $matches[1] + ">" } else { "NONE" }
        $hasFooterWrap = $footerTag -match 'footer-wrap'
        $hasSiteFooter = $footerTag -match 'site-footer'
        $hasHiran = $content -match 'footer-hiran-wrap'
        
        $results += [PSCustomObject]@{
            Page = $p
            FooterClass = $footerTag
            HasHiranMinar = $hasHiran
        }
    }
}

$results | Format-Table -AutoSize

