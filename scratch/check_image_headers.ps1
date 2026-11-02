$images = Get-ChildItem assets/images/courses/*
$res = @()
foreach ($img in $images) {
    $bytes = [System.IO.File]::ReadAllBytes($img.FullName)
    $headerHex = ($bytes[0..7] | ForEach-Object { $_.ToString("X2") }) -join " "
    $headerAscii = [System.Text.Encoding]::ASCII.GetString($bytes, 0, [Math]::Min(16, $bytes.Length))
    
    $type = "Unknown"
    if ($headerHex -like "89 50 4E 47*") { $type = "PNG (Actual format)" }
    elseif ($headerHex -like "FF D8 FF*") { $type = "JPEG (Actual format)" }
    elseif ($headerHex -like "52 49 46 46*") { $type = "RIFF/WEBP" }
    
    $res += [PSCustomObject]@{
        Name = $img.Name
        SizeKB = [math]::Round($img.Length / 1KB, 1)
        HeaderHex = $headerHex
        ActualType = $type
    }
}
$res | Format-Table -AutoSize

