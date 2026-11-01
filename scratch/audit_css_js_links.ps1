$files = Get-ChildItem -Path courses -Filter *.html

foreach ($f in $files) {
    Write-Host "=== $($f.Name) ===" -ForegroundColor Cyan
    $content = Get-Content $f.FullName
    $css = $content | Where-Object { $_ -match '<link\s+rel="stylesheet"' }
    $js = $content | Where-Object { $_ -match '<script\s+src=' }
    Write-Host "  CSS:"
    $css | ForEach-Object { Write-Host "    $($_.Trim())" }
    Write-Host "  JS:"
    $js | ForEach-Object { Write-Host "    $($_.Trim())" }
}

