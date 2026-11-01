$specs = Get-ChildItem -Path "courses\Content & SEO Blueprint\*.md"

foreach ($s in $specs) {
    Write-Host "`n****************************************************************"
    Write-Host "FILE: $($s.Name)"
    Write-Host "****************************************************************"
    $lines = Get-Content $s.FullName
    # Print lines 1 to 50
    $lines[0..45] | ForEach-Object { Write-Host $_ }
}

