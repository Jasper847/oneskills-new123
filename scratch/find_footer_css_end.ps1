$lines = Get-Content "assets/css/main.css"
for ($i = 8842; $i -lt 9450; $i++) {
    if ($lines[$i] -match '\.footer-hiran-badge') {
        Write-Output "Line $($i+1): $($lines[$i])"
    }
}

