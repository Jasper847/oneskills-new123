param()

$artifactDir = "C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e"
$courses = @(
    @{ Name = "crypto-trading"; Url = "http://localhost:8080/courses/crypto-trading.html"; Out = "$artifactDir\harmonized_crypto_trading.png" },
    @{ Name = "forex-trading"; Url = "http://localhost:8080/courses/forex-trading.html"; Out = "$artifactDir\harmonized_forex_trading.png" },
    @{ Name = "web3-blockchain"; Url = "http://localhost:8080/courses/web3-blockchain.html"; Out = "$artifactDir\harmonized_web3_blockchain.png" },
    @{ Name = "shopify-ecommerce"; Url = "http://localhost:8080/courses/shopify-ecommerce.html"; Out = "$artifactDir\harmonized_shopify_ecommerce.png" }
)

$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edge)) {
    $edge = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}

foreach ($c in $courses) {
    Write-Host "Capturing $($c.Name)..."
    try {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url $c.Url -outPath $c.Out -width 1440 -height 900
    } catch {
        Write-Warning "Could not capture $($c.Name): $_"
    }
}
Write-Host "Captures complete."
