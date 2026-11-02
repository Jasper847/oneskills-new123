param()

$artifactDir = "C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e"
$pages = @(
    @{ Name = "footer_freelancing"; Url = "http://localhost:8080/courses/freelancing-mastery.html"; Out = "$artifactDir\footer_freelancing.png" },
    @{ Name = "footer_crypto"; Url = "http://localhost:8080/courses/crypto-trading.html"; Out = "$artifactDir\footer_crypto.png" },
    @{ Name = "footer_catalog_hub"; Url = "http://localhost:8080/courses/index.html"; Out = "$artifactDir\footer_catalog_hub.png" },
    @{ Name = "footer_about"; Url = "http://localhost:8080/about.html"; Out = "$artifactDir\footer_about.png" }
)

foreach ($p in $pages) {
    Write-Host "Capturing $($p.Name)..."
    try {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url $p.Url -outPath $p.Out -width 1440 -height 1000 -scrollToId "footer"
    } catch {
        Write-Warning "Could not capture $($p.Name): $_"
    }
}
Write-Host "Footer captures complete."

