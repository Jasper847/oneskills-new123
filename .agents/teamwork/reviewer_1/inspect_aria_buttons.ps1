$ErrorActionPreference = 'Stop'

$html = Get-Content 'courses\freelancing-mastery.html' -Raw
$js = Get-Content 'assets\js\course-v2.js' -Raw

Write-Host "============================================================"
Write-Host "INDEPENDENT ARIA INTERACTIVITY & BUTTON AUDIT"
Write-Host "============================================================"

# 1. Filter tabs inspection
Write-Host "`n--- Filter Groups / Tabs ---"
$pillarTabs = [regex]::Match($html, '(?s)<div[^>]*id="skill-pillar-tabs"[^>]*>.*?</div>')
if ($pillarTabs.Success) {
    Write-Host "skill-pillar-tabs:"
    $m = [regex]::Match($pillarTabs.Value, '<div[^>]*id="skill-pillar-tabs"[^>]*>')
    Write-Host "  Tag: $($m.Value)"
    $btns = [regex]::Matches($pillarTabs.Value, '<button\b[^>]*>')
    Write-Host "  Buttons in skill-pillar-tabs: $($btns.Count)"
    foreach ($b in $btns) { Write-Host "    $($b.Value)" }
}

$curriculumTabs = [regex]::Match($html, '(?s)<div[^>]*id="curriculum-filter-tabs"[^>]*>.*?</div>')
if ($curriculumTabs.Success) {
    Write-Host "`ncurriculum-filter-tabs:"
    $m = [regex]::Match($curriculumTabs.Value, '<div[^>]*id="curriculum-filter-tabs"[^>]*>')
    Write-Host "  Tag: $($m.Value)"
    $btns = [regex]::Matches($curriculumTabs.Value, '<button\b[^>]*>')
    Write-Host "  Buttons in curriculum-filter-tabs: $($btns.Count)"
    foreach ($b in $btns) { Write-Host "    $($b.Value)" }
}

# 2. Tuition toggles
Write-Host "`n--- Tuition Switcher Buttons ---"
$tuitionBtns = [regex]::Matches($html, '<button[^>]*id="btn-fee-[^"]*"[^>]*>')
foreach ($b in $tuitionBtns) { Write-Host "  $($b.Value)" }

# 3. Batch slot options
Write-Host "`n--- Batch Slot Picker ---"
$batchGrid = [regex]::Match($html, '<div[^>]*class="[^"]*c-batch-slots-grid[^"]*"[^>]*>')
Write-Host "  Container: $($batchGrid.Value)"
$slotBtns = [regex]::Matches($html, '<button[^>]*class="[^"]*c-slot-card[^"]*"[^>]*>')
Write-Host "  Slot buttons: $($slotBtns.Count)"
foreach ($b in $slotBtns) { Write-Host "    $($b.Value)" }

# 4. Commuter town buttons
Write-Host "`n--- Commuter Town Buttons ---"
$townGrid = [regex]::Match($html, '<div[^>]*class="[^"]*c-town-pills[^"]*"[^>]*>')
Write-Host "  Container: $($townGrid.Value)"
$townBtns = [regex]::Matches($html, '<button[^>]*class="[^"]*town-btn[^"]*"[^>]*>')
Write-Host "  Town buttons: $($townBtns.Count)"
foreach ($b in $townBtns) { Write-Host "    $($b.Value)" }

# 5. Live regions
Write-Host "`n--- Dynamic Live Regions ---"
$liveRegions = [regex]::Matches($html, '<[^>]*aria-live=[^>]*>')
Write-Host "Live regions count: $($liveRegions.Count)"
foreach ($lr in $liveRegions) { Write-Host "  $($lr.Value)" }

# 6. Accordions / Curriculum Triggers
Write-Host "`n--- Accordion Triggers (aria-expanded, aria-controls) ---"
$currTriggers = [regex]::Matches($html, '<button[^>]*class="[^"]*c-curriculum-trigger[^"]*"[^>]*>')
Write-Host "Curriculum triggers count: $($currTriggers.Count)"
$missingExpanded = 0
$missingControls = 0
foreach ($ct in $currTriggers) {
    if ($ct.Value -notmatch 'aria-expanded=') { $missingExpanded++ }
    if ($ct.Value -notmatch 'aria-controls=') { $missingControls++ }
}
Write-Host "Curriculum triggers missing aria-expanded: $missingExpanded"
Write-Host "Curriculum triggers missing aria-controls: $missingControls"
for ($i=0; $i -lt [Math]::Min(3, $currTriggers.Count); $i++) {
    Write-Host "  Sample trigger: $($currTriggers[$i].Value)"
}

$faqTriggers = [regex]::Matches($html, '<button[^>]*class="[^"]*c-faq-trigger[^"]*"[^>]*>')
Write-Host "`nFAQ triggers count: $($faqTriggers.Count)"
$faqMissingExpanded = 0
$faqMissingControls = 0
foreach ($ft in $faqTriggers) {
    if ($ft.Value -notmatch 'aria-expanded=') { $faqMissingExpanded++ }
    if ($ft.Value -notmatch 'aria-controls=') { $faqMissingControls++ }
}
Write-Host "FAQ triggers missing aria-expanded: $faqMissingExpanded"
Write-Host "FAQ triggers missing aria-controls: $faqMissingControls"
for ($i=0; $i -lt [Math]::Min(3, $faqTriggers.Count); $i++) {
    Write-Host "  Sample FAQ trigger: $($faqTriggers[$i].Value)"
}
