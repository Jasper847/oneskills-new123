param(
    [string]$url = "http://localhost:8080/courses/freelancing-mastery.html"
)

$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$port = 9226
$userData = "$env:TEMP\edge_cdp_profile_$port"

$viewports = @(
    @{ name = "Desktop_1920"; w = 1920; h = 1080; mobile = $false },
    @{ name = "Desktop_1440"; w = 1440; h = 900;  mobile = $false },
    @{ name = "Desktop_1280"; w = 1280; h = 800;  mobile = $false },
    @{ name = "Tablet_768";   w = 768;  h = 1024; mobile = $true },
    @{ name = "Mobile_430";   w = 430;  h = 932;  mobile = $true },
    @{ name = "Mobile_390";   w = 390;  h = 844;  mobile = $true },
    @{ name = "Mobile_375";   w = 375;  h = 667;  mobile = $true }
)

$qaResults = @()

foreach ($vp in $viewports) {
    Write-Host "Testing viewport: $($vp.name) ($($vp.w)x$($vp.h))..."
    $proc = Start-Process -FilePath $edge -ArgumentList "--headless=new", "--window-size=$($vp.w),$($vp.h)", "--remote-debugging-port=$port", "--user-data-dir=`"$userData`"", "about:blank" -PassThru
    Start-Sleep -Seconds 2

    try {
        $tabs = Invoke-RestMethod -Uri "http://localhost:$port/json"
        $wsUrl = $tabs[0].webSocketDebuggerUrl
        $ws = New-Object System.Net.WebSockets.ClientWebSocket
        $cts = New-Object System.Threading.CancellationTokenSource
        $task = $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token)
        $task.Wait()

        function Send-CDPMessage($ws, [string]$method, [hashtable]$params, [int]$id) {
            $msgObj = @{ id = $id; method = $method; params = $params }
            $json = $msgObj | ConvertTo-Json -Depth 10 -Compress
            $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
            $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)
            $ws.SendAsync($segment, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [System.Threading.CancellationToken]::None).Wait()
        }

        function Read-CDPMessage($ws) {
            $buffer = New-Object byte[] 2097152
            $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$buffer)
            $ms = New-Object System.IO.MemoryStream
            do {
                $res = $ws.ReceiveAsync($segment, [System.Threading.CancellationToken]::None)
                $res.Wait()
                $ms.Write($buffer, 0, $res.Result.Count)
            } while (-not $res.Result.EndOfMessage)
            $json = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
            return $json | ConvertFrom-Json
        }

        Send-CDPMessage $ws "Page.enable" @{} 1
        $null = Read-CDPMessage $ws

        Send-CDPMessage $ws "Page.navigate" @{ url = $url } 2
        $null = Read-CDPMessage $ws
        Start-Sleep -Seconds 3

        $evalScript = @"
(() => {
    return {
        viewportWidth: window.innerWidth,
        viewportHeight: window.innerHeight,
        scrollWidth: document.documentElement.scrollWidth,
        hasHorizontalOverflow: document.documentElement.scrollWidth > window.innerWidth,
        title: document.title,
        h1Text: document.querySelector('h1') ? document.querySelector('h1').textContent.trim() : null
    };
})()
"@
        Send-CDPMessage $ws "Runtime.evaluate" @{ expression = $evalScript; returnByValue = $true } 3
        $evalRes = Read-CDPMessage $ws
        $val = $evalRes.result.result.value

        $qaResults += [PSCustomObject]@{
            Viewport = $vp.name
            Width = $vp.w
            ScrollWidth = $val.scrollWidth
            Overflow = $val.hasHorizontalOverflow
            Passed = (-not $val.hasHorizontalOverflow)
        }

        # If Desktop 1440, capture updated section screenshots for proof
        if ($vp.name -eq "Desktop_1440") {
            Send-CDPMessage $ws "Page.captureScreenshot" @{ format = "png" } 4
            $shotRes = Read-CDPMessage $ws
            $base64 = $shotRes.result.data
            $bytes = [System.Convert]::FromBase64String($base64)
            [System.IO.File]::WriteAllBytes("C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e\final_verified_desktop.png", $bytes)
            Write-Host "Saved final_verified_desktop.png"
        }

        # If Mobile 390, capture mobile screenshot
        if ($vp.name -eq "Mobile_390") {
            Send-CDPMessage $ws "Page.captureScreenshot" @{ format = "png" } 5
            $shotRes = Read-CDPMessage $ws
            $base64 = $shotRes.result.data
            $bytes = [System.Convert]::FromBase64String($base64)
            [System.IO.File]::WriteAllBytes("C:\Users\Nisar\.gemini\antigravity\brain\2aeb9aab-b228-4753-b03d-411b17fa0d3e\final_verified_mobile.png", $bytes)
            Write-Host "Saved final_verified_mobile.png"
        }
    }
    finally {
        if ($ws -and $ws.State -eq [System.Net.WebSockets.WebSocketState]::Open) {
            try { $ws.Abort() } catch {}
        }
        if ($proc -and -not $proc.HasExited) {
            Stop-Process -Id $proc.Id -Force
        }
    }
}

$qaResults | Format-Table -AutoSize

