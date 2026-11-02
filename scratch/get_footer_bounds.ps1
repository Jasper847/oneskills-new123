$lines = Get-Content "index.html"
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '<footer') {
        Write-Output "Start: $($i + 1)"
    }
    if ($lines[$i] -match '</footer>') {
        Write-Output "End: $($i + 1)"
    }
}

