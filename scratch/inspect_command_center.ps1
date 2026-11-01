$path = "courses\Content & SEO Blueprint\oneskills_pk_real_time_local_seo_keyword_intelligence_rank_1_action_dashboard.html"
$lines = Get-Content $path
Write-Host "Total lines: $($lines.Length)"

# Find headers, sections, keywords
$headers = Select-String -Path $path -Pattern '<h[1-4]' | Select-Object -First 30 LineNumber, Line
foreach ($h in $headers) {
    Write-Host "Line $($h.LineNumber): $($h.Line.Trim())"
}

