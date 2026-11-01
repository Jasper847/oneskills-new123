$ErrorActionPreference = "Stop"

$shots = @(
    @{ url = "http://localhost:8080/courses/index.html"; name = "v3_catalog_hub_desktop.png"; w = 1440; h = 900; isMob = $false },
    @{ url = "http://localhost:8080/courses/ai-web-development.html"; name = "v3_ai_web_dev_desktop.png"; w = 1440; h = 900; isMob = $false },
    @{ url = "http://localhost:8080/courses/forex-trading.html"; name = "v3_forex_trading_desktop.png"; w = 1440; h = 900; isMob = $false },
    @{ url = "http://localhost:8080/courses/web3-blockchain.html"; name = "v3_web3_blockchain_desktop.png"; w = 1440; h = 900; isMob = $false },
    @{ url = "http://localhost:8080/courses/index.html"; name = "v3_catalog_hub_mobile.png"; w = 390; h = 844; isMob = $true }
)

$artifactDir = "C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e"

foreach ($s in $shots) {
    $tempOut = "C:\Users\Nisar\Desktop\oneskills new123\scratch\shots\sections\$($s.name)"
    $artifactOut = Join-Path $artifactDir $s.name
    Write-Output "Capturing $($s.name)..."
    if ($s.isMob) {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url $s.url -outPath $tempOut -width $s.w -height $s.h -isMobile
    } else {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url $s.url -outPath $tempOut -width $s.w -height $s.h
    }
    if (Test-Path $tempOut) {
        Copy-Item -Path $tempOut -Destination $artifactOut -Force
        Write-Output "Copied to $artifactOut"
    }
}
Write-Output "Showcase visual captures complete!"

