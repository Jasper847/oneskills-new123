$c = Get-Content "courses/freelancing-mastery.html" -Raw
$imgTags = [regex]::Matches($c, '<img\b[^>]*>')
foreach ($img in $imgTags) {
    if ($img.Value -match 'src="([^"]+)"') {
        $src = $matches[1]
        $local = $src.Replace('../', '')
        Write-Host "Tag: $($img.Value)"
        Write-Host "  Path: $src => Exists: $(Test-Path $local)"
    }
}

