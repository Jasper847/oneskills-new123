$path = 'courses/freelancing-mastery.html'
$content = [System.IO.File]::ReadAllText($path, [System.Text.Encoding]::UTF8)

# 1. Replace opening tags
$content = $content.Replace('<div class="c-lessons-grid module-lessons-grid">', '<ol class="c-lessons-grid module-lessons-grid">')

# 2. Replace lesson divs with li
$content = [regex]::Replace($content, '<div class="c-lesson-item lesson-item">(.*?)</div>', '<li class="c-lesson-item lesson-item">$1</li>')

# 3. Replace closing tags before deliverable bar
$content = [regex]::Replace($content, '(?<=</li>\r?\n\s*)</div>(?=\r?\n\s*<div class="c-deliverable-box module-deliverable-bar">)', '</ol>')

[System.IO.File]::WriteAllText($path, $content, [System.Text.Encoding]::UTF8)

$olCount = (Select-String -Path $path -Pattern '<ol class="c-lessons-grid').Count
$closeOlCount = (Select-String -Path $path -Pattern '</ol>').Count
$liCount = (Select-String -Path $path -Pattern '<li class="c-lesson-item').Count
Write-Host "OL count: $olCount, Close OL count: $closeOlCount, LI count: $liCount"
