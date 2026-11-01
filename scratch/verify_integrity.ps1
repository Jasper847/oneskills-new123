Add-Type -AssemblyName System.Web

$html = Get-Content 'courses\freelancing-mastery.html' -Raw
$decoded = [System.Web.HttpUtility]::HtmlDecode($html)

$requiredItems = @(
    'PKR 25,000',
    '12,500',
    '8,500',
    'Nisar Mehar',
    'Sheikhupura',
    'Farooqabad',
    'Safdarabad',
    'Muridke',
    'Nankana Sahib',
    'Module 01',
    'Module 02',
    'Module 03',
    'Module 04',
    'Module 05',
    'Module 06',
    'Module 07',
    'Module 08',
    'Module 09',
    'Module 10',
    'Module 11',
    'Module 12',
    'Meta & Google Ads Mastery',
    'AI Content & Video Engine',
    'Local SEO & Google Maps Rank',
    'Client Monetization & Dual Income',
    'Live Meta Ad Campaign & Lead Funnel',
    'AI Creative & Viral Video Portfolio',
    'Top-Rated Upwork & Fiverr Freelance Suite',
    'Dual Payment Rails: International USD & Local PKR',
    'Why OneSkills',
    'What''s Included',
    'Class Requirements',
    'Who Should Join',
    'Dedicated Intel Core i7 Workstation',
    '20kVA Commercial Generator',
    'Dedicated 100Mbps Optical Fibre Line',
    'What is Freelancing & How It Works',
    'Platform Rules, Safety & Payoneer'
)

$passed = 0
$failed = 0

foreach ($item in $requiredItems) {
    if ($decoded.Contains($item)) {
        Write-Host "[PASS] Verified: $item" -ForegroundColor Green
        $passed++
    } else {
        Write-Host "[FAIL] Missing: $item" -ForegroundColor Red
        $failed++
    }
}

Write-Host "--- Integrity Verification Summary ---"
Write-Host "Total Verified: $passed / $($requiredItems.Count)"
Write-Host "Failed: $failed"
