$files = Get-ChildItem -Path "courses" -Filter "*.html"
foreach ($f in $files) {
    $content = Get-Content $f.FullName
    $titleMatch = Select-String -Path $f.FullName -Pattern '<title>(.*?)</title>'
    $title = if ($titleMatch) { $titleMatch.Matches[0].Groups[1].Value } else { "No Title" }
    $v2Check = Select-String -Path $f.FullName -Pattern 'course-v2'
    $hasV2 = if ($v2Check) { "Uses course-v2" } else { "Legacy Template" }
    Write-Host "$($f.Name) | Lines: $($content.Length) | $hasV2 | Title: $title"
}

