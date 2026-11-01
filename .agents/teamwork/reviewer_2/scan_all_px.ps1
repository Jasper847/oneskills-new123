$css = Get-Content 'assets\css\course-v2.css'

# Let's inspect all lines with any px values
$allNon8 = @()
for ($i = 0; $i -lt $css.Length; $i++) {
    $line = $css[$i]
    # Skip comments, tokens, font-size, border widths (1px, 2px), border-radius, box-shadow blur/spread
    if ($line -match '^\s*--' -or $line -match '^\s*/\*' -or $line -match '\*/' -or $line -match '@keyframes') {
        continue
    }
    
    # Check margin, padding, gap, top, bottom, left, right, width, height
    if ($line -match '(?i)(margin|padding|gap|top|bottom|left|right|width|height)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        
        # Exclude font-size, border-*, outline-*
        if ($prop -match '(?i)(font|border|outline)') { continue }
        
        $pxs = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxs) {
            $n = [int]$px.Groups[1].Value
            $abs = [Math]::Abs($n)
            if ($abs -ne 0 -and ($abs % 8 -ne 0)) {
                $allNon8 += "Line $($i+1): $line (Value: ${n}px)"
            }
        }
    }
}

Write-Host "Total non-8px instances found across all margin/padding/gap/top/bottom/left/right/width/height:"
$allNon8 | ForEach-Object { Write-Host $_ }
