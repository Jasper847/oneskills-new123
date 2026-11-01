$html = Get-Content 'courses/freelancing-mastery.html' -Raw

$buttons = [regex]::Matches($html, '<button[^>]*>')
Write-Host "Total <button> elements: $($buttons.Count)"
foreach ($b in $buttons) {
  Write-Host "BUTTON: $($b.Value)"
}
