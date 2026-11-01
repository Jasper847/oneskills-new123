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
    if (Test-Path $f) {
        Write-Host "=== $f ===" -ForegroundColor Cyan
        $content = Get-Content $f -Raw
        
        # Schema rating
        if ($content -match '(?s)"aggregateRating":\s*\{(.*?)\}') {
            Write-Host "Schema aggregateRating: $($matches[1].Trim())"
        } else {
            Write-Host "Schema aggregateRating: NONE"
        }
        
        # Visual rating
        $lines = Get-Content $f
        for ($i = 0; $i -lt $lines.Count; $i++) {
            $line = $lines[$i]
            if ($line -match "5\.0|rating|review|testimonial|★★★★★") {
                if ($line -notmatch "stylesheet|preload|meta") {
                    Write-Host "Line $($i+1): $($line.Trim())"
                }
            }
        }
    }
}

