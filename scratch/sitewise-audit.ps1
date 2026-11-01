# scratch/sitewise-audit.ps1
# Non-mutating forensic audit across all files

$htmlFiles = Get-ChildItem -Path . -Recurse -Filter "*.html" | Where-Object { $_.FullName -notmatch '\\_archive\\' -and $_.FullName -notmatch '\\\.agents\\' -and $_.FullName -notmatch 'redesign' }

Write-Host "=== 1. FILE SIZES & LINE COUNTS (Thermo-Nuclear Review) ==="
foreach ($f in $htmlFiles) {
    $lines = (Get-Content $f.FullName).Length
    $rel = $f.FullName.Replace((Get-Location).Path + "\", "")
    if ($lines -gt 1000) {
        Write-Host "WARNING > 1000 lines: $rel ($lines lines)"
    } else {
        Write-Host "OK <= 1000 lines: $rel ($lines lines)"
    }
}

Write-Host "`n=== 2. ACCESSIBILITY AUDIT (WCAG 2.2 / POUR) ==="
foreach ($f in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $rel = $f.FullName.Replace((Get-Location).Path + "\", "")
    
    # Check images without alt
    $imgWithoutAlt = [regex]::Matches($content, '<img(?![^>]*\balt=)[^>]*>')
    if ($imgWithoutAlt.Count -gt 0) {
        Write-Host "A11Y ISSUE [Missing Alt]: $rel has $($imgWithoutAlt.Count) images without alt"
    }

    # Check buttons without accessible name
    $btnEmpty = [regex]::Matches($content, '<button(?![^>]*\baria-label=)[^>]*>\s*<svg[^>]*>[\s\S]*?<\/svg>\s*<\/button>')
    if ($btnEmpty.Count -gt 0) {
        Write-Host "A11Y ISSUE [Empty Icon Button]: $rel has $($btnEmpty.Count) icon buttons without aria-label"
    }

    # Check headings hierarchy: multiple H1
    $h1Count = [regex]::Matches($content, '<h1\b', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase).Count
    if ($h1Count -ne 1) {
        Write-Host "SEO/A11Y ISSUE [H1 Count]: $rel has $h1Count <h1> tags (expected 1)"
    }

    # Check lang attribute on html tag
    if (-not ($content -match '<html[^>]*\blang=')) {
        Write-Host "A11Y ISSUE [Missing lang]: $rel is missing lang attribute on <html>"
    }
}

Write-Host "`n=== 3. COLOR SYSTEM & CSS TOKENS (Better-Colors) ==="
$cssFiles = Get-ChildItem -Path "assets/css" -Filter "*.css"
foreach ($css in $cssFiles) {
    $content = [System.IO.File]::ReadAllText($css.FullName, [System.Text.Encoding]::UTF8)
    $rel = $css.FullName.Replace((Get-Location).Path + "\", "")
    $hexMatches = [regex]::Matches($content, '#[0-9a-fA-F]{3,8}')
    $varMatches = [regex]::Matches($content, 'var\(--[a-zA-Z0-9_-]+\)')
    Write-Host "$rel - Hex literals: $($hexMatches.Count), CSS Var references: $($varMatches.Count)"
}

Write-Host "`n=== 4. MOTION & ANIMATION AUDIT (Emil Kowalski / Animate) ==="
foreach ($css in $cssFiles) {
    $content = [System.IO.File]::ReadAllText($css.FullName, [System.Text.Encoding]::UTF8)
    $rel = $css.FullName.Replace((Get-Location).Path + "\", "")
    $hasPrefersReduced = $content.Contains("prefers-reduced-motion")
    $hasAllTransitions = [regex]::Matches($content, 'transition:\s*all\b').Count
    $animatesHeight = [regex]::Matches($content, 'transition:[^;]*\bheight\b').Count
    Write-Host "$rel - prefers-reduced-motion: $hasPrefersReduced | transition:all instances: $hasAllTransitions | height transitions: $animatesHeight"
}
