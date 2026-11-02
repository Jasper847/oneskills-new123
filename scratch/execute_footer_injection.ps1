[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

# Template: Subdirectory Course Pages
$footerCourses = @'
  <footer class="footer-wrap" id="footer">
    <div class="container footer-container">

      <div class="footer-top-grid">

        <!-- Column 1: OneSkills.pk Brand -->
        <div class="footer-brand-col">
          <div class="footer-brand-name">OneSkills<span class="brand-pk">.pk</span></div>
          <div class="footer-brand-sub" aria-hidden="true">ACADEMY</div>
          <p class="footer-desc">Practical digital skills and hands-on mentorship for learners in Sheikhupura.</p>

          <div class="footer-social-icons-grid" aria-label="OneSkills Social Media Profiles">
            <a class="social-icon-btn fb" href="https://www.facebook.com/oneskillspk" target="_blank"
              rel="noopener noreferrer" title="Follow @oneskillspk on Facebook" aria-label="Facebook">
              <svg viewBox="0 0 24 24">
                <path
                  d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
              </svg>
            </a>

            <a class="social-icon-btn insta" href="https://www.instagram.com/oneskillspk/" target="_blank"
              rel="noopener noreferrer" title="Follow @oneskillspk on Instagram" aria-label="Instagram">
              <svg viewBox="0 0 24 24">
                <path
                  d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
              </svg>
            </a>

            <a class="social-icon-btn yt" href="https://www.youtube.com/@OneSkillspk" target="_blank"
              rel="noopener noreferrer" title="Subscribe to @OneSkillspk on YouTube" aria-label="YouTube">
              <svg viewBox="0 0 24 24">
                <path
                  d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z" />
              </svg>
            </a>

            <a class="social-icon-btn x" href="https://x.com/oneskillspk/" target="_blank" rel="noopener noreferrer"
              title="Follow @oneskillspk on X" aria-label="X Twitter">
              <svg viewBox="0 0 24 24">
                <path
                  d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
              </svg>
            </a>

            <a class="social-icon-btn wa" href="https://wa.me/923176036127" target="_blank" rel="noopener noreferrer"
              title="Chat with OneSkills on WhatsApp" aria-label="WhatsApp">
              <svg viewBox="0 0 24 24">
                <path
                  d="M12.04 2c-5.46 0-9.91 4.45-9.91 9.91 0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38c1.45.79 3.08 1.21 4.74 1.21 5.46 0 9.91-4.45 9.91-9.91 0-2.65-1.03-5.14-2.9-7.01A9.816 9.816 0 0 0 12.04 2zm0 18.15c-1.48 0-2.93-.4-4.2-1.15l-.3-.18-3.12.82.83-3.04-.2-.31a8.163 8.163 0 0 1-1.26-4.38c0-4.54 3.7-8.24 8.24-8.24 2.2 0 4.27.86 5.82 2.42a8.18 8.18 0 0 1 2.41 5.83c.01 4.54-3.68 8.23-8.22 8.23zm4.52-6.16c-.25-.12-1.47-.72-1.69-.81-.23-.08-.39-.12-.56.12-.17.25-.64.81-.79.97-.14.17-.29.19-.54.06-.25-.12-1.05-.39-1.99-1.23-.74-.66-1.23-1.47-1.38-1.72-.14-.25-.02-.38.11-.51.11-.11.25-.29.37-.43.12-.14.17-.25.25-.41.08-.17.04-.31-.02-.43-.06-.12-.56-1.34-.76-1.84-.2-.48-.41-.42-.56-.43h-.48c-.17 0-.43.06-.66.31-.22.25-.86.84-.86 2.06 0 1.21.89 2.39 1.01 2.55.12.17 1.74 2.66 4.22 3.73.59.25 1.05.41 1.41.52.59.19 1.13.16 1.56.1.48-.07 1.47-.6 1.67-1.18.21-.58.21-1.07.14-1.18-.06-.1-.23-.17-.48-.29z" />
              </svg>
            </a>
          </div>

          <div class="footer-brand-tagline-wrap">
            <div class="footer-brand-dash" aria-hidden="true"></div>
            <span class="footer-brand-tagline">Skills Today, Brighter Tomorrows.</span>
          </div>
        </div>

        <!-- Column 2: Career Tracks -->
        <div class="footer-col">
          <h4>Career Tracks</h4>
          <ul class="footer-links-list">
            <li>
              <a href="freelancing-mastery.html" class="footer-nav-item">
                <span>Freelancing &amp; Digital Marketing</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="ai-tools-automation.html" class="footer-nav-item">
                <span>AI Tools &amp; Automation</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="ai-web-development.html" class="footer-nav-item">
                <span>AI Powered Web Development</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="crypto-trading.html" class="footer-nav-item">
                <span>Crypto Trading</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="forex-trading.html" class="footer-nav-item">
                <span>Forex Trading</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="web3-blockchain.html" class="footer-nav-item">
                <span>Web3 &amp; Blockchain</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="programming-js-cpp.html" class="footer-nav-item">
                <span>Computer &amp; Programming</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="ai-based-computer-course.html" class="footer-nav-item">
                <span>AI Computer &amp; Office Skills</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="shopify-ecommerce.html" class="footer-nav-item">
                <span>Shopify &amp; E-Commerce</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
          </ul>
        </div>

        <!-- Column 3: Academy Hub -->
        <div class="footer-col">
          <h4>Academy Hub</h4>
          <ul class="footer-links-list">
            <li>
              <a href="../about.html" class="footer-nav-item">
                <span>Why OneSkills</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="../index.html#instructors" class="footer-nav-item">
                <span>Lead Mentors</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="../index.html#reviews" class="footer-nav-item">
                <span>Verified Reviews</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="../index.html#faq" class="footer-nav-item">
                <span>FAQ &amp; Admissions</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="../index.html#campus" class="footer-nav-item">
                <span>Campus Directions</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="../guides/index.html" class="footer-nav-item">
                <span>Career Guides</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
          </ul>
        </div>

        <!-- Column 4: Campus Desk -->
        <div class="footer-col">
          <h4>Campus Desk</h4>
          <ul class="footer-campus-list">
            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                  <circle cx="12" cy="10" r="3"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Address</span>
                <span class="campus-item-val">Lahore – Sargodha Road, Opp. Mian Hospital, Near KIPS College, Sheikhupura</span>
              </div>
            </li>

            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Phone / WhatsApp</span>
                <span class="campus-item-val"><a href="tel:+923176036127">+92 317 603 6127</a></span>
              </div>
            </li>

            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                  <polyline points="22,6 12,13 2,6"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Email</span>
                <span class="campus-item-val"><a href="mailto:info@OneSkills.pk">info@OneSkills.pk</a></span>
              </div>
            </li>

            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <circle cx="12" cy="12" r="10"/>
                  <polyline points="12 6 12 12 16 14"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Hours</span>
                <span class="campus-item-val">Mon–Sat &middot; 8:30 AM – 6:00 PM</span>
              </div>
            </li>
          </ul>
        </div>

      </div>

      <!-- Bottom Legal Bar -->
      <div class="footer-bottom-bar">
        <p>&copy; 2026 OneSkills.pk. All Rights Reserved.</p>
        <div class="footer-legal-links">
          <a href="../privacy-policy.html">Privacy Policy</a>
          <span class="legal-divider" aria-hidden="true">|</span>
          <a href="../terms-of-service.html">Terms of Service</a>
          <span class="legal-divider" aria-hidden="true">|</span>

          <a href="#hero" class="footer-back-to-top" id="footer-back-to-top" aria-label="Back to top">
            <span class="back-to-top-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <line x1="12" y1="19" x2="12" y2="5"/>
                <polyline points="5 12 12 5 19 12"/>
              </svg>
            </span>
            <span>Back to top</span>
          </a>
        </div>
      </div>

      <!-- Panoramic Hiran Minar Editorial Visual -->
      <div class="footer-hiran-wrap">
        <img
          src="../assets/images/sections/Golden-Hour Reflections at Hiran Minar.webp"
          alt="Scenic golden-hour reflections at Hiran Minar in Sheikhupura"
          class="footer-hiran-img"
          loading="lazy"
          decoding="async"
          width="1920"
          height="540"
        />
        <div class="footer-hiran-fade" aria-hidden="true"></div>
        <div class="footer-hiran-badge" aria-label="Sheikhupura — Our Home">
          <span class="hiran-badge-city">Sheikhupura</span>
          <span class="hiran-badge-home">
            <span>OUR HOME</span>
            <span class="hiran-badge-line" aria-hidden="true"></span>
          </span>
        </div>
      </div>

    </div>
  </footer>
'@

# Template: Catalog Hub (courses/index.html)
$footerCatalog = $footerCourses -replace 'href="#hero"', 'href="#main-content"'

# Template: Root Pages (about.html, privacy-policy.html, terms-of-service.html, 404.html, index.html)
$footerRoot = @'
  <footer class="footer-wrap" id="footer">
    <div class="container footer-container">

      <div class="footer-top-grid">

        <!-- Column 1: OneSkills.pk Brand -->
        <div class="footer-brand-col">
          <div class="footer-brand-name">OneSkills<span class="brand-pk">.pk</span></div>
          <div class="footer-brand-sub" aria-hidden="true">ACADEMY</div>
          <p class="footer-desc">Practical digital skills and hands-on mentorship for learners in Sheikhupura.</p>

          <div class="footer-social-icons-grid" aria-label="OneSkills Social Media Profiles">
            <a class="social-icon-btn fb" href="https://www.facebook.com/oneskillspk" target="_blank"
              rel="noopener noreferrer" title="Follow @oneskillspk on Facebook" aria-label="Facebook">
              <svg viewBox="0 0 24 24">
                <path
                  d="M24 12.073c0-6.627-5.373-12-12-12s-12 5.373-12 12c0 5.99 4.388 10.954 10.125 11.854v-8.385H7.078v-3.47h3.047V9.43c0-3.007 1.792-4.669 4.533-4.669 1.312 0 2.686.235 2.686.235v2.953H15.83c-1.491 0-1.956.925-1.956 1.874v2.25h3.328l-.532 3.47h-2.796v8.385C19.612 23.027 24 18.062 24 12.073z" />
              </svg>
            </a>

            <a class="social-icon-btn insta" href="https://www.instagram.com/oneskillspk/" target="_blank"
              rel="noopener noreferrer" title="Follow @oneskillspk on Instagram" aria-label="Instagram">
              <svg viewBox="0 0 24 24">
                <path
                  d="M12 2.163c3.204 0 3.584.012 4.85.07 3.252.148 4.771 1.691 4.919 4.919.058 1.265.069 1.645.069 4.849 0 3.205-.012 3.584-.069 4.849-.149 3.225-1.664 4.771-4.919 4.919-1.266.058-1.644.07-4.85.07-3.204 0-3.584-.012-4.849-.07-3.26-.149-4.771-1.699-4.919-4.92-.058-1.265-.07-1.644-.07-4.849 0-3.204.013-3.583.07-4.849.149-3.227 1.664-4.771 4.919-4.919 1.266-.057 1.645-.069 4.849-.069zm0-2.163c-3.259 0-3.667.014-4.947.072-4.358.2-6.78 2.618-6.98 6.98-.059 1.281-.073 1.689-.073 4.948 0 3.259.014 3.668.072 4.948.2 4.358 2.618 6.78 6.98 6.98 1.281.058 1.689.072 4.948.072 3.259 0 3.668-.014 4.948-.072 4.354-.2 6.782-2.618 6.979-6.98.059-1.28.073-1.689.073-4.948 0-3.259-.014-3.667-.072-4.947-.196-4.354-2.617-6.78-6.979-6.98-1.281-.059-1.69-.073-4.949-.073zm0 5.838c-3.403 0-6.162 2.759-6.162 6.162s2.759 6.163 6.162 6.163 6.162-2.759 6.162-6.163c0-3.403-2.759-6.162-6.162-6.162zm0 10.162c-2.209 0-4-1.79-4-4 0-2.209 1.791-4 4-4s4 1.791 4 4c0 2.21-1.791 4-4 4zm6.406-11.845c-.796 0-1.441.645-1.441 1.44s.645 1.44 1.441 1.44c.795 0 1.439-.645 1.439-1.44s-.644-1.44-1.439-1.44z" />
              </svg>
            </a>

            <a class="social-icon-btn yt" href="https://www.youtube.com/@OneSkillspk" target="_blank"
              rel="noopener noreferrer" title="Subscribe to @OneSkillspk on YouTube" aria-label="YouTube">
              <svg viewBox="0 0 24 24">
                <path
                  d="M23.498 6.186a3.016 3.016 0 0 0-2.122-2.136C19.505 3.545 12 3.545 12 3.545s-7.505 0-9.377.505A3.017 3.017 0 0 0 .502 6.186C0 8.07 0 12 0 12s0 3.93.502 5.814a3.016 3.016 0 0 0 2.122 2.136c1.871.505 9.376.505 9.376.505s7.505 0 9.377-.505a3.015 3.015 0 0 0 2.122-2.136C24 15.93 24 12 24 12s0-3.93-.502-5.814zM9.545 15.568V8.432L15.818 12l-6.273 3.568z" />
              </svg>
            </a>

            <a class="social-icon-btn x" href="https://x.com/oneskillspk/" target="_blank" rel="noopener noreferrer"
              title="Follow @oneskillspk on X" aria-label="X Twitter">
              <svg viewBox="0 0 24 24">
                <path
                  d="M18.244 2.25h3.308l-7.227 8.26 8.502 11.24H16.17l-5.214-6.817L4.99 21.75H1.68l7.73-8.835L1.254 2.25H8.08l4.713 6.231zm-1.161 17.52h1.833L7.084 4.126H5.117z" />
              </svg>
            </a>

            <a class="social-icon-btn wa" href="https://wa.me/923176036127" target="_blank" rel="noopener noreferrer"
              title="Chat with OneSkills on WhatsApp" aria-label="WhatsApp">
              <svg viewBox="0 0 24 24">
                <path
                  d="M12.04 2c-5.46 0-9.91 4.45-9.91 9.91 0 1.75.46 3.45 1.32 4.95L2.05 22l5.25-1.38c1.45.79 3.08 1.21 4.74 1.21 5.46 0 9.91-4.45 9.91-9.91 0-2.65-1.03-5.14-2.9-7.01A9.816 9.816 0 0 0 12.04 2zm0 18.15c-1.48 0-2.93-.4-4.2-1.15l-.3-.18-3.12.82.83-3.04-.2-.31a8.163 8.163 0 0 1-1.26-4.38c0-4.54 3.7-8.24 8.24-8.24 2.2 0 4.27.86 5.82 2.42a8.18 8.18 0 0 1 2.41 5.83c.01 4.54-3.68 8.23-8.22 8.23zm4.52-6.16c-.25-.12-1.47-.72-1.69-.81-.23-.08-.39-.12-.56.12-.17.25-.64.81-.79.97-.14.17-.29.19-.54.06-.25-.12-1.05-.39-1.99-1.23-.74-.66-1.23-1.47-1.38-1.72-.14-.25-.02-.38.11-.51.11-.11.25-.29.37-.43.12-.14.17-.25.25-.41.08-.17.04-.31-.02-.43-.06-.12-.56-1.34-.76-1.84-.2-.48-.41-.42-.56-.43h-.48c-.17 0-.43.06-.66.31-.22.25-.86.84-.86 2.06 0 1.21.89 2.39 1.01 2.55.12.17 1.74 2.66 4.22 3.73.59.25 1.05.41 1.41.52.59.19 1.13.16 1.56.1.48-.07 1.47-.6 1.67-1.18.21-.58.21-1.07.14-1.18-.06-.1-.23-.17-.48-.29z" />
              </svg>
            </a>
          </div>

          <div class="footer-brand-tagline-wrap">
            <div class="footer-brand-dash" aria-hidden="true"></div>
            <span class="footer-brand-tagline">Skills Today, Brighter Tomorrows.</span>
          </div>
        </div>

        <!-- Column 2: Career Tracks -->
        <div class="footer-col">
          <h4>Career Tracks</h4>
          <ul class="footer-links-list">
            <li>
              <a href="courses/freelancing-mastery.html" class="footer-nav-item">
                <span>Freelancing &amp; Digital Marketing</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/ai-tools-automation.html" class="footer-nav-item">
                <span>AI Tools &amp; Automation</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/ai-web-development.html" class="footer-nav-item">
                <span>AI Powered Web Development</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/crypto-trading.html" class="footer-nav-item">
                <span>Crypto Trading</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/forex-trading.html" class="footer-nav-item">
                <span>Forex Trading</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/web3-blockchain.html" class="footer-nav-item">
                <span>Web3 &amp; Blockchain</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/programming-js-cpp.html" class="footer-nav-item">
                <span>Computer &amp; Programming</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/ai-based-computer-course.html" class="footer-nav-item">
                <span>AI Computer &amp; Office Skills</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="courses/shopify-ecommerce.html" class="footer-nav-item">
                <span>Shopify &amp; E-Commerce</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
          </ul>
        </div>

        <!-- Column 3: Academy Hub -->
        <div class="footer-col">
          <h4>Academy Hub</h4>
          <ul class="footer-links-list">
            <li>
              <a href="about.html" class="footer-nav-item">
                <span>Why OneSkills</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="index.html#instructors" class="footer-nav-item">
                <span>Lead Mentors</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="index.html#reviews" class="footer-nav-item">
                <span>Verified Reviews</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="index.html#faq" class="footer-nav-item">
                <span>FAQ &amp; Admissions</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="index.html#campus" class="footer-nav-item">
                <span>Campus Directions</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
            <li>
              <a href="guides/index.html" class="footer-nav-item">
                <span>Career Guides</span>
                <span class="footer-nav-arrow" aria-hidden="true">&rarr;</span>
              </a>
            </li>
          </ul>
        </div>

        <!-- Column 4: Campus Desk -->
        <div class="footer-col">
          <h4>Campus Desk</h4>
          <ul class="footer-campus-list">
            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M21 10c0 7-9 13-9 13s-9-6-9-13a9 9 0 0 1 18 0z"/>
                  <circle cx="12" cy="10" r="3"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Address</span>
                <span class="campus-item-val">Lahore – Sargodha Road, Opp. Mian Hospital, Near KIPS College, Sheikhupura</span>
              </div>
            </li>

            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Phone / WhatsApp</span>
                <span class="campus-item-val"><a href="tel:+923176036127">+92 317 603 6127</a></span>
              </div>
            </li>

            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <path d="M4 4h16c1.1 0 2 .9 2 2v12c0 1.1-.9 2-2 2H4c-1.1 0-2-.9-2-2V6c0-1.1.9-2 2-2z"/>
                  <polyline points="22,6 12,13 2,6"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Email</span>
                <span class="campus-item-val"><a href="mailto:info@OneSkills.pk">info@OneSkills.pk</a></span>
              </div>
            </li>

            <li class="campus-info-item">
              <div class="campus-item-icon" aria-hidden="true">
                <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                  <circle cx="12" cy="12" r="10"/>
                  <polyline points="12 6 12 12 16 14"/>
                </svg>
              </div>
              <div class="campus-item-text">
                <span class="campus-item-label">Hours</span>
                <span class="campus-item-val">Mon–Sat &middot; 8:30 AM – 6:00 PM</span>
              </div>
            </li>
          </ul>
        </div>

      </div>

      <!-- Bottom Legal Bar -->
      <div class="footer-bottom-bar">
        <p>&copy; 2026 OneSkills.pk. All Rights Reserved.</p>
        <div class="footer-legal-links">
          <a href="privacy-policy.html">Privacy Policy</a>
          <span class="legal-divider" aria-hidden="true">|</span>
          <a href="terms-of-service.html">Terms of Service</a>
          <span class="legal-divider" aria-hidden="true">|</span>

          <a href="#home" class="footer-back-to-top" id="footer-back-to-top" aria-label="Back to top">
            <span class="back-to-top-icon" aria-hidden="true">
              <svg viewBox="0 0 24 24" width="13" height="13" fill="none" stroke="currentColor" stroke-width="2.5" stroke-linecap="round" stroke-linejoin="round">
                <line x1="12" y1="19" x2="12" y2="5"/>
                <polyline points="5 12 12 5 19 12"/>
              </svg>
            </span>
            <span>Back to top</span>
          </a>
        </div>
      </div>

      <!-- Panoramic Hiran Minar Editorial Visual -->
      <div class="footer-hiran-wrap">
        <img
          src="assets/images/sections/Golden-Hour Reflections at Hiran Minar.webp"
          alt="Scenic golden-hour reflections at Hiran Minar in Sheikhupura"
          class="footer-hiran-img"
          loading="lazy"
          decoding="async"
          width="1920"
          height="540"
        />
        <div class="footer-hiran-fade" aria-hidden="true"></div>
        <div class="footer-hiran-badge" aria-label="Sheikhupura — Our Home">
          <span class="hiran-badge-city">Sheikhupura</span>
          <span class="hiran-badge-home">
            <span>OUR HOME</span>
            <span class="hiran-badge-line" aria-hidden="true"></span>
          </span>
        </div>
      </div>

    </div>
  </footer>
'@

# Helper to replace footer
function Replace-Footer($filePath, $newFooterHtml) {
    if (-not (Test-Path $filePath)) {
        Write-Warning "File not found: $filePath"
        return
    }
    $raw = [System.IO.File]::ReadAllText($filePath, [System.Text.Encoding]::UTF8)
    if ($raw -match '(?s)<footer\b[^>]*>.*?</footer>') {
        $replaced = [regex]::Replace($raw, '(?s)<footer\b[^>]*>.*?</footer>', [System.Text.RegularExpressions.MatchEvaluator]{ return $newFooterHtml })
        [System.IO.File]::WriteAllText($filePath, $replaced, [System.Text.Encoding]::UTF8)
        Write-Output "Successfully injected canonical footer into: $filePath"
    } else {
        Write-Error "Could not find <footer> in $filePath"
    }
}

# 1. Inject into 9 course pages
$coursePages = @(
    "courses/freelancing-mastery.html",
    "courses/ai-web-development.html",
    "courses/ai-tools-automation.html",
    "courses/crypto-trading.html",
    "courses/forex-trading.html",
    "courses/web3-blockchain.html",
    "courses/ai-based-computer-course.html",
    "courses/programming-js-cpp.html",
    "courses/shopify-ecommerce.html"
)

foreach ($cp in $coursePages) {
    Replace-Footer $cp $footerCourses
}

# 2. Inject into courses/index.html (Catalog Hub)
Replace-Footer "courses/index.html" $footerCatalog

# 3. Inject into privacy-policy.html & terms-of-service.html
Replace-Footer "privacy-policy.html" $footerRoot
Replace-Footer "terms-of-service.html" $footerRoot

# 4. Inject into index.html (update Career Tracks in footer)
Replace-Footer "index.html" $footerRoot

# 5. Handle about.html: add footer.css and inject footer
$aboutFile = "about.html"
$aboutRaw = [System.IO.File]::ReadAllText($aboutFile, [System.Text.Encoding]::UTF8)
if ($aboutRaw -notmatch 'assets/css/footer\.css') {
    $linkCss = "  <link rel=""stylesheet"" href=""assets/css/footer.css"">"
    $aboutRaw = $aboutRaw.Replace('<link rel="stylesheet" href="assets/css/notion-theme.css">', "<link rel=""stylesheet"" href=""assets/css/notion-theme.css"">`n$linkCss")
}
# Replace footer
$aboutFooterRoot = $footerRoot -replace 'href="#home"', 'href="#top"'
$aboutRaw = [regex]::Replace($aboutRaw, '(?s)<footer\b[^>]*>.*?</footer>', [System.Text.RegularExpressions.MatchEvaluator]{ return $aboutFooterRoot })
[System.IO.File]::WriteAllText($aboutFile, $aboutRaw, [System.Text.Encoding]::UTF8)
Write-Output "Successfully updated about.html"

# 6. Handle 404.html: add footer.css and inject footer
$file404 = "404.html"
$raw404 = [System.IO.File]::ReadAllText($file404, [System.Text.Encoding]::UTF8)
if ($raw404 -notmatch 'assets/css/footer\.css') {
    $linkCss = "  <link rel=""stylesheet"" href=""assets/css/footer.css"">"
    $raw404 = $raw404.Replace('<link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">', "<link href=""https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap"" rel=""stylesheet"">`n$linkCss")
}
$footer404 = $footerRoot -replace 'href="#home"', 'href="#top"'
$raw404 = [regex]::Replace($raw404, '(?s)<footer\b[^>]*>.*?</footer>', [System.Text.RegularExpressions.MatchEvaluator]{ return $footer404 })
[System.IO.File]::WriteAllText($file404, $raw404, [System.Text.Encoding]::UTF8)
Write-Output "Successfully updated 404.html"
