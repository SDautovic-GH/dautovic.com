# dautovic.com — PRD & Technical Reference

| Field | Value |
| :--- | :--- |
| **Document Type** | Product Requirements Document (PRD) & Technical Spec |
| **App Name** | dautovic.com |
| **App Version** | 1.0.0 |
| **PRD Revision** | v1.0 |
| **Date** | 2026-10-18 |
| **Author** | Samir Dautovic |
| **Status** | Deployed & Active |
| **Summary** | High-performance personal publishing platform, historical archive (2005–2023), minimalist CMS writing desk, and custom RSS Reader companion (`today.dautovic.com`) migrated from WordPress.com and GitHub Pages to Cloudflare Workers and Edge infrastructure. |

---

## 1. Objective & Non-Goals

- **Primary Objective:** Deliver a fast, private, distraction-free personal publication platform and RSS ecosystem free from WordPress.com hosting overhead, plugin lock-in, and slow third-party SSL pipelines. Guarantee 100% data ownership of all 63 historical articles (2005–2023) and 8 static pages, sub-second global edge delivery via Cloudflare Workers, and seamless multi-device cloud synchronization on `today.dautovic.com`.
- **Audience:** Public web visitors, tech readers, and Samir Dautovic across macOS Safari, iOS mobile devices, and Windows workstations.
- **Non-Goals:** 
  - No monolithic database dependencies or complex headless CMS frameworks (Ghost, WordPress, Strapi).
  - No client-side heavy JavaScript frameworks (React, Next.js, Vue) for public content; pure vanilla HTML, modern CSS variables, and clean vanilla JS.
  - No third-party ad networks, telemetry trackers, or non-essential cookies.

---

## 2. Active Decisions & Technical Rationale

| Date | Decision | Reason & Trade-offs | Status |
| :--- | :--- | :--- | :--- |
| 2026-10-18 | Migration from WordPress.com to Cloudflare Workers | Eliminates recurring WordPress hosting fees, eliminates slow server execution, and unlocks sub-50ms global TTFB via Cloudflare Edge. | Locked |
| 2026-10-18 | Migration of `today.dautovic.com` from GitHub Pages to Cloudflare | Bypasses GitHub Pages Let's Encrypt automated CAA/Dnsruby NXDomain delays and negative DNS caching; provides instant edge SSL certificate issuance. | Locked |
| 2026-10-18 | Cloudflare Worker Static Assets (`[assets] directory = "./public"`) | Zero build step complexity; edge servers directly cache and serve static assets while supporting edge routing. | Locked |
| 2026-10-18 | Minimalist CMS Desk at `/admin` with Passcode Gate | Lightweight distraction-free editor with live preview, auto-slug generation, and local JSON/D1 drafting without external CMS accounts. | Locked |
| 2026-10-18 | Strict Origin Referrer Rule in Google Cloud Console | Modern browsers (Safari, Chrome) send only `https://today.dautovic.com` without a trailing slash under `strict-origin-when-cross-origin`. Adding both bare origin and wildcard paths ensures valid API key handshake. | Locked |
| 2026-10-18 | Editorial CSS Design System with Dark/Light Mode | Clean typography-first layout with curated squircle logo frame, responsive side-by-side author portrait, and dynamic theme-color meta synchronization for iOS Safari. | Locked |

---

## 3. Mistakes, Pitfalls & Guardrails (DO NOT REPEAT)

- ⚠️ **GitHub Pages Subdomain SSL Hangs (Dnsruby NXDomain):** Never host critical subdomains (like `today.dautovic.com`) on GitHub Pages when the apex domain uses Cloudflare DNS proxying. GitHub Pages' automated Let's Encrypt certificate worker repeatedly queries authoritative DNS and fails with `InvalidDNSError` or negative CAA cache for hours. Always host directly on Cloudflare.
- ⚠️ **Cloudflare Worker Route Wildcards Hijacking Subdomains:** When attaching a custom domain in Cloudflare Workers, never select "Production and Preview". Doing so creates a wildcard route (`*.dautovic.com/*`) that intercepts traffic intended for subdomains like `today.dautovic.com`. Always select **"Production only"** (`dautovic.com`).
- ⚠️ **Worker Route Required for `www`:** A DNS CNAME from `www.dautovic.com` to `dautovic.com` is NOT enough for Cloudflare Workers. Cloudflare Edge requires an explicit Worker Route for `www.dautovic.com/*`, otherwise requests fail with **HTTP 522 Connection Timed Out**.
- ⚠️ **Google Cloud API Key Strict-Origin Blocking:** In Google Cloud Console (APIs & Services > Credentials), specifying only `https://today.dautovic.com/*` will **fail** on modern browsers. Under the default browser `Referrer-Policy: strict-origin-when-cross-origin`, the browser sends `https://today.dautovic.com` (no trailing slash). Always register both `https://today.dautovic.com` AND `https://today.dautovic.com/*`.
- ⚠️ **Mobile Horizontal Scroll & Link Wrapping:** Never allow un-wrapping inline flex rows in footers or navigation on mobile viewports. Eight links on one row forced mobile Safari to render a 520px body width, creating horizontal page sliding. Always apply `flex-wrap: wrap;` and lock root viewports with `overflow-x: hidden;`.
- ⚠️ **Fake Transparency in Logo Files:** Never export or save raster assets with baked-in Photoshop transparency checkerboards. Clean vector or solid-bounded PNG/JPG exports with CSS border-radius and box-shadow ensure crisp presentation across light and dark modes.

