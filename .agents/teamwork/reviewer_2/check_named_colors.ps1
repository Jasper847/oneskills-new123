$lines = Get-Content 'assets\css\course-v2.css'

$namedColors = '\b(white|black|red|green|blue|yellow|orange|purple|gray|grey)\b'

function Remove-VarCalls([string]$str) {
    while ($true) {
        $idx = $str.IndexOf("var(")
        if ($idx -lt 0) { break }
        
        $depth = 0
        $endIdx = -1
        for ($j = $idx + 3; $j -lt $str.Length; $j++) {
            if ($str[$j] -eq '(') { $depth++ }
            elseif ($str[$j] -eq ')') {
                $depth--
                if ($depth -eq 0) {
                    $endIdx = $j
                    break
                }
            }
        }
        
        if ($endIdx -ge 0) {
            $str = $str.Substring(0, $idx) + "VAR_REPLACED" + $str.Substring($endIdx + 1)
        } else {
            break
        }
    }
    return $str
}

$namedOutsideVar = @()

for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*--' -or $line -match '^\s*/\*' -or $line -match '\*/') {
        continue
    }
    
    $cleanLine = Remove-VarCalls $line
    if ($cleanLine -match '(?i)(?:color|background|border|fill|stroke|outline)\s*:\s*([^;]+);') {
        $val = $matches[1]
        $m = [regex]::Matches($val, $namedColors, [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)
        foreach ($match in $m) {
            $namedOutsideVar += "Line $($i+1): $line (Found named color outside var: $($match.Value))"
        }
    }
}

Write-Host "Total named colors outside var(): $($namedOutsideVar.Count)"
$namedOutsideVar | ForEach-Object { Write-Host $_ }
