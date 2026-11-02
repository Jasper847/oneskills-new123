$mainCss = Get-Content "assets/css/main.css"
$startIndex = 8808 # line with :root
$endIndex = 9398   # line with } before RESPONSIVE

$header = @"
/* ============================================================
   PREMIUM REFINED FOOTER -- ONESKILLS.PK
   Ultra-Premium Editorial Footer x Luxury Digital Academy
   Sheikhupura Architectural Signature (Apple-Level Restraint)
   ============================================================ */
"@

$footerCss = @($header) + $mainCss[$startIndex..$endIndex]
[System.IO.File]::WriteAllLines("assets/css/footer.css", $footerCss, [System.Text.Encoding]::UTF8)
Write-Output "Written $($footerCss.Length) lines to assets/css/footer.css"
