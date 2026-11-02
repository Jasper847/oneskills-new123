$lines = Get-Content "assets/css/main.css"
$start = -1
$end = -1
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '\.footer-wrap\s*\{' -and $start -eq -1) {
        $start = $i + 1
    }
}
Write-Output "footer-wrap start line: $start"
if ($start -gt 0) {
    # find where it ends or inspect 200 lines
    $lines[($start - 1)..($start + 250)] | Select-Object -First 50
}

