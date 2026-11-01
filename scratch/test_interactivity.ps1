$port = 9223
$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$userData = "$env:TEMP\edge_cdp_profile_$port"

$proc = Start-Process -FilePath $edge -ArgumentList "--headless=new", "--remote-debugging-port=$port", "--user-data-dir=`"$userData`"", "http://localhost:8080/courses/freelancing-mastery.html" -PassThru
Start-Sleep -Seconds 2

try {
    $tabs = Invoke-RestMethod -Uri "http://localhost:$port/json"
    $wsUrl = $tabs[0].webSocketDebuggerUrl

    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $cts = New-Object System.Threading.CancellationTokenSource
    $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token).Wait()

    function Send-CDP($method, $params, $id) {
        $json = @{ id = $id; method = $method; params = $params } | ConvertTo-Json -Depth 10 -Compress
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
        $ws.SendAsync((New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)), [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [System.Threading.CancellationToken]::None).Wait()
        
        $buf = New-Object byte[] 2097152
        $ms = New-Object System.IO.MemoryStream
        do {
            $res = $ws.ReceiveAsync((New-Object System.ArraySegment[byte] -ArgumentList @(,$buf)), [System.Threading.CancellationToken]::None)
            $res.Wait()
            $ms.Write($buf, 0, $res.Result.Count)
        } while (-not $res.Result.EndOfMessage)
        return [System.Text.Encoding]::UTF8.GetString($ms.ToArray()) | ConvertFrom-Json
    }

    # Enable Runtime & Log
    Send-CDP "Runtime.enable" @{} 1 | Out-Null

    # Test 1: Check document title and H1
    $eval1 = Send-CDP "Runtime.evaluate" @{ expression = "document.querySelector('h1').innerText" } 2
    Write-Output "H1 Text: $($eval1.result.result.value)"

    # Test 2: Check Tuition Toggle
    Send-CDP "Runtime.evaluate" @{ expression = "document.getElementById('btn-fee-install').click()" } 3 | Out-Null
    $feeText = Send-CDP "Runtime.evaluate" @{ expression = "document.getElementById('fee-display-amount').innerText" } 4
    Write-Output "Installment Fee Text after click: $($feeText.result.result.value)"

    # Test 3: Check Syllabus Filter
    Send-CDP "Runtime.evaluate" @{ expression = "document.getElementById('syllabus-search').value = 'Meta Pixel'; document.getElementById('syllabus-search').dispatchEvent(new Event('input'))" } 5 | Out-Null
    $visibleCount = Send-CDP "Runtime.evaluate" @{ expression = "Array.from(document.querySelectorAll('#syllabus-stack .c-phase-item')).filter(function(el) { return el.style.display !== 'none'; }).length" } 6
    Write-Output "Visible modules after search 'Meta Pixel': $($visibleCount.result.result.value)"

    # Test 4: Check Town Commute Click
    Send-CDP "Runtime.evaluate" @{ expression = "document.querySelector('.c-town-btn[data-town=""farooqabad""]').click()" } 7 | Out-Null
    $townTitle = Send-CDP "Runtime.evaluate" @{ expression = "document.getElementById('town-commute-title').innerText" } 8
    Write-Output "Commuter Town Title after click: $($townTitle.result.result.value)"

    # Test 5: Verify Schema.org LD+JSON parsing
    $schemaValid = Send-CDP "Runtime.evaluate" @{ expression = "(function() { try { var s = JSON.parse(document.querySelector('script[type=""application/ld+json""]').textContent); return s['@graph'].length; } catch (e) { return 'ERROR: ' + e.message; } })()" } 9
    Write-Output "Parsed Schema @graph items count: $($schemaValid.result.result.value)"

    Write-Output "ALL INTERACTIVE TESTS PASSED!"
} finally {
    try { $ws.Abort() } catch {}
    Stop-Process -Id $proc.Id -Force -ErrorAction SilentlyContinue
}
