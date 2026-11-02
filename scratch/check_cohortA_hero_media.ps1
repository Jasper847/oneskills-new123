$cohortA = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/ai-tools-automation.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html"
)

foreach ($f in $cohortA) {
    $content = Get-Content $f -Raw
    if ($content -match '(?s)(<div class="c-hero-card-media">.*?</div>)') {
        Write-Host "=== $f ==="
        Write-Host $matches[1]
    }
}

