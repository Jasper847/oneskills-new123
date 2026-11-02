$cssFiles = @(
    "assets/css/course-v3-core.css",
    "assets/css/course-v2.css",
    "assets/css/main.css",
    "assets/css/refinement.css"
)

foreach ($f in $cssFiles) {
    if (Test-Path $f) {
        $content = Get-Content $f -Raw
        $heroCardMedia = $content -match '\.c-hero-card-media'
        $heroGrid = $content -match '\.c-hero-grid'
        $heroInner = $content -match '\.c-hero__inner'
        $heroCard = $content -match '\.c-hero-card\b'
        $heroCardBEM = $content -match '\.c-hero__card\b'
        
        Write-Host "File: $f"
        Write-Host "  .c-hero-grid: $heroGrid"
        Write-Host "  .c-hero__inner: $heroInner"
        Write-Host "  .c-hero-card: $heroCard"
        Write-Host "  .c-hero__card: $heroCardBEM"
        Write-Host "  .c-hero-card-media: $heroCardMedia"
    }
}

