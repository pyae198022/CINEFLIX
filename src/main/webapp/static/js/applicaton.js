
lucide.createIcons();

const searchBtn = document.getElementById('searchBtn');
const searchBarContainer = document.getElementById('searchBarContainer');
const searchInput = document.getElementById('searchInput');
const searchResults = document.getElementById('searchResults');
const emptyState = document.getElementById('emptyState');
const resultsList = document.getElementById('resultsList');
const searchWrapper = document.getElementById('searchWrapper');

const dropdownBtn = document.getElementById('profileDropdownBtn');
const dropdownMenu = document.getElementById('profileDropdown');

let searchOpen = false;

// Toggle Search Bar visibility
searchBtn.addEventListener('click', (e) => {
	e.stopPropagation();
	searchOpen = !searchOpen;
	if (searchOpen) {
		searchBarContainer.classList.replace('hidden', 'flex');
		searchBtn.classList.add('hidden');
		searchInput.focus();
	}
});

let debounceTimer;
    searchInput.addEventListener('input', (e) => {
        const query = e.target.value.trim();
        const root = window.rootPath || '';

        clearTimeout(debounceTimer);
        debounceTimer = setTimeout(async () => {
            if (query.length > 0) {
                searchResults.classList.remove('hidden');
                try {
                    const response = await fetch(`${root}/movie/search?query=${encodeURIComponent(query)}`);
                    const movies = await response.json();

                    emptyState.classList.add('hidden');
                    resultsList.classList.remove('hidden');
                    resultsList.innerHTML = '';

                    if (movies && movies.length > 0) {
                        movies.forEach(movie => {
                            const movieHtml = `
                                <div onclick="window.location.href='${root}/movie-detail?id=${movie.id}'" 
                                     class="group px-4 py-3 hover:bg-red-600 transition-all cursor-pointer flex items-center gap-4 border-b border-white/5">
                                    <div class="w-10 h-14 bg-gray-800 rounded shadow-md flex-shrink-0 overflow-hidden">
                                        <img src="${root}/static/movies/${movie.poster}" class="w-full h-full object-cover" />
                                    </div>
                                    <div class="flex-1 min-w-0 text-left">
                                        <p class="text-white text-sm font-bold truncate group-hover:text-white">${movie.title}</p>
                                        <p class="text-gray-400 text-xs group-hover:text-red-100 transition-colors">
                                            ${movie.year} • ${movie.genre}
                                        </p>
                                    </div>
                                </div>`;
                            resultsList.insertAdjacentHTML('beforeend', movieHtml);
                        });
                    } else {
                        resultsList.innerHTML = '<div class="p-6 text-center text-gray-500 text-sm">No movies found.</div>';
                    }
                } catch (err) {
                    console.error("Search error:", err);
                }
            } else {
                searchResults.classList.add('hidden');
                resultsList.innerHTML = '';
            }
        }, 300);
    });

// Close on click outside
document.addEventListener('click', (e) => {
	if (!searchWrapper.contains(e.target)) {
		searchBarContainer.classList.replace('flex', 'hidden');
		searchResults.classList.add('hidden');
		searchBtn.classList.remove('hidden');
		searchOpen = false;
		searchInput.value = '';
	}
});

// Global Shortcut (⌘ K or Ctrl K)
document.addEventListener('keydown', (e) => {
	if ((e.metaKey || e.ctrlKey) && e.key === 'k') {
		e.preventDefault();
		searchBtn.click();
	}
});

// Inside your DOMContentLoaded block in applicaton.js
if (dropdownBtn && dropdownMenu) {
	dropdownBtn.addEventListener('click', (e) => {
		e.preventDefault();
		e.stopPropagation(); // Prevents the document click listener from firing immediately

		// Toggle the hidden class
		const isHidden = dropdownMenu.classList.contains('hidden');
		if (isHidden) {
			dropdownMenu.classList.remove('hidden');
		} else {
			dropdownMenu.classList.add('hidden');
		}
	});

	// Close when clicking outside, but NOT when clicking inside the menu
	document.addEventListener('click', (e) => {
		if (!dropdownBtn.contains(e.target) && !dropdownMenu.contains(e.target)) {
			dropdownMenu.classList.add('hidden');
		}
	});
}

