$lines = Get-Content 'assets/css/course-v2.css'
$items = @()

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    $lineNum = $i + 1
    if ($line -match '^\s*(margin(?:-top|-bottom|-left|-right)?|padding(?:-top|-bottom|-left|-right)?|gap|column-gap|row-gap|top|bottom|left|right)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        $pxMatches = [regex]::Matches($val, '(-?\d+(?:\.\d+)?)px')
        $hasViolation = $false
        foreach ($m in $pxMatches) {
            $n = [double]$m.Groups[1].Value
            $abs = [Math]::Abs($n)
            if ($abs -ne 0 -and ($abs % 8) -ne 0) {
                $hasViolation = $true
                break
            }
        }
        if ($hasViolation) {
            $items += [PSCustomObject]@{
                Line = $lineNum
                Prop = $prop
                Val = $val.Trim()
            }
        }
    }
}

$items | Export-Csv -Path '.agents/teamwork/worker_remediation/spacing_violations.csv' -NoTypeInformation
Write-Host "Exported $($items.Count) spacing violations to spacing_violations.csv"
