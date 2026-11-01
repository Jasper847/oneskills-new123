# Extract verbatim curriculum, outcomes, and pricing from courses/freelancing-mastery.html
$content = Get-Content -Path 'courses\freelancing-mastery.html' -Raw

Write-Output "=== PRICING NUMBERS ==="
$priceMatches = [regex]::Matches($content, '(?i)(PKR\s*[\d,]+|25,000|12,500|8,500|\$500[^\n<]*|\$1,500|\$600)')
$priceMatches | ForEach-Object { $_.Value } | Select-Object -Unique

Write-Output "`n=== OUTCOMES ==="
$outcomes = [regex]::Matches($content, '(?s)<div class="c-outcome-card">.*?<span class="c-outcome-num">(.*?)</span>.*?<h4>(.*?)</h4>.*?<p>(.*?)</p>')
$outcomes | ForEach-Object {
    "Number: " + $_.Groups[1].Value.Trim()
    "Title: " + $_.Groups[2].Value.Trim()
    "Desc: " + $_.Groups[3].Value.Trim()
    "---"
}

Write-Output "`n=== 12 MODULES AND 84 LESSONS ==="
$modules = [regex]::Matches($content, '(?s)<details class="c-phase-item[^"]*"[^>]*>.*?<span class="c-phase-pill[^"]*">(.*?)</span>.*?<h3 class="c-phase-title[^"]*">(.*?)</h3>.*?<span class="module-project-pill">(.*?)</span>(.*?)</details>')
Write-Output "Found $($modules.Count) modules."
for ($m = 0; $m -lt $modules.Count; $m++) {
    $mod = $modules[$m]
    $pill = $mod.Groups[1].Value.Trim()
    $mTitle = $mod.Groups[2].Value.Trim()
    $deliv = $mod.Groups[3].Value.Trim()
    $body = $mod.Groups[4].Value
    
    Write-Output "`nMODULE $($m+1): $mTitle"
    Write-Output "Badge: $pill"
    Write-Output "Deliverable Pill: $deliv"
    
    $lessons = [regex]::Matches($body, '(?s)<div class="c-lesson-item[^"]*"><span class="lesson-check">(.*?)</span><span><strong>(.*?)</strong>(.*?)</span></div>')
    Write-Output "Lessons ($($lessons.Count)): "
    foreach ($l in $lessons) {
        $num = $l.Groups[1].Value.Trim()
        $bold = $l.Groups[2].Value.Trim()
        $rest = $l.Groups[3].Value.Trim()
        Write-Output "  Lesson ${num}: $bold $rest"
    }
    
    if ($body -match '(?s)<div class="c-deliverable-box[^"]*">\s*<span><strong>(.*?)</strong>(.*?)</span>') {
        Write-Output "  Proof of Work: $($matches[1].Trim()) $($matches[2].Trim())"
    }
}
