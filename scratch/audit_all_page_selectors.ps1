$pages = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/programming-js-cpp.html",
    "courses/ai-based-computer-course.html",
    "courses/ai-tools-automation.html",
    "courses/web3-blockchain.html",
    "courses/forex-trading.html",
    "courses/crypto-trading.html",
    "courses/shopify-ecommerce.html",
    "courses/index.html"
)

$results = foreach ($p in $pages) {
    $c = Get-Content $p -Raw
    [PSCustomObject]@{
        Page = (Split-Path $p -Leaf)
        HasSyllabusSearch = $c.Contains('id="syllabus-search"')
        HasCurriculumSearch = $c.Contains('id="curriculum-search"')
        HasCurriculumFilterTabs = $c.Contains('id="curriculum-filter-tabs"')
        HasWeekFilter = $c.Contains('data-week-filter')
        HasPhaseItem = $c.Contains('c-phase-item')
        HasAccordionItem = $c.Contains('c-accordion-item')
        HasBtnFeeFull = $c.Contains('id="btn-fee-full"')
        HasTuitionSwitcher = $c.Contains('c-tuition-switcher')
        HasSubnavLink = $c.Contains('c-subnav-link')
        HasSubnavBEM = $c.Contains('c-subnav__link')
    }
}

$results | Format-Table -AutoSize

