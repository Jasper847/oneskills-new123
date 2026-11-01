$css = Get-Content 'assets\css\course-v2.css'

$propRegex = [regex]'(?i)^\s*(margin(?:-(?:top|bottom|left|right))?|padding(?:-(?:top|bottom|left|right))?|gap|row-gap|column-gap|top|bottom|left|right|width|height|min-width|min-height|max-width|max-height)\s*:\s*([^;]+);'
$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})|rgba?\([^)]+\))'

$spacingViolations = @()
$colorViolations = @()

for ($i = 0; $i -lt $css.Length; $i++) {
    $line = $css[$i]
    $lineNum = $i + 1
    
    $m = $propRegex.Match($line)
    if ($m.Success) {
        $prop = $m.Groups[1].Value.ToLower()
        $val = $m.Groups[2].Value
        
        # Find px values in $val
        $pxMatches = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxMatches) {
            $num = [int]$px.Groups[1].Value
            $abs = [Math]::Abs($num)
            # 0, 4, 8, 16, 24, 32, 40, 48, 56, 64, 72, 80, 88, 96, ...
            # Also allow 1px / 2px for thin dividers/strokes if not margin/padding/gap
            if ($prop -match '^(margin|padding|gap|row-gap|column-gap|top|bottom|left|right)') {
                # Strict 8px grid (allow 4px as half-step if appropriate, but let's check % 8)
                if ($abs -ne 0 -and $abs % 8 -ne 0 -and $abs -ne 4) {
                    $spacingViolations += [PSCustomObject]@{
                        Line = $lineNum
                        Prop = $prop
                        Text = $line.Trim()
                        Value = $px.Value
                    }
                }
            } elseif ($prop -match '^(width|height|min-width|min-height|max-width|max-height)') {
                # Dimensions: check if small fixed dimensions violate 8px
                if ($abs -ne 0 -and $abs % 8 -ne 0 -and $abs -ne 4 -and $abs -lt 300) {
                    $spacingViolations += [PSCustomObject]@{
                        Line = $lineNum
                        Prop = $prop
                        Text = $line.Trim()
                        Value = $px.Value
                    }
                }
            }
        }
    }
    
    # Check colors outside var()
    # Note: Ignore CSS variable definitions in :root or html[data-theme="dark"]
    if ($line -notmatch '^\s*--') {
        $lineWithoutVars = [regex]::Replace($line, 'var\([^)]+\)', '')
        # Also handle multiple nested vars if any
        while ($lineWithoutVars -match 'var\(') {
            $lineWithoutVars = [regex]::Replace($lineWithoutVars, 'var\([^()]*\)', '')
        }
        $colMatches = $colorRegex.Matches($lineWithoutVars)
        foreach ($c in $colMatches) {
            $colorViolations += [PSCustomObject]@{
                Line = $lineNum
                Text = $line.Trim()
                Color = $c.Value
            }
        }
    }
}

Write-Host "Total Spacing/Dimension Violations: $($spacingViolations.Count)"
Write-Host "Total Hardcoded Colors (outside var): $($colorViolations.Count)"

Write-Output $spacingViolations | Export-Csv -Path ".agents\teamwork\worker_remediation_2\spacing_violations.csv" -NoTypeInformation
Write-Output $colorViolations | Export-Csv -Path ".agents\teamwork\worker_remediation_2\color_violations.csv" -NoTypeInformation
