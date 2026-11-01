$html = Get-Content 'courses/freelancing-mastery.html' -Raw

$details = [regex]::Matches($html, '<details[^>]*>')
Write-Host "Total <details> elements: $($details.Count)"
foreach ($d in $details) {
  Write-Host "DETAILS: $($d.Value)"
}
