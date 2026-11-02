$content = Get-Content courses/crypto-trading.html -Raw

if ($content -match '(?s)(<div class="c-tuition-card">.*?</div>\s*</aside>)') {
    Write-Host "=== Tuition Card in Hero ==="
    Write-Host $matches[1]
}

if ($content -match '(?s)(<section id="location"[^>]*>.*?</section>)') {
    Write-Host "=== Location Section ==="
    # First 40 lines
    $lines = ($matches[1] -split "`r?`n")
    $lines[0..[Math]::Min(40, $lines.Length - 1)] -join "`r`n"
}

