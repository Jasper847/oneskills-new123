param(
    [string]$id = "fee-display-amount",
    [string]$out = "C:\Users\Nisar\Desktop\oneskills new123\scratch\shots\sections\view_fee_card.png"
)

powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/courses/freelancing-mastery.html" -outPath $out -width 1440 -height 900 -scrollToId $id
Copy-Item $out -Destination "C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e\" -Force
Write-Output "Captured $out"

