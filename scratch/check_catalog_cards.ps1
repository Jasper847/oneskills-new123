$content = Get-Content courses/index.html -Raw
$cardMatches = [regex]::Matches($content, '(?s)<article[^>]*class="[^"]*c-catalog-card[^"]*"[^>]*>.*?</article>')

Write-Host "Found $($cardMatches.Count) catalog cards in courses/index.html"
foreach ($cm in $cardMatches) {
    $cardHtml = $cm.Value
    $title = if ($cardHtml -match '<h3[^>]*>(.*?)</h3>') { $matches[1] -replace '<[^>]+>', '' } else { "Unknown" }
    $img = if ($cardHtml -match '<img[^>]+src="([^"]+)"') { $matches[1] } else { "NONE" }
    Write-Host "Card: $title | Image: $img"
}

