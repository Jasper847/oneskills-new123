$artifactDir = "C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e"

Get-Process msedge -ErrorAction SilentlyContinue | Where-Object { $_.CommandLine -match '9223' } | Stop-Process -Force -ErrorAction SilentlyContinue
Start-Sleep -Seconds 2

powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/courses/crypto-trading.html" -outPath "$artifactDir\footer_crypto.png" -width 1440 -height 1000 -scrollToId "footer"

Start-Sleep -Seconds 2

powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/about.html" -outPath "$artifactDir\footer_about.png" -width 1440 -height 1000 -scrollToId "footer"

