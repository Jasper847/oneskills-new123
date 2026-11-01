$lines = Get-Content 'assets/css/course-v2.css'
Write-Host "--- ALL REMAINING SPACING VIOLATIONS ---"
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*(margin(?:-top|-bottom|-left|-right)?|padding(?:-top|-bottom|-left|-right)?|gap|column-gap|row-gap|top|bottom|left|right)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        $pxMatches = [regex]::Matches($val, '(-?\d+(?:\.\d+)?)px')
        foreach ($m in $pxMatches) {
            $n = [double]$m.Groups[1].Value
            $abs = [Math]::Abs($n)
            if ($abs -ne 0 -and ($abs % 8) -ne 0) {
                Write-Host "$($i+1): $prop : $val"
                break
            }
        }
    }
}

Write-Host "`n--- ALL REMAINING COLOR VIOLATIONS ---"
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*(color|background|background-color|border|border-color|border-top|border-bottom|border-left|border-right|box-shadow)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        $stripped = [regex]::Replace($val, 'var\([^)]+\)', '')
        if ($stripped -match '#[0-9a-fA-F]{3,8}|rgba?\([^)]+\)') {
            if ($line -notmatch '--[a-zA-Z0-9_-]+:') {
                Write-Host "$($i+1): $prop : $val"
            }
        }
    }
}
