# CSS Stress Test Harness
$cssLines = Get-Content 'assets\css\course-v2.css'
$results = @()

for ($i = 0; $i -lt $cssLines.Length; $i++) {
    $line = $cssLines[$i]
    if ($line -match '^\s*([a-zA-Z0-9\-_]+)\s*:\s*([^;]+);') {
        $prop = $matches[1].ToLower()
        $val = $matches[2]
        $pxMatches = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxMatches) {
            $num = [int]$px.Groups[1].Value
            $abs = [Math]::Abs($num)
            $results += [PSCustomObject]@{
                Line = $i + 1
                Prop = $prop
                Val = $val.Trim()
                Num = $num
                Abs = $abs
                Mod8 = ($abs % 8)
            }
        }
    }
}

Write-Host "Total px values found in CSS: $($results.Count)"
$non8 = $results | Where-Object { $_.Abs -ne 0 -and $_.Mod8 -ne 0 }
Write-Host "Total non-8px px values: $($non8.Count)"

Write-Host "`nBreakdown of non-8px by property:"
$non8 | Group-Object Prop | Select-Object Name, Count | Format-Table -AutoSize

Write-Host "`nNon-8px properties in Spacing (margin, padding, gap, top, bottom, left, right):"
$spacingProps = $non8 | Where-Object { $_.Prop -match '^(margin|padding|gap|row-gap|column-gap|top|bottom|left|right)' }
Write-Host "Count: $($spacingProps.Count)"
if ($spacingProps.Count -gt 0) {
    $spacingProps | Format-Table Line, Prop, Val, Num -AutoSize
}

Write-Host "`nNon-8px properties in Dimensions (width, height, min-width, min-height, max-width, max-height):"
$dimProps = $non8 | Where-Object { $_.Prop -match '^(width|height|min-width|min-height|max-width|max-height)' }
Write-Host "Count: $($dimProps.Count)"
if ($dimProps.Count -gt 0) {
    $dimProps | Format-Table Line, Prop, Val, Num -AutoSize
}

Write-Host "`nNon-8px properties in other properties (border, border-radius, font-size, box-shadow, etc.):"
$otherProps = $non8 | Where-Object { $_.Prop -notmatch '^(margin|padding|gap|row-gap|column-gap|top|bottom|left|right|width|height|min-width|min-height|max-width|max-height)' }
Write-Host "Count: $($otherProps.Count)"
$otherProps | Group-Object Prop | Select-Object Name, Count | Format-Table -AutoSize
