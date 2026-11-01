# deploy-nav-updates.ps1
# Updates navigation and footer links across all courses and guides

# --- 1. UPDATE GUIDES ---
$guideFiles = Get-ChildItem "guides/*.html"

foreach ($file in $guideFiles) {
    $content = [System.IO.File]::ReadAllText($file.FullName, [System.Text.Encoding]::UTF8)
    $modified = $false

    # 1. Primary Nav: Add Guides link if not present
    $oldNav = '<li><a class="nav-link" href="../index.html#courses">Courses</a></li>'
    $newNavWithGuides = '<li><a class="nav-link" href="../index.html#courses">Courses</a></li>' + "`r`n" + '          <li><a class="nav-link active" href="computer-courses-after-matric-in-sheikhupura.html" aria-current="page">Guides</a></li>'
    
    if (-not $content.Contains('aria-current="page">Guides</a>') -and $content.Contains($oldNav)) {
        $content = $content.Replace($oldNav, $newNavWithGuides)
        $modified = $true
    }

    # 2. Breadcrumbs: Change "../index.html#courses">Guides</a> to "computer-courses-after-matric-in-sheikhupura.html">Guides</a>
    $oldBreadcrumb = '<a href="../index.html#courses">Guides</a>'
    $newBreadcrumb = '<a href="computer-courses-after-matric-in-sheikhupura.html">Guides</a>'
    if ($content.Contains($oldBreadcrumb)) {
        $content = $content.Replace($oldBreadcrumb, $newBreadcrumb)
        $modified = $true
    }

    # 3. Footer: Add Career Guides & ensure About Us in Academy Hub
    $oldHub = '<h4>Academy Hub</h4>' + "`r`n" + '          <ul class="footer-links-list">' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../index.html#about" class="footer-nav-item">'
    $newHub = '<h4>Academy Hub</h4>' + "`r`n" + '          <ul class="footer-links-list">' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../about.html" class="footer-nav-item">' + "`r`n" + '                <span>About Us</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>' + "`r`n" + '            <li>' + "`r`n" + '              <a href="computer-courses-after-matric-in-sheikhupura.html" class="footer-nav-item">' + "`r`n" + '                <span>Career Guides</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../index.html#about" class="footer-nav-item">'
    
    if (-not $content.Contains('<span>Career Guides</span>') -and $content.Contains($oldHub)) {
        $content = $content.Replace($oldHub, $newHub)
        $modified = $true
    }

    if ($modified) {
        [System.IO.File]::WriteAllText($file.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Updated Guide: $($file.Name)"
    } else {
        Write-Host "Guide Already Up-To-Date: $($file.Name)"
    }
}

# --- 2. UPDATE COURSES ---
# Courses with 4-column panel footer (crypto, forex, ai-tools, ai-based, freelancing, programming, web3)
$fcolCourses = @(
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/freelancing-mastery.html",
    "courses/programming-js-cpp.html",
    "courses/web3-blockchain.html"
)

foreach ($cPath in $fcolCourses) {
    if (Test-Path $cPath) {
        $content = [System.IO.File]::ReadAllText((Resolve-Path $cPath).Path, [System.Text.Encoding]::UTF8)
        $modified = $false

        # Primary Nav
        $oldNav = '<li><a class="nav-link" href="../index.html#courses">Courses</a></li>'
        $newNav = '<li><a class="nav-link" href="../index.html#courses">Courses</a></li>' + "`r`n" + '          <li><a class="nav-link" href="../guides/computer-courses-after-matric-in-sheikhupura.html">Guides</a></li>'
        if (-not $content.Contains('guides/computer-courses-after-matric-in-sheikhupura.html') -and $content.Contains($oldNav)) {
            $content = $content.Replace($oldNav, $newNav)
            $modified = $true
        }

        # Footer Academy column
        $oldAcademy = '<h3>Academy</h3>' + "`r`n" + '          <a href="../about.html">About Us</a>'
        $newAcademy = '<h3>Academy</h3>' + "`r`n" + '          <a href="../about.html">About Us</a>' + "`r`n" + '          <a href="../guides/computer-courses-after-matric-in-sheikhupura.html">Career Guides</a>'
        if ($content.Contains($oldAcademy) -and -not $content.Contains('Career Guides</a>')) {
            $content = $content.Replace($oldAcademy, $newAcademy)
            $modified = $true
        } else {
            # Try with index.html#about
            $oldAcademy2 = '<h3>Academy</h3>' + "`r`n" + '          <a href="../index.html#about">About Us</a>'
            $newAcademy2 = '<h3>Academy</h3>' + "`r`n" + '          <a href="../about.html">About Us</a>' + "`r`n" + '          <a href="../guides/computer-courses-after-matric-in-sheikhupura.html">Career Guides</a>'
            if ($content.Contains($oldAcademy2) -and -not $content.Contains('Career Guides</a>')) {
                $content = $content.Replace($oldAcademy2, $newAcademy2)
                $modified = $true
            }
        }

        # Footer Programs: add Shopify if missing
        $oldProg = '<a href="ai-based-computer-course.html">AI Computer Course</a>'
        $newProg = '<a href="ai-based-computer-course.html">AI Computer Course</a>' + "`r`n" + '          <a href="shopify-ecommerce.html">Shopify &amp; E-Commerce</a>'
        if ($content.Contains($oldProg) -and -not $content.Contains('shopify-ecommerce.html')) {
            $content = $content.Replace($oldProg, $newProg)
            $modified = $true
        }

        if ($modified) {
            [System.IO.File]::WriteAllText((Resolve-Path $cPath).Path, $content, [System.Text.Encoding]::UTF8)
            Write-Host "Updated Course: $cPath"
        } else {
            Write-Host "Course Checked (no change): $cPath"
        }
    }
}

# Courses with Hiran Minar footer (ai-web-development.html, shopify-ecommerce.html)
$hiranCourses = @(
    "courses/ai-web-development.html",
    "courses/shopify-ecommerce.html"
)

foreach ($hPath in $hiranCourses) {
    if (Test-Path $hPath) {
        $content = [System.IO.File]::ReadAllText((Resolve-Path $hPath).Path, [System.Text.Encoding]::UTF8)
        $modified = $false

        # Primary Nav
        $oldNav1 = '<li><a class="nav-link active" href="../index.html#courses" aria-current="location">Courses</a></li>'
        $newNav1 = '<li><a class="nav-link active" href="../index.html#courses" aria-current="location">Courses</a></li>' + "`r`n" + '          <li><a class="nav-link" href="../guides/computer-courses-after-matric-in-sheikhupura.html">Guides</a></li>'
        if (-not $content.Contains('guides/computer-courses-after-matric-in-sheikhupura.html') -and $content.Contains($oldNav1)) {
            $content = $content.Replace($oldNav1, $newNav1)
            $modified = $true
        }

        $oldNav2 = '<li><a class="nav-link" href="../index.html#courses">Courses</a></li>'
        $newNav2 = '<li><a class="nav-link" href="../index.html#courses">Courses</a></li>' + "`r`n" + '          <li><a class="nav-link" href="../guides/computer-courses-after-matric-in-sheikhupura.html">Guides</a></li>'
        if (-not $content.Contains('guides/computer-courses-after-matric-in-sheikhupura.html') -and $content.Contains($oldNav2)) {
            $content = $content.Replace($oldNav2, $newNav2)
            $modified = $true
        }

        # Footer Academy Hub
        $oldHub = '<h4>Academy Hub</h4>' + "`r`n" + '          <ul class="footer-links-list">' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../index.html#about" class="footer-nav-item">'
        $newHub = '<h4>Academy Hub</h4>' + "`r`n" + '          <ul class="footer-links-list">' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../about.html" class="footer-nav-item">' + "`r`n" + '                <span>About OneSkills</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../guides/computer-courses-after-matric-in-sheikhupura.html" class="footer-nav-item">' + "`r`n" + '                <span>Career Guides</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../index.html#about" class="footer-nav-item">'
        if (-not $content.Contains('<span>Career Guides</span>') -and $content.Contains($oldHub)) {
            $content = $content.Replace($oldHub, $newHub)
            $modified = $true
        }

        # Footer Career Tracks: add Shopify to ai-web-development if missing
        $oldTrack = '<span>Computer &amp; Office Skills</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>'
        $newTrack = '<span>Computer &amp; Office Skills</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>' + "`r`n" + '            <li>' + "`r`n" + '              <a href="../courses/shopify-ecommerce.html" class="footer-nav-item">' + "`r`n" + '                <span>Shopify &amp; E-Commerce</span>' + "`r`n" + '                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>' + "`r`n" + '              </a>' + "`r`n" + '            </li>'
        if ($hPath -eq "courses/ai-web-development.html" -and -not $content.Contains('shopify-ecommerce.html') -and $content.Contains($oldTrack)) {
            $content = $content.Replace($oldTrack, $newTrack)
            $modified = $true
        }

        if ($modified) {
            [System.IO.File]::WriteAllText((Resolve-Path $hPath).Path, $content, [System.Text.Encoding]::UTF8)
            Write-Host "Updated Course: $hPath"
        } else {
            Write-Host "Course Checked (no change): $hPath"
        }
    }
}
