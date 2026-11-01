Get-ChildItem courses/*.html | ForEach-Object {
    $c = Get-Content $_.FullName -Raw
    $hasReviews = $c -match 'id="reviews"|c-reviews|c-testimonials|c-review-card'
    $hasReviewQuote = $c -match 'blockquote|c-review-quote|c-testimonial'
    $mapsLink = $c -match 'google\.com/search\?q=oneskills\+sheikhupura'
    Write-Host "$($_.Name) : hasReviewsSection=$hasReviews | hasQuotes=$hasReviewQuote | mapsLink=$mapsLink"
}

