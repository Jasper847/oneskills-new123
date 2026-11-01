$courseFiles = Get-ChildItem "courses/*.html" | Where-Object { $_.Name -notmatch "redesign" }

foreach ($file in $courseFiles) {
    $content = Get-Content $file.FullName -Raw -Encoding utf8
    $hasGuidesNav = $content.Contains("guides/computer-courses-after-matric-in-sheikhupura.html")
    $hasPrimaryNav = $content.Contains('class="primary-nav"')
    $hasAcademyHub = $content.Contains('Academy Hub')
    [PSCustomObject]@{
        Name = $file.Name
        HasGuidesNav = $hasGuidesNav
        HasPrimaryNav = $hasPrimaryNav
        HasAcademyHub = $hasAcademyHub
    }
}
