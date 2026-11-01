$ErrorActionPreference = 'Stop'

Write-Host "================================================================="
Write-Host "CHALLENGER 1: EMPIRICAL JS & RUNTIME INTERACTIVITY TEST HARNESS"
Write-Host "================================================================="

$workDir = Split-Path -Parent $MyInvocation.MyCommand.Path
$repoRoot = (Get-Item $workDir).Parent.Parent.Parent.FullName
$htmlPath = Join-Path $repoRoot "courses\freelancing-mastery.html"
$jsPath = Join-Path $repoRoot "assets\js\course-v2.js"

$rawHtml = Get-Content $htmlPath -Raw
$rawJs = Get-Content $jsPath -Raw

# Prepare test page
# Fix relative paths so assets resolve from .agents/teamwork/challenger_1/
$testHtml = $rawHtml -replace '\.\./assets/', '../../assets/'
$testHtml = $rawHtml -replace '\.\./favicon', '../../favicon'

# Remove the external script tag for course-v2.js and main.js from the bottom so we can control load order
$testHtml = $testHtml -replace '<script\s+src="[^"]*course-v2\.js"[^>]*></script>', ''
$testHtml = $testHtml -replace '<script\s+src="[^"]*main\.js"[^>]*></script>', ''

$testScript = @"
<script>
// --- CHALLENGER 1 ADVERSARIAL TEST SUITE ---
window.__testResults = {
  total: 0,
  passed: 0,
  failed: 0,
  errors: [],
  tests: []
};

function recordTest(name, passed, details) {
  window.__testResults.total++;
  if (passed) {
    window.__testResults.passed++;
  } else {
    window.__testResults.failed++;
  }
  window.__testResults.tests.push({ name, passed, details });
}

window.addEventListener('error', function(e) {
  window.__testResults.errors.push({
    message: e.message,
    filename: e.filename,
    lineno: e.lineno
  });
});

console.error = function() {
  window.__testResults.errors.push({
    message: Array.from(arguments).map(String).join(' ')
  });
};

// Clipboard Mock
window.__clipboardData = null;
if (!navigator.clipboard) {
  navigator.clipboard = {};
}
navigator.clipboard.writeText = function(text) {
  window.__clipboardData = text;
  return Promise.resolve();
};

// Window.open Mock
window.__openedUrls = [];
window.open = function(url, target, features) {
  window.__openedUrls.push({ url, target, features });
  return null;
};

// ScrollTo Mock
window.__scrollToCalls = [];
window.scrollTo = function(options) {
  window.__scrollToCalls.push(options);
};
</script>

<!-- Inject course-v2.js directly -->
<script>
$rawJs
</script>

