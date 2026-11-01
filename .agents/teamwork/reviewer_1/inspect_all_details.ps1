$html = Get-Content 'courses\freelancing-mastery.html' -Raw

$details = [regex]::Matches($html, '<details\b[^>]*>')
$summaries = [regex]::Matches($html, '<summary\b[^>]*>(.*?)</summary>')

for ($i = 0; $i -lt $details.Count; $i++) {
    Write-Host "[$i] Details: $($details[$i].Value) | Summary text: $($summaries[$i].Groups[1].Value.Trim())"
}
