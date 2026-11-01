param(
    [string]$url = "http://localhost:8080/courses/freelancing-mastery.html",
    [string]$outPath = "C:\Users\Nisar\Desktop\oneskills new123\scratch\shots\sections\screen.png",
    [int]$width = 1440,
    [int]$height = 900,
    [string]$scrollToId = "",
    [switch]$isMobile,
    [switch]$darkMode
)

$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$port = 9223
$userData = "$env:TEMP\edge_cdp_profile_$port"

# Start Edge with remote debugging
$proc = Start-Process -FilePath $edge -ArgumentList "--headless=new", "--window-size=$width,$height", "--remote-debugging-port=$port", "--user-data-dir=`"$userData`"", "about:blank" -PassThru
Start-Sleep -Seconds 2

try {
    # Get WebSocket debugger URL
    $tabs = Invoke-RestMethod -Uri "http://localhost:$port/json"
    $wsUrl = $tabs[0].webSocketDebuggerUrl
    Write-Output "WS URL: $wsUrl"

    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $cts = New-Object System.Threading.CancellationTokenSource
    $task = $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token)
    $task.Wait()

    function Send-CDPMessage($ws, [string]$method, [hashtable]$params, [int]$id) {
        $msgObj = @{
            id = $id
            method = $method
            params = $params
        }
        $json = $msgObj | ConvertTo-Json -Depth 10 -Compress
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
        $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)
        $ws.SendAsync($segment, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [System.Threading.CancellationToken]::None).Wait()
    }

    function Read-CDPMessage($ws) {
        $buffer = New-Object byte[] 2097152 # 2MB
        $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$buffer)
        $ms = New-Object System.IO.MemoryStream
        do {
            $res = $ws.ReceiveAsync($segment, [System.Threading.CancellationToken]::None)
            $res.Wait()
            $ms.Write($buffer, 0, $res.Result.Count)
        } while (-not $res.Result.EndOfMessage)
        $jsonStr = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
        $ms.Dispose()
        return ($jsonStr | ConvertFrom-Json)
    }

    # 1. Enable Page
    Send-CDPMessage $ws "Page.enable" @{} 1
    $null = Read-CDPMessage $ws

    # 2. Set Device Metrics
    $metrics = @{
        width = $width
        height = $height
        deviceScaleFactor = 2
        mobile = $isMobile
    }
    Send-CDPMessage $ws "Emulation.setDeviceMetricsOverride" $metrics 2
    $null = Read-CDPMessage $ws

    # 3. Navigate
    Send-CDPMessage $ws "Page.navigate" @{ url = $url } 3
    $null = Read-CDPMessage $ws

    # Wait for page to render
    Start-Sleep -Seconds 3

    if ($darkMode) {
        Send-CDPMessage $ws "Runtime.enable" @{} 8
        $null = Read-CDPMessage $ws
        Send-CDPMessage $ws "Runtime.evaluate" @{ expression = "document.documentElement.setAttribute('data-theme', 'dark');" } 9
        $null = Read-CDPMessage $ws
        Start-Sleep -Milliseconds 400
    }

    if ($scrollToId) {
        Send-CDPMessage $ws "Runtime.enable" @{} 10
        $null = Read-CDPMessage $ws
        $scrollExpr = "const el = document.getElementById('$scrollToId') || document.querySelector('$scrollToId'); if (el) { el.scrollIntoView({ behavior: 'instant', block: 'start' }); window.scrollBy(0, -80); }"
        Send-CDPMessage $ws "Runtime.evaluate" @{ expression = $scrollExpr } 11
        $null = Read-CDPMessage $ws
        Start-Sleep -Milliseconds 600
    }

    # 4. Capture screenshot
    Send-CDPMessage $ws "Page.captureScreenshot" @{ format = "png" } 4
    $response = Read-CDPMessage $ws

    # If response is an event, keep reading until id == 4
    $maxTries = 10
    while ($response.id -ne 4 -and $maxTries -gt 0) {
        $response = Read-CDPMessage $ws
        $maxTries--
    }

    if ($response.result -and $response.result.data) {
        $imgBytes = [System.Convert]::FromBase64String($response.result.data)
        [System.IO.File]::WriteAllBytes($outPath, $imgBytes)
        Write-Output "Screenshot saved successfully to $outPath ($($imgBytes.Length) bytes)"
    } else {
        Write-Error "Failed to capture screenshot: $($response | ConvertTo-Json -Depth 2)"
    }

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", [System.Threading.CancellationToken]::None).Wait()
} finally {
    Stop-Process -Id $proc.Id -Force
}

