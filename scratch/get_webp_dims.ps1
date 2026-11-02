function Get-WebpDimensions($path) {
    $bytes = [System.IO.File]::ReadAllBytes($path)
    if ($bytes.Length -lt 30) { return "Unknown" }
    
    $riff = [System.Text.Encoding]::ASCII.GetString($bytes, 0, 4)
    $webp = [System.Text.Encoding]::ASCII.GetString($bytes, 8, 4)
    if ($riff -ne "RIFF" -or $webp -ne "WEBP") { return "Not WebP" }
    
    $format = [System.Text.Encoding]::ASCII.GetString($bytes, 12, 4)
    if ($format -eq "VP8 ") {
        $width = ($bytes[26] -bor ($bytes[27] -shl 8)) -band 0x3fff
        $height = ($bytes[28] -bor ($bytes[29] -shl 8)) -band 0x3fff
        return "${width}x${height} (VP8 Lossy)"
    } elseif ($format -eq "VP8L") {
        $b1 = $bytes[21]
        $b2 = $bytes[22]
        $b3 = $bytes[23]
        $b4 = $bytes[24]
        $width = 1 + ($b1 -bor (($b2 -band 0x3f) -shl 8))
        $height = 1 + ((($b2 -band 0xc0) -shr 6) -bor ($b3 -shl 2) -bor (($b4 -band 0x0f) -shl 10))
        return "${width}x${height} (VP8L Lossless)"
    } elseif ($format -eq "VP8X") {
        $width = 1 + ($bytes[24] -bor ($bytes[25] -shl 8) -bor ($bytes[26] -shl 16))
        $height = 1 + ($bytes[27] -bor ($bytes[28] -shl 8) -bor ($bytes[29] -shl 16))
        return "${width}x${height} (VP8X Extended)"
    }
    return "$format (Unknown)"
}

$images = Get-ChildItem assets/images/courses/*.webp
$res = @()
foreach ($img in $images) {
    $dim = Get-WebpDimensions $img.FullName
    $res += [PSCustomObject]@{
        Name = $img.Name
        Dimensions = $dim
        SizeKB = [math]::Round($img.Length / 1KB, 1)
    }
}
$res | Format-Table -AutoSize
