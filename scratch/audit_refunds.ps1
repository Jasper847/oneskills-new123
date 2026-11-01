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
    "courses/index.html",
    "assets/js/course-v2.js",
    "assets/js/course-v3-core.js"
)

foreach ($f in $files) {
    if (Test-Path $f) {
        Write-Host "=== $f ===" -ForegroundColor Cyan
        $lines = Get-Content $f
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $line = $lines[$i]
            if ($line -match "refund|money-back|guarantee") {
                Write-Host "Line $($i+1): $($line.Trim())"
            }
        }
    }
}