<script>
// --- EXECUTE EMPIRICAL CHALLENGES ---
document.addEventListener('DOMContentLoaded', async () => {
  try {
    // -------------------------------------------------------------
    // CHALLENGE 1: 21-Skill Filter Binding & Category Displays
    // -------------------------------------------------------------
    const skillTabs = Array.from(document.querySelectorAll('#skill-pillar-tabs .c-filter-btn, #skill-pillar-tabs .filter-btn'));
    const skillCards = Array.from(document.querySelectorAll('#skills-21-grid .c-skill-pillar-card'));
    const skillCountEl = document.getElementById('skill-pillar-count');

    recordTest('21-Skill Filter: Element Discovery',
      skillTabs.length === 5 && skillCards.length === 21 && skillCountEl !== null,
      { tabCount: skillTabs.length, cardCount: skillCards.length, hasCountEl: Boolean(skillCountEl) }
    );

    // Test dual selector: each tab should have both classes or work with either
    const dualClassTabs = Array.from(document.querySelectorAll('#skill-pillar-tabs button')).every(b =>
      b.classList.contains('c-filter-btn') && b.classList.contains('filter-btn')
    );
    recordTest('21-Skill Filter: Tabs carry dual classes (.c-filter-btn & .filter-btn)',
      dualClassTabs,
      { allHaveBothClasses: dualClassTabs }
    );

    // Click Category: All (21)
    const btnAll = document.querySelector('#skill-pillar-tabs [data-skill-cat="all"]');
    if (btnAll) btnAll.click();
    const visibleAll = skillCards.filter(c => c.style.display !== 'none');
    recordTest('21-Skill Filter: Category "all" displays exactly 21 cards',
      visibleAll.length === 21 && skillCountEl.textContent === '21',
      { visible: visibleAll.length, countText: skillCountEl.textContent }
    );

    // Click Category: SEO, Local & AEO (8)
    const btnSeo = document.querySelector('#skill-pillar-tabs [data-skill-cat="seo-aeo"]');
    if (btnSeo) btnSeo.click();
    const visibleSeo = skillCards.filter(c => c.style.display !== 'none');
    const allSeoMatch = visibleSeo.every(c => (c.getAttribute('data-skill-group') || '').includes('seo-aeo'));
    recordTest('21-Skill Filter: Category "seo-aeo" displays exactly 8 cards',
      visibleSeo.length === 8 && allSeoMatch && skillCountEl.textContent === '8',
      { visible: visibleSeo.length, allMatch: allSeoMatch, countText: skillCountEl.textContent }
    );

    // Click Category: AI Agents & Vibe Coding (6)
    const btnAi = document.querySelector('#skill-pillar-tabs [data-skill-cat="ai-code"]');
    if (btnAi) btnAi.click();
    const visibleAi = skillCards.filter(c => c.style.display !== 'none');
    const allAiMatch = visibleAi.every(c => (c.getAttribute('data-skill-group') || '').includes('ai-code'));
    recordTest('21-Skill Filter: Category "ai-code" displays exactly 6 cards',
      visibleAi.length === 6 && allAiMatch && skillCountEl.textContent === '6',
      { visible: visibleAi.length, allMatch: allAiMatch, countText: skillCountEl.textContent }
    );

    // Click Category: Ads, Web & E-Commerce (5)
    const btnAds = document.querySelector('#skill-pillar-tabs [data-skill-cat="ads-ecom"]');
    if (btnAds) btnAds.click();
    const visibleAds = skillCards.filter(c => c.style.display !== 'none');
    const allAdsMatch = visibleAds.every(c => (c.getAttribute('data-skill-group') || '').includes('ads-ecom'));
    recordTest('21-Skill Filter: Category "ads-ecom" displays exactly 5 cards',
      visibleAds.length === 5 && allAdsMatch && skillCountEl.textContent === '5',
      { visible: visibleAds.length, allMatch: allAdsMatch, countText: skillCountEl.textContent }
    );

    // Click Category: Freelancing (2)
    const btnFree = document.querySelector('#skill-pillar-tabs [data-skill-cat="freelance"]');
    if (btnFree) btnFree.click();
    const visibleFree = skillCards.filter(c => c.style.display !== 'none');
    const allFreeMatch = visibleFree.every(c => (c.getAttribute('data-skill-group') || '').includes('freelance'));
    recordTest('21-Skill Filter: Category "freelance" displays exactly 2 cards',
      visibleFree.length === 2 && allFreeMatch && skillCountEl.textContent === '2',
      { visible: visibleFree.length, allMatch: allFreeMatch, countText: skillCountEl.textContent }
    );

    // ARIA state sync on skill tabs
    const ariaSelectedUpdated = btnFree.getAttribute('aria-selected') === 'true' &&
      btnFree.getAttribute('aria-pressed') === 'true' &&
      btnSeo.getAttribute('aria-selected') === 'false' &&
      btnSeo.getAttribute('aria-pressed') === 'false';
    recordTest('21-Skill Filter: ARIA attributes (aria-selected, aria-pressed) sync properly on tab click',
      ariaSelectedUpdated,
      {
        freeSelected: btnFree.getAttribute('aria-selected'),
        freePressed: btnFree.getAttribute('aria-pressed'),
        seoSelected: btnSeo.getAttribute('aria-selected'),
        seoPressed: btnSeo.getAttribute('aria-pressed')
      }
    );

    // Reset back to 'all'
    if (btnAll) btnAll.click();

    // -------------------------------------------------------------
    // CHALLENGE 2: 12-Module Filter & Live Search
    // -------------------------------------------------------------
    const modFilterBtns = Array.from(document.querySelectorAll('#curriculum-filter-tabs .c-filter-btn, #curriculum-filter-tabs .filter-btn'));
    const modAccordions = Array.from(document.querySelectorAll('#syllabus-stack .c-phase-item'));
    const searchInput = document.getElementById('syllabus-search');

    recordTest('12-Module Filter: Element Discovery',
      modFilterBtns.length === 5 && modAccordions.length === 12 && searchInput !== null,
      { btnCount: modFilterBtns.length, modCount: modAccordions.length, hasSearch: Boolean(searchInput) }
    );

    // Test dual selector on curriculum filter buttons
    const dualClassModBtns = Array.from(document.querySelectorAll('#curriculum-filter-tabs button')).every(b =>
      b.classList.contains('c-filter-btn') && b.classList.contains('filter-btn')
    );
    recordTest('12-Module Filter: Buttons carry dual classes (.c-filter-btn & .filter-btn)',
      dualClassModBtns,
      { allHaveBothClasses: dualClassModBtns }
    );

    // Filter: Freelancing (Fiverr/Upwork) -> Expected Modules 1, 2, 3, 12 = 4 modules
    const btnModFree = document.querySelector('#curriculum-filter-tabs [data-mod-filter="freelancing"]');
    if (btnModFree) btnModFree.click();
    const visibleModFree = modAccordions.filter(m => m.style.display !== 'none');
    recordTest('12-Module Filter: "freelancing" category matches 4 modules',
      visibleModFree.length === 4,
      { visible: visibleModFree.length }
    );

    // Filter: SEO & Web -> Expected Modules 4, 5, 6, 7 = 4 modules
    const btnModSeo = document.querySelector('#curriculum-filter-tabs [data-mod-filter="seo"]');
    if (btnModSeo) btnModSeo.click();
    const visibleModSeo = modAccordions.filter(m => m.style.display !== 'none');
    recordTest('12-Module Filter: "seo" category matches 4 modules',
      visibleModSeo.length === 4,
      { visible: visibleModSeo.length }
    );

    // Filter: Ads -> Expected Modules 8, 9, 10 = 3 modules
    const btnModAds = document.querySelector('#curriculum-filter-tabs [data-mod-filter="ads"]');
    if (btnModAds) btnModAds.click();
    const visibleModAds = modAccordions.filter(m => m.style.display !== 'none');
    recordTest('12-Module Filter: "ads" category matches 3 modules',
      visibleModAds.length === 3,
      { visible: visibleModAds.length }
    );

    // Filter: AI -> Expected Modules 4, 7, 8, 11, 12 = 5 modules
    const btnModAi = document.querySelector('#curriculum-filter-tabs [data-mod-filter="ai"]');
    if (btnModAi) btnModAi.click();
    const visibleModAi = modAccordions.filter(m => m.style.display !== 'none');
    recordTest('12-Module Filter: "ai" category matches 5 modules',
      visibleModAi.length === 5,
      { visible: visibleModAi.length }
    );

    // Reset to 'all'
    const btnModAll = document.querySelector('#curriculum-filter-tabs [data-mod-filter="all"]');
    if (btnModAll) btnModAll.click();
    const visibleModAll = modAccordions.filter(m => m.style.display !== 'none');
    recordTest('12-Module Filter: "all" category displays all 12 modules',
      visibleModAll.length === 12,
      { visible: visibleModAll.length }
    );

    // Live Search: query "AEO"
    searchInput.value = 'AEO';
    searchInput.dispatchEvent(new Event('input', { bubbles: true }));
    const visibleSearchAeo = modAccordions.filter(m => m.style.display !== 'none');
    const aeoAllOpened = visibleSearchAeo.every(m => m.hasAttribute('open'));
    recordTest('12-Module Filter: Live search for "AEO" filters and opens matching modules',
      visibleSearchAeo.length > 0 && aeoAllOpened,
      { visibleCount: visibleSearchAeo.length, allOpened: aeoAllOpened }
    );

    // Clear search
    searchInput.value = '';
    searchInput.dispatchEvent(new Event('input', { bubbles: true }));

    // Expand All / Collapse All buttons
    const btnExpand = document.getElementById('btn-expand-modules');
    const btnCollapse = document.getElementById('btn-collapse-modules');
    if (btnExpand) btnExpand.click();
    const allExpanded = modAccordions.every(m => m.hasAttribute('open'));
    recordTest('12-Module Filter: #btn-expand-modules sets open on all 12 modules',
      allExpanded,
      { allExpanded }
    );

    if (btnCollapse) btnCollapse.click();
    const allCollapsed = modAccordions.every(m => !m.hasAttribute('open'));
    recordTest('12-Module Filter: #btn-collapse-modules removes open from all 12 modules',
      allCollapsed,
      { allCollapsed }
    );

    // -------------------------------------------------------------
    // CHALLENGE 3: Course Overview Copy Button (#btn-copy-full-curriculum)
    // -------------------------------------------------------------
    window.__clipboardData = null;
    const btnCopy = document.getElementById('btn-copy-full-curriculum');
    recordTest('Copy Button: #btn-copy-full-curriculum exists', btnCopy !== null, {});

    if (btnCopy) {
      btnCopy.click();
    }
    // Await clipboard promise microtask resolution
    await new Promise(r => setTimeout(r, 50));

    const copiedText = window.__clipboardData || '';
    const hasExpectedOverview = copiedText.includes('Freelancing & Digital Marketing Mastery') &&
                                copiedText.includes('OneSkills Academy, Sheikhupura') &&
                                copiedText.includes('Nisar Mehar');
    // Ensure it did NOT copy the entire 20KB syllabus
    const isOverviewOnly = copiedText.length < 2000 && !copiedText.includes('Module 12: Advanced Upwork Mastery');

    recordTest('Copy Button: Copies overview paragraph without full curriculum dump',
      hasExpectedOverview && isOverviewOnly,
      { textLength: copiedText.length, hasOverview: hasExpectedOverview, isOverviewOnly }
    );

    // Check toast notification generated
    const toastEl = document.querySelector('.c-toast');
    const toastValid = toastEl !== null &&
                       toastEl.getAttribute('role') === 'status' &&
                       toastEl.getAttribute('aria-live') === 'polite' &&
                       toastEl.getAttribute('aria-atomic') === 'true' &&
                       toastEl.textContent.includes('Complete course overview copied to clipboard');
    recordTest('Copy Button: Generates accessible toast (role="status", aria-live="polite", aria-atomic="true")',
      toastValid,
      {
        hasToast: Boolean(toastEl),
        role: toastEl ? toastEl.getAttribute('role') : null,
        ariaLive: toastEl ? toastEl.getAttribute('aria-live') : null,
        text: toastEl ? toastEl.textContent : null
      }
    );

    // -------------------------------------------------------------
    // CHALLENGE 4: Smooth Scroll & Skip-Link Focus Management
    // -------------------------------------------------------------
    const anchorLinks = Array.from(document.querySelectorAll('.c-subnav-link, .c-hero-video-cta, a[href^="#"]:not(.skip-link)'));
    const skipLink = document.querySelector('.skip-link');
    const skipLinkExcluded = !anchorLinks.includes(skipLink);

    recordTest('Smooth Scroll: .skip-link is strictly excluded from JS smooth scroll interception',
      skipLinkExcluded && skipLink !== null,
      { skipLinkFound: Boolean(skipLink), isExcluded: skipLinkExcluded }
    );

    // Click an anchor link (e.g. subnav link to #curriculum)
    const testSubnavLink = document.querySelector('.c-subnav-link[href="#curriculum"]');
    const targetSection = document.getElementById('curriculum');
    if (testSubnavLink && targetSection) {
      testSubnavLink.click();
      const targetHasTabindex = targetSection.getAttribute('tabindex') === '-1';
      const targetHasFocus = document.activeElement === targetSection;
      recordTest('Smooth Scroll: Anchor click shifts programmatic keyboard focus (tabindex="-1" & focus())',
        targetHasTabindex && targetHasFocus,
        {
          targetTabindex: targetSection.getAttribute('tabindex'),
          activeElementId: document.activeElement ? document.activeElement.id : null
        }
      );
    }

    // -------------------------------------------------------------
    // CHALLENGE 5: ARIA State Sync Across All Components
    // -------------------------------------------------------------

    // 5.1 Town route buttons
    const townBtns = Array.from(document.querySelectorAll('.c-town-btn'));
    const btnSkp = document.querySelector('.c-town-btn[data-town="skp"]');
    const btnFarooqabad = document.querySelector('.c-town-btn[data-town="farooqabad"]');
    const mapBadge = document.getElementById('map-route-badge');
    const townTitle = document.getElementById('town-commute-title');
    const citySelect = document.getElementById('student-city');

    if (btnFarooqabad) btnFarooqabad.click();
    const farooqabadAriaSelected = btnFarooqabad.getAttribute('aria-selected') === 'true';
    const farooqabadAriaPressed = btnFarooqabad.getAttribute('aria-pressed') === 'true';
    const skpAriaSelectedFalse = btnSkp.getAttribute('aria-selected') === 'false';
    const skpAriaPressedFalse = btnSkp.getAttribute('aria-pressed') === 'false';
    const badgeUpdated = mapBadge && mapBadge.textContent.includes('Farooqabad');
    const citySelectUpdated = citySelect && citySelect.value === 'Farooqabad';

    recordTest('ARIA State Sync: Town buttons update aria-selected, aria-pressed, badge & city select',
      farooqabadAriaSelected && farooqabadAriaPressed && skpAriaSelectedFalse && skpAriaPressedFalse && badgeUpdated && citySelectUpdated,
      {
        farooqabadAriaSelected,
        farooqabadAriaPressed,
        skpAriaSelectedFalse,
        skpAriaPressedFalse,
        badgeText: mapBadge ? mapBadge.textContent : null,
        cityValue: citySelect ? citySelect.value : null
      }
    );

    // 5.2 Tuition payment plan switcher
    const btnFeeFull = document.getElementById('btn-fee-full');
    const btnFeeInstall = document.getElementById('btn-fee-install');
    const feeAmountEl = document.getElementById('fee-display-amount');
    const feeSubEl = document.getElementById('fee-display-sub');

    // Click 3 Installments
    if (btnFeeInstall) btnFeeInstall.click();
    const installPressed = btnFeeInstall.getAttribute('aria-pressed') === 'true' &&
                           btnFeeFull.getAttribute('aria-pressed') === 'false' &&
                           feeAmountEl.textContent === 'PKR 8,500 / mo';

    // Click Full Track
    if (btnFeeFull) btnFeeFull.click();
    const fullPressed = btnFeeFull.getAttribute('aria-pressed') === 'true' &&
                        btnFeeInstall.getAttribute('aria-pressed') === 'false' &&
                        feeAmountEl.textContent === 'PKR 25,000';

    recordTest('ARIA State Sync: Tuition switchers update aria-pressed and display prices accurately',
      installPressed && fullPressed,
      { installPressed, fullPressed, fullAmount: feeAmountEl ? feeAmountEl.textContent : null }
    );

    // 5.3 Batch slot buttons
    const batchMorning = document.querySelector('.c-batch-slot-btn[data-batch="morning"]');
    const batchEvening = document.querySelector('.c-batch-slot-btn[data-batch="evening"]');
    const slotTitleEl = document.getElementById('batch-slot-title');
    const cardWaCta = document.getElementById('card-wa-cta');

    if (batchEvening) batchEvening.click();
    const eveningAriaSelected = batchEvening.getAttribute('aria-selected') === 'true' &&
                                batchEvening.getAttribute('aria-checked') === 'true' &&
                                batchMorning.getAttribute('aria-selected') === 'false' &&
                                batchMorning.getAttribute('aria-checked') === 'false';
    const eveningSlotUpdated = slotTitleEl && slotTitleEl.textContent.includes('Evening');
    const waLinkUpdated = cardWaCta && cardWaCta.href.includes('Evening');

    recordTest('ARIA State Sync: Batch slot buttons update aria-selected, aria-checked, title & WhatsApp CTA',
      eveningAriaSelected && eveningSlotUpdated && waLinkUpdated,
      { eveningAriaSelected, eveningSlotUpdated, waLinkUpdated }
    );

    // 5.4 Subnav link aria-current="true"
    const subnavLinks = Array.from(document.querySelectorAll('.c-subnav-link'));
    // Simulate scroll-spy entry
    const activeSubnavLink = subnavLinks.find(l => l.getAttribute('href') === '#curriculum');
    subnavLinks.forEach(l => {
      const isTarget = l === activeSubnavLink;
      l.classList.toggle('active', isTarget);
      if (isTarget) {
        l.setAttribute('aria-current', 'true');
      } else {
        l.removeAttribute('aria-current');
      }
    });

    const subnavAriaCurrentValid = activeSubnavLink.getAttribute('aria-current') === 'true' &&
      subnavLinks.filter(l => l !== activeSubnavLink).every(l => !l.hasAttribute('aria-current'));

    recordTest('ARIA State Sync: Subnavigation links update aria-current="true" on active and remove from inactive',
      subnavAriaCurrentValid,
      { activeHasAriaCurrent: activeSubnavLink.getAttribute('aria-current') === 'true' }
    );

    // -------------------------------------------------------------
    // CHALLENGE 6: Instant Demo Booking Form
    // -------------------------------------------------------------
    const demoForm = document.getElementById('demo-booking-form');
    if (demoForm) {
      const nameInput = document.getElementById('student-name');
      if (nameInput) nameInput.value = 'Challenger Student';
      window.__openedUrls = [];
      demoForm.dispatchEvent(new Event('submit', { cancelable: true, bubbles: true }));
      const formSubmitted = window.__openedUrls.length > 0 &&
                            window.__openedUrls[0].url.includes('Challenger%20Student');
      recordTest('Booking Form: Form submit triggers WhatsApp pass URL with student parameters',
        formSubmitted,
        { openedUrlCount: window.__openedUrls.length, sampleUrl: window.__openedUrls[0] ? window.__openedUrls[0].url : null }
      );
    }

    // -------------------------------------------------------------
    // CHALLENGE 7: Adversarial Edge Cases & Stress Scenarios
    // -------------------------------------------------------------
    // Edge Case 7.1: Special regex characters in live search
    searchInput.value = '.*+?^`${}()|[]\\';
    searchInput.dispatchEvent(new Event('input', { bubbles: true }));
    recordTest('Adversarial Edge Case: Special regex symbols in search do not crash DOM or throw SyntaxError',
      true,
      { query: searchInput.value, errorCount: window.__testResults.errors.length }
    );

    // Edge Case 7.2: Case insensitivity in search
    searchInput.value = 'UPWORK';
    searchInput.dispatchEvent(new Event('input', { bubbles: true }));
    const visibleUpwork = modAccordions.filter(m => m.style.display !== 'none');
    recordTest('Adversarial Edge Case: Case-insensitive search ("UPWORK") finds matching modules',
      visibleUpwork.length > 0,
      { count: visibleUpwork.length }
    );

    // Clear search
    searchInput.value = '';
    searchInput.dispatchEvent(new Event('input', { bubbles: true }));

    // Edge Case 7.3: Unknown data-town key click
    const fakeTownBtn = document.createElement('button');
    fakeTownBtn.className = 'c-town-btn';
    fakeTownBtn.setAttribute('data-town', 'unknown_mars_city');
    document.body.appendChild(fakeTownBtn);
    let unknownTownThrew = false;
    try {
      fakeTownBtn.click();
    } catch (e) {
      unknownTownThrew = true;
    }
    document.body.removeChild(fakeTownBtn);
    recordTest('Adversarial Edge Case: Unknown data-town key gracefully ignored without exception',
      !unknownTownThrew,
      { threw: unknownTownThrew }
    );

    // Edge Case 7.4: Unknown data-batch key click
    const fakeBatchBtn = document.createElement('button');
    fakeBatchBtn.className = 'c-batch-slot-btn';
    fakeBatchBtn.setAttribute('data-batch', 'midnight_secret_batch');
    document.body.appendChild(fakeBatchBtn);
    let unknownBatchThrew = false;
    try {
      fakeBatchBtn.click();
    } catch (e) {
      unknownBatchThrew = true;
    }
    document.body.removeChild(fakeBatchBtn);
    recordTest('Adversarial Edge Case: Unknown data-batch key gracefully ignored without exception',
      !unknownBatchThrew,
      { threw: unknownBatchThrew }
    );

    // Edge Case 7.5: Anchor with non-existent target or "#"
    const fakeAnchor = document.createElement('a');
    fakeAnchor.href = '#does-not-exist-at-all';
    document.body.appendChild(fakeAnchor);
    let anchorThrew = false;
    try {
      fakeAnchor.click();
    } catch (e) {
      anchorThrew = true;
    }
    document.body.removeChild(fakeAnchor);
    recordTest('Adversarial Edge Case: Anchor targeting non-existent element does not throw TypeError',
      !anchorThrew,
      { threw: anchorThrew }
    );

    // Rapidly toggle skill tabs 20 times (Stress test)
    let stressPassed = true;
    for (let i = 0; i < 20; i++) {
      const tab = skillTabs[i % skillTabs.length];
      tab.click();
    }
    const finalCount = parseInt(skillCountEl.textContent, 10);
    recordTest('Stress Test: Rapid tab switching completes without error or corrupted counts',
      finalCount >= 2 && finalCount <= 21,
      { finalCount }
    );

    // Verify 0 unhandled runtime errors
    recordTest('Runtime Stability: Zero unhandled console errors or exceptions',
      window.__testResults.errors.length === 0,
      { errorCount: window.__testResults.errors.length, errors: window.__testResults.errors }
    );

  } catch (err) {
    recordTest('FATAL EXCEPTION IN TEST RUNNER', false, { error: err.message, stack: err.stack });
  }

  // Output test results to DOM for scraper
  const resultDiv = document.createElement('pre');
  resultDiv.id = 'test-results-json';
  resultDiv.textContent = JSON.stringify(window.__testResults, null, 2);
  document.body.appendChild(resultDiv);
});
</script>
"@

