$vars = @(
    "--footer-wrap-bg",
    "--footer-card-bg",
    "--footer-card-border",
    "--footer-card-shadow",
    "--font-display"
)
$css = Get-Content "assets/css/main.css"
for ($i = 0; $i -lt 200; $i++) {
    foreach ($v in $vars) {
        if ($css[$i] -match [regex]::Escape($v)) {
            Write-Output "Line $($i+1): $($css[$i])"
        }
    }
}

