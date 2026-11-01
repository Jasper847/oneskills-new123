$lines = Get-Content 'assets/css/course-v2.css'
$items = @()

for ($i = 0; $i -lt $lines.Count; $i++) {
    $line = $lines[$i]
    $lineNum = $i + 1
    if ($line -match '^\s*(width|height|min-width|min-height)\s*:\s*([^;]+);') {
        $prop = $matches[1]
        $val = $matches[2]
        if ($val -notmatch 'calc|%|vw|ch|em|rem|auto|none|max-content|min-content') {
            $pxMatches = [regex]::Matches($val, '(\d+(?:\.\d+)?)px')
            foreach ($m in $pxMatches) {
                $n = [double]$m.Groups[1].Value
                if ($n -gt 0 -and ($n % 8) -ne 0 -and $n -lt 500) {
                    $items += [PSCustomObject]@{
                        Line = $lineNum
                        Prop = $prop
                        Val = $val.Trim()
                    }
                    break
                }
            }
        }
    }
}

$items | Export-Csv -Path '.agents/teamwork/worker_remediation/dim_violations.csv' -NoTypeInformation
Write-Host "Exported $($items.Count) dimension violations"
$items | Group-Object Val | Sort-Object Count -Descending | Select-Object Count, Name | Format-Table -AutoSize
