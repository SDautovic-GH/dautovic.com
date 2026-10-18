/**
 * Cloudflare Pages Function: Dynamic OpenGraph & Meta Tag Injector for /post
 * Runs on Cloudflare Edge via HTMLRewriter
 */

function escapeHtml(str) {
  if (!str) return "";
  return str
    .replace(/&/g, "&amp;")
    .replace(/</g, "&lt;")
    .replace(/>/g, "&gt;")
    .replace(/"/g, "&quot;")
    .replace(/'/g, "&#039;");
}

export async function onRequest(context) {
  const { request, env } = context;
  const url = new URL(request.url);
  const slug = url.searchParams.get("slug");

  // Let Cloudflare serve the static response
  const response = await context.next();

  if (!slug) {
    return response;
  }

  try {
    let post = null;

    // 1. Try D1 database if bound
    if (env.DB) {
      try {
        post = await env.DB.prepare(
          "SELECT title, excerpt, category, published_at FROM posts WHERE slug = ?"
        ).bind(slug).first();
      } catch (e) {}
    }

    // 2. Fall back to static /data/posts.json
    if (!post) {
      try {
        const postsRes = await fetch(new URL("/data/posts.json", request.url));
        if (postsRes.ok) {
          const posts = await postsRes.json();
          post = posts.find(p => p.slug === slug);
        }
      } catch (e) {}
    }

    if (!post) {
      return response;
    }

    const title = `${post.title} — Dautovic`;
    const description = post.excerpt || "Notes on technology, leadership, and digital media from Boston and beyond.";
    const canonicalUrl = url.href;
    const imageUrl = new URL("/assets/img/hero.jpg", request.url).href;

    // Native zero-allocation streaming HTMLRewriter on Cloudflare Edge
    return new HTMLRewriter()
      .on("title", {
        element(e) {
          e.setInnerContent(title);
        }
      })
      .on("head", {
        element(e) {
          e.append(`
  <meta name="description" content="${escapeHtml(description)}">
  <meta property="og:site_name" content="Dautovic">
  <meta property="og:title" content="${escapeHtml(title)}">
  <meta property="og:description" content="${escapeHtml(description)}">
  <meta property="og:type" content="article">
  <meta property="og:url" content="${escapeHtml(canonicalUrl)}">
  <meta property="og:image" content="${escapeHtml(imageUrl)}">
  <meta name="twitter:card" content="summary_large_image">
  <meta name="twitter:title" content="${escapeHtml(title)}">
  <meta name="twitter:description" content="${escapeHtml(description)}">
  <meta name="twitter:image" content="${escapeHtml(imageUrl)}">
`, { html: true });
        }
      })
      .transform(response);

  } catch (err) {
    return response;
  }
}
