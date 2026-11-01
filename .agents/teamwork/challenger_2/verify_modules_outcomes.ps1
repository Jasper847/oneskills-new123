# Extract and compare Modules and Outcomes
$html = Get-Content 'courses\freelancing-mastery.html' -Raw
$baseline = Get-Content '.agents\teamwork\explorer_survey_html\analysis.md' -Raw

Write-Host "=== OUTCOMES EXTRACTION FROM HTML ==="
$outcomeCards = [regex]::Matches($html, '(?s)<div class="c-outcome-card">.*?<span class="c-outcome-num">(Outcome \d\d)</span>\s*<h4>(.*?)</h4>\s*<p>(.*?)</p>')
Write-Host "Total outcome cards found: $($outcomeCards.Count)"
foreach ($oc in $outcomeCards) {
    $num = $oc.Groups[1].Value.Trim()
    $title = [System.Net.WebUtility]::HtmlDecode($oc.Groups[2].Value.Trim())
    $desc = [System.Net.WebUtility]::HtmlDecode($oc.Groups[3].Value.Trim())
    Write-Host "`n$num Title: $title"
    Write-Host "$num Desc: $desc"
}

Write-Host "`n=== MODULE TITLES EXTRACTION FROM HTML ==="
$moduleMatches = [regex]::Matches($html, '(?s)<h3 class="c-phase-title module-title-h3">\s*(Module \d\d:[^<]+)</h3>')
Write-Host "Total module headers found: $($moduleMatches.Count)"
foreach ($mm in $moduleMatches) {
    $rawMod = [System.Net.WebUtility]::HtmlDecode($mm.Groups[1].Value.Trim())
    Write-Host $rawMod
}

Write-Host "`n=== PRICING IN HTML ==="
$p25k = ([regex]::Matches($html, 'PKR 25,000')).Count
$p12k = ([regex]::Matches($html, '2 installments of PKR 12,500')).Count
$p8k = ([regex]::Matches($html, 'PKR 8,500\s*/\s*mo')).Count
Write-Host "PKR 25,000 count: $p25k"
Write-Host "2 installments of PKR 12,500 count: $p12k"
Write-Host "PKR 8,500 / mo count: $p8k"
