$matches = Select-String -Path 'courses/freelancing-mastery.html' -Pattern 'workstation|Core i7|96|25,000|25000|4\.9|10[–-]12|Seats Left'
foreach ($m in $matches) {
    Write-Output "$($m.LineNumber): $($m.Line.Trim())"
}

