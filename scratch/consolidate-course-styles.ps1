$cryptoContent = [System.IO.File]::ReadAllText('courses/crypto-trading.html', [System.Text.Encoding]::UTF8)
$styleMatch = [regex]::Match($cryptoContent, '<style>([\s\S]*?)<\/style>')
$cssHeader = '/* ONESKILLS - Course Layout and Components Stylesheet */' + "`r`n`r`n"
$cssContent = $cssHeader + $styleMatch.Groups[1].Value.Trim()

[System.IO.File]::WriteAllText('assets/css/course-v1.css', $cssContent, [System.Text.Encoding]::UTF8)
Write-Host "Created assets/css/course-v1.css"

$courses = @(
    'courses/crypto-trading.html',
    'courses/forex-trading.html',
    'courses/freelancing-mastery.html',
    'courses/ai-tools-automation.html',
    'courses/ai-based-computer-course.html',
    'courses/programming-js-cpp.html',
    'courses/web3-blockchain.html'
)

$linkTag = '<link rel="stylesheet" href="../assets/css/course-v1.css">'

foreach ($c in $courses) {
    $content = [System.IO.File]::ReadAllText($c, [System.Text.Encoding]::UTF8)
    $beforeLines = ($content -split "`r?`n").Length
    
    $content = [regex]::Replace($content, '\s*<style>[\s\S]*?<\/style>', "`r`n  $linkTag")
    $afterLines = ($content -split "`r?`n").Length
    
    [System.IO.File]::WriteAllText($c, $content, [System.Text.Encoding]::UTF8)
    Write-Host "$c lines reduced: $beforeLines -> $afterLines"
}
