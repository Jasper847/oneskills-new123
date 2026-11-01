$html = Get-Content 'courses\freelancing-mastery.html'
$totalLines = $html.Length

function Scan-Pattern([string]$name, [string]$pattern) {
    $found = [System.Collections.Generic.List[object]]::new()
    for ($i = 0; $i -lt $totalLines; $i++) {
        if ($html[$i] -match $pattern) {
            $found.Add([PSCustomObject]@{
                LineNumber = $i + 1
                LineText = $html[$i].Trim()
            })
        }
    }
    return [PSCustomObject]@{
        Name = $name
        Pattern = $pattern
        Count = $found.Count
        Items = $found
    }
}

$queries = @(
    @{ Name = "Batch Cap (12 seats / 10-12 desks / 12 students / 12 nodes)"; Pattern = "12 (seats|desks|students|workstations|learners|cohort|nodes)|10.{1,3}12 (desks|seats|students)" },
    @{ Name = "Workstation References"; Pattern = "workstation" },
    @{ Name = "Duration (12-Week / 3 Months)"; Pattern = "12.{0,3}week|3.{0,3}month" },
    @{ Name = "Lab Hours & Sessions (80+ hours, 96 hours, 36 physical labs)"; Pattern = "80\+|96|36 (physical|live|sessions|labs)" },
    @{ Name = "Tuition: PKR 25,000 / 12,500 / 8,500"; Pattern = "25,000|12,500|8,500|28,000" },
    @{ Name = "Instructor: Nisar Mehar"; Pattern = "Nisar Mehar|Nisar" },
    @{ Name = "Guarantee: 14-day 100% money-back / refund"; Pattern = "14.{0,3}day|money.{0,3}back|refund" },
    @{ Name = "Free Demo Class / Demo Pass"; Pattern = "Free Demo|demo class|demo seat" },
    @{ Name = "Local Retainers: PKR 30,000-80,000 / mo"; Pattern = "30,000|80,000|retainer" },
    @{ Name = "Platforms: Upwork / Fiverr"; Pattern = "Upwork|Fiverr" },
    @{ Name = "Campus: Sheikhupura Address / Landmarks"; Pattern = "Lahore.{1,3}Sargodha|Mian Hospital|KIPS College" },
    @{ Name = "Power Continuity: 20kVA Generator / UPS"; Pattern = "20kVA|generator|UPS" },
    @{ Name = "Network: 100Mbps Fiber"; Pattern = "100Mbps|optical f|fiber" },
    @{ Name = "Ratings & Social Proof: 5.0 / Google Reviews"; Pattern = "5\.0|Google Review" }
)

$results = foreach ($q in $queries) {
    Scan-Pattern $q.Name $q.Pattern
}

$results | Select-Object Name, Count | Format-Table -AutoSize

Write-Host "`n=== DETAILED OCCURRENCE BREAKDOWN ==="
foreach ($r in $results) {
    Write-Host "`n--- $($r.Name) [Total Count: $($r.Count)] ---" -ForegroundColor Cyan
    foreach ($m in $r.Items | Select-Object -First 8) {
        $preview = if ($m.LineText.Length -gt 120) { $m.LineText.Substring(0, 120) + "..." } else { $m.LineText }
        Write-Host "  Line $($m.LineNumber): $preview"
    }
    if ($r.Items.Count -gt 8) {
        Write-Host "  ... and $($r.Items.Count - 8) more occurrences." -ForegroundColor Yellow
    }
}
