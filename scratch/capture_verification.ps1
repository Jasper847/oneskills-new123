$ErrorActionPreference = "Stop"

$shots = @(
    @{ id = "hero"; name = "view_hero_desktop.png"; w = 1440; h = 900; isMob = $false; dark = $false },
    @{ id = "internship"; name = "view_internship_desktop.png"; w = 1440; h = 900; isMob = $false; dark = $false },
    @{ id = "specs"; name = "view_specs_desktop.png"; w = 1440; h = 900; isMob = $false; dark = $false },
    @{ id = "admissions"; name = "view_admissions_desktop.png"; w = 1440; h = 900; isMob = $false; dark = $false },
    @{ id = "internship"; name = "view_internship_mobile.png"; w = 390; h = 844; isMob = $true; dark = $false },
    @{ id = "admissions"; name = "view_admissions_mobile.png"; w = 390; h = 844; isMob = $true; dark = $false }
)

foreach ($s in $shots) {
    $outPath = "C:\Users\Nisar\Desktop\oneskills new123\scratch\shots\sections\$($s.name)"
    Write-Output "Capturing $($s.name) at $($s.w)x$($s.h)..."
    if ($s.isMob) {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/courses/freelancing-mastery.html" -outPath $outPath -width $s.w -height $s.h -scrollToId $s.id -isMobile
    } else {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/courses/freelancing-mastery.html" -outPath $outPath -width $s.w -height $s.h -scrollToId $s.id
    }
}

Write-Output "All screenshots captured successfully!"

