$files = @(
  "courses/web3-blockchain.html",
  "courses/forex-trading.html",
  "courses/crypto-trading.html",
  "courses/shopify-ecommerce.html",
  "courses/index.html"
)
$css = Get-Content "assets/css/course-v3-core.css" -Raw
$classes = @{}
foreach ($f in $files) {
  $content = Get-Content $f -Raw
  $matches = [regex]::Matches($content, 'class="([^"]+)"')
  foreach ($m in $matches) {
    $tokens = $m.Groups[1].Value -split '\s+'
    foreach ($t in $tokens) {
      if ($t.StartsWith("c-") -or $t.StartsWith("brand-") -or $t.StartsWith("site-")) {
        $classes[$t] = $true
      }
    }
  }
}

$missing = @()
foreach ($c in $classes.Keys) {
  $pattern = [regex]::Escape("." + $c)
  if ($css -notmatch $pattern) {
    $missing += $c
  }
}
Write-Output "Total missing classes in course-v3-core.css: $($missing.Count)"
$missing | Sort-Object | ForEach-Object { Write-Output $_ }
