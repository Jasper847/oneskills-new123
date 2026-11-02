$content = Get-Content courses/freelancing-mastery.html -Raw
if ($content -match '(?s)(<footer[^>]*>.*?</footer>)') {
    Write-Host "=== Footer in freelancing-mastery.html ==="
    $lines = ($matches[1] -split "`r?`n")
    $lines[0..[Math]::Min(80, $lines.Length - 1)] -join "`r`n"
}

