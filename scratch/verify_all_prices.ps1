$matrix = @(
    @{ File = "courses/freelancing-mastery.html"; ExpectedFull = 28000; ExpectedInstall = 14000 },
    @{ File = "courses/ai-web-development.html"; ExpectedFull = 35000; ExpectedInstall = 17500 },
    @{ File = "courses/ai-tools-automation.html"; ExpectedFull = 20000; ExpectedInstall = 10000 },
    @{ File = "courses/crypto-trading.html"; ExpectedFull = 35000; ExpectedInstall = 17500 },
    @{ File = "courses/forex-trading.html"; ExpectedFull = 35000; ExpectedInstall = 17500 },
    @{ File = "courses/web3-blockchain.html"; ExpectedFull = 40000; ExpectedInstall = 20000 },
    @{ File = "courses/ai-based-computer-course.html"; ExpectedFull = 15000; ExpectedInstall = 7500 },
    @{ File = "courses/programming-js-cpp.html"; ExpectedFull = 25000; ExpectedInstall = 12500 },
    @{ File = "courses/shopify-ecommerce.html"; ExpectedFull = 30000; ExpectedInstall = 15000 }
)

$report = @()

foreach ($item in $matrix) {
    $c = Get-Content $item.File -Raw
    
    # Check schema price
    $schemaPrice = if ($c -match '"price":\s*"(\d+)"') { [int]$matches[1] } else { 0 }
    
    # Check body data-fee-full
    $bodyFull = if ($c -match 'data-fee-full="PKR\s*([0-9,]+)"') { [int]($matches[1] -replace ',','') } else { 0 }
    
    # Format strings
    $fullFormatted = "{0:N0}" -f $item.ExpectedFull
    $installFormatted = "{0:N0}" -f $item.ExpectedInstall
    
    $fullMatches = [regex]::Matches($c, "PKR\s*$fullFormatted").Count
    $installMatches = [regex]::Matches($c, "PKR\s*$installFormatted").Count
    
    $matchExpected = ($schemaPrice -eq $item.ExpectedFull) -and ($bodyFull -eq $item.ExpectedFull)
    
    $report += [PSCustomObject]@{
        Course = Split-Path $item.File -Leaf
        Expected = $item.ExpectedFull
        SchemaPrice = $schemaPrice
        BodyAttr = $bodyFull
        FullPriceMentions = $fullMatches
        InstallPriceMentions = $installMatches
        PriceSynced = $matchExpected
    }
}

$report | Format-Table -AutoSize

