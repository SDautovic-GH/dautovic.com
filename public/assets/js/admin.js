/* ==========================================================================
   dautovic.com - Lightweight CMS Desk Script
   Supports Markdown, HTML, live preview, formatting toolbar & image upload
   ========================================================================== */

(function () {
  const PASSCODE = 'dautovic2026';

  // Theme support
  const themeToggle = document.getElementById('theme-toggle');
  const savedTheme = localStorage.getItem('dautovic-theme') || (window.matchMedia('(prefers-color-scheme: dark)').matches ? 'dark' : 'light');
  document.documentElement.setAttribute('data-theme', savedTheme);
  if (themeToggle) {
    themeToggle.addEventListener('click', () => {
      const cur = document.documentElement.getAttribute('data-theme');
      const next = cur === 'dark' ? 'light' : 'dark';
      document.documentElement.setAttribute('data-theme', next);
      localStorage.setItem('dautovic-theme', next);
    });
  }

  // Views
  const authView = document.getElementById('auth-view');
  const dashboardView = document.getElementById('dashboard-view');
  const editorView = document.getElementById('editor-view');

  // Form Elements
  const loginForm = document.getElementById('login-form');
  const passcodeInput = document.getElementById('passcode-input');
  const adminPostsTbody = document.getElementById('admin-posts-tbody');
  const statsSummary = document.getElementById('stats-summary');
  const adminSearch = document.getElementById('admin-search');
  const newPostBtn = document.getElementById('new-post-btn');

  // Editor Elements
  const editorHeading = document.getElementById('editor-heading');
  const postTitleInput = document.getElementById('post-title-input');
  const postSlugInput = document.getElementById('post-slug-input');
  const postCatInput = document.getElementById('post-cat-input');
  const postExcerptInput = document.getElementById('post-excerpt-input');
  const postContentInput = document.getElementById('post-content-input');
  const previewOutput = document.getElementById('preview-output');
  const wordCountBadge = document.getElementById('word-count-badge');
  const imageUploadInput = document.getElementById('image-upload-input');
  const saveDraftBtn = document.getElementById('save-draft-btn');
  const publishBtn = document.getElementById('publish-btn');
  const cancelEditBtn = document.getElementById('cancel-edit-btn');
  const deletePostBtn = document.getElementById('delete-post-btn');
  const deleteZone = document.getElementById('delete-zone');

  let posts = [];
  let editingPostId = null;

  // Session check
  if (sessionStorage.getItem('dautovic-auth') === 'true') {
    showDashboard();
  }

  loginForm.addEventListener('submit', (e) => {
    e.preventDefault();
    if (passcodeInput.value === PASSCODE) {
      sessionStorage.setItem('dautovic-auth', 'true');
      showDashboard();
    } else {
      alert('Incorrect passcode.');
      passcodeInput.value = '';
    }
  });

  async function showDashboard() {
    authView.style.display = 'none';
    editorView.style.display = 'none';
    dashboardView.style.display = 'block';
    await loadPosts();
  }

  async function loadPosts() {
    try {
      let res;
      try {
        res = await fetch('/api/posts');
        if (!res.ok) throw new Error('API not available');
        posts = await res.json();
      } catch (e) {
        res = await fetch('/data/posts.json');
        posts = await res.json();
        const localOverrides = JSON.parse(localStorage.getItem('dautovic_custom_posts') || '[]');
        if (localOverrides.length > 0) {
          const localMap = new Map(localOverrides.map(p => [p.slug, p]));
          posts = posts.map(p => localMap.get(p.slug) || p);
          localOverrides.forEach(p => {
            if (!posts.some(ep => ep.slug === p.slug)) {
              posts.unshift(p);
            }
          });
        }
      }
      renderTable();
    } catch (err) {
      console.error('Failed to load posts:', err);
    }
  }

  function renderTable() {
    const query = (adminSearch.value || '').toLowerCase().trim();
    const filtered = posts.filter(p => !query || p.title.toLowerCase().includes(query) || (p.categories && p.categories.join(' ').toLowerCase().includes(query)));

    const publishedCount = posts.filter(p => p.status === 'published').length;
    const draftCount = posts.filter(p => p.status === 'draft').length;
    statsSummary.textContent = `${posts.length} total posts (${publishedCount} published, ${draftCount} drafts)`;

    adminPostsTbody.innerHTML = filtered.map(p => {
      const isDraft = p.status === 'draft';
      const badgeClass = isDraft ? 'badge-draft' : 'badge-published';
      const badgeText = isDraft ? 'Draft' : 'Published';
      const cat = p.categories && p.categories[0] ? p.categories[0] : 'General';
      const date = (p.date || '').split(' ')[0];

      return `
        <tr>
          <td>
            <strong>${escapeHtml(p.title)}</strong><br>
            <span style="font-size:0.75rem;color:var(--text-muted);">${escapeHtml(p.slug)}</span>
          </td>
          <td><span style="font-size:0.85rem;">${escapeHtml(cat)}</span></td>
          <td><span style="font-size:0.85rem;color:var(--text-muted);">${date}</span></td>
          <td><span class="${badgeClass}">${badgeText}</span></td>
          <td style="text-align:right;">
            <button class="admin-btn btn-outline edit-btn" data-slug="${escapeHtml(p.slug)}" style="padding:4px 10px;font-size:0.8rem;">Edit</button>
            <a href="/post.html?slug=${encodeURIComponent(p.slug)}" target="_blank" class="admin-btn btn-outline" style="padding:4px 10px;font-size:0.8rem;">View ↗</a>
          </td>
        </tr>
      `;
    }).join('');

    adminPostsTbody.querySelectorAll('.edit-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        const slug = btn.getAttribute('data-slug');
        const post = posts.find(p => p.slug === slug);
        if (post) openEditor(post);
      });
    });
  }

  adminSearch.addEventListener('input', renderTable);

  newPostBtn.addEventListener('click', () => {
    openEditor(null);
  });

  function openEditor(post) {
    dashboardView.style.display = 'none';
    editorView.style.display = 'block';

    if (post) {
      editingPostId = post.slug;
      editorHeading.textContent = 'Edit Story';
      postTitleInput.value = post.title;
      postSlugInput.value = post.slug;
      postCatInput.value = post.categories ? post.categories.join(', ') : 'General';
      postExcerptInput.value = post.excerpt || '';
      postContentInput.value = post.content || '';
      deleteZone.style.display = 'flex';
    } else {
      editingPostId = null;
      editorHeading.textContent = 'Write New Story';
      postTitleInput.value = '';
      postSlugInput.value = '';
      postCatInput.value = 'General';
      postExcerptInput.value = '';
      postContentInput.value = '';
      deleteZone.style.display = 'none';
    }

    updatePreview();
  }

  // Auto slugify title
  postTitleInput.addEventListener('input', () => {
    if (!editingPostId) {
      postSlugInput.value = postTitleInput.value
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/(^-|-$)/g, '');
    }
  });

  // Toolbar Formatting Helpers
  function insertAtCursor(textToInsert) {
    const textarea = postContentInput;
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const val = textarea.value;

    textarea.value = val.substring(0, start) + textToInsert + val.substring(end);
    textarea.selectionStart = textarea.selectionEnd = start + textToInsert.length;
    textarea.focus();
    updatePreview();
  }

  function wrapSelection(prefix, suffix, defaultText) {
    const textarea = postContentInput;
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const val = textarea.value;
    const selected = val.substring(start, end) || defaultText;

    const replacement = prefix + selected + suffix;
    textarea.value = val.substring(0, start) + replacement + val.substring(end);
    textarea.selectionStart = start + prefix.length;
    textarea.selectionEnd = start + prefix.length + selected.length;
    textarea.focus();
    updatePreview();
  }

  function prefixLines(prefix) {
    const textarea = postContentInput;
    const start = textarea.selectionStart;
    const end = textarea.selectionEnd;
    const val = textarea.value;

    const selected = val.substring(start, end) || 'List item';
    const lines = selected.split('\n');
    const prefixed = lines.map(l => prefix + l).join('\n');

    textarea.value = val.substring(0, start) + prefixed + val.substring(end);
    textarea.selectionStart = start;
    textarea.selectionEnd = start + prefixed.length;
    textarea.focus();
    updatePreview();
  }

  // Toolbar button listeners
  document.querySelectorAll('.editor-toolbar .toolbar-btn').forEach(btn => {
    btn.addEventListener('click', () => {
      const action = btn.getAttribute('data-action');
      if (!action) return;

      switch (action) {
        case 'title':
          insertAtCursor('\n# Major Section Title\n');
          break;
        case 'heading':
          insertAtCursor('\n## Heading 2\n');
          break;
        case 'subheading':
          insertAtCursor('\n### Heading 3\n');
          break;
        case 'bold':
          wrapSelection('**', '**', 'bold text');
          break;
        case 'italic':
          wrapSelection('*', '*', 'italic text');
          break;
        case 'strike':
          wrapSelection('~~', '~~', 'strikethrough text');
          break;
        case 'bullet':
          prefixLines('- ');
          break;
        case 'number':
          prefixLines('1. ');
          break;
        case 'quote':
          prefixLines('> ');
          break;
        case 'divider':
          insertAtCursor('\n\n---\n\n');
          break;
        case 'code':
          const textarea = postContentInput;
          const selected = textarea.value.substring(textarea.selectionStart, textarea.selectionEnd);
          if (selected.includes('\n')) {
            wrapSelection('\n```\n', '\n```\n', 'code block');
          } else {
            wrapSelection('`', '`', 'code');
          }
          break;
        case 'newline':
          insertAtCursor('<br>\n');
          break;
        case 'link':
          const tArea = postContentInput;
          const selectedText = tArea.value.substring(tArea.selectionStart, tArea.selectionEnd) || 'link text';
          const url = prompt('Enter link URL (e.g. https://example.com):', 'https://');
          if (url && url !== 'https://') {
            insertAtCursor(`[${selectedText}](${url})`);
          }
          break;
      }
    });
  });

  // Image Upload Handler
  if (imageUploadInput) {
    imageUploadInput.addEventListener('change', async (e) => {
      const file = e.target.files[0];
      if (!file) return;

      const alt = prompt('Enter image caption/alt text:', file.name.split('.')[0]) || 'Image';
      
      const reader = new FileReader();
      reader.onload = (event) => {
        const img = new Image();
        img.onload = () => {
          const maxW = 1200;
          let w = img.width;
          let h = img.height;
          if (w > maxW) {
            h = Math.round((h * maxW) / w);
            w = maxW;
          }
          const canvas = document.createElement('canvas');
          canvas.width = w;
          canvas.height = h;
          const ctx = canvas.getContext('2d');
          ctx.drawImage(img, 0, 0, w, h);
          const dataUrl = canvas.toDataURL('image/jpeg', 0.82);

          insertAtCursor(`\n![${alt}](${dataUrl})\n`);
        };
        img.src = event.target.result;
      };
      reader.readAsDataURL(file);
      imageUploadInput.value = '';
    });
  }

  // Real-time Markdown & HTML Live Preview Parser
  function parseContent(raw) {
    if (!raw) return '<em style="color:var(--text-muted);">Preview will render here…</em>';

    let html = raw;

    // Code blocks: ```code```
    html = html.replace(/```([\s\S]*?)```/gim, '<pre><code>$1</code></pre>');
    // Inline code: `code`
    html = html.replace(/`([^`]+)`/gim, '<code>$1</code>');

    // Headings
    html = html.replace(/^### (.*$)/gim, '<h3>$1</h3>');
    html = html.replace(/^## (.*$)/gim, '<h2>$1</h2>');
    html = html.replace(/^# (.*$)/gim, '<h1>$1</h1>');

    // Dividers: ---
    html = html.replace(/^---$/gim, '<hr class="story-divider">');

    // Bold, Italic, Strikethrough
    html = html.replace(/\*\*(.*?)\*\*/gim, '<strong>$1</strong>');
    html = html.replace(/\*(.*?)\*/gim, '<em>$1</em>');
    html = html.replace(/~~(.*?)~~/gim, '<del>$1</del>');

    // Images: ![alt](url)
    html = html.replace(/!\[(.*?)\]\((.*?)\)/gim, '<figure style="margin:16px 0;"><img src="$2" alt="$1" style="max-width:100%;border-radius:8px;"><figcaption style="font-size:0.8rem;color:var(--text-muted);margin-top:4px;">$1</figcaption></figure>');

    // Links: [text](url)
    html = html.replace(/\[(.*?)\]\((.*?)\)/gim, '<a href="$2" target="_blank" rel="noopener" style="color:var(--accent);">$1</a>');

    // Blockquotes: > quote
    html = html.replace(/^\> (.*$)/gim, '<blockquote>$1</blockquote>');

    // Unordered lists: - item
    html = html.replace(/^\- (.*$)/gim, '<li>$1</li>');
    html = html.replace(/(<li>.*<\/li>)/gim, '<ul>$1</ul>');
    html = html.replace(/<\/ul>\s*<ul>/gim, '');

    // Convert double newlines to paragraphs
    const paragraphs = html.split(/\n\s*\n/);
    html = paragraphs.map(p => {
      p = p.trim();
      if (!p) return '';
      if (p.startsWith('<h') || p.startsWith('<ul') || p.startsWith('<block') || p.startsWith('<figure') || p.startsWith('<pre') || p.startsWith('<hr') || p.startsWith('<div')) {
        return p;
      }
      return `<p>${p.replace(/\n/g, '<br>')}</p>`;
    }).join('\n');

    return html;
  }

  postContentInput.addEventListener('input', updatePreview);

  function updatePreview() {
    const text = postContentInput.value;
    previewOutput.innerHTML = parseContent(text);

    // Update word count & read time
    if (wordCountBadge) {
      const words = (text.trim().match(/\w+/g) || []).length;
      const mins = Math.max(1, Math.round(words / 200));
      wordCountBadge.textContent = `${words} words • ${mins} min read`;
    }
  }

  cancelEditBtn.addEventListener('click', () => {
    editorView.style.display = 'none';
    dashboardView.style.display = 'block';
  });

  saveDraftBtn.addEventListener('click', () => savePost('draft'));
  publishBtn.addEventListener('click', () => savePost('published'));

  async function savePost(status) {
    const title = postTitleInput.value.trim();
    if (!title) {
      alert('Please enter a title.');
      return;
    }

    const slug = postSlugInput.value.trim() || title.toLowerCase().replace(/[^a-z0-9]+/g, '-');
    const categories = postCatInput.value.split(',').map(s => s.trim()).filter(Boolean);
    const excerpt = postExcerptInput.value.trim();
    const rawContent = postContentInput.value.trim();
    const formattedContent = parseContent(rawContent);
    const words = (rawContent.match(/\w+/g) || []).length;
    const readTime = `${Math.max(1, Math.round(words / 200))} min read`;
    const now = new Date().toISOString().replace('T', ' ').substring(0, 19);

    const postData = {
      title,
      slug,
      categories: categories.length ? categories : ['General'],
      tags: [],
      excerpt: excerpt || rawContent.substring(0, 150).replace(/<[^>]+>/g, '') + '…',
      content: formattedContent,
      readTime,
      date: now,
      status
    };

    try {
      const res = await fetch('/api/posts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(postData)
      });
      if (!res.ok) throw new Error('API save failed');
    } catch (e) {
      let custom = JSON.parse(localStorage.getItem('dautovic_custom_posts') || '[]');
      custom = custom.filter(p => p.slug !== slug);
      custom.unshift(postData);
      localStorage.setItem('dautovic_custom_posts', JSON.stringify(custom));
    }

    alert(`Story ${status === 'published' ? 'published' : 'saved as draft'} successfully!`);
    showDashboard();
  }

  deletePostBtn.addEventListener('click', async () => {
    if (!confirm('Are you sure you want to delete this story?')) return;
    try {
      await fetch(`/api/posts/${encodeURIComponent(editingPostId)}`, { method: 'DELETE' });
    } catch (e) {}

    let custom = JSON.parse(localStorage.getItem('dautovic_custom_posts') || '[]');
    custom = custom.filter(p => p.slug !== editingPostId);
    localStorage.setItem('dautovic_custom_posts', JSON.stringify(custom));
    posts = posts.filter(p => p.slug !== editingPostId);

    alert('Story deleted.');
    showDashboard();
  });

  function escapeHtml(str) {
    return (str || '').replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }
})();
