$urls = @(
  'http://localhost:8080/',
  'http://localhost:8080/about.html',
  'http://localhost:8080/guides/',
  'http://localhost:8080/guides/index.html',
  'http://localhost:8080/courses/ai-web-development.html',
  'http://localhost:8080/courses/shopify-ecommerce.html',
  'http://localhost:8080/courses/ai-tools-automation.html',
  'http://localhost:8080/courses/crypto-trading.html',
  'http://localhost:8080/courses/forex-trading.html',
  'http://localhost:8080/courses/freelancing-mastery.html',
  'http://localhost:8080/courses/ai-based-computer-course.html',
  'http://localhost:8080/guides/computer-courses-after-matric-in-sheikhupura.html',
  'http://localhost:8080/guides/which-computer-course-is-best-for-online-earning-in-sheikhupura.html',
  'http://localhost:8080/guides/office-management-ms-office-course-in-sheikhupura.html',
  'http://localhost:8080/guides/ai-graphic-design-video-editing-course-sheikhupura.html',
  'http://localhost:8080/guides/computer-courses-for-females-in-sheikhupura.html',
  'http://localhost:8080/guides/dit-vs-short-ai-computer-course-sheikhupura.html',
  'http://localhost:8080/guides/computer-it-courses-for-farooqabad-safdarabad-students.html',
  'http://localhost:8080/guides/ai-web-development-trading-courses-near-muridke.html',
  'http://localhost:8080/guides/seo-training-website-flipping-course-sheikhupura.html'
)

foreach ($u in $urls) {
  try {
    $res = Invoke-WebRequest -Uri $u -UseBasicParsing -TimeoutSec 3
    [PSCustomObject]@{ Url = $u; Status = $res.StatusCode }
  } catch {
    [PSCustomObject]@{ Url = $u; Status = $_.Exception.Message }
  }
}
