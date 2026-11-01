$c = Get-Content 'courses\freelancing-mastery.html' -Raw
$modules = ([regex]::Matches($c, 'Module \d\d')).Count
$lessons = ([regex]::Matches($c, 'class="c-lesson-item')).Count
$pkr25k = ([regex]::Matches($c, 'PKR 25,000')).Count
$pkr12k = ([regex]::Matches($c, '2 installments of PKR 12,500')).Count

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

$missingIds = @()
foreach ($id in $ids) {
  if ($c -notmatch ('id="' + $id + '"')) {
    $missingIds += $id
  }
}

Write-Host "Modules (should be 12): $modules"
Write-Host "Lessons (should be 84): $lessons"
Write-Host "PKR 25,000 count: $pkr25k"
Write-Host "PKR 12,500 count: $pkr12k"
Write-Host "Missing IDs count: $($missingIds.Count)"
if ($missingIds.Count -gt 0) {
  Write-Host "Missing IDs: $($missingIds -join ', ')"
}
