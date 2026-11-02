Add-Type -AssemblyName System.Drawing

$images = @(
    "freelancing-mastery-dark.webp",
    "ai-web-development-dark.webp",
    "ai-tools-automation-dark.webp",
    "computer-course-dark.webp",
    "Programming-Course-dark.webp",
    "crypto-trading-dark.webp",
    "crypto-trading-light.webp",
    "forex-trading-dark.webp",
    "forex-trading-light.webp",
    "web3-blockchain-dark.webp",
    "web3-blockchain-light.webp",
    "shopify-ecommerce-dark.webp",
    "shopify-ecommerce-light.webp"
)

$results = @()
foreach ($img in $images) {
    $file = "assets/images/courses/$img"
    if (Test-Path $file) {
        $item = Get-Item $file
        # Get dimensions using shell or file stream
        $results += [PSCustomObject]@{
            FileName = $img
            SizeBytes = $item.Length
            SizeKB = [math]::Round($item.Length / 1KB, 2)
            Exists = $true
        }
    } else {
        $results += [PSCustomObject]@{
            FileName = $img
            SizeBytes = 0
            SizeKB = 0
            Exists = $false
        }
    }
}

$results | Format-Table -AutoSize

