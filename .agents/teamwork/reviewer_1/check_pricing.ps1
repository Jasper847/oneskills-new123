$ErrorActionPreference = 'Stop'

$lines = Get-Content 'courses\freelancing-mastery.html'
Write-Host "--- Occurrences of PKR 25,000 ---"
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match 'PKR 25,000') {
        Write-Host "Line $($i+1): $($lines[$i].Trim())"
    }
}

Write-Host "`n--- Occurrences of PKR 12,500 ---"
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '12,500') {
        Write-Host "Line $($i+1): $($lines[$i].Trim())"
    }
}

Write-Host "`n--- Occurrences of PKR 8,500 ---"
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '8,500') {
        Write-Host "Line $($i+1): $($lines[$i].Trim())"
    }
}
