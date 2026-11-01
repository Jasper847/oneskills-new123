$specs = Get-ChildItem -Path "courses\Content & SEO Blueprint\*.md"

foreach ($s in $specs) {
    Write-Host "=========================================================="
    Write-Host "FILE: $($s.Name)"
    Write-Host "=========================================================="
    $lines = Get-Content $s.FullName
    Write-Host "Total Lines: $($lines.Length)"
    
    # Extract headers
    $headers = Select-String -Path $s.FullName -Pattern '^#+ ' | Select-Object -First 15
    foreach ($h in $headers) {
        Write-Host "  $($h.Line.Trim())"
    }
}

