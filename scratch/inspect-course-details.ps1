$files = Get-ChildItem "courses/*.html" | Where-Object { $_.Name -notmatch "redesign" }

foreach ($f in $files) {
    Write-Host "=== FILE: $($f.Name) ==="
    $lines = Get-Content $f.FullName
    for ($i = 0; $i -lt $lines.Length; $i++) {
        if ($lines[$i] -match '<nav class="primary-nav"') {
            Write-Host "PRIMARY NAV at line $($i)"
            $end = [Math]::Min($i + 15, $lines.Length - 1)
            for ($j = $i; $j -le $end; $j++) {
                Write-Host "  $($lines[$j])"
            }
        }
        if ($lines[$i] -match '<h3>Academy</h3>' -or $lines[$i] -match '<h4>Academy Hub</h4>') {
            Write-Host "ACADEMY FOOTER at line $($i)"
            $end = [Math]::Min($i + 15, $lines.Length - 1)
            for ($j = $i; $j -le $end; $j++) {
                Write-Host "  $($lines[$j])"
            }
        }
    }
}
