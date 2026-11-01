$filePath = "index.html"
$content = [System.IO.File]::ReadAllText($filePath)
$normalized = $content.Replace("`r`n", "`n")
[System.IO.File]::WriteAllText($filePath, $normalized, [System.Text.Encoding]::UTF8)
Write-Host "Normalized index.html to LF: " $normalized.Length "chars"
