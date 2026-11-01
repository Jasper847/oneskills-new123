$lines = Get-Content 'assets\css\course-v2.css'

$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})\b|rgba?\([^)]+\)|hsla?\([^)]+\))'
# Also check for standalone named colors like "color: white", "border-color: black", etc.
$namedColors = '\b(white|black|red|green|blue|yellow|orange|purple|gray|grey)\b'

$hardcodedInstances = @()

for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    
    # Skip token definitions in :root or html[data-theme="dark"]
    if ($line -match '^\s*--') {
        continue
    }
    # Skip comments
    if ($line -match '^\s*/\*' -or $line -match '\*/') {
        continue
    }
    
    # Strip all var(...) calls cleanly, even nested ones
    $stripped = $line
    while ($stripped -match 'var\([^()]*\)') {
        $stripped = [regex]::Replace($stripped, 'var\([^()]*\)', '')
    }
    
    # Check for hex/rgba/hsla
    $m = $colorRegex.Matches($stripped)
    if ($m.Count -gt 0) {
        foreach ($match in $m) {
            $hardcodedInstances += [PSCustomObject]@{
                LineNumber = $i + 1
                LineContent = $line.Trim()
                Matched = $match.Value
                Type = "Hex/RGBA"
            }
        }
    }
    
    # Check for named colors on color/background/border/fill/stroke properties
    if ($stripped -match '(?i)(?:color|background|border|fill|stroke|outline)\s*:\s*([^;]+);') {
        $val = $matches[1]
        $namedMatches = [regex]::Matches($val, $namedColors, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        foreach ($nm in $namedMatches) {
            $hardcodedInstances += [PSCustomObject]@{
                LineNumber = $i + 1
                LineContent = $line.Trim()
                Matched = $nm.Value
                Type = "Named Color"
            }
        }
    }
}

Write-Host "Total hardcoded color instances outside var(): $($hardcodedInstances.Count)"
foreach ($inst in $hardcodedInstances) {
    Write-Host "Line $($inst.LineNumber) [$($inst.Type): $($inst.Matched)]: $($inst.LineContent)"
}
