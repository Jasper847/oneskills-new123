$refs = Get-ChildItem -Path "Project References" -Directory

foreach ($r in $refs) {
    Write-Host "=========================================="
    Write-Host "REFERENCE: $($r.Name)"
    Write-Host "=========================================="
    $htmls = Get-ChildItem -Path $r.FullName -Filter "*.html" | Select-Object -First 5
    foreach ($h in $htmls) {
        Write-Host "  HTML: $($h.Name)"
    }
    $images = Get-ChildItem -Path $r.FullName -Recurse -File -Include "*.png", "*.jpg", "*.avif" | Where-Object { $_.FullName -notmatch "node_modules" } | Select-Object -First 5
    foreach ($img in $images) {
        Write-Host "  IMG: $($img.Name) ($($img.Length) bytes)"
    }
}

