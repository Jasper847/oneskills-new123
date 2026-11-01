$c = Get-Content "index.html" -Raw
$matches = [regex]::Matches($c, '<!-- Supporting Review \d+: ([^>]+) -->')
foreach ($m in $matches) {
    Write-Host "Reviewer: $($m.Groups[1].Value.Trim())"
}
$featured = [regex]::Matches($c, 'featured-review-author[^>]*>([^<]+)<')
foreach ($f in $featured) {
    Write-Host "Featured Reviewer: $($f.Groups[1].Value.Trim())"
}
