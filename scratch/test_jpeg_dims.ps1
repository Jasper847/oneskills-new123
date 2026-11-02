Add-Type -AssemblyName System.Drawing

# Test JPEG files first
$jpegFiles = @(
    "assets/images/courses/Programming-Course-dark.webp",
    "assets/images/courses/shopify-ecommerce-dark.webp"
)

foreach ($f in $jpegFiles) {
    $img = [System.Drawing.Image]::FromFile((Resolve-Path $f))
    Write-Host "$f : $($img.Width) x $($img.Height)"
    $img.Dispose()
}

