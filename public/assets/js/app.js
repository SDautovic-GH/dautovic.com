/* ==========================================================================
   dautovic.com - Client Application
   Fast, lightweight, zero-dependency blog reader
   ========================================================================== */

(function () {
  // Theme Management
  const themeToggle = document.getElementById('theme-toggle');
  const prefersDark = window.matchMedia('(prefers-color-scheme: dark)');
  const savedTheme = localStorage.getItem('dautovic-theme');

  function setTheme(theme) {
    document.documentElement.setAttribute('data-theme', theme);
    localStorage.setItem('dautovic-theme', theme);
    updateThemeIcon(theme);
  }

  function updateThemeIcon(theme) {
    if (!themeToggle) return;
    themeToggle.innerHTML = theme === 'dark' 
      ? '<svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><circle cx="12" cy="12" r="5"/><path d="M12 1v2M12 21v2M4.22 4.22l1.42 1.42M18.36 18.36l1.42 1.42M1 12h2M21 12h2M4.22 19.78l1.42-1.42M18.36 5.64l1.42-1.42"/></svg>'
      : '<svg width="18" height="18" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"/></svg>';
  }

  const initialTheme = savedTheme || (prefersDark.matches ? 'dark' : 'light');
  setTheme(initialTheme);

  if (themeToggle) {
    themeToggle.addEventListener('click', () => {
      const current = document.documentElement.getAttribute('data-theme');
      setTheme(current === 'dark' ? 'light' : 'dark');
    });
  }

  prefersDark.addEventListener('change', (e) => {
    if (!localStorage.getItem('dautovic-theme')) {
      setTheme(e.matches ? 'dark' : 'light');
    }
  });

  // Blog State
  let allPosts = [];
  let currentCategory = 'all';
  let searchQuery = '';
  let currentPage = 1;
  const postsPerPage = 10;

  // DOM Elements
  const postsContainer = document.getElementById('posts-container');
  const searchInput = document.getElementById('search-input');
  const categoryChips = document.getElementById('category-chips');
  const prevBtn = document.getElementById('prev-btn');
  const nextBtn = document.getElementById('next-btn');
  const pageIndicator = document.getElementById('page-indicator');

  async function loadPosts() {
    try {
      // Try live API first (Cloudflare D1), fall back to static JSON
      let res;
      try {
        res = await fetch('/api/posts');
        if (!res.ok) throw new Error('API not available');
      } catch (e) {
        res = await fetch('/data/posts.json');
      }
      allPosts = await res.json();
      renderCategories();
      renderPosts();
    } catch (err) {
      console.error('Failed to load posts:', err);
      if (postsContainer) {
        postsContainer.innerHTML = '<div style="text-align:center;padding:40px;color:var(--text-muted)">Unable to load posts. Please try again.</div>';
      }
    }
  }

  function renderCategories() {
    if (!categoryChips) return;
    const catCounts = {};
    allPosts.forEach(p => {
      p.categories.forEach(c => {
        catCounts[c] = (catCounts[c] || 0) + 1;
      });
    });

    const sortedCats = Object.keys(catCounts).sort((a, b) => catCounts[b] - catCounts[a]);
    
    let html = `<button class="chip-btn ${currentCategory === 'all' ? 'active' : ''}" data-cat="all">All (${allPosts.length})</button>`;
    sortedCats.forEach(c => {
      html += `<button class="chip-btn ${currentCategory === c ? 'active' : ''}" data-cat="${escapeHtml(c)}">${escapeHtml(c)} (${catCounts[c]})</button>`;
    });

    categoryChips.innerHTML = html;

    categoryChips.querySelectorAll('.chip-btn').forEach(btn => {
      btn.addEventListener('click', () => {
        categoryChips.querySelectorAll('.chip-btn').forEach(b => b.classList.remove('active'));
        btn.classList.add('active');
        currentCategory = btn.getAttribute('data-cat');
        currentPage = 1;

        // Automatically scroll category chip smoothly into view
        btn.scrollIntoView({ behavior: 'smooth', block: 'nearest', inline: 'center' });

        renderPosts();
      });
    });

    // Support horizontal scroll with mouse wheel
    if (!categoryChips.dataset.wheelBound) {
      categoryChips.dataset.wheelBound = 'true';
      categoryChips.addEventListener('wheel', (e) => {
        if (Math.abs(e.deltaY) > Math.abs(e.deltaX)) {
          e.preventDefault();
          categoryChips.scrollLeft += e.deltaY;
        }
      }, { passive: false });
    }
  }

  function renderPosts() {
    if (!postsContainer) return;

    let filtered = allPosts.filter(p => {
      const matchesCat = (currentCategory === 'all') || (p.categories && p.categories.includes(currentCategory));
      const query = searchQuery.toLowerCase().trim();
      const matchesSearch = !query || 
        p.title.toLowerCase().includes(query) || 
        (p.excerpt && p.excerpt.toLowerCase().includes(query)) ||
        (p.categories && p.categories.some(c => c.toLowerCase().includes(query)));
      return matchesCat && matchesSearch;
    });

    const totalPages = Math.ceil(filtered.length / postsPerPage) || 1;
    if (currentPage > totalPages) currentPage = totalPages;

    const startIdx = (currentPage - 1) * postsPerPage;
    const paginated = filtered.slice(startIdx, startIdx + postsPerPage);

    if (paginated.length === 0) {
      postsContainer.innerHTML = '<div style="text-align:center;padding:48px 0;color:var(--text-muted);">No stories found matching your filter.</div>';
    } else {
      postsContainer.innerHTML = paginated.map(p => {
        const cat = p.categories && p.categories[0] ? p.categories[0] : 'General';
        const dateStr = formatDate(p.date);
        return `
          <article class="post-card">
            <div class="card-meta">
              <span class="card-cat">${escapeHtml(cat)}</span>
              <span>•</span>
              <time datetime="${p.date}">${dateStr}</time>
              <span>•</span>
              <span>${p.readTime || '2 min read'}</span>
            </div>
            <h2 class="card-title">
              <a href="/post.html?slug=${encodeURIComponent(p.slug)}">${escapeHtml(p.title)}</a>
            </h2>
            <p class="card-excerpt">${escapeHtml(p.excerpt || '')}</p>
            <div class="card-footer">
              <a href="/post.html?slug=${encodeURIComponent(p.slug)}" class="read-link">
                Read story <span>→</span>
              </a>
            </div>
          </article>
        `;
      }).join('');
    }

    if (pageIndicator) {
      pageIndicator.textContent = `Page ${currentPage} of ${totalPages}`;
    }
    if (prevBtn) prevBtn.disabled = currentPage === 1;
    if (nextBtn) nextBtn.disabled = currentPage === totalPages;
  }

  // Event Listeners
  if (searchInput) {
    searchInput.addEventListener('input', (e) => {
      searchQuery = e.target.value;
      currentPage = 1;
      renderPosts();
    });
  }

  if (prevBtn) {
    prevBtn.addEventListener('click', () => {
      if (currentPage > 1) {
        currentPage--;
        renderPosts();
        window.scrollTo({ top: 300, behavior: 'smooth' });
      }
    });
  }

  if (nextBtn) {
    nextBtn.addEventListener('click', () => {
      currentPage++;
      renderPosts();
      window.scrollTo({ top: 300, behavior: 'smooth' });
    });
  }

  function formatDate(raw) {
    try {
      const d = new Date(raw.replace(' ', 'T'));
      return d.toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' });
    } catch (e) {
      return raw.split(' ')[0] || raw;
    }
  }

  function escapeHtml(str) {
    if (!str) return '';
    return str.replace(/&/g, '&amp;').replace(/</g, '&lt;').replace(/>/g, '&gt;').replace(/"/g, '&quot;');
  }

  // Initialize
  if (postsContainer) {
    loadPosts();
  }
})();
