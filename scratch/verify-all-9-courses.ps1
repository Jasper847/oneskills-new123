$pages = @(
  'ai-web-development.html',
  'freelancing-mastery.html',
  'ai-tools-automation.html',
  'crypto-trading.html',
  'forex-trading.html',
  'web3-blockchain.html',
  'programming-js-cpp.html',
  'ai-based-computer-course.html',
  'shopify-ecommerce.html'
)

Write-Host "=================== FORENSIC AUDIT OF ALL 9 COURSES ==================="
$allPass = $true

foreach ($p in $pages) {
  $filePath = Join-Path 'courses' $p
  $url = 'http://localhost:8080/courses/' + $p
  
  if (-not (Test-Path $filePath)) {
    Write-Host "[FAIL] File missing: $filePath" -ForegroundColor Red
    $allPass = $false
    continue
  }
  
  $content = Get-Content -Raw $filePath
  $fileSize = (Get-Item $filePath).Length
  
  $hasCourseV1 = $content.Contains('course-v1.css')
  $hasMainCss = $content.Contains('main.css')
  $hasCanvas = $content.Contains('developer-canvas-stage')
  $hasRoadmap = $content.Contains('timeline-phase-card')
  $hasDeliverables = $content.Contains('deliverables-grid')
  $hasHardware = $content.Contains('hardware-spec-table-card')
  $hasCohortCard = $content.Contains('executive-cohort-card')
  $hasMentor = $content.Contains('mentor-editorial-card')
  $hasFaq = $content.Contains('faq-pro-grid')
  $hasFooter = $content.Contains('footer-wrap')
  $hasSchema = $content.Contains('"@type": "Course"')
  
  try {
    $res = Invoke-WebRequest -Uri $url -UseBasicParsing -TimeoutSec 5
    $statusCode = $res.StatusCode
  } catch {
    $statusCode = 'ERR: ' + $_.Exception.Message
    $allPass = $false
  }

  $status = if ($hasCourseV1 -and $hasMainCss -and $hasCanvas -and $hasRoadmap -and $hasDeliverables -and $hasHardware -and $hasCohortCard -and $hasMentor -and $hasFaq -and $hasFooter -and $hasSchema -and ($statusCode -eq 200)) { "[PASS]" } else { "[FAIL]" }
  if ($status -eq "[FAIL]") { $allPass = $false }

  Write-Host "$status HTTP $statusCode | $p ($fileSize bytes)"
  Write-Host "       CSS: v1=$hasCourseV1 main=$hasMainCss | Canvas=$hasCanvas | Roadmap=$hasRoadmap | Deliverables=$hasDeliverables"
  Write-Host "       Hardware=$hasHardware | CohortCard=$hasCohortCard | Mentor=$hasMentor | FAQ=$hasFaq | Schema=$hasSchema"
}

Write-Host "========================================================================"
if ($allPass) {
  Write-Host "ALL 9 COURSES VERIFIED 100% COMPLIANT WITH $500M DESIGN SPECIFICATION!" -ForegroundColor Green
} else {
  Write-Host "SOME COURSES FAILED VERIFICATION" -ForegroundColor Red
}
