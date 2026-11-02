param(
    [string]$file = "courses/freelancing-mastery.html"
)

$lines = Get-Content $file
$start = -1
$end = -1
for ($i = 0; $i -lt $lines.Length; $i++) {
    if ($lines[$i] -match '<footer') {
        $start = $i + 1
    }
    if ($lines[$i] -match '</footer>') {
        $end = $i + 1
    }
}
Write-Output "File: $file"
Write-Output "Start: $start, End: $end"
if ($start -gt 0 -and $end -gt $start) {
    $lines[($start - 1)..($end - 1)] | Select-Object -First 40
}

