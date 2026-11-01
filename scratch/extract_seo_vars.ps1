$path = "courses\Content & SEO Blueprint\oneskills_pk_real_time_local_seo_keyword_intelligence_rank_1_action_dashboard.html"
$content = Get-Content $path -Raw

# Search for const / var declarations in script
$matches = [regex]::Matches($content, "(const|var|let)\s+([A-Za-z0-9_]+)\s*=")
foreach ($m in $matches) {
    Write-Host "Variable: $($m.Groups[2].Value)"
}

