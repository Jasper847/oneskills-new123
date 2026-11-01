# fix-toc-position.ps1
$baseDir = "c:\Users\Nisar\Desktop\oneskills new123\guides"
$files = Get-ChildItem -Path $baseDir -Filter "*.html"

foreach ($f in $files) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)

    # Check if TOC is outside <main>
    $tocPattern = '(?s)<!-- In-Page Table of Contents Navigation -->.*?<\/nav>'
    $tocMatch = [System.Text.RegularExpressions.Regex]::Match($content, $tocPattern)

    if ($tocMatch.Success) {
        $tocHtml = $tocMatch.Value
        # Remove the misplaced TOC
        $content = $content.Replace("`r`n`r`n      " + $tocHtml, "")
        $content = $content.Replace($tocHtml, "")

        # Target after </header> of .guide-header
        $guideHeaderEnd = "</header>"
        # Find </header> after <article
        $articleIdx = $content.IndexOf("<article")
        if ($articleIdx -gt 0) {
            $guideHeaderIdx = $content.IndexOf($guideHeaderEnd, $articleIdx)
            if ($guideHeaderIdx -gt 0) {
                $insertPos = $guideHeaderIdx + $guideHeaderEnd.Length
                $formattedToc = "`r`n`r`n      " + $tocHtml.Trim()
                $content = $content.Substring(0, $insertPos) + $formattedToc + $content.Substring($insertPos)
            }
        }

        [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Repositioned TOC in $($f.Name)"
    }
}
