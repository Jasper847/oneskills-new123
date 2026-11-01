$files = Get-ChildItem -Path courses -Filter *.html
foreach ($f in $files) {
    $text = Get-Content $f.FullName -Raw
    $matches = [regex]::Matches($text, '(?i)(?:generator|ups|kva|fiber|fibre|mbps|air condition|solar|display)[^\<\n\r]*')
    if ($matches.Count -gt 0) {
        Write-Host "=== $($f.Name) ===" -ForegroundColor Cyan
        foreach ($m in $matches) {
            Write-Host "  $($m.Value.Trim())"
        }
    }
}

