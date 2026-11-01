$courses = Get-ChildItem "courses/*.html" | Where-Object { $_.Name -notmatch "redesign" }

foreach ($c in $courses) {
    $content = [System.IO.File]::ReadAllText($c.FullName, [System.Text.Encoding]::UTF8)
    $hasExternalCss = $content.Contains('rel="stylesheet"')
    $hasInlineStyle = $content.Contains('<style>')
    $hasSkipLink = $content.Contains('class="skip-link"')
    $hasCourseSchema = $content.Contains('"@type": "Course"')
    $hasFaqSchema = $content.Contains('"@type": "FAQPage"')
    $hasBreadcrumbSchema = $content.Contains('"@type": "BreadcrumbList"')
    $hasTwitter = $content.Contains('name="twitter:card"')
    
    [PSCustomObject]@{
        Course = $c.Name
        HasExternalCss = $hasExternalCss
        HasInlineStyle = $hasInlineStyle
        HasSkipLink = $hasSkipLink
        HasCourseSchema = $hasCourseSchema
        HasFaqSchema = $hasFaqSchema
        HasBreadcrumbSchema = $hasBreadcrumbSchema
        HasTwitter = $hasTwitter
    }
}
