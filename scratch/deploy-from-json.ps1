# deploy-from-json.ps1
$configsPath = Join-Path $PSScriptRoot "guide-configs.json"
$configs = Get-Content -Raw -Path $configsPath -Encoding UTF8 | ConvertFrom-Json

$baseDir = "c:\Users\Nisar\Desktop\oneskills new123\guides"

$commonCss = @'
    /* Table of Contents */
    .guide-toc {
      background: var(--surface-subtle);
      border: 1px solid var(--line);
      border-radius: 12px;
      padding: 20px 24px;
      margin-bottom: 36px;
    }

    .guide-toc-title {
      font-size: 13px;
      font-weight: 700;
      letter-spacing: .06em;
      text-transform: uppercase;
      color: var(--accent);
      margin-bottom: 12px;
      display: flex;
      align-items: center;
      gap: 8px;
    }

    .guide-toc-list {
      list-style: none;
      padding: 0;
      margin: 0;
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(260px, 1fr));
      gap: 8px 16px;
    }

    .guide-toc-list li {
      margin: 0;
    }

    .guide-toc-list li a {
      color: var(--text-2);
      font-size: 13.5px;
      text-decoration: none;
      display: inline-flex;
      align-items: center;
      gap: 6px;
      transition: color .2s ease;
      line-height: 1.5;
    }

    .guide-toc-list li a:hover,
    .guide-toc-list li a:focus-visible {
      color: var(--accent);
      text-decoration: underline;
    }

    /* FAQ Accordions in Guides */
    .guide-faq-section {
      margin-top: 48px;
      margin-bottom: 36px;
    }

    .guide-faq-list {
      display: grid;
      gap: 12px;
      margin-top: 20px;
    }

    .guide-faq-item {
      border: 1px solid var(--line);
      border-radius: 10px;
      background: var(--surface-subtle);
      overflow: hidden;
      transition: border-color .2s ease;
    }

    .guide-faq-item[open] {
      border-color: var(--accent);
    }

    .guide-faq-summary {
      list-style: none;
      padding: 16px 20px;
      display: flex;
      align-items: center;
      justify-content: space-between;
      gap: 12px;
      cursor: pointer;
      font-weight: 600;
      font-size: 15px;
      color: var(--text);
      user-select: none;
    }

    .guide-faq-summary::-webkit-details-marker {
      display: none;
    }

    .guide-faq-chevron {
      flex-shrink: 0;
      transition: transform .2s ease;
      color: var(--text-3);
    }

    .guide-faq-item[open] .guide-faq-chevron {
      transform: rotate(180deg);
      color: var(--accent);
    }

    .guide-faq-answer {
      padding: 0 20px 18px 20px;
      color: var(--text-2);
      font-size: 14.5px;
      line-height: 1.65;
    }

    .guide-faq-answer p {
      margin-bottom: 8px;
    }

    .guide-faq-answer p:last-child {
      margin-bottom: 0;
    }

    /* Related Guides Section */
    .related-guides-section {
      margin-top: 48px;
      padding-top: 36px;
      border-top: 1px solid var(--line);
    }

    .related-guides-title {
      font-family: var(--font-display, 'Plus Jakarta Sans', sans-serif);
      font-size: 1.35rem;
      font-weight: 700;
      color: var(--text);
      margin-bottom: 18px;
      letter-spacing: -.01em;
    }

    .related-guides-grid {
      display: grid;
      grid-template-columns: repeat(auto-fit, minmax(240px, 1fr));
      gap: 16px;
    }

    .related-guide-card {
      background: var(--surface-subtle);
      border: 1px solid var(--line);
      border-radius: 10px;
      padding: 18px;
      text-decoration: none;
      display: flex;
      flex-direction: column;
      justify-content: space-between;
      transition: transform .2s ease, border-color .2s ease, box-shadow .2s ease;
    }

    .related-guide-card:hover,
    .related-guide-card:focus-visible {
      transform: translateY(-2px);
      border-color: var(--accent);
      box-shadow: 0 8px 20px rgba(0,0,0,0.06);
    }

    .related-guide-tag {
      font-size: 11px;
      font-weight: 700;
      text-transform: uppercase;
      letter-spacing: .06em;
      color: var(--accent);
      margin-bottom: 8px;
    }

    .related-guide-card h4 {
      font-size: 14.5px;
      font-weight: 600;
      line-height: 1.4;
      color: var(--text);
      margin: 0 0 12px 0;
    }

    .related-guide-action {
      font-size: 13px;
      font-weight: 700;
      color: var(--accent);
      display: inline-flex;
      align-items: center;
      gap: 4px;
    }
'@

