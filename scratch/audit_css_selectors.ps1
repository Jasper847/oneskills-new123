$css = Get-Content "assets/css/course-v3-core.css" -Raw
Write-Host "header-inner in CSS: $($css.Contains('header-inner'))"
Write-Host "site-header__inner in CSS: $($css.Contains('site-header__inner'))"
Write-Host "c-breadcrumb in CSS: $($css.Contains('c-breadcrumb'))"
Write-Host "c-breadcrumbs in CSS: $($css.Contains('c-breadcrumbs'))"
Write-Host "c-tuition-card in CSS: $($css.Contains('c-tuition-card'))"
Write-Host "tuition-switcher in CSS: $($css.Contains('tuition-switcher'))"

$js = Get-Content "assets/js/course-v3-core.js" -Raw
Write-Host "`nJS Checks:"
Write-Host "data-tuition-mode in JS: $($js.Contains('data-tuition-mode'))"
Write-Host "tuition-toggle in JS: $($js.Contains('tuition-toggle'))"
Write-Host "site-header in JS: $($js.Contains('site-header'))"
Write-Host "c-subnav in JS: $($js.Contains('c-subnav'))"
Write-Host "c-subnav-link in JS: $($js.Contains('c-subnav-link'))"
Write-Host "c-subnav__link in JS: $($js.Contains('c-subnav__link'))"

