$lines = Get-Content 'assets/css/course-v2.css'
$spacingViolations = @()
$colorViolations = @()
$dimViolations = @()

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    $lineNum = $i + 1
    
    # 1. Check spacing properties: margin, padding, gap, top, bottom, left, right
    if ($line -match '^\s*(margin(?:-top|-bottom|-left|-right)?|padding(?:-top|-bottom|-left|-right)?|gap|column-gap|row-gap|top|bottom|left|right)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        $pxMatches = [regex]::Matches($val, '(-?\d+(?:\.\d+)?)px')
        foreach ($m in $pxMatches) {
            $n = [double]$m.Groups[1].Value
            $abs = [Math]::Abs($n)
            # Allow 0, or exact multiples of 8 (or 4 for border-radius/half-steps if standard allows, but standard mandates 8px)
            if ($abs -ne 0 -and ($abs % 8) -ne 0) {
                $spacingViolations += [PSCustomObject]@{
                    Line = $lineNum
                    Property = $prop
                    Value = $val.Trim()
                }
                break
            }
        }
    }

    # 2. Check dimension properties: width, height, min-width, min-height, max-width, max-height (excluding 100%, auto, etc.)
    if ($line -match '^\s*(width|height|min-width|min-height)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        # Ignore max-width/widths with calc, percentages, vw, ch, etc.
        if ($val -notmatch 'calc|%|vw|ch|em|rem|auto|none|max-content|min-content') {
            $pxMatches = [regex]::Matches($val, '(\d+(?:\.\d+)?)px')
            foreach ($m in $pxMatches) {
                $n = [double]$m.Groups[1].Value
                if ($n -gt 0 -and ($n % 8) -ne 0 -and $n -lt 500) {
                    $dimViolations += [PSCustomObject]@{
                        Line = $lineNum
                        Property = $prop
                        Value = $val.Trim()
                    }
                    break
                }
            }
        }
    }

    # 3. Check hardcoded colors
    if ($line -match '^\s*(color|background|background-color|border|border-color|border-top|border-bottom|border-left|border-right|box-shadow)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        # Remove var(...) declarations
        $stripped = [regex]::Replace($val, 'var\([^)]+\)', '')
        # Remove none, transparent, currentColor, inherit, initial
        if ($stripped -match '#[0-9a-fA-F]{3,8}|rgba?\([^)]+\)') {
            # Check if this is within a :root or custom property declaration
            if ($line -notmatch '--[a-zA-Z0-9_-]+:') {
                $colorViolations += [PSCustomObject]@{
                    Line = $lineNum
                    Property = $prop
                    Value = $val.Trim()
                }
            }
        }
    }
}

Write-Host "Non-8px Spacing Violations: $($spacingViolations.Count)"
Write-Host "Non-8px Dimension Violations: $($dimViolations.Count)"
Write-Host "Hardcoded Color Violations: $($colorViolations.Count)"

# Output first 10 of each
if ($spacingViolations.Count -gt 0) {
    Write-Host "`nSample Spacing Violations:"
    $spacingViolations | Select-Object -First 10 | Format-Table
}

if ($colorViolations.Count -gt 0) {
    Write-Host "`nSample Color Violations:"
    $colorViolations | Select-Object -First 10 | Format-Table
}