foreach ($cfg in $configs) {
    $filePath = Join-Path $baseDir $cfg.file
    if (-not (Test-Path $filePath)) {
        Write-Host "File not found: $($cfg.file)"
        continue
    }

    $content = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)

    # 1. Update meta description
    $content = [System.Text.RegularExpressions.Regex]::Replace($content, '<meta name="description"[\s\S]*?>', "<meta name=`"description`" content=`"$($cfg.metaDesc)`">")

    # 2. Add Twitter cards if not present
    if ($content -notmatch 'twitter:card') {
        $twitterHtml = @"
  <!-- Twitter Card -->
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:site" content="@oneskillspk">
  <meta name="twitter:title" content="$($cfg.twitterTitle)">
  <meta name="twitter:description" content="$($cfg.twitterDesc)">
  <meta name="twitter:image" content="https://oneskills.pk/assets/images/brand/og-cover.webp">
"@
        $content = $content.Replace('<!-- Google Fonts -->', "$twitterHtml`r`n`r`n  <!-- Google Fonts -->")
    }

    # 3. Add CSS for TOC, FAQ, and Related Guides if not present
    if ($content -notmatch '\.guide-toc\s*\{') {
        $content = $content.Replace('  </style>', "$commonCss`r`n  </style>")
    }

    # 4. Add FAQPage JSON-LD if not present
    if ($content -notmatch '"@type": "FAQPage"') {
        $faqEntities = @()
        foreach ($f in $cfg.faqs) {
            $escapedQ = $f.q.Replace('"', '\"')
            $escapedA = $f.a.Replace('"', '\"')
            $faqEntities += @"
      {
        "@type": "Question",
        "name": "$escapedQ",
        "acceptedAnswer": {
          "@type": "Answer",
          "text": "$escapedA"
        }
      }
"@
        }
        $faqArrayStr = [string]::Join(",`r`n", $faqEntities)
        $faqJsonLd = @"
  <script type="application/ld+json">
  {
    "@context": "https://schema.org",
    "@type": "FAQPage",
    "mainEntity": [
$faqArrayStr
    ]
  }
  </script>
</head>
"@
        $content = $content.Replace('</head>', $faqJsonLd)
    }

    # 5. Insert TOC Navigation right below <header class="guide-header">
    if ($content -notmatch 'class="guide-toc"') {
        $tocItems = @()
        foreach ($item in $cfg.toc) {
            $tocItems += "          <li><a href=`"$($item.href)`">&darr; $($item.text)</a></li>"
        }
        $tocItemsStr = [string]::Join("`r`n", $tocItems)
        $tocHtml = @"
      <!-- In-Page Table of Contents Navigation -->
      <nav class="guide-toc" aria-label="Table of contents">
        <div class="guide-toc-title">
          <svg width="15" height="15" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
          Quick In-Guide Navigation
        </div>
        <ul class="guide-toc-list">
$tocItemsStr
        </ul>
      </nav>
"@
        $targetHeaderEnd = '</header>'
        $idx = $content.IndexOf($targetHeaderEnd)
        if ($idx -gt 0) {
            $endIdx = $idx + $targetHeaderEnd.Length
            $content = $content.Substring(0, $endIdx) + "`r`n`r`n" + $tocHtml + $content.Substring($endIdx)
        }
    }

    # 6. Apply section ID replacements
    if ($cfg.sectionReplacements) {
        foreach ($sr in $cfg.sectionReplacements) {
            if ($sr.old -and $content.Contains($sr.old)) {
                $content = $content.Replace($sr.old, $sr.new)
            }
        }
    }

    # 7. Insert FAQ HTML Section before CTA Banner if not present
    if ($content -notmatch 'class="guide-faq-section"') {
        $faqItemsHtml = @()
        foreach ($f in $cfg.faqs) {
            $faqItemsHtml += @"
            <details class="guide-faq-item">
              <summary class="guide-faq-summary">
                <span>$($f.q)</span>
                <svg class="guide-faq-chevron" width="16" height="16" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" aria-hidden="true"><polyline points="6 9 12 15 18 9"></polyline></svg>
              </summary>
              <div class="guide-faq-answer">
                <p>$($f.a)</p>
              </div>
            </details>
"@
        }
        $faqItemsStr = [string]::Join("`r`n", $faqItemsHtml)
        $faqSectionHtml = @"
        <!-- FAQ Section -->
        <div class="guide-faq-section" id="faqs">
          <h2>Frequently Asked Questions</h2>
          <div class="guide-faq-list">
$faqItemsStr
          </div>
        </div>
"@
        $ctaMarker = '<!-- CTA Banner -->'
        if ($content.Contains($ctaMarker)) {
            $content = $content.Replace($ctaMarker, "$faqSectionHtml`r`n`r`n        $ctaMarker")
        }
    }

    # 8. Insert Related Guides Topic Cluster before </article> if not present
    if ($content -notmatch 'class="related-guides-section"') {
        $relatedCards = @()
        foreach ($rc in $cfg.related) {
            $relatedCards += @"
            <a href="$($rc.url)" class="related-guide-card">
              <span class="related-guide-tag">$($rc.tag)</span>
              <h4>$($rc.title)</h4>
              <span class="related-guide-action">$($rc.action) &rarr;</span>
            </a>
"@
        }
        $relatedCardsStr = [string]::Join("`r`n", $relatedCards)
        $relatedHtml = @"
        <!-- Related Guides Topic Cluster -->
        <section class="related-guides-section" id="related-guides" aria-labelledby="related-guides-title">
          <h2 class="related-guides-title" id="related-guides-title">Explore Related Guides for Sheikhupura Students</h2>
          <div class="related-guides-grid">
$relatedCardsStr
          </div>
        </section>
"@
        $articleEndMarker = '      </div>' + "`r`n" + '    </article>'
        if ($content.Contains($articleEndMarker)) {
            $content = $content.Replace($articleEndMarker, "$relatedHtml`r`n      </div>`r`n    </article>")
        } else {
            $fallbackEnd = '    </article>'
            $content = $content.Replace($fallbackEnd, "$relatedHtml`r`n    </article>")
        }
    }

    [System.IO.File]::WriteAllText($filePath, $content, [System.Text.Encoding]::UTF8)
    Write-Host "Successfully enhanced $($cfg.file)"
}
