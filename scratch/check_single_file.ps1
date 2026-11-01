param([string]$path)
$c = Get-Content $path -Raw
[PSCustomObject]@{
    File = $path
    Count28k = [regex]::Matches($c, '28,000|28000').Count
    Count35k = [regex]::Matches($c, '35,000|35000').Count
    Count175k = [regex]::Matches($c, '17,500|17500').Count
    RadioWithAriaSelected = [regex]::Matches($c, 'role="radio"[^>]*aria-selected').Count
    TabWithAriaPressed = [regex]::Matches($c, 'role="tab"[^>]*aria-pressed').Count
    RatingCount15 = [regex]::Matches($c, '"ratingCount":\s*"15"').Count
    PostalCode39350 = [regex]::Matches($c, '"postalCode":\s*"39350"').Count
}
