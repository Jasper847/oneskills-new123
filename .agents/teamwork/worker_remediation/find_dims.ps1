$lines = Get-Content 'assets/css/course-v2.css'
for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    if ($line -match '^\s*(width|height|min-width|min-height)\s*:\s*(\d+)px\s*;') {
        $n = [int]$matches[2]
        if ($n % 8 -ne 0) {
            Write-Host "$($i+1): $($matches[1]): ${n}px"
        }
    }
}
