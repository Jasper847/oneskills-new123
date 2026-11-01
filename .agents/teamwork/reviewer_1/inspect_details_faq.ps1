$html = Get-Content 'courses\freelancing-mastery.html' -Raw

$details = [regex]::Matches($html, '<details\b[^>]*>')
Write-Host "Details elements count: $($details.Count)"
$summaries = [regex]::Matches($html, '<summary\b[^>]*>')
Write-Host "Summary elements count: $($summaries.Count)"

Write-Host "`nSample details/summary:"
for ($i = 0; $i -lt [Math]::Min(5, $details.Count); $i++) {
    Write-Host "Details: $($details[$i].Value)"
    Write-Host "Summary: $($summaries[$i].Value)"
}
