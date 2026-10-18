# Tasks: dautovic.com & today.dautovic.com

| Field | Value |
| :--- | :--- |
| **Document Type** | Task Registry & Operational Roadmap |
| **App Name** | dautovic.com (Main Site & RSS Reader Ecosystem) |
| **Current Version** | 1.0.0 |
| **Status** | Active & Deployed |
| **Last Updated** | 2026-10-18 |

---

## 1. Immediate Next Steps / Active Sprint

- [ ] **Content Review & Verification:** Spot-check older posts (2005–2010) in the archive (`/archive.html`) to ensure all legacy image embeds and formatting display cleanly.
- [ ] **CMS Writing Workflow Test:** Publish a new story draft via the CMS Desk (`/admin`) and verify automatic publication to `posts.json` / D1 and RSS feed (`/feed.xml`).
- [ ] **Automated Backup Routine:** Establish a scheduled GitHub Action or local script to back up SQLite D1 database and feed exports weekly.

---

## 2. Blocked / Open Questions

- *(None currently blocking — all primary systems, domains, SSL, and authentication fully operational)*

---

## 3. Completed Milestones

- [x] **Mobile Post Metadata & Editorial Card Polish:**
  - Resolved awkward 2-line metadata wrapping on mobile screens across all post cards. Split post metadata into a focused single-line top row (`Category • Date`) with `white-space: nowrap; overflow: hidden; text-overflow: ellipsis;` and relocated reading time (`2 min read`) to the card footer next to `Read story →`.
  - Streamlined article header on `/post.html` with `.article-pre-meta` and grouped author/date in `.article-meta-info` with a compact short-month date format, keeping author, date, and share button on a crisp single line across mobile viewports.
  - Ensured centered alignment for the "Featured Writing" pill badge and header text on mobile. *(Completed: 2026-10-18)*
- [x] **Dynamic OpenGraph Edge Cards & Pill Badge Centering:**
  - Built Cloudflare Edge Functions (`functions/post.js` & `functions/page.js`) with native `HTMLRewriter` to inject custom story title, excerpt, and thumbnail into OpenGraph and Twitter card meta tags on link sharing (iMessage, WhatsApp, Slack, Twitter/X).
  - Centered the pill-shaped "Featured Writing" badge and subtext on mobile viewports for balanced presentation.
  - Added full static OpenGraph tags to `index.html`, `archive.html`, and `links.html`. *(Completed: 2026-10-18)*
- [x] **Editorial Design & Typography Overhaul:** Shipped high-end publishing experience across the site:
  - Loaded *Newsreader* variable editorial serif for literary long-form reading.
  - Added ambient scroll progress bar on `post.html` via native CSS scroll-timeline with JS fallback.
  - Designed asymmetrical "Featured Writing" hero grid for cornerstone essays.
  - Built end-of-article Next/Previous story continuity navigation cards.
  - Added power-user keyboard shortcuts (`/` and `Cmd+K` to search, `Esc` to clear).
  - Added decade timeline quick-jump navigation on `archive.html` (`2020s`, `2010s`, `2000s`).
  - Upgraded share button with non-blocking toast notification.
  - Refined story cards with spring Bézier lift and ambient dark-mode glow. *(Completed: 2026-10-18)*
