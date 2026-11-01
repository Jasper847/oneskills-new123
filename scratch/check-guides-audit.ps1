$guides = Get-ChildItem "guides/*.html"

foreach ($g in $guides) {
    $content = Get-Content $g.FullName -Raw -Encoding utf8
    [PSCustomObject]@{
        Guide = $g.Name
        NavHasGuides = $content.Contains('aria-current="page">Guides</a>')
        BreadcrumbGuides = $content.Contains('<a href="computer-courses-after-matric-in-sheikhupura.html">Guides</a>')
        FooterHasCareerGuides = $content.Contains('Career Guides')
        HasTOC = $content.Contains('class="guide-toc"')
        HasFAQ = $content.Contains('class="guide-faq-section"')
        HasRelated = $content.Contains('class="related-guides-section"')
    }
}
