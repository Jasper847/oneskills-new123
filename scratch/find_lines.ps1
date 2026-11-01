$patterns = @{
    "Metadata & SEO" = 'name="description"'
    "JSON-LD Schema" = 'application/ld\+json'
    "Hero Section" = 'class="c-hero-v2'
    "Facts Strip" = 'class="c-hero-stats'
    "Subnav Anchor" = 'c-subnav'
    "Overview Section" = 'id="overview"'
    "Method / 4-Stage" = 'id="method"'
    "Benefits Bar" = 'class="c-benefits-bar'
    "Curriculum Blueprint" = 'id="curriculum"'
    "Deliverables HUD" = 'id="deliverables"'
    "Internship Section" = 'id="internship"'
    "Comparison Section" = 'id="comparison"'
    "Campus Studio & Specs" = 'id="specs"'
    "Reviews Proof Card" = 'id="reviews"'
    "Admissions Section" = 'id="admissions"'
    "FAQ Section" = 'id="faq"'
}

foreach ($key in $patterns.Keys) {
    $m = Select-String -Path 'courses/freelancing-mastery.html' -Pattern $patterns[$key] | Select-Object -First 1
    if ($m) {
        Write-Host "$key : Line $($m.LineNumber)"
    }
}