window.sendReaction = async function(type) {
	const urlParams = new URLSearchParams(window.location.search);
	const movieId = urlParams.get('id');
	if (!movieId) return;

	const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

	try {
		const response = await fetch(`${window.rootPath}/api/movies/${movieId}/react?type=${type}`, {
			method: 'POST',
			headers: { [csrfHeader]: csrfToken }
		});

		if (response.status === 401) {
			window.location.href = `${window.rootPath}/login`;
			return;
		}
		if (response.ok) {
			const data = await response.json();

			// Convert string "true" to actual boolean true
			const isLiked = data.liked === "true";
			const isDisliked = data.disliked === "true";

			// 1. Update Counts
			document.getElementById('like-count').innerText = data.likes;

			// 2. Update Like Button UI
			const likeBtn = document.getElementById('like-btn');
			const likeIcon = likeBtn.querySelector('i');
			if (isLiked) {
				likeBtn.classList.add('bg-blue-600/20');
				likeBtn.classList.remove('hover:bg-white/5');
				likeIcon.style.color = '#3b82f6'; // Blue-500
				likeIcon.style.fill = 'currentColor';
			} else {
				likeBtn.classList.remove('bg-blue-600/20');
				likeBtn.classList.add('hover:bg-white/5');
				likeIcon.style.color = '';
				likeIcon.style.fill = 'none';
			}

			// 3. Update Dislike Button UI
			const dislikeBtn = document.getElementById('dislike-btn');
			const dislikeIcon = dislikeBtn.querySelector('i');
			if (isDisliked) {
				dislikeBtn.classList.add('bg-red-600/20');
				dislikeBtn.classList.remove('hover:bg-white/5');
				dislikeIcon.style.color = '#ef4444'; // Red-500
				dislikeIcon.style.fill = 'currentColor';
			} else {
				dislikeBtn.classList.remove('bg-red-600/20');
				dislikeBtn.classList.add('hover:bg-white/5');
				dislikeIcon.style.color = '';
				dislikeIcon.style.fill = 'none';
			}
		}
	} catch (err) {
		console.error("Reaction failed:", err);
	}
};

window.toggleWatchlist = async function(movieId, element) {
	const csrfToken = document.querySelector('meta[name="_csrf"]')?.content;
	const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.content;

	try {
		const response = await fetch(`${window.rootPath}/my-lists/watchlist/${movieId}`, {
			method: 'POST',
			headers: { [csrfHeader]: csrfToken }
		});

		if (response.status === 401) {
			window.location.href = `${window.rootPath}/login`;
			return;
		}

		if (response.ok) {
			const data = await response.json();
			const iconPath = element.querySelector('svg path');
			let textNode = element.querySelector('.btn-text');

			if (data.added) {
				// Change to Success State (Green)
				element.classList.remove('bg-gray-600/80', 'hover:bg-gray-600');
				element.classList.add('bg-green-600', 'hover:bg-green-700');
				iconPath.setAttribute('d', 'M20 6L9 17l-5-5');
				if (textNode) textNode.innerText = 'In Your List';
			} else {
				// 1. Remove from grid if we are on the "My List" page
				if (window.location.pathname.includes('/my-list')) {
					const movieCard = element.closest('.movie-card');
					if (movieCard) {
						movieCard.style.transform = 'scale(0.9)';
						movieCard.style.opacity = '0';
						setTimeout(() => {
							movieCard.remove();
							// Update the count display
							const countEl = document.getElementById('movie-count');
							if (countEl) {
								let currentCount = parseInt(countEl.innerText) || 0;
								countEl.innerText = (currentCount - 1) + ' movies saved';

								// Show empty state if list is empty
								if (currentCount - 1 <= 0) {
									document.getElementById('empty-state')?.classList.remove('hidden');
									document.getElementById('movie-grid')?.classList.add('hidden');
								}
							}
						}, 300);
					}
				}

				// 2. Revert to Default State (Gray)
				element.classList.remove('bg-green-600', 'hover:bg-green-700');
				element.classList.add('bg-gray-600/80', 'hover:bg-gray-600');
				iconPath.setAttribute('d', 'M12 5v14M5 12h14');
				if (textNode) textNode.innerText = 'Add to List';
			}
		}
	} catch (err) {
		console.error("Watchlist toggle failed:", err);
	}
}