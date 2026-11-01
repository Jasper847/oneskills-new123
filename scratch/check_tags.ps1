$html = Get-Content 'courses\dm-new-course.html' -Raw
$tags = @('section', 'main', 'article', 'details', 'nav', 'header', 'footer', 'div')
foreach ($t in $tags) {
    $o = ([regex]::Matches($html, '<' + $t + '[\s>]', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
    $c = ([regex]::Matches($html, '</' + $t + '>', [System.Text.RegularExpressions.RegexOptions]::IgnoreCase)).Count
    Write-Host ("Tag <$t>: opens=$o, closes=$c, diff=" + ($o - $c))
}
