$html = Get-Content 'courses\freelancing-mastery.html' -Raw

Write-Host "--- Batch Slots section ---"
$batchSection = [regex]::Match($html, '(?s)<div[^>]*class="[^"]*c-batch-slots-grid[^"]*"[^>]*>.*?</div>\s*</div>')
if ($batchSection.Success) {
    Write-Host $batchSection.Value.Substring(0, [Math]::Min(1000, $batchSection.Value.Length))
}

Write-Host "`n--- Curriculum Accordion triggers ---"
# Find buttons inside #curriculum
$currSection = [regex]::Match($html, '(?s)<section[^>]*id="curriculum"[^>]*>.*?</section>')
if ($currSection.Success) {
    $triggers = [regex]::Matches($currSection.Value, '<button\b[^>]*>')
    Write-Host "Buttons inside curriculum section: $($triggers.Count)"
    foreach ($t in $triggers) {
        Write-Host "  $($t.Value)"
    }
}

Write-Host "`n--- FAQ Triggers ---"
$faqSection = [regex]::Match($html, '(?s)<section[^>]*id="faq"[^>]*>.*?</section>')
if ($faqSection.Success) {
    $faqBtns = [regex]::Matches($faqSection.Value, '<button\b[^>]*>')
    Write-Host "Buttons inside FAQ section: $($faqBtns.Count)"
    foreach ($t in $faqBtns) {
        Write-Host "  $($t.Value)"
    }
}
