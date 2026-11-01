# Update index.html
$index = [System.IO.File]::ReadAllText("index.html", [System.Text.Encoding]::UTF8)
$index = $index.Replace('href="guides/computer-courses-after-matric-in-sheikhupura.html"', 'href="guides/index.html"')
[System.IO.File]::WriteAllText("index.html", $index, [System.Text.Encoding]::UTF8)
Write-Host "Updated index.html"

# Update about.html
$about = [System.IO.File]::ReadAllText("about.html", [System.Text.Encoding]::UTF8)
$about = $about.Replace('href="guides/computer-courses-after-matric-in-sheikhupura.html"', 'href="guides/index.html"')
[System.IO.File]::WriteAllText("about.html", $about, [System.Text.Encoding]::UTF8)
Write-Host "Updated about.html"

# Update courses
$courses = Get-ChildItem "courses/*.html" | Where-Object { $_.Name -notmatch "redesign" }
foreach ($c in $courses) {
    $cContent = [System.IO.File]::ReadAllText($c.FullName, [System.Text.Encoding]::UTF8)
    if ($cContent.Contains('href="../guides/computer-courses-after-matric-in-sheikhupura.html"')) {
        $cContent = $cContent.Replace('href="../guides/computer-courses-after-matric-in-sheikhupura.html"', 'href="../guides/index.html"')
        [System.IO.File]::WriteAllText($c.FullName, $cContent, [System.Text.Encoding]::UTF8)
        Write-Host "Updated $($c.Name)"
    }
}
