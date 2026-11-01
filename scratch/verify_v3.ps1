$ErrorActionPreference = "Stop"

$shots = @(
    @{ id = "hero"; name = "v3_desktop_hero.png"; w = 1440; h = 900; isMob = $false },
    @{ id = "curriculum"; name = "v3_desktop_curriculum.png"; w = 1440; h = 900; isMob = $false },
    @{ id = "admissions"; name = "v3_desktop_admissions.png"; w = 1440; h = 900; isMob = $false },
    @{ id = "hero"; name = "v3_mobile_hero.png"; w = 390; h = 844; isMob = $true }
)

$artifactDir = "C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e"

foreach ($s in $shots) {
    $tempOut = "C:\Users\Nisar\Desktop\oneskills new123\scratch\shots\sections\$($s.name)"
    $artifactOut = Join-Path $artifactDir $s.name
    Write-Output "Capturing $($s.name)..."
    if ($s.isMob) {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/courses/freelancing-mastery.html" -outPath $tempOut -width $s.w -height $s.h -scrollToId $s.id -isMobile
    } else {
        powershell -ExecutionPolicy Bypass -File scratch/test_ws.ps1 -url "http://localhost:8080/courses/freelancing-mastery.html" -outPath $tempOut -width $s.w -height $s.h -scrollToId $s.id
    }
    if (Test-Path $tempOut) {
        Copy-Item -Path $tempOut -Destination $artifactOut -Force
        Write-Output "Copied to $artifactOut"
    }
}
Write-Output "V3 visual capture complete!"

