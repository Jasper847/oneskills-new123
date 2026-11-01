$css = Get-Content 'assets\css\course-v2.css' -Raw

# Replace hardcoded colors outside token headers
$replacements = @(
    # Specific component rules
    @('background: #fef3c7; color: #d97706;', 'background: var(--badge-gold-bg); color: var(--badge-gold-text);'),
    @('background: #d1fae5; color: #059669;', 'background: var(--badge-emerald-bg); color: var(--badge-emerald-text);'),
    @('background: #ede9fe; color: #7c3aed;', 'background: var(--badge-purple-bg); color: var(--badge-purple-text);'),
    @('background: #ffedd5; color: #ea580c;', 'background: var(--badge-amber-bg); color: var(--badge-amber-text);'),
    
    # Gradients
    @('background: linear-gradient(135deg, #6e44ff 0%, #9066ff 100%);', 'background: var(--gradient-violet);'),
    @('background: linear-gradient(135deg, #f43f5e 0%, #fb7185 100%);', 'background: var(--gradient-rose);'),
    @('background: linear-gradient(135deg, #0284c7 0%, #38bdf8 100%);', 'background: var(--gradient-sky);'),
    @('background: linear-gradient(135deg, #059669 0%, #34d399 100%);', 'background: var(--gradient-emerald);'),

    # Color #ffffff
    @('color: #ffffff !important;', 'color: var(--text-inverse, #ffffff) !important;'),
    @('color: #ffffff;', 'color: var(--text-inverse, #ffffff);'),
    @('fill: #ffffff;', 'fill: var(--text-inverse, #ffffff);'),
    @('stroke: #ffffff;', 'stroke: var(--text-inverse, #ffffff);'),

    # Brand violet rgba(110, 68, 255, ...)
    @('rgba(110, 68, 255, 0.22)', 'var(--accent-glow, rgba(110, 68, 255, 0.22))'),
    @('rgba(110, 68, 255, 0.28)', 'var(--accent-glow, rgba(110, 68, 255, 0.28))'),
    @('rgba(110, 68, 255, 0.32)', 'var(--accent-glow, rgba(110, 68, 255, 0.32))'),
    @('rgba(110, 68, 255, 0.35)', 'var(--line-strong, rgba(110, 68, 255, 0.35))'),
    @('rgba(110, 68, 255, 0.3)', 'var(--accent-line, rgba(110, 68, 255, 0.3))'),
    @('rgba(110, 68, 255, 0.2)', 'var(--accent-line, rgba(110, 68, 255, 0.2))'),
    @('rgba(110, 68, 255, 0.18)', 'var(--accent-alpha, rgba(110, 68, 255, 0.18))'),
    @('rgba(110, 68, 255, 0.16)', 'var(--accent-alpha, rgba(110, 68, 255, 0.16))'),
    @('rgba(110, 68, 255, 0.15)', 'var(--accent-alpha, rgba(110, 68, 255, 0.15))'),
    @('rgba(110, 68, 255, 0.14)', 'var(--accent-alpha, rgba(110, 68, 255, 0.14))'),
    @('rgba(110, 68, 255, 0.12)', 'var(--accent-alpha, rgba(110, 68, 255, 0.12))'),
    @('rgba(110, 68, 255, 0.1)', 'var(--accent-alpha, rgba(110, 68, 255, 0.1))'),
    @('rgba(110, 68, 255, 0.08)', 'var(--surface-subtle, rgba(110, 68, 255, 0.08))'),
    @('rgba(110, 68, 255, 0.06)', 'var(--surface-hover, rgba(110, 68, 255, 0.06))'),
    @('rgba(110, 68, 255, 0.05)', 'var(--surface-subtle, rgba(110, 68, 255, 0.05))'),
    @('rgba(110, 68, 255, 0.02)', 'var(--surface-subtle, rgba(110, 68, 255, 0.02))'),

    # Plum shadows rgba(35, 27, 43, ...)
    @('0 4px 14px rgba(35, 27, 43, 0.05)', 'var(--shadow-plum-subtle)'),
    @('0 16px 44px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-card)'),
    @('0 14px 30px -4px rgba(35, 27, 43, 0.13), 0 4px 10px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-float)'),
    @('0 4px 16px rgba(35, 27, 43, 0.04)', 'var(--shadow-plum-subtle)'),
    @('0 12px 32px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-card)'),
    @('0 18px 40px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-float)'),
    @('0 10px 28px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-card)'),
    @('0 16px 36px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-float)'),
    @('0 12px 28px rgba(35, 27, 43, 0.04)', 'var(--shadow-plum-card)'),
    @('0 16px 36px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-float)'),
    @('0 16px 38px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-card)'),
    @('0 20px 48px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-card)'),
    @('0 12px 30px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-card)'),
    @('0 -6px 20px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-card)'),
    @('0 8px 24px rgba(35, 27, 43, 0.08)', 'var(--shadow-plum-card)'),
    @('0 8px 20px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-card)'),
    @('0 8px 20px rgba(35, 27, 43, 0.04)', 'var(--shadow-plum-card)'),
    @('0 10px 24px rgba(35, 27, 43, 0.06)', 'var(--shadow-plum-card)'),
    @('0 6px 18px rgba(35, 27, 43, 0.04)', 'var(--shadow-plum-subtle)'),
    @('0 8px 20px rgba(35, 27, 43, 0.05)', 'var(--shadow-plum-card)'),
    @('0 4px 12px rgba(35, 27, 43, 0.04)', 'var(--shadow-plum-subtle)'),
    @('0 4px 14px rgba(35, 27, 43, 0.04)', 'var(--shadow-plum-subtle)'),
    @('0 4px 16px rgba(35, 27, 43, 0.03)', 'var(--shadow-plum-subtle)'),
    @('0 4px 12px rgba(35, 27, 43, 0.03)', 'var(--shadow-plum-subtle)'),
    @('rgba(35, 27, 43, 0.11)', 'var(--line)'),
    @('rgba(35, 27, 43, 0.2)', 'var(--line-strong)'),
    @('rgba(35, 27, 43, 0.04)', 'var(--surface-subtle)'),
    @('rgba(35, 27, 43, 0.06)', 'var(--surface-hover)'),
    @('rgba(35, 27, 43, 0.08)', 'var(--surface-hover)'),

    # Status / Indicators
    @('color: #f59e0b;', 'color: var(--accent-amber, #f59e0b);'),
    @('color: #10b981;', 'color: var(--tag-roas, #10b981);'),
    @('color: #059669;', 'color: var(--accent-emerald, #059669);'),
    @('background: rgba(16, 185, 129, 0.15);', 'background: var(--accent-emerald-alpha, rgba(16, 185, 129, 0.15));'),
    @('border-color: rgba(16, 185, 129, 0.3);', 'border-color: var(--accent-emerald-line, rgba(16, 185, 129, 0.3));'),
    @('rgba(16, 185, 129, 0.12)', 'var(--accent-emerald-alpha, rgba(16, 185, 129, 0.12))'),
    @('rgba(16, 185, 129, 0.04)', 'var(--accent-emerald-subtle, rgba(16, 185, 129, 0.04))'),
    @('rgba(245, 158, 11, 0.35)', 'var(--accent-amber-line, rgba(245, 158, 11, 0.35))'),
    @('rgba(168, 85, 247, 0.35)', 'var(--accent-line, rgba(168, 85, 247, 0.35))')
)

foreach ($r in $replacements) {
    $from = [regex]::Escape($r[0])
    $to = $r[1]
    $css = [regex]::Replace($css, $from, $to)
}

Set-Content -Path 'assets\css\course-v2.css' -Value $css -Encoding UTF8
Write-Host "Batch color replacements complete."
