$css = Get-Content 'assets\css\course-v2.css'
Write-Host "Total lines: $($css.Length)"

# 1. Check all dimensions >= 300px
Write-Host "`n--- Checking dimensions >= 300px ---"
$dimRegex = [regex]'(?i)^\s*(width|height|min-width|min-height|max-width|max-height)\s*:\s*([^;]+);'
for ($i = 0; $i -lt $css.Length; $i++) {
    $m = $dimRegex.Match($css[$i])
    if ($m.Success) {
        $prop = $m.Groups[1].Value
        $val = $m.Groups[2].Value
        $pxMatches = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxMatches) {
            $n = [int]$px.Groups[1].Value
            $abs = [Math]::Abs($n)
            if ($abs -ge 300 -and ($abs % 8 -ne 0)) {
                Write-Host "Line $($i+1): $prop : $val (Value $n is not divisible by 8)"
            }
        }
    }
}

# 2. Check all spacing/dimensions where value is 4px or non-divisible by 8
Write-Host "`n--- Checking spacing properties with 4px or non-8px ---"
$propRegex = [regex]'(?i)^\s*(margin(?:-(?:top|bottom|left|right))?|padding(?:-(?:top|bottom|left|right))?|gap|row-gap|column-gap|top|bottom|left|right|width|height|min-width|min-height|max-width|max-height)\s*:\s*([^;]+);'
$count4px = 0
$countNon8px = 0
for ($i = 0; $i -lt $css.Length; $i++) {
    $line = $css[$i]
    $m = $propRegex.Match($line)
    if ($m.Success) {
        $prop = $m.Groups[1].Value
        $val = $m.Groups[2].Value
        $pxMatches = [regex]::Matches($val, '(?<![a-zA-Z\-])(-?\d+)px')
        foreach ($px in $pxMatches) {
            $n = [int]$px.Groups[1].Value
            $abs = [Math]::Abs($n)
            if ($abs -eq 4) {
                $count4px++
                Write-Host "Line $($i+1) [4px]: $line"
            } elseif ($abs -ne 0 -and ($abs % 8 -ne 0)) {
                $countNon8px++
                Write-Host "Line $($i+1) [NON-8PX ($abs)]: $line"
            }
        }
    }
}
Write-Host "Total 4px spacing instances: $count4px"
Write-Host "Total non-8px/non-4px spacing instances: $countNon8px"
