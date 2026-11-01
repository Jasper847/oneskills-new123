Get-ChildItem -Recurse -Include *.html,*.js | Where-Object { $_.FullName -notmatch '\\\.git|node_modules|scratch' } | ForEach-Object {
    $c = Get-Content $_.FullName -Raw
    if ($c -match '(3287777098|0309[\s-]?6036127|\+88457845695|\+4857548854826)') {
        Write-Host "$($_.FullName) contains: $($matches[1])"
    }
}

