$html = Get-Content 'courses\freelancing-mastery.html'

$modules = @()
$currentMod = $null

for ($i = 0; $i -lt $html.Length; $i++) {
    $line = $html[$i].Trim()
    if ($line -match 'class="c-phase-pill module-week-badge">(?<week>[^<]+)<') {
        $week = $Matches['week']
        # Next line or nearby is title
        $titleLine = $html[$i+1].Trim()
        if ($titleLine -match 'class="c-phase-title module-title-h3">(?<title>[^<]+)<') {
            $title = $Matches['title']
            $currentMod = @{
                Index = $modules.Count + 1
                Line = $i + 1
                Week = $week
                Title = $title
                Lessons = @()
            }
            $modules += $currentMod
        }
    }
    if ($currentMod -and $line -match '<li class="c-lesson-item lesson-item"><span class="lesson-check">(?<num>[^<]+)</span><span><strong>(?<name>[^<]+)</strong>(?<desc>[^<]+)</span></li>') {
        $currentMod.Lessons += @{
            Num = $Matches['num']
            Name = $Matches['name']
            Desc = $Matches['desc']
        }
    }
}

Write-Host "Total Modules Found: $($modules.Count)"
$totalLessons = 0

foreach ($m in $modules) {
    $firstNum = $m.Lessons[0].Num
    $lastNum = $m.Lessons[-1].Num
    $totalLessons += $m.Lessons.Count
    Write-Host "Module $($m.Index) (Line $($m.Line)): $($m.Title)" -ForegroundColor Cyan
    Write-Host "  Week: $($m.Week) | Lessons: $($m.Lessons.Count) (From $firstNum to $lastNum)"
}

Write-Host "`nTotal Lessons Count Across All Modules: $totalLessons"

