$ErrorActionPreference = 'Stop'

$html = Get-Content 'courses\freelancing-mastery.html' -Raw
$lines = Get-Content 'courses\freelancing-mastery.html'

Write-Host "============================================================"
Write-Host "INDEPENDENT SEMANTICS & ARIA AUDIT"
Write-Host "============================================================"

# 1. Main element
$mainMatches = [regex]::Matches($html, '<main\b[^>]*>')
Write-Host "Main elements found: $($mainMatches.Count)"
foreach ($m in $mainMatches) { Write-Host "  $($m.Value)" }

# 2. Figure elements
$figMatches = [regex]::Matches($html, '<figure\b[^>]*>')
Write-Host "`nFigure elements found: $($figMatches.Count)"
foreach ($m in $figMatches) { Write-Host "  $($m.Value)" }

# 3. Article elements
$artMatches = [regex]::Matches($html, '<article\b[^>]*>')
Write-Host "`nArticle elements found: $($artMatches.Count)"
for ($i=0; $i -lt [Math]::Min(10, $artMatches.Count); $i++) { Write-Host "  $($artMatches[$i].Value)" }

# 4. Aside elements
$asideMatches = [regex]::Matches($html, '<aside\b[^>]*>')
Write-Host "`nAside elements found: $($asideMatches.Count)"
foreach ($m in $asideMatches) { Write-Host "  $($m.Value)" }

# 5. DL, DT, DD
$dlMatches = [regex]::Matches($html, '<dl\b[^>]*>')
Write-Host "`nDL elements found: $($dlMatches.Count)"
foreach ($m in $dlMatches) { Write-Host "  $($m.Value)" }
$dtMatches = [regex]::Matches($html, '<dt\b[^>]*>')
Write-Host "DT elements found: $($dtMatches.Count)"
$ddMatches = [regex]::Matches($html, '<dd\b[^>]*>')
Write-Host "DD elements found: $($ddMatches.Count)"

# 6. OL, LI
$olMatches = [regex]::Matches($html, '<ol\b[^>]*>')
Write-Host "`nOL elements found: $($olMatches.Count)"
foreach ($m in $olMatches) { Write-Host "  $($m.Value)" }
$liMatches = [regex]::Matches($html, '<li\b[^>]*>')
Write-Host "LI elements found: $($liMatches.Count)"

# Check if lesson items are inside ol/li
$olLessons = [regex]::Matches($html, '<ol[^>]*class="[^"]*c-lessons-grid[^"]*"')
Write-Host "OL with c-lessons-grid found: $($olLessons.Count)"
$liLessons = [regex]::Matches($html, '<li[^>]*class="[^"]*c-lesson-item[^"]*"')
Write-Host "LI with c-lesson-item found: $($liLessons.Count)"

# 7. Table accessibility
Write-Host "`n--- Table Accessibility ---"
$tableMatches = [regex]::Matches($html, '<table\b[^>]*>')
Write-Host "Table elements found: $($tableMatches.Count)"
$captionMatches = [regex]::Matches($html, '<caption\b[^>]*>')
Write-Host "Caption elements found: $($captionMatches.Count)"
foreach ($m in $captionMatches) { Write-Host "  $($m.Value)" }
$thColMatches = [regex]::Matches($html, '<th\b[^>]*scope="col"[^>]*>')
Write-Host "th scope='col' found: $($thColMatches.Count)"
$thRowMatches = [regex]::Matches($html, '<th\b[^>]*scope="row"[^>]*>')
Write-Host "th scope='row' found: $($thRowMatches.Count)"
$thOther = [regex]::Matches($html, '<th\b(?![^>]*scope=)[^>]*>')
Write-Host "th without scope found: $($thOther.Count)"

# 8. Check for any invalid aria-label on generic div / span
Write-Host "`n--- ARIA Attribute Validity on Generic Elements ---"
$divAriaLabels = [regex]::Matches($html, '<div\b(?![^>]*role=)[^>]*aria-label=[^>]*>')
Write-Host "div with aria-label but NO role: $($divAriaLabels.Count)"
foreach ($m in $divAriaLabels) { Write-Host "  VIOLATION: $($m.Value)" }

$spanAriaLabels = [regex]::Matches($html, '<span\b(?![^>]*role=)[^>]*aria-label=[^>]*>')
Write-Host "span with aria-label but NO role: $($spanAriaLabels.Count)"
foreach ($m in $spanAriaLabels) { Write-Host "  VIOLATION: $($m.Value)" }

# 9. Check heading hierarchy
Write-Host "`n--- Heading Hierarchy Audit ---"
$headingPattern = '<(h[1-6])\b([^>]*)>(.*?)</\1>'
$headings = [regex]::Matches($html, $headingPattern, [System.Text.RegularExpressions.RegexOptions]::Singleline)
Write-Host "Total headings found: $($headings.Count)"

$lastLevel = 0
$headingSkips = 0
for ($i = 0; $i -lt $headings.Count; $i++) {
    $tag = $headings[$i].Groups[1].Value
    $attrs = $headings[$i].Groups[2].Value
    $content = $headings[$i].Groups[3].Value.Trim()
    $level = [int]$tag.Substring(1)
    
    # Check if level skipped (e.g. 1 -> 3, or 2 -> 4)
    if ($lastLevel -gt 0 -and $level -gt ($lastLevel + 1)) {
        Write-Host ("  HEADING SKIP DETECTED: h" + $lastLevel + " followed by h" + $level + ": " + $content)
        $headingSkips++
    }
    $lastLevel = $level
}
Write-Host "Heading skips count: $headingSkips"

# Check emojis in headings
Write-Host "`n--- Emojis in Headings ---"
$emojiPattern = '[\u2600-\u27BF\uD83C-\uDBFF\uDC00-\uDFFF]'
$rawEmojiHeadings = 0
for ($i = 0; $i -lt $headings.Count; $i++) {
    $tag = $headings[$i].Groups[1].Value
    $content = $headings[$i].Groups[3].Value
    # Check if emoji is outside aria-hidden
    $contentWithoutAriaHidden = [regex]::Replace($content, '<span\s+aria-hidden=["'']true["''][^>]*>.*?</span>', '')
    if ($contentWithoutAriaHidden -match $emojiPattern) {
        Write-Host "  RAW EMOJI IN HEADING ($tag): $content"
        $rawEmojiHeadings++
    }
}
Write-Host "Raw emojis in headings count: $rawEmojiHeadings"

# 10. Check specific visually hidden h3s for outcomes & benefits
Write-Host "`n--- Visually Hidden H3s ---"
$visuallyHiddenH3 = [regex]::Matches($html, '<h3[^>]*class="[^"]*visually-hidden[^"]*"[^>]*>(.*?)</h3>')
Write-Host "Visually hidden h3 found: $($visuallyHiddenH3.Count)"
foreach ($m in $visuallyHiddenH3) { Write-Host "  $($m.Value)" }

# 11. Check footer headings
Write-Host "`n--- Footer Headings ---"
$footerMatch = [regex]::Match($html, '(?s)<footer\b.*?</footer>')
if ($footerMatch.Success) {
    $footerHeadings = [regex]::Matches($footerMatch.Value, '<(h[1-6])\b[^>]*>(.*?)</\1>')
    Write-Host "Footer headings count: $($footerHeadings.Count)"
    foreach ($fh in $footerHeadings) {
        Write-Host "  $($fh.Groups[1].Value): $($fh.Groups[2].Value.Trim())"
    }
} else {
    Write-Host "Footer element not found!"
}
