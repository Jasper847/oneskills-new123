$js = Get-Content assets/js/course-v3-core.js -Raw

Write-Host "=== JS Event Listeners & Selectors ==="
$selectors = @(
    "c-fee-plan-btn",
    "c-tuition-switcher__btn",
    "c-batch-slot-btn",
    "c-batch-selector__btn",
    "c-town-btn",
    "c-transit-tabs",
    "c-town-tabs__btn",
    "c-hero-card"
)

foreach ($s in $selectors) {
    $count = ([regex]::Matches($js, $s)).Count
    Write-Host "$s : $count occurrences"
}

