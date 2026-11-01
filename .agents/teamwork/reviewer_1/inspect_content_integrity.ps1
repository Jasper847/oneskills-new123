$ErrorActionPreference = 'Stop'

$current = Get-Content 'courses\freelancing-mastery.html' -Raw
$backupPath = '_archive\backups\snapshot_before_cleanup\courses\freelancing-mastery.html'
if (-not (Test-Path $backupPath)) {
    $backupPath = '_archive\courses\freelancing-mastery-legacy-backup.html'
}
Write-Host "Comparing against backup: $backupPath"
$backup = Get-Content $backupPath -Raw

Write-Host "============================================================"
Write-Host "INDEPENDENT STANDARD 6 (CONTENT INTEGRITY) AUDIT"
Write-Host "============================================================"

# 1. Modules count & titles
Write-Host "`n1. Curriculum Modules Check:"
$currModMatches = [regex]::Matches($current, 'Module\s+(\d\d)[:\s–-]+([^<]+)')
$backModMatches = [regex]::Matches($backup, 'Module\s+(\d\d)[:\s–-]+([^<]+)')
Write-Host "Current modules found: $($currModMatches.Count)"
Write-Host "Backup modules found: $($backModMatches.Count)"

for ($i = 0; $i -lt [Math]::Max($currModMatches.Count, $backModMatches.Count); $i++) {
    $cVal = if ($i -lt $currModMatches.Count) { $currModMatches[$i].Value.Trim() } else { "MISSING" }
    $bVal = if ($i -lt $backModMatches.Count) { $backModMatches[$i].Value.Trim() } else { "MISSING" }
    if ($cVal -ne $bVal) {
        Write-Host "  DIFF in Module $($i+1):"
        Write-Host "    Current: $cVal"
        Write-Host "    Backup:  $bVal"
    } else {
        Write-Host "  MATCH Module $($i+1): $cVal"
    }
}

# 2. Lessons count
Write-Host "`n2. Curriculum Lessons Check:"
$currLessons = [regex]::Matches($current, 'class=[\x22\x27][^\x22\x27]*c-lesson-item[^\x22\x27]*[\x22\x27]')
$backLessons = [regex]::Matches($backup, 'class=[\x22\x27][^\x22\x27]*(?:c-lesson-item|lesson-item)[^\x22\x27]*[\x22\x27]')
Write-Host "Current lessons found: $($currLessons.Count) (expected 84)"
Write-Host "Backup lessons found: $($backLessons.Count)"

# Check lesson numbering 01 through 84
$missingLessonNumbers = @()
for ($num = 1; $num -le 84; $num++) {
    $strNum = $num.ToString("00")
    if ($current -notmatch "class=[\x22\x27][^\x22\x27]*lesson-num[^\x22\x27]*[\x22\x27][^>]*>\s*$strNum\b") {
        $missingLessonNumbers += $strNum
    }
}
Write-Host "Missing lesson numbers from 01 to 84: $($missingLessonNumbers.Count)"
if ($missingLessonNumbers.Count -gt 0) {
    Write-Host "  Missing: $($missingLessonNumbers -join ', ')"
}

# 3. Pricing Figures
Write-Host "`n3. Pricing Figures Check:"
$pkr25kCurr = ([regex]::Matches($current, 'PKR 25,000')).Count
$pkr25kBack = ([regex]::Matches($backup, 'PKR 25,000')).Count
Write-Host "PKR 25,000 count - Current: $pkr25kCurr, Backup: $pkr25kBack"

$pkr12kCurr = ([regex]::Matches($current, '2 installments of PKR 12,500')).Count
$pkr12kBack = ([regex]::Matches($backup, '2 installments of PKR 12,500')).Count
Write-Host "2 installments of PKR 12,500 count - Current: $pkr12kCurr, Backup: $pkr12kBack"

$pkr8kCurr = ([regex]::Matches($current, 'PKR 8,500\s*/\s*mo')).Count
$pkr8kBack = ([regex]::Matches($backup, 'PKR 8,500\s*/\s*mo')).Count
Write-Host "PKR 8,500 / mo count - Current: $pkr8kCurr, Backup: $pkr8kBack"

# 4. Learning outcomes check
Write-Host "`n4. Learning Outcomes Check:"
$currOutcomes = [regex]::Matches($current, 'class=[\x22\x27][^\x22\x27]*c-outcome-card[^\x22\x27]*[\x22\x27]')
$backOutcomes = [regex]::Matches($backup, 'class=[\x22\x27][^\x22\x27]*c-outcome-card[^\x22\x27]*[\x22\x27]')
Write-Host "Outcome cards count - Current: $($currOutcomes.Count), Backup: $($backOutcomes.Count)"

$outcomeTitles = @(
    "High-Ticket Upwork & Client Sourcing Engine",
    "Technical SEO & Content Monetization System",
    "Paid Traffic & Performance Ads Mastery",
    "Commercial Web Build & AI-Assisted Workflows"
)
foreach ($ot in $outcomeTitles) {
    $hasCurr = $current -match [regex]::Escape($ot)
    $hasBack = $backup -match [regex]::Escape($ot)
    Write-Host "  Outcome '$ot': Current=$hasCurr, Backup=$hasBack"
}

# 5. Dynamic element IDs
Write-Host "`n5. Dynamic Element IDs:"
$dynamicIds = @(
  'batch-slot-title',
  'batch-seats-badge',
  'batch-audience-note',
  'card-wa-btn-text',
  'card-wa-cta',
  'fee-display-amount',
  'fee-display-sub',
  'map-route-badge',
  'town-commute-title',
  'town-commute-desc'
)
$missingDynamicIds = @()
foreach ($id in $dynamicIds) {
    if ($current -notmatch "id=[\x22\x27]$id[\x22\x27]") {
        $missingDynamicIds += $id
    }
}
Write-Host "Missing dynamic IDs: $($missingDynamicIds.Count)"
if ($missingDynamicIds.Count -gt 0) {
    Write-Host "  Missing: $($missingDynamicIds -join ', ')"
}
