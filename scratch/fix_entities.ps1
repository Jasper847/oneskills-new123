$targetFiles = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/ai-tools-automation.html",
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/web3-blockchain.html",
    "courses/ai-based-computer-course.html",
    "courses/programming-js-cpp.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html",
    "about.html",
    "privacy-policy.html",
    "terms-of-service.html",
    "404.html",
    "index.html"
)

$ndash = [char]0x2013
$mdash = [char]0x2014

foreach ($filePath in $targetFiles) {
    if (Test-Path $filePath) {
        $text = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
        $orig = $text
        
        # Replace corrupt sequences or non-breaking dashes with pure ASCII entities
        $text = $text.Replace("Lahore " + $ndash + " Sargodha", "Lahore &ndash; Sargodha")
        $text = $text.Replace("Lahore " + [char]0x00E2 + [char]0x20AC + [char]0x201C + " Sargodha", "Lahore &ndash; Sargodha")
        $text = $text.Replace("Lahore â€`" Sargodha", "Lahore &ndash; Sargodha")
        $text = $text.Replace("Lahore â€"" Sargodha", "Lahore &ndash; Sargodha")
        $text = $text.Replace("Lahore ?" + " Sargodha", "Lahore &ndash; Sargodha")
        
        $text = $text.Replace("Mon" + $ndash + "Sat", "Mon&ndash;Sat")
        $text = $text.Replace("Monâ€`"Sat", "Mon&ndash;Sat")
        $text = $text.Replace("Monâ€""Sat", "Mon&ndash;Sat")
        
        $text = $text.Replace("8:30 AM " + $ndash + " 6:00 PM", "8:30 AM &ndash; 6:00 PM")
        $text = $text.Replace("8:30 AM â€`" 6:00 PM", "8:30 AM &ndash; 6:00 PM")
        $text = $text.Replace("8:30 AM â€"" 6:00 PM", "8:30 AM &ndash; 6:00 PM")
        
        $text = $text.Replace("Sheikhupura " + $mdash + " Our Home", "Sheikhupura &mdash; Our Home")
        $text = $text.Replace("Sheikhupura â€`" Our Home", "Sheikhupura &mdash; Our Home")
        $text = $text.Replace("Sheikhupura â€"" Our Home", "Sheikhupura &mdash; Our Home")

        # Also regex for any remaining â€"
        $text = [regex]::Replace($text, 'Lahore\s*[^a-zA-Z0-9\s<>&;,]+\s*Sargodha', 'Lahore &ndash; Sargodha')
        $text = [regex]::Replace($text, 'Mon\s*[^a-zA-Z0-9\s<>&;,]+\s*Sat', 'Mon&ndash;Sat')
        $text = [regex]::Replace($text, '8:30 AM\s*[^a-zA-Z0-9\s<>&;,]+\s*6:00 PM', '8:30 AM &ndash; 6:00 PM')
        $text = [regex]::Replace($text, 'Sheikhupura\s*[^a-zA-Z0-9\s<>&;,]+\s*Our Home', 'Sheikhupura &mdash; Our Home')
        
        if ($text -ne $orig) {
            [System.IO.File]::WriteAllText($filePath, $text, [System.Text.Encoding]::UTF8)
            Write-Output "Cleaned entities in: $filePath"
        }
    }
}
Write-Output "Done cleaning entities."
