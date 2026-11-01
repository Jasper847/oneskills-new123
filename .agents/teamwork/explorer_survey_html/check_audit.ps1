# Script to extract IDs, headings, inline styles, ARIA attributes
$content = Get-Content -Path 'courses\freelancing-mastery.html' -Raw

Write-Output "=== DUPLICATE IDS ==="
$idMatches = [regex]::Matches($content, 'id=["'']([^"'']+)["'']')
$ids = $idMatches | ForEach-Object { $_.Groups[1].Value }
$dupes = $ids | Group-Object | Where-Object { $_.Count -gt 1 }
if ($dupes) {
    $dupes | ForEach-Object { "$($_.Name) (Count: $($_.Count))" }
} else {
    Write-Output "No duplicate IDs found."
}

Write-Output "`n=== ALL HEADINGS IN ORDER ==="
$hMatches = [regex]::Matches($content, '(?s)<(h[1-6])[^>]*>(.*?)</\1>')
$hMatches | ForEach-Object {
    $tag = $_.Groups[1].Value
    $text = ($_.Groups[2].Value -replace '<[^>]+>', '' -replace '\s+', ' ').Trim()
    "$tag : $text"
}

Write-Output "`n=== INLINE STYLES COUNT & EXAMPLES ==="
$styleMatches = [regex]::Matches($content, 'style=["'']([^"'']+)["'']')
Write-Output "Total inline style attributes: $($styleMatches.Count)"
$styleMatches | ForEach-Object {
    $_.Groups[1].Value
} | Select-Object -Unique

Write-Output "`n=== ARIA ROLES AND TABS ==="
$roleMatches = [regex]::Matches($content, 'role=["'']([^"'']+)["'']')
$roleMatches | ForEach-Object { $_.Groups[1].Value } | Group-Object | Select-Object Count, Name

Write-Output "`n=== ARIA-LABEL ON DIVS/SPANS ==="
$divAria = [regex]::Matches($content, '(?i)<(div|span|section)[^>]*aria-label=["'']([^"'']+)["''][^>]*>')
$divAria | ForEach-Object {
    $tag = $_.Groups[1].Value
    $label = $_.Groups[2].Value
    "<$tag> aria-label='$label'"
}
