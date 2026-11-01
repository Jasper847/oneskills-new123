# Test interaction on freelancing-mastery vs web3-blockchain

$url1 = "http://localhost:8080/courses/freelancing-mastery.html"
$url2 = "http://localhost:8080/courses/web3-blockchain.html"

# Check HTML IDs and Classes present
$c1 = Get-Content "courses/freelancing-mastery.html" -Raw
$c2 = Get-Content "courses/web3-blockchain.html" -Raw

Write-Host "=== FREELANCING MASTERY ==="
Write-Host "Has syllabus-search: $($c1.Contains('id="syllabus-search"'))"
Write-Host "Has curriculum-filter-tabs: $($c1.Contains('id="curriculum-filter-tabs"'))"
Write-Host "Has c-phase-item: $($c1.Contains('c-phase-item'))"
Write-Host "Has btn-fee-full: $($c1.Contains('id="btn-fee-full"'))"
Write-Host "Has c-subnav-link: $($c1.Contains('c-subnav-link'))"

Write-Host "`n=== WEB3 BLOCKCHAIN ==="
Write-Host "Has syllabus-search: $($c2.Contains('id="syllabus-search"'))"
Write-Host "Has curriculum-search: $($c2.Contains('id="curriculum-search"'))"
Write-Host "Has curriculum-filter-tabs: $($c2.Contains('id="curriculum-filter-tabs"'))"
Write-Host "Has c-phase-item: $($c2.Contains('c-phase-item'))"
Write-Host "Has c-accordion-item: $($c2.Contains('c-accordion-item'))"
Write-Host "Has btn-fee-full: $($c2.Contains('id="btn-fee-full"'))"
Write-Host "Has c-tuition-switcher: $($c2.Contains('c-tuition-switcher'))"
Write-Host "Has c-subnav-link: $($c2.Contains('c-subnav-link'))"
Write-Host "Has c-subnav__link: $($c2.Contains('c-subnav__link'))"

