$courses = @(
    "crypto-trading.html",
    "forex-trading.html",
    "web3-blockchain.html",
    "shopify-ecommerce.html"
)

foreach ($c in $courses) {
    $content = Get-Content "courses/$c" -Raw
    Write-Host "=== $c ==="
    $hasBatchSlotBtn = $content -match 'c-batch-slot-btn'
    $hasBatchSelectorBtn = $content -match 'c-batch-selector'
    $hasTownBtn = $content -match 'c-town-btn'
    $hasTownTabs = $content -match 'c-town-tabs'
    
    Write-Host "  c-batch-slot-btn: $hasBatchSlotBtn"
    Write-Host "  c-batch-selector: $hasBatchSelectorBtn"
    Write-Host "  c-town-btn: $hasTownBtn"
    Write-Host "  c-town-tabs: $hasTownTabs"
}

