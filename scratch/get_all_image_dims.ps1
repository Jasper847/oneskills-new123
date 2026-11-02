function Get-ImageDetails($path) {
    $bytes = [System.IO.File]::ReadAllBytes($path)
    if ($bytes.Length -lt 30) { return "File too small" }
    
    # Check JPEG
    if ($bytes[0] -eq 0xFF -and $bytes[1] -eq 0xD8) {
        Add-Type -AssemblyName System.Drawing
        $img = [System.Drawing.Image]::FromFile((Resolve-Path $path))
        $w = $img.Width
        $h = $img.Height
        $img.Dispose()
        return "JPEG ${w}x${h}"
    }
    
    # Check WebP VP8
    for ($i = 12; $i -lt [Math]::Min(100, $bytes.Length - 10); $i++) {
        if ($bytes[$i] -eq 0x9D -and $bytes[$i+1] -eq 0x01 -and $bytes[$i+2] -eq 0x2A) {
            $w = $bytes[$i+3] -bor (($bytes[$i+4] -band 0x3F) -shl 8)
            $h = $bytes[$i+5] -bor (($bytes[$i+6] -band 0x3F) -shl 8)
            return "WebP VP8 ${w}x${h}"
        }
    }
    
    # Check WebP VP8X Extended
    $chunk = [System.Text.Encoding]::ASCII.GetString($bytes, 12, 4)
    if ($chunk -eq "VP8X") {
        $w = 1 + ($bytes[24] -bor ($bytes[25] -shl 8) -bor ($bytes[26] -shl 16))
        $h = 1 + ($bytes[27] -bor ($bytes[28] -shl 8) -bor ($bytes[29] -shl 16))
        return "WebP VP8X ${w}x${h}"
    }
    
    return "Unknown format"
}

$images = Get-ChildItem assets/images/courses/*.*
$res = @()
foreach ($img in $images) {
    $detail = Get-ImageDetails $img.FullName
    $res += [PSCustomObject]@{
        Name = $img.Name
        Dimensions = $detail
        SizeKB = [math]::Round($img.Length / 1KB, 1)
    }
}
$res | Format-Table -AutoSize

