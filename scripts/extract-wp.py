#!/usr/bin/env python3
import xml.etree.ElementTree as ET
import json
import re
import html
from datetime import datetime

XML_PATH = "/Users/samirdautovic/Downloads/dautovic.WordPress.2026-10-18.xml"
POSTS_OUT = "/Users/samirdautovic/Developer/dautovic.com/public/data/posts.json"
PAGES_OUT = "/Users/samirdautovic/Developer/dautovic.com/public/data/pages.json"
FEED_OUT = "/Users/samirdautovic/Developer/dautovic.com/public/feed.xml"
SQL_OUT = "/Users/samirdautovic/Developer/dautovic.com/schema.sql"

def clean_content(raw_html):
    if not raw_html:
        return ""
    cleaned = re.sub(r'<!--\s*/?wp:[^>]*-->', '', raw_html)
    cleaned = cleaned.strip()
    return cleaned

def make_excerpt(content_html, max_len=180):
    text = re.sub(r'<[^>]+>', ' ', content_html)
    text = html.unescape(text)
    text = re.sub(r'\s+', ' ', text).strip()
    if len(text) <= max_len:
        return text
    return text[:max_len].rsplit(' ', 1)[0] + '…'

def calc_read_time(content_html):
    text = re.sub(r'<[^>]+>', ' ', content_html)
    words = len(re.findall(r'\w+', text))
    mins = max(1, round(words / 200))
    return f"{mins} min read"

def parse_wp_xml():
    print(f"Reading XML from: {XML_PATH}")
    tree = ET.parse(XML_PATH)
    root = tree.getroot()
    channel = root.find('channel')

    ns = {
        'wp': 'http://wordpress.org/export/1.2/',
        'content': 'http://purl.org/rss/1.0/modules/content/',
        'dc': 'http://purl.org/dc/elements/1.1/',
        'excerpt': 'http://wordpress.org/export/1.2/excerpt/'
    }

    posts = []
    pages = []

    for item in channel.findall('item'):
        pt_elem = item.find('wp:post_type', ns)
        st_elem = item.find('wp:status', ns)
        if pt_elem is None or st_elem is None:
            continue
        
        post_type = pt_elem.text
        status = st_elem.text

        if status != 'publish':
            continue

        title_elem = item.find('title')
        title = title_elem.text if title_elem is not None and title_elem.text else 'Untitled'
        
        slug_elem = item.find('wp:post_name', ns)
        slug = slug_elem.text if slug_elem is not None and slug_elem.text else re.sub(r'[^a-z0-9]+', '-', title.lower()).strip('-')

        date_elem = item.find('wp:post_date', ns)
        date_str = date_elem.text if date_elem is not None and date_elem.text else ''

        content_elem = item.find('content:encoded', ns)
        raw_content = content_elem.text if content_elem is not None and content_elem.text else ''
        content = clean_content(raw_content)

        categories = []
        tags = []
        for cat in item.findall('category'):
            domain = cat.attrib.get('domain')
            cat_name = cat.text
            if not cat_name:
                continue
            if domain == 'category':
                categories.append(cat_name)
            elif domain == 'post_tag':
                tags.append(cat_name)

        link_elem = item.find('link')
        original_link = link_elem.text if link_elem is not None and link_elem.text else ''

        post_data = {
            'id': len(posts) + 1 if post_type == 'post' else len(pages) + 1,
            'title': title,
            'slug': slug,
            'date': date_str,
            'categories': categories if categories else ['General'],
            'tags': tags,
            'excerpt': make_excerpt(content),
            'content': content,
            'readTime': calc_read_time(content),
            'link': original_link,
            'status': 'published'
        }

        if post_type == 'post':
            posts.append(post_data)
        elif post_type == 'page':
            pages.append(post_data)

    posts.sort(key=lambda x: x['date'], reverse=True)
    for idx, p in enumerate(posts):
        p['id'] = idx + 1

    print(f"Parsed {len(posts)} posts and {len(pages)} pages.")

    with open(POSTS_OUT, 'w', encoding='utf-8') as f:
        json.dump(posts, f, indent=2, ensure_ascii=False)
    print(f"Saved posts JSON: {POSTS_OUT}")

    with open(PAGES_OUT, 'w', encoding='utf-8') as f:
        json.dump(pages, f, indent=2, ensure_ascii=False)
    print(f"Saved pages JSON: {PAGES_OUT}")

    generate_sql(posts, pages)
    generate_rss(posts)

