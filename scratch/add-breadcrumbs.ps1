# PowerShell script to add breadcrumbs to 9 guide files
$guides = @(
    @{
        File = "computer-courses-after-matric-in-sheikhupura.html"
        Title = "Computer Courses After Matric"
    },
    @{
        File = "which-computer-course-is-best-for-online-earning-in-sheikhupura.html"
        Title = "Best Course for Online Earning"
    },
    @{
        File = "office-management-ms-office-course-in-sheikhupura.html"
        Title = "Office Management & MS Office"
    },
    @{
        File = "ai-graphic-design-video-editing-course-sheikhupura.html"
        Title = "AI Graphic Design & Video Editing"
    },
    @{
        File = "computer-courses-for-females-in-sheikhupura.html"
        Title = "Computer Courses for Females"
    },
    @{
        File = "dit-vs-short-ai-computer-course-sheikhupura.html"
        Title = "DIT vs Short AI Courses"
    },
    @{
        File = "computer-it-courses-for-farooqabad-safdarabad-students.html"
        Title = "Courses for Farooqabad & Safdarabad"
    },
    @{
        File = "ai-web-development-trading-courses-near-muridke.html"
        Title = "Courses Near Muridke"
    },
    @{
        File = "seo-training-website-flipping-course-sheikhupura.html"
        Title = "SEO & Website Flipping"
    }
)

$baseDir = "c:\Users\Nisar\Desktop\oneskills new123\guides"

$cssSnippet = @'
    .guide-breadcrumbs {
      display: flex;
      flex-wrap: wrap;
      align-items: center;
      gap: 8px;
      font-size: 13px;
      margin-bottom: 24px;
      color: var(--text-3);
    }

    .guide-breadcrumbs a {
      color: var(--text-2);
      text-decoration: none;
      transition: color .2s ease;
    }

    .guide-breadcrumbs a:hover {
      color: var(--accent);
    }

    .guide-breadcrumbs .breadcrumb-sep {
      color: var(--text-3);
      user-select: none;
    }

    .guide-breadcrumbs [aria-current="page"] {
      color: var(--text);
      font-weight: 600;
    }
'@

foreach ($g in $guides) {
    $filePath = Join-Path $baseDir $g.File
    if (-not (Test-Path $filePath)) {
        Write-Host "Missing: $($g.File)"
        continue
    }

    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    # 1. Add CSS if not present
    if ($content -notmatch '\.guide-breadcrumbs\s*\{') {
        $targetCss = '    .guide-container {'
        $replacementCss = $cssSnippet + "`r`n`r`n" + $targetCss
        $content = $content.Replace($targetCss, $replacementCss)
    }

    # 2. Add BreadcrumbList Schema if not present
    if ($content -notmatch 'BreadcrumbList') {
        $jsonLd = @"
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "BreadcrumbList",
    "itemListElement": [
      { "@type": "ListItem", "position": 1, "name": "Home", "item": "https://oneskills.pk/" },
      { "@type": "ListItem", "position": 2, "name": "Guides", "item": "https://oneskills.pk/#courses" },
      { "@type": "ListItem", "position": 3, "name": "$($g.Title)", "item": "https://oneskills.pk/guides/$($g.File)" }
    ]
  }
  </script>
</head>
"@
        $content = $content.Replace("</head>", $jsonLd)
    }

    # 3. Add HTML breadcrumbs if not present
    if ($content -notmatch 'class="guide-breadcrumbs"') {
        $targetHtml = '<article class="guide-container">'
        $htmlNav = @"
    <article class="guide-container">
      <nav class="guide-breadcrumbs" aria-label="Breadcrumb navigation">
        <a href="../index.html">Home</a>
        <span class="breadcrumb-sep" aria-hidden="true">&rsaquo;</span>
        <a href="../index.html#courses">Guides</a>
        <span class="breadcrumb-sep" aria-hidden="true">&rsaquo;</span>
        <span aria-current="page">$($g.Title)</span>
      </nav>
"@
        $content = $content.Replace($targetHtml, $htmlNav.TrimEnd())
    }

    [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Updated $($g.File)"
}
