$cssFiles = Get-ChildItem -Path assets/css -Filter *.css
foreach ($cf in $cssFiles) {
    $text = Get-Content $cf.FullName -Raw
    $hasBento = $text.Contains('c-bento-grid')
    $hasHeroInner = $text.Contains('c-hero__inner')
    Write-Host "$($cf.Name): c-bento-grid=$hasBento, c-hero__inner=$hasHeroInner"
}

