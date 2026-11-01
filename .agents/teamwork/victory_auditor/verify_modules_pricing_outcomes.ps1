# verify_modules_pricing_outcomes.ps1
$analysis = Get-Content '.agents\teamwork\explorer_survey_html\analysis.md' -Raw
$html = Get-Content 'courses\freelancing-mastery.html' -Raw

Write-Host "=== VERIFYING 12 MODULES ===" -ForegroundColor Cyan
$analysisModules = [regex]::Matches($analysis, '(?m)^\s*-\s*\*\*Module\s+(\d\d):\s*(.*?)\*\*\s*\((.*?)\)$')
Write-Host "Baseline modules found: $($analysisModules.Count)"

$htmlModules = [regex]::Matches($html, '<h3 class="[^"]*module-title-h3[^"]*">\s*(Module\s+\d\d:\s*.*?)\s*</h3>')
Write-Host "HTML modules found: $($htmlModules.Count)"

$moduleMismatches = 0
for ($i = 0; $i -lt [Math]::Min($analysisModules.Count, $htmlModules.Count); $i++) {
    $aNum = $analysisModules[$i].Groups[1].Value.Trim()
    $aName = [System.Net.WebUtility]::HtmlDecode($analysisModules[$i].Groups[2].Value.Trim())
    $aFull = "Module ${aNum}: $aName"
    
    $hFull = [System.Net.WebUtility]::HtmlDecode($htmlModules[$i].Groups[1].Value.Trim())
    
    $cleanA = ($aFull -replace '\s+', ' ').Trim()
    $cleanH = ($hFull -replace '\s+', ' ').Trim()
    
    if ($cleanA -ne $cleanH) {
        $moduleMismatches++
        Write-Host "Module mismatch at ${i}:"
        Write-Host "  Baseline: $cleanA"
        Write-Host "  HTML:     $cleanH"
    }
}
Write-Host "Total module mismatches: $moduleMismatches"

Write-Host "`n=== VERIFYING 4 LEARNING OUTCOMES ===" -ForegroundColor Cyan
$htmlOutcomes = [regex]::Matches($html, '(?s)<div class="c-outcome-card">.*?<span class="c-outcome-num">(Outcome \d\d)</span>\s*<h4>(.*?)</h4>\s*<p>(.*?)</p>')
Write-Host "HTML outcome cards found: $($htmlOutcomes.Count)"
foreach ($oc in $htmlOutcomes) {
    Write-Host "  $($oc.Groups[1].Value): $($oc.Groups[2].Value)"
}

Write-Host "`n=== VERIFYING PRICING NUMBERS ===" -ForegroundColor Cyan
$p25k = ([regex]::Matches($html, 'PKR 25,000')).Count
$p12k = ([regex]::Matches($html, '2 installments of PKR 12,500')).Count
$p8k = ([regex]::Matches($html, 'PKR 8,500\s*/\s*mo')).Count
Write-Host "PKR 25,000 occurrences: $p25k (Expected >= 2)"
Write-Host "2 installments of PKR 12,500 occurrences: $p12k (Expected >= 1)"
Write-Host "PKR 8,500 / mo occurrences: $p8k (Expected >= 2)"

$pricingOk = ($p25k -ge 2 -and $p12k -ge 1 -and $p8k -ge 2)
Write-Host "Pricing preservation: $pricingOk" -ForegroundColor $(if ($pricingOk) { "Green" } else { "Red" })
