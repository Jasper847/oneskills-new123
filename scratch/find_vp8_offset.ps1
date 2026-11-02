$bytes = [System.IO.File]::ReadAllBytes("assets/images/courses/freelancing-mastery-dark.webp")
$chunk = [System.Text.Encoding]::ASCII.GetString($bytes, 12, 4)
Write-Host "Chunk: $chunk"
$hexStart = ($bytes[20..31] | ForEach-Object { $_.ToString("X2") }) -join " "
Write-Host "Bytes 20-31: $hexStart"

# Let us find where 9D 01 2A is in the file!
for ($i = 12; $i -lt 50; $i++) {
    if ($bytes[$i] -eq 0x9D -and $bytes[$i+1] -eq 0x01 -and $bytes[$i+2] -eq 0x2A) {
        Write-Host "Found VP8 start code 9D 01 2A at offset $i"
        $w = $bytes[$i+3] -bor (($bytes[$i+4] -band 0x3F) -shl 8)
        $h = $bytes[$i+5] -bor (($bytes[$i+6] -band 0x3F) -shl 8)
        Write-Host "Dimensions: $w x $h"
    }
}

