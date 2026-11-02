$urls = @(
    "http://localhost:8080/",
    "http://localhost:8080/courses/",
    "http://localhost:8080/courses/freelancing-mastery.html",
    "http://localhost:8080/courses/ai-web-development.html",
    "http://localhost:8080/courses/ai-tools-automation.html",
    "http://localhost:8080/courses/crypto-trading.html",
    "http://localhost:8080/courses/forex-trading.html",
    "http://localhost:8080/courses/web3-blockchain.html",
    "http://localhost:8080/courses/ai-based-computer-course.html",
    "http://localhost:8080/courses/programming-js-cpp.html",
    "http://localhost:8080/courses/shopify-ecommerce.html",
    "http://localhost:8080/about.html",
    "http://localhost:8080/privacy-policy.html",
    "http://localhost:8080/terms-of-service.html",
    "http://localhost:8080/404.html"
)

foreach ($u in $urls) {
    try {
        $res = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 3
        Write-Output "$($res.StatusCode) OK: $u"
    } catch {
        Write-Output "ERR: $u -> $_"
    }
}
