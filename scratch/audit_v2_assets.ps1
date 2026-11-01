$results = Get-ChildItem -Recurse -File -Include *.html,*.js,*.css | Where-Object { $_.FullName -notmatch '\\\.git|\\scratch' } | ForEach-Object {
    $matches = Select-String -Path $_.FullName -Pattern "course-v2"
    if ($matches) {
        [PSCustomObject]@{
            File = $_.FullName.Replace("c:\Users\Nisar\Desktop\oneskills new123\", "")
            MatchCount = $matches.Count
            FirstMatch = $matches[0].Line.Trim()
        }
    }
}
$results | Format-Table -AutoSize

