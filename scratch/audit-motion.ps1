$content = [System.IO.File]::ReadAllText("assets/css/main.css", [System.Text.Encoding]::UTF8)

# Find keyframes
$keyframes = [regex]::Matches($content, '@keyframes\s+([a-zA-Z0-9_-]+)')
Write-Host "Total @keyframes defined: $($keyframes.Count)"
foreach ($k in $keyframes) {
    Write-Host "  Keyframe: $($k.Groups[1].Value)"
}

# Check prefers-reduced-motion coverage
$reducedMatches = [regex]::Matches($content, '@media\s*\(\s*prefers-reduced-motion[^)]*\)\s*\{[\s\S]*?\}')
Write-Host "prefers-reduced-motion blocks: $($reducedMatches.Count)"

# Check transition: all
$allTransitions = [regex]::Matches($content, 'transition:\s*all\s+([^;]+);')
Write-Host "transition: all instances: $($allTransitions.Count)"
for ($i = 0; $i -lt [Math]::Min(5, $allTransitions.Count); $i++) {
    Write-Host "  Sample: $($allTransitions[$i].Value)"
}

# Check scale(0) instances
$scale0 = [regex]::Matches($content, 'scale\(0\)')
Write-Host "scale(0) instances (strictly prohibited by Emil Kowalski animate skill): $($scale0.Count)"
foreach ($s in $scale0) {
    Write-Host "  Found scale(0)"
}
