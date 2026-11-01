# Script to check inline styles and CSS spacing against 8px grid
$content = Get-Content -Path 'courses\freelancing-mastery.html' -Raw
$lines = Get-Content -Path 'courses\freelancing-mastery.html'

Write-Output "=== DETAILED INLINE STYLES AUDIT (courses/freelancing-mastery.html) ==="
for ($i = 0; $i -lt $lines.Count; $i++) {
    $lineNum = $i + 1
    $line = $lines[$i]
    if ($line -match 'style=["'']([^"'']+)["'']') {
        $style = $matches[1]
        Write-Output "Line $lineNum : $style"
    }
}
