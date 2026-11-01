# OneSkills Academy — URL Migration Map
**Date updated:** August 16, 2026  
**Purpose:** Comprehensive 301 redirect map from live WordPress URLs to the new clean static architecture.

---

## Master 301 Redirect Map

| Currently Indexed Live WordPress URL (Source) | New Static Destination | Status |
|---|---|---|
| `https://oneskills.pk/` | `https://oneskills.pk/` (Served by `index.html`) | Same — no redirect needed |
| `https://oneskills.pk/about/` | `https://oneskills.pk/about.html` | **301 required** |
| `https://oneskills.pk/courses/freelancing-digital-marketing-mastery/` | `https://oneskills.pk/courses/freelancing-mastery.html` | **301 required** |
| `https://oneskills.pk/courses/forex-trading-mastery/` | `https://oneskills.pk/courses/forex-trading.html` | **301 required** |
| `https://oneskills.pk/courses/ai-tools-automation/` | `https://oneskills.pk/courses/ai-tools-automation.html` | **301 required** |
| `https://oneskills.pk/courses/ai-powered-web-development/` | `https://oneskills.pk/courses/ai-web-development.html` | **301 required** |
| `https://oneskills.pk/courses/crypto-trading-training/` | `https://oneskills.pk/courses/crypto-trading.html` | **301 required** |
| `https://oneskills.pk/courses/web3-blockchain-mastery/` | `https://oneskills.pk/courses/web3-blockchain.html` | **301 required** |
| `https://oneskills.pk/courses/ai-based-computer-course-sheikhupura/` | `https://oneskills.pk/courses/ai-based-computer-course.html` | **301 required** |
| `https://oneskills.pk/courses/` | `https://oneskills.pk/#courses` | **301 recommended** |

---

## Server Implementation Rules

### Option A — Apache `.htaccess` (Standard cPanel / LiteSpeed / Apache)

Add to the root `.htaccess` file **above** WordPress rewrite rules:

```apache
# OneSkills URL Migration — 301 Redirects
RewriteEngine On

Redirect 301 /courses/freelancing-digital-marketing-mastery/ /courses/freelancing-mastery.html
Redirect 301 /courses/forex-trading-mastery/ /courses/forex-trading.html
Redirect 301 /courses/ai-tools-automation/ /courses/ai-tools-automation.html
Redirect 301 /courses/ai-powered-web-development/ /courses/ai-web-development.html
Redirect 301 /courses/crypto-trading-training/ /courses/crypto-trading.html
Redirect 301 /courses/web3-blockchain-mastery/ /courses/web3-blockchain.html
Redirect 301 /courses/ai-based-computer-course-sheikhupura/ /courses/ai-based-computer-course.html
Redirect 301 /courses/ /#courses
Redirect 301 /about/ /about.html
```

### Option B — Nginx Configuration

```nginx
# OneSkills URL Migration
location = /courses/freelancing-digital-marketing-mastery/ {
    return 301 /courses/freelancing-mastery.html;
}
location = /courses/forex-trading-mastery/ {
    return 301 /courses/forex-trading.html;
}
location = /courses/ai-tools-automation/ {
    return 301 /courses/ai-tools-automation.html;
}
location = /courses/ai-powered-web-development/ {
    return 301 /courses/ai-web-development.html;
}
location = /courses/crypto-trading-training/ {
    return 301 /courses/crypto-trading.html;
}
location = /courses/web3-blockchain-mastery/ {
    return 301 /courses/web3-blockchain.html;
}
location = /courses/ai-based-computer-course-sheikhupura/ {
    return 301 /courses/ai-based-computer-course.html;
}
location = /courses/ {
    return 301 /#courses;
}
location = /about/ {
    return 301 /about.html;
}
```

### Option C — Cloudflare Bulk Redirects (Zero Server Overhead)
Create a Redirect Rule in Cloudflare Dashboard:
- Matching incoming paths above -> 301 Permanent Redirect to destination HTML URLs.
