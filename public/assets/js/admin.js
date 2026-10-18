/* ==========================================================================
   dautovic.com - Lightweight CMS Desk Script
   ========================================================================== */

(function () {
  const PASSCODE = 'dautovic2026'; // Default passcode, customizable in Cloudflare Functions

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
  const saveDraftBtn = document.getElementById('save-draft-btn');
  const publishBtn = document.getElementById('publish-btn');
  const cancelEditBtn = document.getElementById('cancel-edit-btn');
  const deletePostBtn = document.getElementById('delete-post-btn');
  const deleteZone = document.getElementById('delete-zone');

  let posts = [];
  let editingPostId = null;

  // Check existing session
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
        // Fall back to static JSON + localStorage overrides
        res = await fetch('/data/posts.json');
        posts = await res.json();
        const localOverrides = JSON.parse(localStorage.getItem('dautovic_custom_posts') || '[]');
        if (localOverrides.length > 0) {
          // Merge local posts
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

  postTitleInput.addEventListener('input', () => {
    if (!editingPostId) {
      postSlugInput.value = postTitleInput.value
        .toLowerCase()
        .replace(/[^a-z0-9]+/g, '-')
        .replace(/(^-|-$)/g, '');
    }
  });

  postContentInput.addEventListener('input', updatePreview);

  function updatePreview() {
    previewOutput.innerHTML = postContentInput.value || '<em style="color:var(--text-muted);">Preview will render here…</em>';
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
    const content = postContentInput.value.trim();
    const now = new Date().toISOString().replace('T', ' ').substring(0, 19);

    const postData = {
      title,
      slug,
      categories: categories.length ? categories : ['General'],
      tags: [],
      excerpt,
      content,
      readTime: `${Math.max(1, Math.round(content.split(/\s+/).length / 200))} min read`,
      date: now,
      status
    };

    try {
      // Attempt API save to Cloudflare D1
      const res = await fetch('/api/posts', {
        method: 'POST',
        headers: { 'Content-Type': 'application/json' },
        body: JSON.stringify(postData)
      });
      if (!res.ok) throw new Error('API save failed');
    } catch (e) {
      // Fallback: save to localStorage
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
