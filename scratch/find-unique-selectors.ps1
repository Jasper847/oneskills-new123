$courses = @(
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/freelancing-mastery.html",
    "courses/ai-tools-automation.html",
    "courses/ai-based-computer-course.html",
    "courses/programming-js-cpp.html",
    "courses/web3-blockchain.html"
)

$allSelectors = @{}

foreach ($c in $courses) {
    $content = [System.IO.File]::ReadAllText($c, [System.Text.Encoding]::UTF8)
    $style = [regex]::Match($content, '<style>([\s\S]*?)<\/style>').Groups[1].Value
    $selectors = [regex]::Matches($style, '([.#a-zA-Z0-9_\-\:,\s]+)\s*\{')
    foreach ($sel in $selectors) {
        $clean = $sel.Groups[1].Value.Trim()
        if (-not $allSelectors.ContainsKey($clean)) {
            $allSelectors[$clean] = [System.Collections.Generic.List[string]]::new()
        }
        $allSelectors[$clean].Add($c)
    }
}

Write-Host "Total unique selectors across all 7 courses: $($allSelectors.Count)"
$uniqueToSingle = 0
foreach ($k in $allSelectors.Keys) {
    if ($allSelectors[$k].Count -lt 7) {
        Write-Host "Selector not in all 7: '$k' (found in $($allSelectors[$k].Count) files)"
        $uniqueToSingle++
    }
}
Write-Host "Differences count: $uniqueToSingle"
