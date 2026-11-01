$path = "courses\Content & SEO Blueprint\oneskills_pk_real_time_local_seo_keyword_intelligence_rank_1_action_dashboard.html"
$content = Get-Content $path -Raw

# Extract COURSES_LAB
if ($content -match 'const COURSES_LAB\s*=\s*(\[[\s\S]*?\]);\s*const CONTENT_GAPS') {
    $coursesJson = $matches[1]
    Set-Content -Path "scratch/seo_courses_lab.json" -Value $coursesJson
    Write-Host "Extracted COURSES_LAB"
}

# Extract CONTENT_GAPS
if ($content -match 'const CONTENT_GAPS\s*=\s*(\[[\s\S]*?\]);\s*const CHECKLIST_ITEMS') {
    $gapsJson = $matches[1]
    Set-Content -Path "scratch/seo_content_gaps.json" -Value $gapsJson
    Write-Host "Extracted CONTENT_GAPS"
}

# Extract KEYWORDS count and clusters
if ($content -match 'const KEYWORDS\s*=\s*(\[[\s\S]*?\]);\s*const COURSES_LAB') {
    $kwJson = $matches[1]
    Set-Content -Path "scratch/seo_keywords.json" -Value $kwJson
    Write-Host "Extracted KEYWORDS"
}

