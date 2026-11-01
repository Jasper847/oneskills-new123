$pages = @(
    '',
    'courses/',
    'courses/freelancing-mastery.html',
    'courses/ai-web-development.html',
    'courses/ai-tools-automation.html',
    'courses/crypto-trading.html',
    'courses/forex-trading.html',
    'courses/web3-blockchain.html',
    'courses/ai-based-computer-course.html',
    'courses/programming-js-cpp.html',
    'courses/shopify-ecommerce.html'
)

foreach ($p in $pages) {
    try {
        $res = Invoke-WebRequest -Uri "http://localhost:8080/$p" -UseBasicParsing -TimeoutSec 5
        Write-Host "$($res.StatusCode) OK: http://localhost:8080/$p" -ForegroundColor Green
    } catch {
        Write-Host "ERR: http://localhost:8080/$p - $($_.Exception.Message)" -ForegroundColor Red
    }
}
