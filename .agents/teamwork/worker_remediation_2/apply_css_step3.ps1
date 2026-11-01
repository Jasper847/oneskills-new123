$css = Get-Content 'assets\css\course-v2.css' -Raw

# 1. Clean up any remaining .sticky-cta blocks
$css = [regex]::Replace($css, '(?s)\.sticky-cta\b[^{]*\{[^}]*\}', '')
$css = [regex]::Replace($css, '(?s)[^\n]*\.sticky-cta[^\n]*\{[^}]*\}', '')
$css = [regex]::Replace($css, '(?s)[^\n]*btn-sticky[^\n]*\{[^}]*\}', '')

# 2. Specific color cleanups
$colReplacements = @(
    @('box-shadow: 0 4px 18px rgba(0, 0, 0, 0.07);', 'box-shadow: var(--shadow-plum-subtle);'),
    @('background: rgba(22, 17, 39, 0.92);', 'background: var(--card);'),
    @('border-color: rgba(255, 255, 255, 0.14);', 'border-color: var(--line-strong);'),
    @('box-shadow: 0 18px 40px -4px rgba(0, 0, 0, 0.5), 0 4px 12px rgba(0, 0, 0, 0.3);', 'box-shadow: var(--shadow-hover);'),
    @('html[data-theme="dark"] body.course-v2-page .c-float-icon--gold { background: rgba(217, 119, 6, 0.25); color: #fbbf24; }', 'html[data-theme="dark"] body.course-v2-page .c-float-icon--gold { background: var(--badge-gold-bg); color: var(--badge-gold-text); }'),
    @('html[data-theme="dark"] body.course-v2-page .c-float-icon--emerald { background: rgba(5, 150, 105, 0.25); color: #34d399; }', 'html[data-theme="dark"] body.course-v2-page .c-float-icon--emerald { background: var(--badge-emerald-bg); color: var(--badge-emerald-text); }'),
    @('html[data-theme="dark"] body.course-v2-page .c-float-icon--purple { background: rgba(124, 58, 237, 0.25); color: #a78bfa; }', 'html[data-theme="dark"] body.course-v2-page .c-float-icon--purple { background: var(--badge-purple-bg); color: var(--badge-purple-text); }'),
    @('html[data-theme="dark"] body.course-v2-page .c-float-icon--amber { background: rgba(234, 88, 12, 0.25); color: #fb923c; }', 'html[data-theme="dark"] body.course-v2-page .c-float-icon--amber { background: var(--badge-amber-bg); color: var(--badge-amber-text); }'),
    @('box-shadow: 0 8px 18px rgba(0, 0, 0, 0.14);', 'box-shadow: var(--shadow-card);'),
    @('background: linear-gradient(to top, rgba(9, 7, 20, 0.85) 0%, rgba(9, 7, 20, 0.2) 100%);', 'background: var(--gradient-card-overlay, linear-gradient(to top, rgba(9, 7, 20, 0.85) 0%, rgba(9, 7, 20, 0.2) 100%));'),
    @('color: #c4b5fd;', 'color: var(--accent-light, #c4b5fd);'),
    @('border: 1px solid rgba(52, 211, 153, 0.3);', 'border: 1px solid var(--accent-emerald-line);'),
    @('background: #140d24;', 'background: var(--bg-dark, #140d24);'),
    @('background: linear-gradient(180deg, rgba(15, 10, 25, 0.1) 0%, rgba(15, 10, 25, 0.5) 45%, rgba(15, 10, 25, 0.92) 100%);', 'background: var(--gradient-overlay-dark, linear-gradient(180deg, rgba(15, 10, 25, 0.1) 0%, rgba(15, 10, 25, 0.5) 45%, rgba(15, 10, 25, 0.92) 100%));'),
    @('background: rgba(22, 16, 38, 0.88);', 'background: var(--surface-dark, rgba(22, 16, 38, 0.88));'),
    @('color: #f8fafc;', 'color: var(--text-inverse, #ffffff);'),
    @('box-shadow: 0 8px 24px rgba(0, 0, 0, 0.25);', 'box-shadow: var(--shadow-modal);'),
    @('border: 1px solid rgba(16, 185, 129, 0.3);', 'border: 1px solid var(--accent-emerald-line);'),
    @('box-shadow: 0 2px 6px rgba(0, 0, 0, 0.03);', 'box-shadow: var(--shadow-subtle, 0 2px 8px rgba(0, 0, 0, 0.04));'),
    @('box-shadow: 0 2px 6px rgba(35, 27, 43, 0.03);', 'box-shadow: var(--shadow-subtle, 0 2px 8px rgba(35, 10, 80, 0.04));'),
    @('color: #d97706;', 'color: var(--accent-amber, #d97706);'),
    @('background: linear-gradient(135deg, #6e44ff, #10b981);', 'background: var(--gradient-brand, linear-gradient(135deg, var(--accent), var(--tag-roas)));'),
    @('box-shadow: 0 14px 36px rgba(0, 0, 0, 0.35);', 'box-shadow: var(--shadow-hover);'),
    @('box-shadow: 0 14px 40px rgba(25, 18, 35, 0.16);', 'box-shadow: var(--shadow-card);'),
    @('0 4px 16px rgba(35, 27, 43, 0.05)', 'var(--shadow-plum-subtle)'),
    @('0 4px 20px rgba(0, 0, 0, 0.6)', 'var(--shadow-hover)'),
    @('border-color: rgba(255, 255, 255, 0.12);', 'border-color: var(--line-strong);'),
    @('border-top-color: rgba(255, 255, 255, 0.12);', 'border-top-color: var(--line-strong);'),
    @('background: rgba(19, 15, 35, 0.95);', 'background: var(--card);'),
    @('background: rgba(255, 255, 255, 0.06);', 'background: var(--surface-hover);')
)

