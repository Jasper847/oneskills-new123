$c = Get-Content "index.html" -Raw
$reviewers = @("Usman Joyia", "Ashfaq Ahmad", "FAIZZAN Cheema", "Hamza Rajpoot", "Wajeeha", "Maliha Asif", "Ali Raza", "Awais")
foreach ($r in $reviewers) {
    if ($c -match [regex]::Escape($r)) {
        Write-Host "Found $r in index.html"
        # Find context around reviewer
        $idx = $c.IndexOf($r)
        if ($idx -ge 0) {
            $start = [Math]::Max(0, $idx - 150)
            $len = [Math]::Min(350, $c.Length - $start)
            Write-Host " Context: $($c.Substring($start, $len).Replace("`n", ' '))" -ForegroundColor Gray
        }
    } else {
        Write-Host "Missing $r in index.html" -ForegroundColor Red
    }
}