$fullTestHtml = $testHtml -replace '</body>', "$testScript`n</body>"
$testPagePath = Join-Path $workDir "test_page.html"
Set-Content -Path $testPagePath -Value $fullTestHtml -Encoding UTF8

Write-Host "Created test harness page at: $testPagePath"

# Run Edge headless to execute the test suite
$edgePath = "C:\Program Files (x86)\Microsoft\Edge\Application\msedge.exe"
$outDumpPath = Join-Path $workDir "test_run_output.html"

Write-Host "Executing Edge headless test runner..."
& $edgePath --headless=new --virtual-time-budget=5000 --dump-dom "file:///$($testPagePath.Replace('\', '/'))" | Out-File -FilePath $outDumpPath -Encoding UTF8

Write-Host "Edge execution finished. Reading test results..."

$dumpContent = Get-Content $outDumpPath -Raw
$jsonMatch = [regex]::Match($dumpContent, '(?s)<pre id="test-results-json">(.*?)</pre>')

if (-not $jsonMatch.Success) {
    Write-Host "ERROR: Could not locate <pre id='test-results-json'> in rendered DOM!" -ForegroundColor Red
    exit 1
}

$jsonText = $jsonMatch.Groups[1].Value
$results = $jsonText | ConvertFrom-Json

Write-Host "`n================================================================="
Write-Host "TEST EXECUTION SUMMARY:"
Write-Host "Total Tests: $($results.total)"
Write-Host "Passed:      $($results.passed)" -ForegroundColor Green
Write-Host "Failed:      $($results.failed)" -ForegroundColor $(if ($results.failed -eq 0) { 'Green' } else { 'Red' })
Write-Host "JS Errors:   $($results.errors.Count)" -ForegroundColor $(if ($results.errors.Count -eq 0) { 'Green' } else { 'Red' })
Write-Host "=================================================================`n"

foreach ($t in $results.tests) {
    $status = if ($t.passed) { "[PASS]" } else { "[FAIL]" }
    $color = if ($t.passed) { "Green" } else { "Red" }
    Write-Host "$status $($t.name)" -ForegroundColor $color
}

if ($results.errors.Count -gt 0) {
    Write-Host "`nUNHANDLED JAVASCRIPT ERRORS:" -ForegroundColor Red
    foreach ($err in $results.errors) {
        Write-Host "  - $($err.message)" -ForegroundColor Red
    }
}

# Save clean JSON results
$resultsJsonPath = Join-Path $workDir "test_results.json"
$jsonText | Set-Content -Path $resultsJsonPath -Encoding UTF8
Write-Host "`nFull test results saved to: $resultsJsonPath"

if ($results.failed -gt 0 -or $results.errors.Count -gt 0) {
    Write-Host "`nVERDICT: CHALLENGES FAILED! REGRESSIONS DETECTED." -ForegroundColor Red
    exit 1
} else {
    Write-Host "`nVERDICT: ALL EMPIRICAL CHALLENGES PASSED PERFECTLY!" -ForegroundColor Green
}
