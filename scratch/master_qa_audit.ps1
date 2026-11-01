# Master QA Audit Script for OneSkills Academy V3 Portfolio

$pages = @(
  "courses/freelancing-mastery.html",
  "courses/ai-web-development.html",
  "courses/programming-js-cpp.html",
  "courses/ai-based-computer-course.html",
  "courses/ai-tools-automation.html",
  "courses/web3-blockchain.html",
  "courses/forex-trading.html",
  "courses/crypto-trading.html",
  "courses/shopify-ecommerce.html",
  "courses/index.html"
)

$allPassed = $true

Write-Host "======================================================"
Write-Host "1. Testing HTTP 200 for all 10 pages on localhost:8080"
Write-Host "======================================================"

foreach ($p in $pages) {
  $url = "http://localhost:8080/$p"
  try {
    $res = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5
    if ($res.StatusCode -eq 200) {
      Write-Host " [PASS] 200 OK: $p ($($res.Content.Length) bytes)" -ForegroundColor Green
    } else {
      Write-Host " [FAIL] Status $($res.StatusCode): $p" -ForegroundColor Red
      $allPassed = $false
    }
  } catch {
    Write-Host " [FAIL] Exception on $url : $_" -ForegroundColor Red
    $allPassed = $false
  }
}

Write-Host "`n======================================================"
Write-Host "2. Validating Schema.org JSON-LD Syntax in all files"
Write-Host "======================================================"

foreach ($p in $pages) {
  if (Test-Path $p) {
    $content = Get-Content -Path $p -Raw
    $pattern = '(?s)<script type="application/ld\+json">(.*?)</script>'
    $matches = [regex]::Matches($content, $pattern)
    if ($matches.Count -eq 0) {
      Write-Host " [FAIL] No JSON-LD found in $p" -ForegroundColor Red
      $allPassed = $false
    } else {
      foreach ($m in $matches) {
        $jsonStr = $m.Groups[1].Value.Trim()
        try {
          $parsed = $jsonStr | ConvertFrom-Json
          Write-Host " [PASS] JSON-LD valid: $p (Root type: $($parsed.'@type' -or $parsed.'@graph'[0].'@type'))" -ForegroundColor Green
        } catch {
          Write-Host " [FAIL] JSON-LD Parse Error in $p : $_" -ForegroundColor Red
          $allPassed = $false
        }
      }
    }
  }
}

Write-Host "`n======================================================"
Write-Host "3. Scanning for Forbidden Tutor LMS & Workstation Claims"
Write-Host "======================================================"

$forbiddenPatterns = @(
  "\(0\.0/\s*0\s*Rating\)",
  "\(0\s*Rating\)",
  "Price:\s*Free",
  "emptystate\.svg",
  "dedicated Core i7",
  "dedicated workstation",
  "workstation nodes",
  "supplied student hardware"
)

foreach ($p in $pages) {
  $content = Get-Content -Path $p -Raw
  $pageClean = $true
  foreach ($fp in $forbiddenPatterns) {
    if ($content -match $fp) {
      Write-Host " [FAIL] $p contains forbidden pattern: $fp" -ForegroundColor Red
      $allPassed = $false
      $pageClean = $false
    }
  }
  if ($pageClean) {
    Write-Host " [PASS] Clean: $p (No LMS bugs or unapproved workstation claims)" -ForegroundColor Green
  }
}

Write-Host "`n======================================================"
Write-Host "4. Checking BYOL Laptop & 14-Day Refund Preservations"
Write-Host "======================================================"

foreach ($p in $pages) {
  $content = Get-Content -Path $p -Raw
  $hasLaptop = ($content -match "laptop" -or $content -match "BYOL")
  $hasRefund = ($content -match "14-Day" -or $content -match "14 days" -or $content -match "refund")
  
  if ($hasLaptop -and $hasRefund) {
    Write-Host " [PASS] Policies Verified: $p (Laptop & Refund confirmed)" -ForegroundColor Green
  } else {
    Write-Host " [FAIL] Missing Policy in $p (Laptop: $hasLaptop, Refund: $hasRefund)" -ForegroundColor Red
    $allPassed = $false
  }
}

Write-Host "`n======================================================"
Write-Host "5. Verifying Referenced Assets on Disk"
Write-Host "======================================================"

$cssFiles = @("assets/css/course-v3-core.css")
$jsFiles = @("assets/js/course-v3-core.js")

foreach ($f in ($cssFiles + $jsFiles)) {
  if (Test-Path $f) {
    Write-Host " [PASS] Found core asset: $f ($( (Get-Item $f).Length ) bytes)" -ForegroundColor Green
  } else {
    Write-Host " [FAIL] Missing asset: $f" -ForegroundColor Red
    $allPassed = $false
  }
}

Write-Host "`n======================================================"
if ($allPassed) {
  Write-Host "OVERALL QA STATUS: ALL 10 PAGES 100% PRODUCTION READY!" -ForegroundColor Green
} else {
  Write-Host "OVERALL QA STATUS: FAILURES DETECTED" -ForegroundColor Red
}
Write-Host "======================================================"

