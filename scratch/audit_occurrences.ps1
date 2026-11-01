$fileCourse = Get-Content 'courses/freelancing-mastery.html'
$fileToS = Get-Content 'terms-of-service.html'
$fileJS = Get-Content 'assets/js/course-v2.js'

Write-Host "================== REFUND REFERENCES =================="
$refundMatches = Select-String -Path 'courses/freelancing-mastery.html' -Pattern 'refund|14-day|14 day'
foreach ($m in $refundMatches) {
    Write-Host "Line $($m.LineNumber): $($m.Line.Trim())"
}

Write-Host "`n================== INSTALLMENT REFERENCES =================="
$instMatches = Select-String -Path 'courses/freelancing-mastery.html', 'assets/js/course-v2.js' -Pattern '14,000|installment|two payments|2 payments'
foreach ($m in $instMatches) {
    Write-Host "$($m.Filename) Line $($m.LineNumber): $($m.Line.Trim())"
}

Write-Host "`n================== INTERNSHIP REFERENCES & CONDITIONS =================="
$internMatches = Select-String -Path 'courses/freelancing-mastery.html' -Pattern 'internship|unpaid|extend|attendance|performance|eligibility'
foreach ($m in $internMatches) {
    Write-Host "Line $($m.LineNumber): $($m.Line.Trim())"
}

Write-Host "`n================== INFRASTRUCTURE & STUDIO CLAIMS =================="
$infraMatches = Select-String -Path 'courses/freelancing-mastery.html' -Pattern 'generator|20kVA|kVA|fiber|optical|air-conditioned|air conditioning|studio|facility|monitors|dual'
foreach ($m in $infraMatches) {
    Write-Host "Line $($m.LineNumber): $($m.Line.Trim())"
}

Write-Host "`n================== INSTRUCTOR CREDENTIALS =================="
$instrucMatches = Select-String -Path 'courses/freelancing-mastery.html' -Pattern 'Nisar|Mehar|7\+|8\+|years|founder|CEO|160\+|alumni'
foreach ($m in $instrucMatches) {
    Write-Host "Line $($m.LineNumber): $($m.Line.Trim())"
}

Write-Host "`n================== ADMISSIONS / DATES =================="
$dateMatches = Select-String -Path 'courses/freelancing-mastery.html', 'assets/js/course-v2.js' -Pattern 'Cohort #15|November|Nov 1|2026-11|validFrom|start date'
foreach ($m in $dateMatches) {
    Write-Host "$($m.Filename) Line $($m.LineNumber): $($m.Line.Trim())"
}

