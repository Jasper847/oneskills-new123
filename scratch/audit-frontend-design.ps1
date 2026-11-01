# scratch/audit-frontend-design.ps1
$htmlFiles = Get-ChildItem -Path . -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch '\\_archive\\' -and $_.FullName -notmatch '\\\.agents\\' -and $_.FullName -notmatch 'redesign' }

Write-Host "=== FRONTEND DESIGN AUDIT (Anthropic Guidelines) ==="

foreach ($f in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $rel = $f.FullName.Replace((Get-Location).Path + "\", "")
    
    # Check for artificial numbering 01, 02, 03
    $numBadges = [regex]::Matches($content, '>(0[1-9])<')
    if ($numBadges.Count -gt 0) {
        Write-Host "Design Audit [Numbered Markers]: $rel has $($numBadges.Count) occurrences of 01-09 markers"
    }

    # Check for text-transform: uppercase in inline styles
    $uppercaseStyles = [regex]::Matches($content, 'text-transform:\s*uppercase')
    if ($uppercaseStyles.Count -gt 0) {
        Write-Host "Design Audit [Inline Uppercase]: $rel has $($uppercaseStyles.Count) inline uppercase styles"
    }
}
