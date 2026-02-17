document.addEventListener('DOMContentLoaded', () => {
	
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

	searchInput.addEventListener('input', async (e) => {
	    const query = e.target.value.trim();
	    const root = window.rootPath || ''; // Use the global variable

	    if (query.length > 0) {
	        searchResults.classList.remove('hidden');
	        try {
	            // Updated fetch path
	            const response = await fetch(`${root}/movie/search?query=` + encodeURIComponent(query));
	            const movies = await response.json();

	            emptyState.classList.add('hidden');
	            resultsList.classList.remove('hidden');
	            resultsList.innerHTML = ''; 

	            if (movies && movies.length > 0) {
	                movies.forEach(movie => {
	                    // Use backticks for the root variable here too
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
	                        </div>
	                    `;
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

	if (dropdownBtn && dropdownMenu) {
		// Toggle dropdown on click
		dropdownBtn.addEventListener('click', (e) => {
			e.stopPropagation();
			dropdownMenu.classList.toggle('hidden');
		});

		// Close dropdown when clicking anywhere else
		document.addEventListener('click', (e) => {
			if (!dropdownBtn.contains(e.target)) {
				dropdownMenu.classList.add('hidden');
			}
		});
	}
})