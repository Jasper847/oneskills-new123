$root = 'c:\Users\Nisar\Desktop\oneskills new123'
$port = 8080
$listener = New-Object System.Net.HttpListener
$listener.Prefixes.Add("http://localhost:$port/")
$listener.Start()
Write-Host "Serving $root on http://localhost:$port/"

$mimeTypes = @{
    '.html' = 'text/html; charset=utf-8'
    '.css'  = 'text/css; charset=utf-8'
    '.js'   = 'application/javascript; charset=utf-8'
    '.json' = 'application/json; charset=utf-8'
    '.png'  = 'image/png'
    '.jpg'  = 'image/jpeg'
    '.jpeg' = 'image/jpeg'
    '.webp' = 'image/webp'
    '.svg'  = 'image/svg+xml'
    '.ico'  = 'image/x-icon'
    '.woff' = 'font/woff'
    '.woff2'= 'font/woff2'
    '.ttf'  = 'font/ttf'
    '.mp4'  = 'video/mp4'
    '.webm' = 'video/webm'
    '.txt'  = 'text/plain'
    '.xml'  = 'application/xml'
}

while ($listener.IsListening) {
    try {
        $ctx = $listener.GetContext()
        $req = $ctx.Request
        $res = $ctx.Response
        $urlPath = $req.Url.LocalPath
        if ($urlPath -eq '/' -or $urlPath -eq '') { $urlPath = '/index.html' }
        $filePath = Join-Path $root $urlPath.TrimStart('/').Replace('/', '\')
        if (Test-Path $filePath -PathType Container) {
            $filePath = Join-Path $filePath 'index.html'
        }
        if (-not (Test-Path $filePath -PathType Leaf) -and $urlPath.Contains('/assets/')) {
            $assetSub = $urlPath.Substring($urlPath.IndexOf('/assets/')).TrimStart('/').Replace('/', '\')
            $candidate = Join-Path $root $assetSub
            if (Test-Path $candidate -PathType Leaf) {
                $filePath = $candidate
            }
        }
        if (Test-Path $filePath -PathType Leaf) {
            $ext = [System.IO.Path]::GetExtension($filePath).ToLower()
            $mime = if ($mimeTypes.ContainsKey($ext)) { $mimeTypes[$ext] } else { 'application/octet-stream' }
            $bytes = [System.IO.File]::ReadAllBytes($filePath)
            $res.ContentType = $mime
            $res.ContentLength64 = $bytes.Length
            $res.StatusCode = 200
            if ($req.HttpMethod -ne 'HEAD') {
                $res.OutputStream.Write($bytes, 0, $bytes.Length)
            }
        } else {
            $res.StatusCode = 404
            $body = [System.Text.Encoding]::UTF8.GetBytes("404 Not Found: $urlPath")
            $res.ContentLength64 = $body.Length
            if ($req.HttpMethod -ne 'HEAD') {
                $res.OutputStream.Write($body, 0, $body.Length)
            }
        }
        $res.OutputStream.Close()
    } catch {
        # Catch and continue
    }
}
