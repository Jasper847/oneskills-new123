$htmlFiles = Get-ChildItem -Recurse -Filter *.html | Where-Object { $_.FullName -notmatch '_archive|Project References|\.agents' }

$fixedFiles = 0
foreach ($f in $htmlFiles) {
    $content = [System.IO.File]::ReadAllText($f.FullName, [System.Text.Encoding]::UTF8)
    $original = $content
    
    # Replace broken â€" with proper HTML entity &ndash;
    if ($content -match 'â€“|â€”|â€"') {
        $content = $content -replace 'â€“', '&ndash;'
        $content = $content -replace 'â€”', '&mdash;'
        $content = $content -replace 'â€"', '&ndash;'
    }

    # Also clean any remaining Lahore - Sargodha dash in footer
    $content = $content -replace 'Lahore\s*–\s*Sargodha', 'Lahore &ndash; Sargodha'
    $content = $content -replace 'Mon\s*–\s*Sat', 'Mon&ndash;Sat'
    $content = $content -replace '8:30 AM\s*–\s*6:00 PM', '8:30 AM &ndash; 6:00 PM'
    $content = $content -replace 'Sheikhupura\s*—\s*Our Home', 'Sheikhupura &mdash; Our Home'
    
    if ($content -ne $original) {
        [System.IO.File]::WriteAllText($f.FullName, $content, [System.Text.Encoding]::UTF8)
        Write-Output "Cleaned entities in: $($f.Name)"
        $fixedFiles++
    }
}

Write-Output "Total files cleaned: $fixedFiles"
