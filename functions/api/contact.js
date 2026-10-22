export async function onRequestPost(context) {
  const { request, env } = context;

  function jsonResponse(data, status = 200) {
    return new Response(JSON.stringify(data), {
      status,
      headers: {
        'Content-Type': 'application/json',
        'Access-Control-Allow-Origin': '*',
        'Access-Control-Allow-Methods': 'POST, OPTIONS',
        'Access-Control-Allow-Headers': 'Content-Type'
      }
    });
  }

  try {
    const body = await request.json().catch(() => ({}));
    const { name, email, subject, message, company } = body;

    // Honeypot anti-spam check
    if (company) {
      return jsonResponse({ success: true, message: 'Message sent.' });
    }

    if (!name || !email || !message) {
      return jsonResponse({ error: 'Name, email, and message are required.' }, 400);
    }

    const ip = request.headers.get('cf-connecting-ip') || '';

    // If D1 DB is bound, persist message
    if (env.DB) {
      try {
        await env.DB.prepare(`
          CREATE TABLE IF NOT EXISTS contacts (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL,
            subject TEXT,
            message TEXT NOT NULL,
            ip TEXT,
            created_at DATETIME DEFAULT CURRENT_TIMESTAMP
          )
        `).run();

        await env.DB.prepare(
          "INSERT INTO contacts (name, email, subject, message, ip) VALUES (?, ?, ?, ?, ?)"
        ).bind(name, email, subject || "General Inquiry", message, ip).run();
      } catch (dbErr) {
        console.error("D1 contact store error:", dbErr);
      }
    }

    return jsonResponse({ success: true, message: 'Thank you! Your message has been received.' });
  } catch (err) {
    return jsonResponse({ error: err.message }, 500);
  }
}

export async function onRequestOptions() {
  return new Response(null, {
    status: 204,
    headers: {
      'Access-Control-Allow-Origin': '*',
      'Access-Control-Allow-Methods': 'POST, OPTIONS',
      'Access-Control-Allow-Headers': 'Content-Type'
    }
  });
}
