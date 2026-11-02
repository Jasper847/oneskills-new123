$content = Get-Content courses/ai-web-development.html -Raw
if ($content -match '(?s)(<section class="c-admissions"[^>]*id="admissions".*?</section>)') {
    Write-Host "=== Admissions Section in ai-web-development.html ==="
    $lines = ($matches[1] -split "`r?`n")
    $lines[0..[Math]::Min(60, $lines.Length - 1)] -join "`r`n"
}

