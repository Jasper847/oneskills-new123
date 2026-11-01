# Character-by-character parser to strip var(...) expressions cleanly
function Remove-Vars($text) {
    $sb = [System.Text.StringBuilder]::new()
    $i = 0
    while ($i -lt $text.Length) {
        if ($i + 4 -le $text.Length -and $text.Substring($i, 4) -eq 'var(') {
            # Skip until matching closing paren
            $depth = 1
            $i += 4
            while ($i -lt $text.Length -and $depth -gt 0) {
                if ($text[$i] -eq '(') {
                    $depth++
                } elseif ($text[$i] -eq ')') {
                    $depth--
                }
                $i++
            }
            # replace with placeholder
            [void]$sb.Append("/*var*/")
        } else {
            [void]$sb.Append($text[$i])
            $i++
        }
    }
    return $sb.ToString()
}

$cssLines = Get-Content 'assets\css\course-v2.css'
$colorRegex = [regex]'(#(?:[0-9a-fA-F]{3,8})\b|rgba?\([^)]+\)|hsla?\([^)]+\))'
$leaks = @()

for ($lineIdx = 0; $lineIdx -lt $cssLines.Length; $lineIdx++) {
    $line = $cssLines[$lineIdx]
    if ($line -match '^\s*\/\*' -or $line -match '^\s*\*') { continue }
    if ($line -match '^\s*--[a-zA-Z0-9\-_]+\s*:') { continue } # CSS token definitions
    
    if ($line -match ':\s*([^;]+);') {
        $val = $matches[1]
        $cleanVal = Remove-Vars $val
        $matchesCol = $colorRegex.Matches($cleanVal)
        foreach ($m in $matchesCol) {
            $leaks += [PSCustomObject]@{
                Line = $lineIdx + 1
                Color = $m.Value
                RawLine = $line.Trim()
                CleanVal = $cleanVal.Trim()
            }
        }
    }
}

Write-Host "Total hardcoded colors outside var(): $($leaks.Count)"
if ($leaks.Count -gt 0) {
    foreach ($l in $leaks) {
        Write-Host "Line $($l.Line): $($l.Color) | $($l.RawLine)"
    }
} else {
    Write-Host "PASS: Zero hardcoded colors exist outside var() across all $($cssLines.Length) lines!"
}
