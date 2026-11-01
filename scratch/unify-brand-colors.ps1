$targetFiles = @(
    "about.html",
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/freelancing-mastery.html",
    "courses/programming-js-cpp.html",
    "courses/web3-blockchain.html"
)

foreach ($path in $targetFiles) {
    if (Test-Path $path) {
        $content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)
        
        # 1. Update light mode accent tokens
        $content = $content.Replace('--accent: #0075de;', '--accent: #6e44ff;')
        $content = $content.Replace('--accent-cyan: #097fe8;', '--accent-cyan: #7b52ff;')
        $content = $content.Replace('--accent-purple: #0075de;', '--accent-purple: #6e44ff;')
        $content = $content.Replace('--accent-dim: #e6f3fe;', '--accent-dim: #f1edff;')
        $content = $content.Replace('--accent-line: rgba(0, 117, 222, .25);', '--accent-line: rgba(110, 68, 255, .25);')
        $content = $content.Replace('--line-strong: rgba(0, 117, 222, .35);', '--line-strong: rgba(110, 68, 255, .35);')
        $content = $content.Replace('--accent-convert: #0075de;', '--accent-convert: #6e44ff;')
        $content = $content.Replace('--accent-convert-hover: #0060b8;', '--accent-convert-hover: #5a30eb;')
        $content = $content.Replace('--accent-convert-shadow: rgba(0, 117, 222, .22);', '--accent-convert-shadow: rgba(110, 68, 255, .28);')

        # 2. Update dark mode accent tokens
        $content = $content.Replace('--line-strong: rgba(0, 117, 222, .45);', '--line-strong: rgba(123, 82, 255, .45);')
        $content = $content.Replace('--accent-dim: rgba(0, 117, 222, .18);', '--accent-dim: rgba(110, 68, 255, .18);')
        $content = $content.Replace('--accent-line: rgba(0, 117, 222, .4);', '--accent-line: rgba(123, 82, 255, .4);')
        $content = $content.Replace('--accent-convert-hover: #1e8bf0;', '--accent-convert-hover: #926cff;')
        $content = $content.Replace('--accent-convert-shadow: rgba(0, 117, 222, .35);', '--accent-convert-shadow: rgba(123, 82, 255, .35);')

        # 3. Ensure :focus-visible exists
        if (-not $content.Contains(':focus-visible')) {
            $focusRule = "`r`n    :focus-visible {`r`n      outline: 2px solid var(--accent);`r`n      outline-offset: 3px;`r`n      border-radius: 4px;`r`n    }`r`n"
            $content = $content.Replace('html {', $focusRule + '    html {')
        }

        [System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)
        Write-Host "Unified brand colors and focus ring in $path"
    }
}
