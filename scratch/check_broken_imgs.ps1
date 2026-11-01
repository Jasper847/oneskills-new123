$c = Get-Content "courses/web3-blockchain.html" -Raw
$imgTags = [regex]::Matches($c, '<img\b[^>]*>')
foreach ($img in $imgTags) {
    Write-Host "Tag: $($img.Value)"
    if ($img.Value -match 'src="([^"]+)"') {
        $src = $matches[1]
        $local = $src.Replace('../', '')
        Write-Host "  Path: $src => Exists: $(Test-Path $local)"
    }
}

