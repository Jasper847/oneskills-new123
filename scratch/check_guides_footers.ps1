$guides = Get-ChildItem "guides" -Filter *.html
foreach ($g in $guides) {
    $content = Get-Content $g.FullName -Raw
    $hasWrap = $content -match 'footer-wrap'
    $hasHiran = $content -match 'footer-hiran-wrap'
    Write-Output "$($g.Name) : hasFooterWrap=$hasWrap, hasHiran=$hasHiran"
}

