$bemClasses = @(
    "c-hero__inner",
    "c-tuition-card",
    "c-tuition-switcher",
    "c-subnav__inner",
    "c-subnav__link",
    "c-bento-grid",
    "c-bento-card",
    "c-accordion-item",
    "c-tools-grid",
    "c-tool-card",
    "c-pricing-grid",
    "c-pricing-card",
    "c-commuter-panel",
    "c-commuter-tab",
    "c-faq-accordion"
)

$css = Get-Content "assets/css/course-v3-core.css" -Raw

foreach ($cls in $bemClasses) {
    $has = $css.Contains(".$cls")
    Write-Host ".$cls in course-v3-core.css: $has"
}