foreach ($r in $colReplacements) {
    $from = [regex]::Escape($r[0])
    $to = $r[1]
    $css = [regex]::Replace($css, $from, $to)
}

# 3. Spacing and dimensions normalization
# Specifically target known properties: margin, padding, gap, row-gap, column-gap, top, bottom, left, right, width, height, min-width, min-height
# Replace line by line
$lines = $css -split "`n"
$outLines = [System.Collections.Generic.List[string]]::new()

$propPattern = '(?i)^\s*(margin(?:-(?:top|bottom|left|right))?|padding(?:-(?:top|bottom|left|right))?|gap|row-gap|column-gap|top|bottom|left|right|width|height|min-width|min-height|max-width|max-height)\s*:\s*([^;]+);'

# Value mapping function for spacing/dimensions
function Normalize-PxValue($prop, $val) {
    # If calc or var is used, handle carefully
    # Match standalone numbers with px: e.g. 14px, -14px
    $replaced = [regex]::Replace($val, '(?<![a-zA-Z\-])(-?\d+)px', {
        param($match)
        $n = [int]$match.Groups[1].Value
        $sign = if ($n -lt 0) { -1 } else { 1 }
        $abs = [Math]::Abs($n)
        
        # Don't touch 0px, 1px, 2px if border-like, but for margin/padding/gap/top/bottom/left/right:
        if ($abs -eq 0 -or $abs -eq 8 -or $abs -eq 16 -or $abs -eq 24 -or $abs -eq 32 -or $abs -eq 40 -or $abs -eq 48 -or $abs -eq 56 -or $abs -eq 64 -or $abs -eq 72 -or $abs -eq 80 -or $abs -eq 88 -or $abs -eq 96 -or $abs -eq 112 -or $abs -eq 120 -or $abs -eq 128 -or $abs -eq 144 -or $abs -eq 160) {
            return $match.Value
        }
        
        # Exact mappings based on audit plan
        $newAbs = switch ($abs) {
            1   { 0 }
            2   { 0 }
            3   { 4 }
            4   { 4 } # 4px is valid half-step in standard 8px system
            5   { 8 }
            6   { 8 }
            7   { 8 }
            9   { 8 }
            10  { 8 }
            11  { 8 }
            12  { 16 }
            13  { 16 }
            14  { 16 }
            15  { 16 }
            18  { 16 }
            20  { 16 } # or 24 depending on context, 16 is standard
            22  { 24 }
            26  { 24 }
            28  { 32 }
            30  { 32 }
            34  { 32 }
            35  { 32 }
            36  { 32 } # or 40
            38  { 40 }
            42  { 40 }
            44  { 48 }
            45  { 48 }
            46  { 48 }
            70  { 72 }
            110 { 112 }
            124 { 128 }
            130 { 128 }
            155 { 160 }
            180 { 176 }
            220 { 224 }
            default {
                # Round to nearest multiple of 8
                $rem = $abs % 8
                if ($rem -ge 4) { $abs + (8 - $rem) } else { $abs - $rem }
            }
        }
        
        $res = $sign * $newAbs
        return "$($res)px"
    })
    
    return $replaced
}

for ($i = 0; $i -lt $lines.Length; $i++) {
    $line = $lines[$i]
    
    # Do not normalize values inside :root tokens or keyframe percentage definitions
    if ($line -match '^\s*--' -or $line -match '^\s*\d+%\s*\{') {
        $outLines.Add($line)
        continue
    }
    
    $m = [regex]::Match($line, $propPattern)
    if ($m.Success) {
        $prop = $m.Groups[1].Value
        $val = $m.Groups[2].Value
        
        # Check specific hero video cta and float badge overrides
        $newVal = Normalize-PxValue $prop.ToLower() $val
        $newLine = $line.Replace($val, $newVal)
        $outLines.Add($newLine)
    } else {
        $outLines.Add($line)
    }
}

$css = $outLines -join "`n"

# Ensure hero video cta and float badge padding/gap are exact per specification
$css = [regex]::Replace($css, '(\.c-hero-video-cta\s*\{[^}]*?padding:)\s*[^;]+;', '$1 8px 24px 8px 8px;')
$css = [regex]::Replace($css, '(\.c-hero-video-cta\s*\{[^}]*?gap:)\s*[^;]+;', '$1 8px;')

$css = [regex]::Replace($css, '(\.c-float-badge\s*\{[^}]*?padding:)\s*[^;]+;', '$1 8px 16px;')
$css = [regex]::Replace($css, '(\.c-float-badge\s*\{[^}]*?gap:)\s*[^;]+;', '$1 8px;')

Set-Content -Path 'assets\css\course-v2.css' -Value $css -Encoding UTF8
Write-Host "Spacing normalization and color cleanups complete."
