$c1 = [System.IO.File]::ReadAllText("courses/crypto-trading.html", [System.Text.Encoding]::UTF8)
$s1 = [regex]::Match($c1, '<style>([\s\S]*?)<\/style>').Groups[1].Value

$courses = @(
    "courses/forex-trading.html",
    "courses/freelancing-mastery.html",
    "courses/ai-tools-automation.html",
    "courses/ai-based-computer-course.html",
    "courses/programming-js-cpp.html",
    "courses/web3-blockchain.html"
)

Write-Host "Length of crypto-trading style: $($s1.Length) chars"

foreach ($c in $courses) {
    $content = [System.IO.File]::ReadAllText($c, [System.Text.Encoding]::UTF8)
    $s = [regex]::Match($content, '<style>([\s\S]*?)<\/style>').Groups[1].Value
    Write-Host "$c style length: $($s.Length) chars - Equals crypto: $($s -eq $s1)"
}
