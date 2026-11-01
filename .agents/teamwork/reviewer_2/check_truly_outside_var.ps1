$lines = Get-Content 'assets\css\course-v2.css'

$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})\b|rgba?\([^)]+\)|hsla?\([^)]+\))'

function Remove-VarCalls([string]$str) {
    # Recursively remove var(...) handling balanced parentheses
    while ($true) {
        $idx = $str.IndexOf("var(")
        if ($idx -lt 0) { break }
        
        # Find matching closing paren
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
            # Unbalanced var(
            break
        }
    }
    return $str
}

$trulyOutsideVar = @()

for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*--' -or $line -match '^\s*/\*' -or $line -match '\*/') {
        continue
    }
    
    $cleanLine = Remove-VarCalls $line
    $m = $colorRegex.Matches($cleanLine)
    if ($m.Count -gt 0) {
        foreach ($match in $m) {
            $trulyOutsideVar += "Line $($i+1): $line (Found outside var: $($match.Value))"
        }
    }
}

Write-Host "Total raw colors truly outside var(): $($trulyOutsideVar.Count)"
$trulyOutsideVar | ForEach-Object { Write-Host $_ }
