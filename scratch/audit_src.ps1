$html = [System.IO.File]::ReadAllText("index.html")
$regex = [regex]'src="([^"]+)"'
$matches = $regex.Matches($html)
$problematic = @()
foreach ($m in $matches) {
    $val = $m.Groups[1].Value
    if ($val.Contains(" ") -or $val.Contains("&") -or $val.EndsWith(".png") -or $val.EndsWith(".avif")) {
        $problematic += $val
    }
}
Write-Host "Total src attributes: " $matches.Count
Write-Host "Problematic count: " $problematic.Count
$problematic | ForEach-Object { Write-Host " - " $_ }
