$html = Get-Content 'courses\freelancing-mastery.html' -Raw

# Match all details modules
$pattern = '(?ms)<details class="c-phase-item module-accordion"[^>]*data-mod-cat="(?<cat>[^"]*)"[^>]*>.*?<span class="c-phase-num[^"]*">(?<modNum>[^<]*)</span>.*?<h3 class="c-phase-title[^"]*">(?<title>[^<]*)</h3>.*?<span class="module-project-pill">(?<deliverablePill>[^<]*)</span>.*?<ol class="c-lessons-grid module-lessons-grid">(?<lessonsHtml>.*?)</ol>.*?<div class="c-deliverable-box module-deliverable-bar">\s*<span>(?<deliverableText>.*?)</span>\s*<div class="deliverable-tools-list">(?<toolsHtml>.*?)</div>'

$matches = [regex]::Matches($html, $pattern)

Write-Host "Found $($matches.Count) Modules in Curriculum Accordion Stack:`n"

$totalLessons = 0

for ($i = 0; $i -lt $matches.Count; $i++) {
    $m = $matches[$i]
    $modNum = $m.Groups['modNum'].Value.Trim()
    $title = $m.Groups['title'].Value.Trim()
    $cat = $m.Groups['cat'].Value.Trim()
    $delPill = $m.Groups['deliverablePill'].Value.Trim()
    $delText = ($m.Groups['deliverableText'].Value -replace '<[^>]+>', '').Trim()
    
    $lessons = [regex]::Matches($m.Groups['lessonsHtml'].Value, '<li[^>]*><span class="lesson-check">(?<num>[^<]*)</span><span><strong>(?<name>[^<]*)</strong>(?<desc>[^<]*)</span></li>')
    $totalLessons += $lessons.Count

    $lessonNumbers = ($lessons | ForEach-Object { $_.Groups['num'].Value }) -join ", "
    $tools = ([regex]::Matches($m.Groups['toolsHtml'].Value, '<span class="tool-mini-tag">(?<t>[^<]*)</span>') | ForEach-Object { $_.Groups['t'].Value }) -join ", "

    Write-Host "MODULE $($i+1): [$modNum] $title" -ForegroundColor Cyan
    Write-Host "  Category: $cat | Lessons Count: $($lessons.Count) (Numbers: $lessonNumbers)"
    Write-Host "  Deliverable Pill: $delPill"
    Write-Host "  Deliverable Text: $delText"
    Write-Host "  Tools: $tools`n"
}

Write-Host "TOTAL MODULES: $($matches.Count) | TOTAL LESSONS: $totalLessons"

