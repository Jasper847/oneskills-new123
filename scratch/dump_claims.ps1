$html = Get-Content 'courses\freelancing-mastery.html'

function Get-DetailedOccurrences($title, $pattern) {
    Write-Host "=================================================="
    Write-Host "CATEGORY: $title"
    Write-Host "=================================================="
    for ($i = 0; $i -lt $html.Length; $i++) {
        if ($html[$i] -match $pattern) {
            $line = $i + 1
            $text = $html[$i].Trim()
            Write-Host "Line $line : $text"
        }
    }
    Write-Host ""
}

Get-DetailedOccurrences "RATINGS (5.0 vs 4.9)" "5\.0|4\.9"
Get-DetailedOccurrences "HOURS (80+ vs 96)" "80\+|96"
Get-DetailedOccurrences "BATCH SIZE (10-12 vs 12)" "10[^\d]{1,5}12|12 (seats|desks|students|workstations|nodes|learners|cohort)"
Get-DetailedOccurrences "INSTRUCTOR (Nisar Mehar)" "Nisar Mehar|Nisar"
Get-DetailedOccurrences "GUARANTEE (14-day money back)" "14[^\d]{1,5}day|money[^\w]{1,5}back|guarantee"
Get-DetailedOccurrences "TUITION & INSTALLMENTS" "25,000|12,500|8,500|28,000"
Get-DetailedOccurrences "FREE DEMO CTAs" "Free Demo|demo class|demo seat"