- [x] **Mobile Navigation & About Link Restoration:** Removed obsolete `hide-mobile` CSS class from the About nav item and added `About` consistently across all public page headers (`index`, `archive`, `links`, `page`, `post`), ensuring full visibility across iOS Safari and mobile viewports. *(Completed: 2026-10-18)*
- [x] **Navigation Privacy & Shortcuts:** Removed public "Today" header pill and footer link across all visitor pages (`index`, `archive`, `links`, `page`, `post`) to keep private RSS Reader hidden from public web visitors. Added quick-launcher shortcuts ("RSS Reader ↗") directly inside the private `/admin` Writing Desk header and dashboard. *(Completed: 2026-10-18)*
- [x] **Domain Registrar Transfer to Cloudflare:** Successfully transferred `dautovic.com` from Automattic (WordPress.com) to Cloudflare Registrar. Expiration extended by 1 full year to 2027-12-17 with at-cost wholesale renewal pricing and unified DNS/hosting management. *(Completed: 2026-10-18)*
- [x] **Legacy WordPress Site Decommissioning:** Downloaded full archival snapshot and set legacy WordPress.com site visibility to Private (under Settings → Reading), locking the name permanently on WordPress free tier without recurring fees. *(Completed: 2026-10-18)*
- [x] **Cross-Platform Git Synchronization Scripts:** Built and tested `SyncGit-macOS-dautovic.com.ps1` (for macOS) and `SyncGit-dautovic.com.ps1` (for Windows workstations with OneDrive mirror sync), establishing commit-first automated push/pull workflows with repo size analytics. *(Completed: 2026-10-18)*
- [x] **Firebase API Key Referrer Fix:** Diagnosed 403 `API_KEY_HTTP_REFERRER_BLOCKED` failure on `today.dautovic.com`. Identified that modern browsers (Safari/Chrome) enforce `strict-origin-when-cross-origin`, transmitting `https://today.dautovic.com` without a trailing slash. Added bare origin `https://today.dautovic.com` and `https://dautovic.com` to Google Cloud Console website restrictions, enabling successful multi-device authentication and cloud feed sync. *(Completed: 2026-10-18)*
- [x] **Firebase Authorized Domains Registration:** Added `dautovic.com` and `today.dautovic.com` to Firebase Authentication Authorized Domains in project `rss-reader-fyi`. *(Completed: 2026-10-18)*
- [x] **RSS Reader Migration to Cloudflare (`today.dautovic.com`):** Unlinked GitHub Pages custom domain to eliminate Let's Encrypt CAA negative DNS caching and `Dnsruby::NXDomain` loops. Deployed static PWA to Cloudflare Worker `rssreader` and attached custom domain `today.dautovic.com` with instant Google Trust Services wildcard SSL (`HTTP/2 200 OK`). *(Completed: 2026-10-18)*
- [x] **Cloudflare Subdomain Route Isolation:** Reconfigured `dautovic-com` Worker custom domain from "Production and Preview" (which created a wildcard `*.dautovic.com/*` route that intercepted subdomains) to "Production only", restoring proper routing to `today.dautovic.com`. *(Completed: 2026-10-18)*
- [x] **Apex & WWW Worker Routing:** Configured Cloudflare Worker Route for `www.dautovic.com/*` mapped to `dautovic-com` Worker, eliminating Error 522 timeouts on `www`. *(Completed: 2026-10-18)*
- [x] **Mobile Responsive Design Polish:** Fixed horizontal page scrolling on iOS Safari by adding `overflow-x: hidden;` on root elements and wrapping the 8-item footer link row. Matched dynamic `<meta name="theme-color">` to background surface color to eliminate white overscroll space on iOS. *(Completed: 2026-10-18)*
- [x] **Brand & Media Asset Restoration:** Extracted author portrait from WordPress archive and styled About page layout with responsive text wrap. Cleaned logo asset by removing baked Photoshop checkerboard transparency artifacts and implementing a refined squircle border with dark-mode glow. *(Completed: 2026-10-18)*
- [x] **Curated Links & Resources Directory:** Built and deployed searchable Links page (`/links.html`) integrated into top navigation pill. *(Completed: 2026-10-18)*
- [x] **WordPress.com Archive Extraction:** Ingested all 63 published articles (2005–2023) and 8 static pages from XML export into clean, lightweight JSON and Cloudflare D1 schema. *(Completed: 2026-10-18)*
- [x] **Initial Cloudflare Deployment:** Deployed static publishing architecture, client-side search engine, and `/admin` CMS Writing Desk to Cloudflare Worker `dautovic-com` and pushed repository to `SDautovic-GH/dautovic.com`. *(Completed: 2026-10-18)*

---

*dautovic.com • Tasks • 2026-10-18 • Samir Dautovic*
