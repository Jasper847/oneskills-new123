$css = Get-Content "assets/css/course-v3-core.css" -Raw
$matches = [regex]::Matches($css, '\.([a-zA-Z0-9_-]+)\s*\{')
$unique = $matches | ForEach-Object { $_.Groups[1].Value } | Select-Object -Unique | Sort-Object
Write-Host "Found $($unique.Count) unique classes in course-v3-core.css"
$unique | Out-String | Select-String -Pattern "header|hero|card|tuition|subnav|nav|breadcrumb|price"

