$path = "assets/css/main.css"
$lines = [System.IO.File]::ReadAllLines($path, [System.Text.Encoding]::UTF8)
$newLines = [System.Collections.Generic.List[string]]::new()

$inserted = $false
for ($i = 0; $i -lt $lines.Length; $i++) {
    $newLines.Add($lines[$i])
    if ($lines[$i].Trim() -eq ":focus-visible {" -and $lines[$i+1].Contains("outline: 2px solid var(--accent);")) {
        # Advance until closing brace
        $j = $i + 1
        while ($j -lt $lines.Length -and $lines[$j].Trim() -ne "}") {
            $newLines.Add($lines[$j])
            $j++
        }
        $newLines.Add($lines[$j])
        $i = $j
        
        # Insert :active tactile press feedback
        $newLines.Add("")
        $newLines.Add("    /* Tactile Press Feedback (Emil Kowalski Philosophy) */")
        $newLines.Add("    .btn-primary:active,")
        $newLines.Add("    .btn-hero-primary:active,")
        $newLines.Add("    .btn-action-primary:active,")
        $newLines.Add("    .btn-header-primary:active {")
        $newLines.Add("      transform: scale(0.98);")
        $newLines.Add("      transition: transform 120ms ease-out;")
        $newLines.Add("    }")
        $inserted = $true
    }
}

if ($inserted) {
    [System.IO.File]::WriteAllLines($path, $newLines, [System.Text.Encoding]::UTF8)
    Write-Host "Successfully inserted tactile button feedback into $path"
} else {
    Write-Host "Could not find insertion anchor"
}
