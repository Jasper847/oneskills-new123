$ErrorActionPreference = 'Stop'

$html = Get-Content 'courses\freelancing-mastery.html' -Raw

Write-Host "============================================================"
Write-Host "TAG BALANCE & WELL-FORMEDNESS AUDIT"
Write-Host "============================================================"

$semanticTags = @('main', 'header', 'footer', 'nav', 'section', 'article', 'aside', 'figure', 'figcaption', 'dl', 'dt', 'dd', 'ol', 'ul', 'li', 'table', 'thead', 'tbody', 'tr', 'th', 'td', 'details', 'summary')

foreach ($tag in $semanticTags) {
    $openCount = ([regex]::Matches($html, "<$tag\b[^>]*>", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
    $closeCount = ([regex]::Matches($html, "</$tag\s*>", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
    $status = if ($openCount -eq $closeCount) { "BALANCED" } else { "MISMATCH" }
    Write-Host ("<$tag>: Opens=$openCount, Closes=$closeCount -> $status")
}

# Also check div tags balance
$divOpen = ([regex]::Matches($html, "<div\b[^>]*>", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
$divClose = ([regex]::Matches($html, "</div\s*>", [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
$divStatus = if ($divOpen -eq $divClose) { "BALANCED" } else { "MISMATCH" }
Write-Host "<div>: Opens=$divOpen, Closes=$divClose -> $divStatus"
