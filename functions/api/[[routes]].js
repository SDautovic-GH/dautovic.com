/**
 * Cloudflare Pages Function - D1 Edge API for dautovic.com
 */

export async function onRequest(context) {
  const { request, env } = context;
  const url = new URL(request.url);
  const pathParts = url.pathname.replace('/api/', '').split('/').filter(Boolean);
  const resource = pathParts[0]; // e.g. "posts"
  const param = pathParts[1];    // e.g. slug

  // Helper for CORS & JSON response
  function jsonResponse(data, status = 200) {
    return new Response(JSON.stringify(data), {
      status,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'GET, POST, DELETE, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type, Authorization'
      }
    });
  }

  if (request.method === 'OPTIONS') {
    return jsonResponse({ ok: true });
  }

  // Check if DB is bound
  const db = env.DB;
  if (!db) {
    return jsonResponse({ error: 'Database binding (DB) not configured.' }, 500);
  }

  try {
        if (resource === 'contact') {
      if (request.method === 'POST') {
        const body = await request.json().catch(() => ({}));
        const { name, email, subject, message, company } = body;

        // Anti-spam honeypot
        if (company) {
          return jsonResponse({ success: true, message: 'Message sent.' });
        }

        if (!name || !email || !message) {
          return jsonResponse({ error: 'Name, email, and message are required.' }, 400);
        }

        const ip = request.headers.get('cf-connecting-ip') || '';

        // If D1 is bound, create table if needed and record message
        if (db) {
          try {
            await db.prepare().run();

            await db.prepare().bind(name, email, subject || 'General', message, ip).run();
          } catch (dbErr) {
            console.error('D1 contact store error:', dbErr);
          }
        }

        return jsonResponse({ success: true, message: 'Thank you! Your message has been received.' });
      }
    }

    if (resource === 'posts') {
      // GET /api/posts
      if (request.method === 'GET' && !param) {
        const { results } = await db.prepare(
          "SELECT id, title, slug, excerpt, category, tags, read_time as readTime, status, published_at as date FROM posts ORDER BY published_at DESC"
        ).all();

        const formatted = results.map(r => ({
          ...r,
          categories: [r.category || 'General'],
          tags: JSON.parse(r.tags || '[]')
        }));

        return jsonResponse(formatted);
      }

      // GET /api/posts/:slug
      if (request.method === 'GET' && param) {
        const post = await db.prepare(
          "SELECT id, title, slug, excerpt, content, category, tags, read_time as readTime, status, published_at as date FROM posts WHERE slug = ?"
        ).bind(param).first();

        if (!post) {
          return jsonResponse({ error: 'Post not found' }, 404);
        }

        post.categories = [post.category || 'General'];
        post.tags = JSON.parse(post.tags || '[]');
        return jsonResponse(post);
      }

      // POST /api/posts (Create or Update)
      if (request.method === 'POST') {
        const body = await request.json();
        const { title, slug, excerpt, content, categories, tags, readTime, status, date } = body;

        const category = categories && categories[0] ? categories[0] : 'General';
        const tagsJson = JSON.stringify(tags || []);
        const pubDate = date || new Date().toISOString().replace('T', ' ').substring(0, 19);

        // Upsert into D1
        await db.prepare(`
          INSERT INTO posts (title, slug, excerpt, content, category, tags, read_time, status, published_at, updated_at)
          VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, CURRENT_TIMESTAMP)
          ON CONFLICT(slug) DO UPDATE SET
            title = excluded.title,
            excerpt = excluded.excerpt,
            content = excluded.content,
            category = excluded.category,
            tags = excluded.tags,
            read_time = excluded.read_time,
            status = excluded.status,
            published_at = excluded.published_at,
            updated_at = CURRENT_TIMESTAMP
        `).bind(title, slug, excerpt, content, category, tagsJson, readTime, status || 'published', pubDate).run();

        return jsonResponse({ success: true, slug });
      }

      // DELETE /api/posts/:slug
      if (request.method === 'DELETE' && param) {
        await db.prepare("DELETE FROM posts WHERE slug = ?").bind(param).run();
        return jsonResponse({ success: true, deleted: param });
      }
    }

    return jsonResponse({ error: 'Not found' }, 404);
  } catch (err) {
    return jsonResponse({ error: err.message }, 500);
  }
}
