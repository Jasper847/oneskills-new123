$courseHtml = Get-Content 'courses/freelancing-mastery.html' -Raw

$anchors = [regex]::Matches($courseHtml, '<a\s+[^>]*href=["''](#[^"'']*)["''][^>]*>')
Write-Host "Total hash anchors found: $($anchors.Count)"
foreach ($m in $anchors) {
  Write-Host $m.Value
}
