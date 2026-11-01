$guideFiles = Get-ChildItem "guides/*.html" | Where-Object { $_.Name -ne "index.html" }

foreach ($file in $guideFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $modified = $false

    # Breadcrumb: link Guides to index.html
    $oldBc = '<a href="computer-courses-after-matric-in-sheikhupura.html">Guides</a>'
    $newBc = '<a href="index.html">Guides</a>'
    if ($content.Contains($oldBc)) {
        $content = $content.Replace($oldBc, $newBc)
        $modified = $true
    }

    # Primary Nav: link Guides to index.html
    $oldNav = '<li><a class="nav-link active" href="computer-courses-after-matric-in-sheikhupura.html" aria-current="page">Guides</a></li>'
    $newNav = '<li><a class="nav-link active" href="index.html" aria-current="page">Guides</a></li>'
    if ($content.Contains($oldNav)) {
        $content = $content.Replace($oldNav, $newNav)
        $modified = $true
    }

    # Footer: link Career Guides to index.html
    $oldFt = '<a href="computer-courses-after-matric-in-sheikhupura.html" class="footer-nav-item">' + "`r`n" + '                <span>Career Guides</span>'
    $newFt = '<a href="index.html" class="footer-nav-item">' + "`r`n" + '                <span>Career Guides</span>'
    if ($content.Contains($oldFt)) {
        $content = $content.Replace($oldFt, $newFt)
        $modified = $true
    }

    if ($modified) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated breadcrumb/nav in $($file.Name)"
    }
}
