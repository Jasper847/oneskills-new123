$html = Get-Content 'courses\freelancing-mastery.html' -Raw
$matches = [regex]::Matches($html, '(?i)\bstyle\s*=\s*["''][^"'']*["'']')
Write-Host "Inline styles count in freelancing-mastery.html: $($matches.Count)"
if ($matches.Count -gt 0) {
    foreach ($m in $matches) {
        Write-Host $m.Value
    }
}
