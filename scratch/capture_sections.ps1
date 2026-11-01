param(
    [string]$url = "http://localhost:8080/courses/freelancing-mastery.html",
    [string]$outputDir = "C:\Users\Nisar\Desktop\oneskills new123\scratch\shots\sections",
    [int]$width = 1440,
    [int]$height = 900
)

$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
if (-not (Test-Path $edge)) {
    $edge = "C:\Program Files\Microsoft\Edge\Application\msedge.exe"
}
$port = 9224
$userData = "$env:TEMP\edge_cdp_profile_$port"

if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir -Force | Out-Null
}

$proc = Start-Process -FilePath $edge -ArgumentList "--headless=new", "--remote-debugging-port=$port", "--user-data-dir=`"$userData`"", "about:blank" -PassThru
Start-Sleep -Seconds 2

try {
    $tabs = Invoke-RestMethod -Uri "http://localhost:$port/json"
    $wsUrl = $tabs[0].webSocketDebuggerUrl
    Write-Output "Connected to Edge CDP: $wsUrl"

    $ws = New-Object System.Net.WebSockets.ClientWebSocket
    $cts = New-Object System.Threading.CancellationTokenSource
    $task = $ws.ConnectAsync([System.Uri]$wsUrl, $cts.Token)
    $task.Wait()

    $script:msgId = 1
    function Send-CDP([string]$method, [hashtable]$params) {
        $id = $script:msgId++
        $msgObj = @{ id = $id; method = $method; params = $params }
        $json = $msgObj | ConvertTo-Json -Depth 10 -Compress
        $bytes = [System.Text.Encoding]::UTF8.GetBytes($json)
        $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$bytes)
        $ws.SendAsync($segment, [System.Net.WebSockets.WebSocketMessageType]::Text, $true, [System.Threading.CancellationToken]::None).Wait()
        return $id
    }

    function Read-CDP([int]$targetId) {
        $maxTries = 50
        while ($maxTries -gt 0) {
            $maxTries--
            $buffer = New-Object byte[] 4194304 # 4MB
            $segment = New-Object System.ArraySegment[byte] -ArgumentList @(,$buffer)
            $ms = New-Object System.IO.MemoryStream
            do {
                $res = $ws.ReceiveAsync($segment, [System.Threading.CancellationToken]::None)
                $res.Wait()
                $ms.Write($buffer, 0, $res.Result.Count)
            } while (-not $res.Result.EndOfMessage)
            $jsonStr = [System.Text.Encoding]::UTF8.GetString($ms.ToArray())
            $ms.Dispose()
            $obj = $jsonStr | ConvertFrom-Json
            if ($obj.id -eq $targetId) {
                return $obj
            }
        }
        return $null
    }

    # Enable Page and Runtime
    $id = Send-CDP "Page.enable" @{}
    $null = Read-CDP $id
    $id = Send-CDP "Runtime.enable" @{}
    $null = Read-CDP $id

    # Set Desktop Metrics
    $metrics = @{
        width = $width
        height = $height
        deviceScaleFactor = 2
        mobile = $false
    }
    $id = Send-CDP "Emulation.setDeviceMetricsOverride" $metrics
    $null = Read-CDP $id

    # Navigate
    Write-Output "Navigating to $url..."
    $id = Send-CDP "Page.navigate" @{ url = $url }
    $null = Read-CDP $id
    Start-Sleep -Seconds 3

    # Check for console errors
    $evalId = Send-CDP "Runtime.evaluate" @{ expression = "window.__errors || 'No runtime errors caught'" }
    $evalRes = Read-CDP $evalId
    Write-Output "Console status: $($evalRes.result.result.value)"

    # Function to scroll to selector and screenshot
    function Capture-Section([string]$sectionId, [string]$filename) {
        $expr = "const el = document.getElementById('$sectionId'); if (el) { el.scrollIntoView({ behavior: 'instant', block: 'start' }); true; } else { false; }"
        $id = Send-CDP "Runtime.evaluate" @{ expression = $expr }
        $null = Read-CDP $id
        Start-Sleep -Milliseconds 800

        $id = Send-CDP "Page.captureScreenshot" @{ format = "png" }
        $resp = Read-CDP $id
        if ($resp -and $resp.result -and $resp.result.data) {
            $bytes = [System.Convert]::FromBase64String($resp.result.data)
            $savePath = Join-Path $outputDir $filename
            [System.IO.File]::WriteAllBytes($savePath, $bytes)
            Write-Output "Saved: $filename ($($bytes.Length) bytes)"
        } else {
            Write-Warning "Failed screenshot for $sectionId"
        }
    }

    Capture-Section "overview" "redesign_overview.png"
    Capture-Section "method" "redesign_method.png"
    Capture-Section "skills" "redesign_skills_bento.png"
    Capture-Section "curriculum" "redesign_curriculum.png"
    Capture-Section "course-blueprint-details" "redesign_blueprint_tabs.png"
    Capture-Section "deliverables" "redesign_deliverables_hud.png"
    Capture-Section "specs" "redesign_specs_hardware.png"

    # Also capture mobile viewport of Skills Bento and Deliverables HUD
    $mobileMetrics = @{
        width = 412
        height = 915
        deviceScaleFactor = 2
        mobile = $true
    }
    $id = Send-CDP "Emulation.setDeviceMetricsOverride" $mobileMetrics
    $null = Read-CDP $id
    Start-Sleep -Milliseconds 500

    Capture-Section "skills" "redesign_mobile_skills.png"
    Capture-Section "deliverables" "redesign_mobile_deliverables.png"
    Capture-Section "course-blueprint-details" "redesign_mobile_blueprint.png"

    $ws.CloseAsync([System.Net.WebSockets.WebSocketCloseStatus]::NormalClosure, "Done", [System.Threading.CancellationToken]::None).Wait()
    Write-Output "All screenshots captured successfully."
} finally {
    if ($proc -and -not $proc.HasExited) {
        Stop-Process -Id $proc.Id -Force
    }
}

