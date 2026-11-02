$cohortA = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/ai-tools-automation.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html"
)

foreach ($f in $cohortA) {
    $content = Get-Content $f -Raw
    if ($content -match '(?s)(<div class="c-hero-card">.*?</div>\s*</div>\s*</div>)') {
        Write-Host "================== $f =================="
        # Print first 35 lines of hero card
        $lines = ($matches[1] -split "`r?`n")
        $lines[0..[Math]::Min(35, $lines.Length - 1)] -join "`r`n"
    }
}

