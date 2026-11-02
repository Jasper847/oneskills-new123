$content = Get-Content courses/freelancing-mastery.html -Raw
if ($content -match '(?s)(<div class="c-hero-card-media">.*?</div>)') {
    Write-Host "Freelancing hero card media:"
    Write-Host $matches[1]
}

# Also check how JS handles image theme switching if at all
$jsCore = Get-Content assets/js/course-v3-core.js -Raw
$jsHasThemeImg = $jsCore -match 'dark\.webp|light\.webp'
Write-Host "JS has theme image switching: $jsHasThemeImg"

$jsMain = Get-Content assets/js/main.js -Raw
$jsMainHasThemeImg = $jsMain -match 'dark\.webp|light\.webp'
Write-Host "main.js has theme image switching: $jsMainHasThemeImg"