---

## 4. Application Architecture & Tech Stack

| Component | Technology | Notes |
| :--- | :--- | :--- |
| **Edge Hosting** | Cloudflare Workers & Pages | Edge network deployment under Cloudflare Account `sdfyix` |
| **Edge Worker Project** | `dautovic-com` | Manages `https://dautovic.com` and `https://www.dautovic.com/*` |
| **RSS Reader Project** | `rssreader` | Manages `https://today.dautovic.com` (PWA application) |
| **DNS & SSL** | Cloudflare Managed DNS | Google Trust Services SSL certificates (`dautovic.com`, `*.dautovic.com`) |
| **Frontend Core** | Pure HTML5 & Vanilla JavaScript | Zero third-party runtime frameworks; zero bundle overhead |
| **Styling & Theming** | Vanilla CSS3 (Custom Properties) | System dark/light theme detection, manual toggle, iOS theme-color sync |
| **Historical Data** | JSON & SQLite (Cloudflare D1) | `posts.json` (63 articles, 2005–2023) and `pages.json` (8 static pages) |
| **Authentication (PWA)** | Google Firebase Authentication | Project `rss-reader-fyi` with Email/Password provider |
| **Cloud Database (PWA)** | Google Cloud Firestore | Cross-device feed state and read/saved tracking |
| **Search Engine** | Client-Side Inverted Index | Instant real-time article and tag search in `app.js` |
| **Content Ingestion** | Python 3 (`scripts/extract-wp.py`)| Custom parser extracting stories from WordPress XML exports |

---

## 5. Domain & DNS Configuration Specification

| Domain / Subdomain | Target / Service | Cloudflare Proxy | SSL Certificate |
| :--- | :--- | :--- | :--- |
| **`dautovic.com`** | Worker `dautovic-com` (Custom Domain) | Proxied (Orange Cloud) | Google Trust Services (Active) |
| **`www.dautovic.com`** | Worker Route `www.dautovic.com/*` → `dautovic-com` | Proxied (Orange Cloud) | Google Trust Services (Active) |
| **`today.dautovic.com`** | Worker `rssreader` (Custom Domain) | Proxied (Orange Cloud) | Google Trust Services (Active) |

---

## 6. Firebase & Google Cloud Security Configuration

To ensure cross-device synchronization operates without permission denials:

1. **Firebase Console (`rss-reader-fyi`):**
   - **Authentication → Authorized Domains:**
     - `dautovic.com`
     - `today.dautovic.com`
     - `sdautovic-gh.github.io`
     - `localhost`
   - **Authentication → Sign-in Method:**
     - `Email/Password` (Enabled)
2. **Google Cloud Console (`rss-reader-fyi` / `110083336585`):**
   - **APIs & Services → Credentials → Browser Key:**
     - `https://today.dautovic.com`
     - `https://today.dautovic.com/*`
     - `https://dautovic.com`
     - `https://*.dautovic.com/*`
     - `https://sdautovic-gh.github.io`
     - `https://sdautovic-gh.github.io/*`

---

## 7. What's New by Version

### Version 1.0.0 (Initial Production Release — 2026-10-18)
- Complete WordPress.com migration to Cloudflare Workers.
- Extracted and restored 63 historical articles and 8 pages from WordPress XML archive.
- Created distraction-free CMS Writing Desk at `/admin`.
- Migrated `today.dautovic.com` PWA to Cloudflare hosting with automated edge SSL.
- Resolved Google Cloud API Key `strict-origin` referrer restrictions.
- Responsive mobile UX polish: fixed horizontal overflow, wrapped footer navigation, matched iOS Safari dynamic theme bars.
- Restored author portrait on About page and eliminated checkerboard logo artifacting.

---

*dautovic.com • PRD • v1.0 • 2026-10-18 • Samir Dautovic*
