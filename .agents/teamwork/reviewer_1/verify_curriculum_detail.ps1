$ErrorActionPreference = 'Stop'

$lines = Get-Content 'courses\freelancing-mastery.html'

Write-Host "============================================================"
Write-Host "CURRICULUM MODULES & LESSONS PRECISE VERIFICATION"
Write-Host "============================================================"

$modules = @()
$currentModule = $null
$totalLessons = 0

foreach ($line in $lines) {
    if ($line -match 'class="[^"]*module-title-h3[^"]*"[^>]*>(.*?)</h3>') {
        $title = $Matches[1].Trim()
        $currentModule = [PSCustomObject]@{
            Title = $title
            Lessons = @()
        }
        $modules += $currentModule
    }
    elseif ($line -match '<li class="[^"]*c-lesson-item[^"]*"><span class="lesson-check">(\d+)</span><span><strong>(.*?)</strong>(.*?)</span></li>') {
        $num = $Matches[1].Trim()
        $bold = $Matches[2].Trim()
        $rest = $Matches[3].Trim()
        if ($currentModule) {
            $currentModule.Lessons += [PSCustomObject]@{
                Number = $num
                Title = "$bold $rest"
            }
            $totalLessons++
        }
    }
}

Write-Host "Found $($modules.Count) modules:"
for ($i = 0; $i -lt $modules.Count; $i++) {
    $m = $modules[$i]
    Write-Host ("`n[$($i+1)] $($m.Title) - $($m.Lessons.Count) lessons")
    foreach ($les in $m.Lessons) {
        Write-Host "    $($les.Number): $($les.Title)"
    }
}

Write-Host "`n------------------------------------------------------------"
Write-Host "TOTAL MODULES: $($modules.Count) (Expected: 12)"
Write-Host "TOTAL LESSONS: $totalLessons (Expected: 84)"
Write-Host "------------------------------------------------------------"
