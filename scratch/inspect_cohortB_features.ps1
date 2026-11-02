$bCourses = @(
    "crypto-trading.html",
    "forex-trading.html",
    "web3-blockchain.html",
    "shopify-ecommerce.html"
)

foreach ($c in $bCourses) {
    $content = Get-Content "courses/$c" -Raw
    Write-Host "================== $c =================="
    
    # Title
    if ($content -match '<h1[^>]*>(.*?)</h1>') {
        Write-Host "Title: " ($matches[1] -replace '<[^>]+>', '')
    }
    
    # Fee & Duration
    if ($content -match 'data-fee-full="([^"]+)"') {
        Write-Host "Fee Full: $($matches[1])"
    }
    if ($content -match 'data-fee-install="([^"]+)"') {
        Write-Host "Fee Install: $($matches[1])"
    }
    
    # Tuition card features
    if ($content -match '(?s)<ul class="c-tuition-card__features"[^>]*>(.*?)</ul>') {
        Write-Host "Hero Tuition Card Items:"
        $items = [regex]::Matches($matches[1], '(?s)<li>(.*?)</li>')
        foreach ($it in $items) {
            $txt = ($it.Groups[1].Value -replace '<[^>]+>', ' ') -replace '\s+', ' '
            Write-Host "  * " $txt.Trim()
        }
    }
}

