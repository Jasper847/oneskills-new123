$files = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/web3-blockchain.html",
    "courses/forex-trading.html",
    "courses/crypto-trading.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html"
)

$results = @()

foreach ($f in $files) {
    if (Test-Path $f) {
        $content = Get-Content $f -Raw
        
        # Title
        $title = ""
        if ($content -match '<title>(.*?)</title>') { $title = $matches[1] }
        
        # H1
        $h1 = ""
        if ($content -match '<h1[^>]*>(.*?)</h1>') { $h1 = ($matches[1] -replace '<[^>]+>', ' ').Trim() }
        
        # Fee in Schema
        $schemaPrice = ""
        if ($content -match '"price":\s*"([^"]+)"') { $schemaPrice = $matches[1] }
        
        # Duration in Schema
        $schemaDuration = ""
        if ($content -match '"duration":\s*"([^"]+)"') { $schemaDuration = $matches[1] }
        
        # TimeRequired in Schema
        $schemaTime = ""
        if ($content -match '"timeRequired":\s*"([^"]+)"') { $schemaTime = $matches[1] }
        
        # Instructors in Schema
        $instructors = @()
        $pattern = '(?s)"instructor":\s*(\[.*?\]|\{.*?\})'
        if ($content -match $pattern) {
            $instBlock = $matches[1]
            $nameMatches = [regex]::Matches($instBlock, '"name":\s*"([^"]+)"')
            foreach ($nm in $nameMatches) {
                $instructors += $nm.Groups[1].Value
            }
        }
        
        # AggregateRating in Schema
        $schemaRating = ""
        if ($content -match '"ratingValue":\s*"([^"]+)"') { $schemaRating = $matches[1] }
        $schemaRatingCount = ""
        if ($content -match '"ratingCount":\s*"([^"]+)"') { $schemaRatingCount = $matches[1] }

        # Visible Tuition
        $visibleFees = @()
        $feeMatches = [regex]::Matches($content, 'PKR\s*[\d,]+')
        foreach ($fm in $feeMatches) {
            if ($visibleFees -notcontains $fm.Value) { $visibleFees += $fm.Value }
        }

        # Visible Duration
        $visibleWeeks = ""
        if ($content -match '(\d+\s*Weeks|\d+-Week)') { $visibleWeeks = $matches[1] }

        # Visible Hours/Lessons
        $visibleHours = ""
        if ($content -match '(\d+\+?\s*Hours|\d+\+?\s*Lessons|\d+\s*Practical Lessons|\d+\s*Sessions)') { $visibleHours = $matches[1] }

        [PSCustomObject]@{
            File = $f
            Title = $title
            H1 = $h1
            SchemaPrice = $schemaPrice
            SchemaDuration = $schemaDuration
            SchemaTime = $schemaTime
            Instructors = ($instructors -join ", ")
            RatingValue = $schemaRating
            RatingCount = $schemaRatingCount
            VisibleWeeks = $visibleWeeks
            VisibleHours = $visibleHours
            VisibleFees = ($visibleFees -join " | ")
        }
    }
}

$results | Format-List

