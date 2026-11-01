$pages = @(
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

$results = foreach ($p in $pages) {
    $c = Get-Content $p -Raw
    
    # Title
    $title = if ($c -match '<title>(.*?)</title>') { $matches[1] } else { "" }
    
    # Meta Description
    $metaDesc = if ($c -match '<meta\s+name="description"\s+content="([^"]*)"') { $matches[1] } else { "" }
    
    # Canonical
    $canonical = if ($c -match '<link\s+rel="canonical"\s+href="([^"]*)"') { $matches[1] } else { "" }
    
    # OG Title & Image
    $ogTitle = if ($c -match '<meta\s+property="og:title"\s+content="([^"]*)"') { $matches[1] } else { "" }
    $ogImage = if ($c -match '<meta\s+property="og:image"\s+content="([^"]*)"') { $matches[1] } else { "" }
    
    # Check H1 Count
    $h1Count = ([regex]::Matches($c, '<h1\b')).Count
    
    # Check Images and missing alt
    $imgTags = [regex]::Matches($c, '<img\b[^>]*>')
    $missingAlt = 0
    $brokenImgLocal = 0
    foreach ($img in $imgTags) {
        $tag = $img.Value
        if ($tag -notmatch 'alt="[^"]*"') {
            $missingAlt++
        }
        if ($tag -match 'src="(\.\./[^"]+)"') {
            $src = $matches[1].Replace('../', '')
            if (-not (Test-Path $src)) {
                $brokenImgLocal++
            }
        }
    }
    
    # Check JSON-LD schema
    $schemaValid = $false
    $schemaType = ""
    $schemaPrice = ""
    $schemaRating = ""
    if ($c -match '(?s)<script type="application/ld\+json">(.*?)</script>') {
        try {
            $parsed = $matches[1].Trim() | ConvertFrom-Json
            $schemaValid = $true
            if ($parsed.'@graph') {
                $schemaType = ($parsed.'@graph' | ForEach-Object { $_.'@type' }) -join ", "
                $courseObj = $parsed.'@graph' | Where-Object { $_.'@type' -eq 'Course' }
                if ($courseObj) {
                    $schemaPrice = $courseObj.offers.price
                    $schemaRating = $courseObj.aggregateRating.ratingValue
                }
            } else {
                $schemaType = $parsed.'@type'
            }
        } catch {
            $schemaValid = $false
        }
    }

    [PSCustomObject]@{
        Page = (Split-Path $p -Leaf)
        TitleLength = $title.Length
        DescLength = $metaDesc.Length
        Canonical = $canonical
        H1Count = $h1Count
        TotalImgs = $imgTags.Count
        MissingAlt = $missingAlt
        BrokenImgs = $brokenImgLocal
        SchemaValid = $schemaValid
        SchemaTypes = $schemaType
        SchemaPrice = $schemaPrice
        SchemaRating = $schemaRating
    }
}

$results | Format-Table -AutoSize

