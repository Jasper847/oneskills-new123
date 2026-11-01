$specs = Get-ChildItem -Path "courses\Content & SEO Blueprint\*.md"

foreach ($s in $specs) {
    $content = Get-Content $s.FullName -Raw
    Write-Host "=================================================="
    Write-Host "SPEC: $($s.Name)"
    
    # Extract Title / Heading
    if ($content -match '(?m)^#\s+(.+)$') { Write-Host "H1: $($matches[1])" }
    if ($content -match '(?m)statedFee[:\s]+([^\r\n]+)') { Write-Host "Fee: $($matches[1])" }
    if ($content -match '(?m)duration[:\s]+([^\r\n]+)') { Write-Host "Duration: $($matches[1])" }
    if ($content -match '(?m)primaryKeyword[:\s]+([^\r\n]+)') { Write-Host "Primary KW: $($matches[1])" }
    if ($content -match '(?m)instructor[:\s]+([^\r\n]+)') { Write-Host "Instructor: $($matches[1])" }
}

