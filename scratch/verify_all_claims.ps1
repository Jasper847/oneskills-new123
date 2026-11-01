$files = @('courses/freelancing-mastery.html', 'terms-of-service.html', 'assets/js/course-v2.js')

Write-Host "=== REFUND TRIGGER SCAN ==="
Select-String -Path $files -Pattern 'refund|money-back' | ForEach-Object {
    Write-Host "$($_.Filename):$($_.LineNumber) -> $($_.Line.Trim())"
}

Write-Host "`n=== PERCENTAGE / ATTENDANCE SCAN ==="
Select-String -Path $files -Pattern '80%|attendance requirement|two weeks|2 weeks' | ForEach-Object {
    Write-Host "$($_.Filename):$($_.LineNumber) -> $($_.Line.Trim())"
}

Write-Host "`n=== INSTRUCTOR YEARS SCAN ==="
Select-String -Path $files -Pattern 'years|year' | Where-Object { $_.Line -match 'Nisar|experience|Strategy' } | ForEach-Object {
    Write-Host "$($_.Filename):$($_.LineNumber) -> $($_.Line.Trim())"
}

Write-Host "`n=== INFRASTRUCTURE EXACT SPEC SCAN ==="
Select-String -Path $files -Pattern 'kVA|fiber|optical|generator|5GHz|surge-protected' | ForEach-Object {
    Write-Host "$($_.Filename):$($_.LineNumber) -> $($_.Line.Trim())"
}

Write-Host "`n=== COHORT / DATE SCAN ==="
Select-String -Path $files -Pattern 'Cohort|November|Nov |validFrom|batch schedule' | ForEach-Object {
    Write-Host "$($_.Filename):$($_.LineNumber) -> $($_.Line.Trim())"
}

