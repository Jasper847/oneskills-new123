$raw = Get-Content -Raw "redesined.html"
$raw = $raw.Replace('href="assets/', 'href="../assets/')
$raw = $raw.Replace('src="assets/', 'src="../assets/')
$raw = $raw.Replace('srcset="assets/', 'srcset="../assets/')
$raw = $raw.Replace('href="favicon.webp"', 'href="../favicon.webp"')
$raw = $raw.Replace('href="index.html', 'href="../index.html')
$raw = $raw.Replace('href="privacy-policy.html"', 'href="../privacy-policy.html"')
$raw = $raw.Replace('href="terms-of-service.html"', 'href="../terms-of-service.html"')

[System.IO.File]::WriteAllText("courses/redesined.html", $raw, [System.Text.Encoding]::UTF8)
Copy-Item "courses/redesined.html" "courses/redesigned.html" -Force
Write-Output "Synced courses/redesined.html and courses/redesigned.html successfully."
