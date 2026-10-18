/**
 * Cloudflare Pages Function: Dynamic OpenGraph & Meta Tag Injector for /page
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
  const { request } = context;
  const url = new URL(request.url);
  const slug = url.searchParams.get("slug");

  const response = await context.next();

  if (!slug) {
    return response;
  }

  try {
    let title = "Page — Dautovic";
    let description = "Personal thoughts, technology trends, and discoveries by Samir Dautovic.";
    let imageUrl = new URL("/assets/img/hero.jpg", request.url).href;

    if (slug === "about") {
      title = "About — Samir Dautovic";
      description = "About Samir Dautovic: technology leader, systems architect, and writer based in Boston.";
      imageUrl = new URL("/assets/img/me.png", request.url).href;
    }

    const canonicalUrl = url.href;

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
  <meta property="og:type" content="website">
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
