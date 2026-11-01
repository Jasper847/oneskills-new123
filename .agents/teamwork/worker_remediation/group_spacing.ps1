$items = Import-Csv '.agents/teamwork/worker_remediation/spacing_violations.csv'
$items | Group-Object Val | Sort-Object Count -Descending | Select-Object Count, Name | Format-Table -AutoSize
