$files = @(
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

foreach ($f in $files) {
    Write-Host "=== $f ===" -ForegroundColor Cyan
    $c = Get-Content $f -Raw
    
    $bodyClass = ""
    if ($c -match '<body[^>]*class="([^"]*)"') { $bodyClass = $matches[1] }
    
    $headerClass = ""
    if ($c -match '<header[^>]*class="([^"]*)"') { $headerClass = $matches[1] }
    
    $hasHeaderInner = $c.Contains('class="header-inner"')
    $hasSiteHeaderInner = $c.Contains('class="site-header__inner"')
    
    $hasBreadcrumbs = $c.Contains('c-breadcrumbs')
    $hasBreadcrumb = $c.Contains('c-breadcrumb')
    
    $hasTuitionCard = $c.Contains('c-tuition-card')
    $hasExecutiveCard = $c.Contains('executive-cohort-card')
    $hasCohortCard = $c.Contains('c-cohort-card')
    
    $hasMobileDock = $c.Contains('c-mobile-dock')
    $hasMobileBar = $c.Contains('c-mobile-sticky-bar')
    $hasStickyApply = $c.Contains('c-sticky-apply-bar')

    [PSCustomObject]@{
        BodyClass = $bodyClass
        HeaderClass = $headerClass
        HeaderInner = if ($hasSiteHeaderInner) { "site-header__inner" } elseif ($hasHeaderInner) { "header-inner" } else { "other" }
        Breadcrumb = if ($hasBreadcrumbs) { "c-breadcrumbs" } elseif ($hasBreadcrumb) { "c-breadcrumb" } else { "none" }
        TuitionCard = if ($hasTuitionCard) { "c-tuition-card" } elseif ($hasExecutiveCard) { "executive-cohort-card" } elseif ($hasCohortCard) { "c-cohort-card" } else { "other" }
        MobileDock = if ($hasMobileDock) { "c-mobile-dock" } elseif ($hasMobileBar) { "c-mobile-sticky-bar" } elseif ($hasStickyApply) { "c-sticky-apply-bar" } else { "none" }
    } | Format-List
}

