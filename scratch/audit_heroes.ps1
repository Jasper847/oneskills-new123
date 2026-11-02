$courses = Get-ChildItem courses/*.html | Where-Object { $_.Name -ne 'index.html' }
$results = @()

foreach ($c in $courses) {
    $content = Get-Content $c.FullName -Raw
    
    # Extract the hero section
    $heroSection = ""
    if ($content -match '(?s)(<section[^>]*class="[^"]*hero[^"]*"[^>]*>.*?</section>)') {
        $heroSection = $matches[1]
    }
    
    # Check for images in hero
    $imgMatches = [regex]::Matches($heroSection, '<img[^>]+src="([^"]+)"')
    $imgList = @()
    foreach ($m in $imgMatches) {
        $imgList += $m.Groups[1].Value
    }
    
    # Check structure markers
    $hasV3Container = $heroSection -match 'course-v3-container'
    $hasHeroGrid = $heroSection -match 'c-hero-grid'
    $hasHeroInner = $heroSection -match 'c-hero__inner'
    $hasHeroCardMedia = $heroSection -match 'c-hero-card-media'
    $hasTuitionCard = $heroSection -match 'c-tuition-card'
    
    # Check CSS references in <head>
    $cssMatches = [regex]::Matches($content, '<link[^>]+rel="stylesheet"[^>]+href="([^"]+)"')
    $cssList = @()
    foreach ($cm in $cssMatches) {
        $cssList += [System.IO.Path]::GetFileName($cm.Groups[1].Value)
    }

    $results += [PSCustomObject]@{
        Course = $c.Name
        GridType = if ($hasHeroGrid) { "c-hero-grid" } elseif ($hasHeroInner) { "c-hero__inner" } else { "Other" }
        HasHeroMedia = $hasHeroCardMedia
        HasTuitionInHero = $hasTuitionCard
        HeroImages = if ($imgList.Count -gt 0) { ($imgList -join ", ") } else { "NONE" }
        Stylesheets = ($cssList -join ", ")
    }
}

$results | Format-Table -AutoSize

