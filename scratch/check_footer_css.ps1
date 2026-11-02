$classes = @(
    "footer-wrap",
    "footer-container",
    "footer-top-grid",
    "footer-brand-col",
    "footer-brand-name",
    "brand-pk",
    "footer-brand-sub",
    "footer-desc",
    "footer-social-icons-grid",
    "social-icon-btn",
    "footer-brand-tagline-wrap",
    "footer-brand-dash",
    "footer-brand-tagline",
    "footer-col",
    "footer-links-list",
    "footer-nav-item",
    "footer-nav-arrow",
    "footer-campus-list",
    "campus-info-item",
    "campus-item-icon",
    "campus-item-text",
    "campus-item-label",
    "campus-item-val",
    "footer-bottom-bar",
    "footer-legal-links",
    "legal-divider",
    "footer-back-to-top",
    "back-to-top-icon",
    "footer-hiran-wrap",
    "footer-hiran-img",
    "footer-hiran-fade",
    "footer-hiran-badge",
    "hiran-badge-city",
    "hiran-badge-home",
    "hiran-badge-line"
)

$mainCss = Get-Content "assets/css/main.css" -Raw

foreach ($cls in $classes) {
    $found = $mainCss -match [regex]::Escape($cls)
    Write-Output "$cls : $found"
}

