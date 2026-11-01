$ErrorActionPreference = 'Stop'

$html = Get-Content 'courses\freelancing-mastery.html' -Raw

Write-Host "============================================================"
Write-Host "ADVERSARIAL STRESS-TEST & ACCESSIBILITY AUDIT"
Write-Host "============================================================"

# 1. Skip link & target verification
Write-Host "`n1. Skip link & Main Target:"
$skipLink = [regex]::Match($html, '<a\b[^>]*class=[\x22\x27][^\x22\x27]*skip-link[^\x22\x27]*[\x22\x27][^>]*>')
Write-Host "  Skip link tag: $($skipLink.Value)"
$skipHref = [regex]::Match($skipLink.Value, 'href=[\x22\x27]#([^"'']+)[\x22\x27]')
if ($skipHref.Success) {
    $targetId = $skipHref.Groups[1].Value
    $targetElement = [regex]::Match($html, "<[^>]*id=[\x22\x27]$targetId[\x22\x27][^>]*>")
    Write-Host "  Skip target #$targetId exists: $($targetElement.Success) -> $($targetElement.Value)"
}

# 2. Image alt tags
Write-Host "`n2. Image alt text audit:"
$imgTags = [regex]::Matches($html, '<img\b[^>]*>')
Write-Host "Total <img> tags: $($imgTags.Count)"
$missingAlt = 0
foreach ($img in $imgTags) {
    if ($img.Value -notmatch '\balt=') {
        Write-Host "  MISSING ALT: $($img.Value)"
        $missingAlt++
    }
}
Write-Host "Images missing alt attribute: $missingAlt"

# 3. Button accessible names
Write-Host "`n3. Button accessible names audit:"
$btnTags = [regex]::Matches($html, '<button\b([^>]*)>(.*?)</button>', [System.Text.RegularExpressions.RegexOptions]::Singleline)
Write-Host "Total <button> tags: $($btnTags.Count)"
$unnamedBtns = 0
foreach ($btn in $btnTags) {
    $attrs = $btn.Groups[1].Value
    $content = [regex]::Replace($btn.Groups[2].Value, '<[^>]+>', '').Trim()
    $hasAriaLabel = $attrs -match 'aria-label=' -or $attrs -match 'aria-labelledby='
    if (-not $hasAriaLabel -and [string]::IsNullOrWhiteSpace($content)) {
        Write-Host "  UNNAMED BUTTON: $($btn.Value)"
        $unnamedBtns++
    }
}
Write-Host "Buttons missing accessible name: $unnamedBtns"

# 4. Form inputs labels
Write-Host "`n4. Form inputs accessible labels audit:"
$inputTags = [regex]::Matches($html, '<input\b[^>]*>')
Write-Host "Total <input> tags: $($inputTags.Count)"
$unlabeledInputs = 0
foreach ($inp in $inputTags) {
    $attrs = $inp.Value
    $hasAriaLabel = $attrs -match 'aria-label=' -or $attrs -match 'aria-labelledby='
    $hasId = $attrs -match 'id=[\x22\x27]([^\x22\x27]+)[\x22\x27]'
    $hasAssociatedLabel = $false
    if ($hasId) {
        $inpId = $Matches[1]
        if ($html -match "<label\b[^>]*for=[\x22\x27]$inpId[\x22\x27]") {
            $hasAssociatedLabel = $true
        }
    }
    if (-not $hasAriaLabel -and -not $hasAssociatedLabel) {
        Write-Host "  UNLABELED INPUT: $($inp.Value)"
        $unlabeledInputs++
    }
}
Write-Host "Inputs missing accessible label: $unlabeledInputs"

# 5. SVGs aria-hidden audit
Write-Host "`n5. Inline SVGs accessibility audit:"
$svgTags = [regex]::Matches($html, '<svg\b[^>]*>')
Write-Host "Total <svg> tags: $($svgTags.Count)"
$unlabeledSvgs = 0
foreach ($svg in $svgTags) {
    $hasHidden = $svg.Value -match 'aria-hidden=[\x22\x27]true[\x22\x27]'
    $hasLabel = $svg.Value -match 'aria-label=' -or $svg.Value -match 'role=[\x22\x27]img[\x22\x27]'
    if (-not $hasHidden -and -not $hasLabel) {
        # Check if parent is button with text or something
        $unlabeledSvgs++
    }
}
Write-Host "SVGs without explicit aria-hidden or role/label: $unlabeledSvgs"

# 6. Check for duplicate IDs in the document
Write-Host "`n6. Duplicate IDs audit:"
$idMatches = [regex]::Matches($html, '\bid=[\x22\x27]([^\x22\x27]+)[\x22\x27]')
$ids = @{}
$duplicateIds = @()
foreach ($m in $idMatches) {
    $idVal = $m.Groups[1].Value
    if ($ids.ContainsKey($idVal)) {
        $ids[$idVal]++
        if ($duplicateIds -notcontains $idVal) {
            $duplicateIds += $idVal
        }
    } else {
        $ids[$idVal] = 1
    }
}
Write-Host "Duplicate IDs found: $($duplicateIds.Count)"
if ($duplicateIds.Count -gt 0) {
    Write-Host "  Duplicates: $($duplicateIds -join ', ')"
}
