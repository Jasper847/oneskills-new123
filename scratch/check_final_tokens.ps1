$patterns = @('8\+ Years', 'Over 8 years', '80%', '20kVA', 'Dedicated Optical Fiber', 'Cohort #15', 'November 18', 'validFrom', 'batch start')
foreach ($p in $patterns) {
    $res = Select-String -Path 'courses/freelancing-mastery.html' -Pattern $p
    foreach ($r in $res) {
        Write-Host "Pattern: $p | Line $($r.LineNumber): $($r.Line.Trim())"
    }
}

