$courses = @(
    "freelancing-mastery.html",
    "ai-web-development.html",
    "ai-tools-automation.html",
    "programming-js-cpp.html",
    "ai-based-computer-course.html",
    "crypto-trading.html",
    "forex-trading.html",
    "web3-blockchain.html",
    "shopify-ecommerce.html"
)

$report = @()
foreach ($c in $courses) {
    $path = "courses/$c"
    $content = Get-Content $path -Raw
    
    # Stylesheets
    $cssMatches = [regex]::Matches($content, '<link[^>]+rel="stylesheet"[^>]+href="([^"]+)"')
    $css = ($cssMatches | ForEach-Object { [System.IO.Path]::GetFileName($_.Groups[1].Value) }) -join ", "
    
    # Sections in order
    $sectionMatches = [regex]::Matches($content, '<section[^>]*id="([^"]+)"|<section[^>]*class="([^"]+)"')
    $sections = ($sectionMatches | ForEach-Object { 
        if ($_.Groups[1].Value) { "#" + $_.Groups[1].Value } else { "." + ($_.Groups[2].Value -split " ")[0] }
    }) -join " -> "
    
    # Hero Right element
    $heroRight = "Unknown"
    if ($content -match '(?s)<section[^>]*class="[^"]*hero[^"]*"[^>]*>(.*?)</section>') {
        $heroBody = $matches[1]
        if ($heroBody -match 'c-hero-card-media') {
            $heroRight = "c-hero-card (Media + Feats)"
        } elseif ($heroBody -match 'c-tuition-card') {
            $heroRight = "c-tuition-card (Fee Switcher in Hero)"
        }
    }
    
    # Check if there is a separate #admissions section
    $hasAdmissions = $content -match 'id="admissions"'

    $report += [PSCustomObject]@{
        Course = $c
        Stylesheets = $css
        HeroRightColumn = $heroRight
        HasAdmissionsSection = $hasAdmissions
        SectionOrder = $sections
    }
}

$report | Format-List

