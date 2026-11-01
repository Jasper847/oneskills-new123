$ids = @(
    'batch-slot-title',
    'batch-seats-badge',
    'batch-audience-note',
    'card-wa-btn-text',
    'card-wa-cta',
    'fee-display-amount',
    'fee-display-sub',
    'map-route-badge',
    'town-commute-title',
    'town-commute-desc'
)

$content = [System.IO.File]::ReadAllText("courses/freelancing-mastery.html")
$allFound = $true

foreach ($id in $ids) {
    if ($content -match [regex]::Escape($id)) {
        Write-Host "FOUND: $id"
    } else {
        Write-Host "MISSING: $id" -ForegroundColor Red
        $allFound = $false
    }
}

# Check style attributes
$styleMatches = [regex]::Matches($content, 'style\s*=\s*"[^"]*"')
Write-Host "Total inline style attributes remaining: $($styleMatches.Count)"

# Check pricing numbers
$prices = @('PKR 25,000', '2 installments of PKR 12,500', 'PKR 8,500 / mo')
foreach ($p in $prices) {
    if ($content -match [regex]::Escape($p)) {
        Write-Host "PRICE PRESERVED: $p"
    } else {
        Write-Host "PRICE MISSING: $p" -ForegroundColor Red
    }
}

# Check module count & lesson count
$moduleMatches = [regex]::Matches($content, 'class="c-phase-item module-accordion"')
Write-Host "Total modules found: $($moduleMatches.Count) (expected 12)"

$lessonMatches = [regex]::Matches($content, 'class="c-lesson-item lesson-item"')
Write-Host "Total lessons found: $($lessonMatches.Count) (expected 84)"
