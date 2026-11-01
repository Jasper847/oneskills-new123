$courses = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/web3-blockchain.html",
    "courses/forex-trading.html",
    "courses/crypto-trading.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html"
)

foreach ($c in $courses) {
    Write-Host "==================================================" -ForegroundColor Yellow
    Write-Host "FILE: $c" -ForegroundColor Cyan
    Write-Host "==================================================" -ForegroundColor Yellow
    $text = Get-Content $c -Raw
    
    # Check Fees
    $fees = [regex]::Matches($text, 'PKR\s*[\d,]+(?:\s*(?:total|full|\/\s*month|\/\s*installment|×|\*|\+)[^\<\n\r]*)?') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[FEES]: $($fees -join ' | ')"

    # Check Duration / Hours
    $durations = [regex]::Matches($text, '\b(?:\d+\s*(?:Weeks?|Months?)|(?:P\d+W)|\d+\+?\s*(?:Hours?|Lessons?|Sessions?))\b') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[DURATION/HOURS]: $($durations -join ' | ')"

    # Check Batch Size & Wording
    $batch = [regex]::Matches($text, '(?i)(?:batch|cohort|admissions open|capped at|maximum \d+|\d+ seats|\d+ students|\d+ desks)[^\<\n\r]*') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[BATCH]: $($batch -join ' | ')"

    # Check Instructors
    $inst = [regex]::Matches($text, '(?i)(?:Nisar Mehar|Bilal Ashraf|Webio|Attique Hussain)[^\<\n\r]*') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[INSTRUCTORS]: $($inst -join ' | ')"

    # Check Ratings
    $ratings = [regex]::Matches($text, '(?i)(?:5\.0(?:\/5)?|\d+\s*reviews?|ratingCount[^\,\}\]]*)') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[RATINGS]: $($ratings -join ' | ')"

    # Check Laptop / BYOL
    $laptop = [regex]::Matches($text, '(?i)(?:laptop|BYOL|workstation|dedicated computer|core i7)[^\<\n\r]*') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[LAPTOP/BYOL]: $($laptop -join ' | ')"

    # Check Internship
    $intern = [regex]::Matches($text, '(?i)(?:internship|floor access|trade review)[^\<\n\r]*') | ForEach-Object { $_.Value.Trim() } | Select-Object -Unique
    Write-Host "[INTERNSHIP]: $($intern -join ' | ')"
}

