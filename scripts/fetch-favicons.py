#!/usr/bin/env python3
"""
scripts/fetch-favicons.py
Automated Favicon Manager for dautovic.com/links.html
Inspects all link cards in public/links.html. If any local icon is missing,
it automatically fetches the high-res favicon and saves it as an optimized PNG.
"""

import os
import re
import urllib.request
from urllib.parse import urlparse
from PIL import Image
import io

BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
LINKS_HTML = os.path.join(BASE_DIR, 'public', 'links.html')
FAVICON_DIR = os.path.join(BASE_DIR, 'public', 'assets', 'img', 'favicons')
os.makedirs(FAVICON_DIR, exist_ok=True)

HEADERS = {'User-Agent': 'Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_7)'}

def fetch_and_save_favicon(domain, target_path):
    sources = [
        f'https://icons.duckduckgo.com/ip3/{domain}.ico',
        f'https://www.google.com/s2/favicons?domain={domain}&sz=64'
    ]
    for src in sources:
        try:
            req = urllib.request.Request(src, headers=HEADERS)
            data = urllib.request.urlopen(req, timeout=5).read()
            if len(data) > 100:
                im = Image.open(io.BytesIO(data))
                im = im.convert('RGBA')
                im.save(target_path, 'PNG')
                print(f"  ✓ Saved {os.path.basename(target_path)} from {src} ({im.size})")
                return True
        except Exception:
            continue
    return False

def sync_all():
    print("Checking links.html for missing favicons...")
    with open(LINKS_HTML, 'r') as f:
        html = f.read()

    pattern = r'<a href=\"([^\"]+)\"[^>]*data-title=\"([^\"]+)\">\s*<div class=\"link-icon\"><img src=\"([^\"]+)\"'
    matches = re.findall(pattern, html)
    print(f"Found {len(matches)} links.")

    missing_count = 0
    for href, title, src in matches:
        if src.startswith('/assets/img/favicons/'):
            local_file = os.path.join(BASE_DIR, 'public', src.lstrip('/'))
            if not os.path.exists(local_file):
                domain = urlparse(href).hostname.replace('www.', '')
                print(f"Missing icon for '{title}' ({domain}) -> {src}")
                if fetch_and_save_favicon(domain, local_file):
                    missing_count += 1
                else:
                    print(f"  ✗ Failed to fetch icon for {domain}")

    if missing_count == 0:
        print("All favicons are fully synchronized and present locally.")
    else:
        print(f"Successfully fetched and saved {missing_count} missing favicons.")

if __name__ == '__main__':
    sync_all()
