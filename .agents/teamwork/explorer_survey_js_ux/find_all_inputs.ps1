$html = Get-Content 'courses/freelancing-mastery.html' -Raw

$inputs = [regex]::Matches($html, '<(input|select)[^>]*>')
Write-Host "Total <input>/<select> elements: $($inputs.Count)"
foreach ($i in $inputs) {
  Write-Host "INPUT/SELECT: $($i.Value)"
}
