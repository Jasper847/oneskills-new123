param(
    [string]$url = "http://localhost:8080/courses/freelancing-mastery.html"
)

$edge = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$port = 9225
$userData = "$env:TEMP\edge_cdp_profile_$port"

$proc = Start-Process -FilePath $edge -ArgumentList "--headless=new", "--window-size=1440,900", "--remote-debugging-port=$port", "--user-data-dir=`"$userData`"", "about:blank" -PassThru
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
    Send-CDPMessage $ws "Runtime.enable" @{} 2
    $null = Read-CDPMessage $ws

    Send-CDPMessage $ws "Page.navigate" @{ url = $url } 3
    $null = Read-CDPMessage $ws
    Start-Sleep -Seconds 3

    $testScript = @"
(() => {
    const results = {};
    const subnavLinks = Array.from(document.querySelectorAll('.c-subnav-link')).map(a => ({
        text: a.textContent.trim(),
        href: a.getAttribute('href'),
        targetExists: !!document.querySelector(a.getAttribute('href'))
    }));
    results.subnav = subnavLinks;

    const fullBtn = document.getElementById('btn-fee-full');
    const installBtn = document.getElementById('btn-fee-install');
    const feeAmount = document.getElementById('fee-display-amount');
    const feeSub = document.getElementById('fee-display-subtitle');

    results.feeSwitcher = {
        fullBtnExists: !!fullBtn,
        installBtnExists: !!installBtn,
        initialAmount: feeAmount ? feeAmount.textContent.trim() : null,
        initialSub: feeSub ? feeSub.textContent.trim() : null
    };

    if (installBtn) {
        installBtn.click();
        results.feeSwitcher.afterInstallClick = {
            amount: feeAmount ? feeAmount.textContent.trim() : null,
            sub: feeSub ? feeSub.textContent.trim() : null
        };
    }

    if (fullBtn) {
        fullBtn.click();
        results.feeSwitcher.afterFullClick = {
            amount: feeAmount ? feeAmount.textContent.trim() : null,
            sub: feeSub ? feeSub.textContent.trim() : null
        };
    }

    const requiredIds = ['overview', 'method', 'curriculum', 'deliverables', 'internship', 'comparison', 'specs', 'reviews', 'admissions', 'faq'];
    results.sections = requiredIds.map(id => ({ id, exists: !!document.getElementById(id) }));

    const blueprintBtns = document.querySelectorAll('.c-bp-btn');
    results.blueprintTabsCount = blueprintBtns.length;

    results.title = document.title;
    return results;
})()
"@

    Send-CDPMessage $ws "Runtime.evaluate" @{ expression = $testScript; returnByValue = $true } 4
    $evalRes = Read-CDPMessage $ws
    $outputJson = $evalRes.result.result.value | ConvertTo-Json -Depth 5
    Set-Content -Path "scratch/interaction_results.json" -Value $outputJson
    Write-Output "Results written to scratch/interaction_results.json"
}
finally {
    if ($ws -and $ws.State -eq [System.Net.WebSockets.WebSocketState]::Open) {
        try { $ws.Abort() } catch {}
    }
    if ($proc -and -not $proc.HasExited) {
        Stop-Process -Id $proc.Id -Force
    }
}
