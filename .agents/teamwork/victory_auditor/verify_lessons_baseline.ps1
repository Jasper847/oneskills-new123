# verify_lessons_baseline.ps1
$analysis = Get-Content '.agents\teamwork\explorer_survey_html\analysis.md' -Raw
$html = Get-Content 'courses\freelancing-mastery.html' -Raw

$analysisLessons = [regex]::Matches($analysis, '(?m)^\s*-\s*\*Lesson\s+(\d\d)\*:\s*(.*?)$')
Write-Host "Analysis frozen lessons count: $($analysisLessons.Count)"

$htmlLessons = [regex]::Matches($html, '<li class="c-lesson-item lesson-item"><span class="lesson-check">(\d+)</span><span><strong>(.*?)</strong>\s*(.*?)</span></li>')
Write-Host "HTML lessons count: $($htmlLessons.Count)"

$mismatches = 0
for ($i = 0; $i -lt [Math]::Min($analysisLessons.Count, $htmlLessons.Count); $i++) {
    $aNum = $analysisLessons[$i].Groups[1].Value.Trim()
    $aText = $analysisLessons[$i].Groups[2].Value.Trim() -replace '&amp;', '&'
    
    $hNum = $htmlLessons[$i].Groups[1].Value.Trim()
    $hBold = $htmlLessons[$i].Groups[2].Value.Trim() -replace '&amp;', '&'
    $hRest = $htmlLessons[$i].Groups[3].Value.Trim() -replace '&amp;', '&'
    $hFull = ($hBold + ' ' + $hRest).Trim()
    
    $cleanA = ($aText -replace '\s+', ' ').Trim()
    $cleanH = ($hFull -replace '\s+', ' ').Trim()
    
    if ($cleanA -ne $cleanH) {
        $mismatches++
        Write-Host "Mismatch at lesson $aNum vs ${hNum}:"
        Write-Host "  Baseline: $cleanA"
        Write-Host "  HTML:     $cleanH"
    }
}

Write-Host "Total mismatches between frozen baseline and HTML: $mismatches"
if ($mismatches -eq 0 -and $analysisLessons.Count -eq 84 -and $htmlLessons.Count -eq 84) {
    Write-Host "VERIFIED: Exactly 84 lessons match verbatim!" -ForegroundColor Green
} else {
    Write-Host "FAILED: Lessons do not match!" -ForegroundColor Red
}
