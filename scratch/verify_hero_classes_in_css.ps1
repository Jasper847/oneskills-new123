$css = Get-Content assets/css/course-v3-core.css -Raw

$classesToCheck = @(
    "c-hero-grid",
    "c-hero-content",
    "c-hero-badge-row",
    "c-hero-title",
    "c-hero-lead",
    "c-hero-telemetry",
    "c-hero-cta-group",
    "c-hero-notice",
    "c-hero-card",
    "c-hero-card-media",
    "c-hero-card-meta",
    "c-hero-card-features",
    "c-facts-strip",
    "c-facts-grid",
    "c-fact-cell"
)

foreach ($cls in $classesToCheck) {
    $found = $css -match "\.$cls\b"
    Write-Host ".$cls : $found"
}