def generate_sql(posts, pages):
    sql_lines = [
        "-- Cloudflare D1 Schema for dautovic.com",
        "DROP TABLE IF EXISTS posts;",
        "CREATE TABLE posts (",
        "  id INTEGER PRIMARY KEY AUTOINCREMENT,",
        "  title TEXT NOT NULL,",
        "  slug TEXT UNIQUE NOT NULL,",
        "  excerpt TEXT,",
        "  content TEXT NOT NULL,",
        "  category TEXT DEFAULT 'General',",
        "  tags TEXT DEFAULT '[]',",
        "  read_time TEXT,",
        "  status TEXT DEFAULT 'published',",
        "  published_at TEXT NOT NULL,",
        "  created_at DATETIME DEFAULT CURRENT_TIMESTAMP,",
        "  updated_at DATETIME DEFAULT CURRENT_TIMESTAMP",
        ");",
        "",
        "CREATE INDEX idx_posts_slug ON posts(slug);",
        "CREATE INDEX idx_posts_date ON posts(published_at DESC);",
        "CREATE INDEX idx_posts_status ON posts(status);",
        "",
        "-- Seed Historical Posts"
    ]

    for p in posts:
        title = p['title'].replace("'", "''")
        slug = p['slug'].replace("'", "''")
        excerpt = p['excerpt'].replace("'", "''")
        content = p['content'].replace("'", "''")
        cat = (p['categories'][0] if p['categories'] else 'General').replace("'", "''")
        tags_json = json.dumps(p['tags']).replace("'", "''")
        read_time = p['readTime']
        date = p['date']
        
        sql = f"INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at) VALUES ('{title}', '{slug}', '{excerpt}', '{content}', '{cat}', '{tags_json}', '{read_time}', 'published', '{date}');"
        sql_lines.append(sql)

    with open(SQL_OUT, 'w', encoding='utf-8') as f:
        f.write("\n".join(sql_lines))
    print(f"Saved Cloudflare D1 SQL schema: {SQL_OUT}")

def generate_rss(posts):
    items_xml = []
    for p in posts[:25]:
        pub_dt = None
        try:
            pub_dt = datetime.strptime(p['date'], "%Y-%m-%d %H:%M:%S")
            pub_str = pub_dt.strftime("%a, %d %b %Y %H:%M:%S +0000")
        except:
            pub_str = p['date']

        item = f"""    <item>
      <title><![CDATA[{p['title']}]]></title>
      <link>https://dautovic.com/{p['slug']}</link>
      <guid isPermaLink="true">https://dautovic.com/{p['slug']}</guid>
      <pubDate>{pub_str}</pubDate>
      <category><![CDATA[{p['categories'][0] if p['categories'] else 'General'}]]></category>
      <description><![CDATA[{p['excerpt']}]]></description>
      <content:encoded><![CDATA[{p['content']}]]></content:encoded>
    </item>"""
        items_xml.append(item)

    items_joined = "\n".join(items_xml)
    now_str = datetime.utcnow().strftime("%a, %d %b %Y %H:%M:%S +0000")
    rss = f"""<?xml version="1.0" encoding="UTF-8"?>
<rss version="2.0" xmlns:content="http://purl.org/rss/1.0/modules/content/" xmlns:atom="http://www.w3.org/2005/Atom">
  <channel>
    <title>Dautovic</title>
    <link>https://dautovic.com</link>
    <atom:link href="https://dautovic.com/feed.xml" rel="self" type="application/rss+xml" />
    <description>Learn every day.</description>
    <language>en-us</language>
    <lastBuildDate>{now_str}</lastBuildDate>
{items_joined}
  </channel>
</rss>"""

    with open(FEED_OUT, 'w', encoding='utf-8') as f:
        f.write(rss)
    print(f"Saved RSS Feed: {FEED_OUT}")

if __name__ == '__main__':
    parse_wp_xml()
