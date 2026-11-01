$pages = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/web3-blockchain.html",
    "courses/forex-trading.html",
    "courses/crypto-trading.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html"
)

$brokenAssets = @()

foreach ($p in $pages) {
    $c = Get-Content $p -Raw
    
    # Check src
    $srcMatches = [regex]::Matches($c, 'src="([^"#?]+)"')
    foreach ($m in $srcMatches) {
        $val = $m.Groups[1].Value
        if ($val -notmatch '^http|^data:') {
            # Relative path from courses/
            $resolved = Join-Path "courses" $val
            # Normalize path
            $norm = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $resolved))
            if (-not (Test-Path $norm)) {
                $brokenAssets += [PSCustomObject]@{
                    File = (Split-Path $p -Leaf)
                    Type = "src"
                    Ref = $val
                    ResolvedPath = $norm.Replace((Get-Location).Path + "\", "")
                }
            }
        }
    }

    # Check href for css & local links
    $hrefMatches = [regex]::Matches($c, 'href="([^"#?]+)"')
    foreach ($m in $hrefMatches) {
        $val = $m.Groups[1].Value
        if ($val -notmatch '^http|^mailto:|^tel:|^#') {
            $resolved = Join-Path "courses" $val
            $norm = [System.IO.Path]::GetFullPath((Join-Path (Get-Location) $resolved))
            if (-not (Test-Path $norm)) {
                $brokenAssets += [PSCustomObject]@{
                    File = (Split-Path $p -Leaf)
                    Type = "href"
                    Ref = $val
                    ResolvedPath = $norm.Replace((Get-Location).Path + "\", "")
                }
            }
        }
    }
}

$brokenAssets | Select-Object -Unique File, Type, Ref, ResolvedPath | Format-Table -AutoSize

