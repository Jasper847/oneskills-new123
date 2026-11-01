$lines = Get-Content 'assets/css/course-v2.css'
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*(width|height|min-width|min-height)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        if ($val -notmatch 'calc|%|vw|ch|em|rem|auto|none|max-content|min-content') {
            $pxMatches = [regex]::Matches($val, '(\d+(?:\.\d+)?)px')
            foreach ($m in $pxMatches) {
                $n = [double]$m.Groups[1].Value
                if ($n -gt 0 -and ($n % 8) -ne 0 -and $n -lt 500) {
                    Write-Host "$($i+1): $prop : $val"
                    break
                }
            }
        }
    }
}
