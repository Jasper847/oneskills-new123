$courses = @(
    @{ File = "courses/ai-based-computer-course.html"; Title = "AI Computer & Office Management Course in Sheikhupura | OneSkills"; Desc = "Gain essential computer skills, MS Office (Word, Excel, PowerPoint) and practical office management with AI tools for career growth in Sheikhupura." },
    @{ File = "courses/ai-tools-automation.html"; Title = "AI Tools & Automation Course in Sheikhupura | OneSkills Academy"; Desc = "Master ChatGPT, Midjourney, Make, and workflow automation. 2-month physical training in Sheikhupura with real business workflows and client projects." },
    @{ File = "courses/crypto-trading.html"; Title = "Crypto Trading Course in Sheikhupura (Spot, Futures & Risk Management) | OneSkills"; Desc = "Learn cryptocurrency trading in Sheikhupura: technical analysis, risk management, Binance, TradingView, and practical chart setups with live market coaching." },
    @{ File = "courses/forex-trading.html"; Title = "Forex Trading Course in Sheikhupura (Price Action & Prop Firm Training) | OneSkills"; Desc = "Master professional currency trading, MT5, supply & demand, risk management, and prop firm qualification at OneSkills Academy Sheikhupura." },
    @{ File = "courses/freelancing-mastery.html"; Title = "Freelancing Mastery Course in Sheikhupura (Upwork, Fiverr & Direct Clients) | OneSkills"; Desc = "Complete freelancing training in Sheikhupura: Upwork bidding, Fiverr gig SEO, portfolio building, and international payment setups. Small physical lab batches." },
    @{ File = "courses/programming-js-cpp.html"; Title = "Programming & Coding Course in Sheikhupura (C++ & JavaScript) | OneSkills"; Desc = "Build rock-solid coding fundamentals with C++ and modern JavaScript. Logic building, algorithms, and practical programming lab training in Sheikhupura." },
    @{ File = "courses/shopify-ecommerce.html"; Title = "Shopify & E-Commerce Course in Sheikhupura (Dropshipping & Local Stores) | OneSkills"; Desc = "Master Shopify store design, product hunting, supplier negotiation, Meta & TikTok video ads, and Pakistan COD scaling in Sheikhupura. 2-month physical training." },
    @{ File = "courses/web3-blockchain.html"; Title = "Web3 & Blockchain Course in Sheikhupura (Smart Contracts & Solidity) | OneSkills"; Desc = "Hands-on Web3 developer training in Sheikhupura. Learn Solidity, smart contracts, Ethereum, dApps, and decentralized architecture with expert mentors." },
    @{ File = "about.html"; Title = "About OneSkills Academy Sheikhupura | Digital Skills & IT Training"; Desc = "Learn about OneSkills Academy in Sheikhupura: our mission, mentorship approach, campus facilities on Sargodha Road, and practical digital career programs." }
)

foreach ($c in $courses) {
    if (Test-Path $c.File) {
        $content = [System.IO.File]::ReadAllText($c.File, [System.Text.Encoding]::UTF8)
        if (-not $content.Contains('name="twitter:card"')) {
            $tCard = '  <!-- Twitter Card -->' + "`r`n" +
                     '  <meta name="twitter:card" content="summary_large_image">' + "`r`n" +
                     '  <meta name="twitter:site" content="@oneskillspk">' + "`r`n" +
                     '  <meta name="twitter:title" content="' + $c.Title + '">' + "`r`n" +
                     '  <meta name="twitter:description" content="' + $c.Desc + '">' + "`r`n" +
                     '  <meta name="twitter:image" content="https://oneskills.pk/assets/images/brand/og-cover.webp">' + "`r`n"
            
            if ($content.Contains('property="og:image"')) {
                $ogImgLine = [regex]::Match($content, '<meta property="og:image"[^>]*>').Value
                $content = $content.Replace($ogImgLine, $ogImgLine + "`r`n" + $tCard)
                [System.IO.File]::WriteAllText($c.File, $content, [System.Text.Encoding]::UTF8)
                Write-Host "Added Twitter Cards to $($c.File)"
            }
        } else {
            Write-Host "Twitter Cards already present in $($c.File)"
        }
    }
}
