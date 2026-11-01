$html = Get-Content 'courses\freelancing-mastery.html'

function Get-LineOccurrences($regex) {
    $list = @()
    for ($i = 0; $i -lt $html.Length; $i++) {
        if ($html[$i] -match $regex) {
            $list += ($i + 1)
        }
    }
    return $list
}

$inventory = @(
    @{ Fact = "Upwork & Fiverr Platforms"; Regex = "Upwork|Fiverr"; Prime = "#skills, #curriculum Week 1-2 & Week 12" },
    @{ Fact = "Dedicated Workstations (Hardware Promise)"; Regex = "workstation"; Prime = "#specs (Production Workstations)" },
    @{ Fact = "Duration: 12 Weeks / 3 Months"; Regex = "12.{0,3}week|3.{0,3}month"; Prime = "Hero Snapshot & Admissions Meta" },
    @{ Fact = "14-Day 100% Money-Back Guarantee"; Regex = "14.{0,3}day|money.{0,3}back|refund"; Prime = "#admissions (Guarantee Strip)" },
    @{ Fact = "Free Demo Class / Demo Pass"; Regex = "Free Demo|demo class|demo seat"; Prime = "Hero Primary CTA & Final CTA" },
    @{ Fact = "Local Retainers (PKR 30k-80k / mo)"; Regex = "30,000|80,000|retainer"; Prime = "#overview (Outcome 04) & Curriculum Week 12" },
    @{ Fact = "Sheikhupura Campus Landmarks"; Regex = "Lahore.{1,3}Sargodha|Mian Hospital|KIPS College"; Prime = "#campus (Commuter Hub) & Footer" },
    @{ Fact = "Lab Hours & Lab Count (80+ hrs vs 96 hrs)"; Regex = "96|80\+|36 (physical|live|sessions|labs)"; Prime = "Hero Snapshot & Admissions Meta" },
    @{ Fact = "Instructor: Nisar Mehar"; Regex = "Nisar Mehar|Nisar"; Prime = "#mentor (Instructor Dossier)" },
    @{ Fact = "Batch Cap (12 Seats / 10-12 Desks)"; Regex = "12 (seats|desks|students|workstations|nodes|cohort)|10.{1,3}12"; Prime = "#admissions (Batch Schedule)" },
    @{ Fact = "20kVA Generator & Power Continuity"; Regex = "20kVA|generator|UPS"; Prime = "#specs (Node Continuity)" },
    @{ Fact = "100Mbps Dedicated Optical Fiber"; Regex = "100Mbps|optical f|fiber"; Prime = "#specs (Network Backbone)" },
    @{ Fact = "Ratings (5.0 vs 4.9 Discrepancy)"; Regex = "5\.0|4\.9"; Prime = "#reviews (Verified Google Reviews)" },
    @{ Fact = "Tuition (PKR 25,000 / 12,500 / 8,500)"; Regex = "25,000|12,500|8,500"; Prime = "#admissions (Fee Calculator & Split Plans)" }
)

Write-Host "| Fact / Claim | Count | Primary Home | Source Lines |"
Write-Host "|---|---:|---|---|"
foreach ($item in $inventory) {
    $lines = Get-LineOccurrences $item.Regex
    $lineStr = ($lines | Select-Object -First 6) -join ", "
    if ($lines.Count -gt 6) { $lineStr += " ... ($($lines.Count) total)" }
    Write-Host "| **$($item.Fact)** | $($lines.Count) | $($item.Prime) | Lines: $lineStr |"
}

