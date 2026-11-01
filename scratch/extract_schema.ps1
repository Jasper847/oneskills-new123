$c = Get-Content -Raw "courses\freelancing-mastery.html"
$matches = [regex]::Matches($c, '<script type="application/ld\+json">[\s\S]*?</script>')
foreach ($m in $matches) {
    Write-Output "=== SCHEMA BLOCK ==="
    Write-Output $m.Value
}

