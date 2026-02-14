<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false" rtexprvalue="true"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="fn" uri="jakarta.tags.functions"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>

<!DOCTYPE html>
<html>
<head>
<c:set value="${pageContext.request.contextPath}" var="root"
	scope="request"></c:set>

<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${not empty title ? title : 'CINEFLIX'}</title>

<link rel="stylesheet" href="/static/css/app.css" />
<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>

<style>
.glass-effect {
	background: rgba(10, 10, 10, 0.8);
	backdrop-filter: blur(12px);
	border-bottom: 1px solid rgba(255, 255, 255, 0.1);
}

.search-dropdown-shadow {
	box-shadow: 0 20px 50px rgba(0, 0, 0, 0.6);
}

.animate-fade-in {
	animation: fadeIn 0.2s ease-out;
}

@
keyframes fadeIn {from { opacity:0;
	transform: translateY(-10px);
}

to {
	opacity: 1;
	transform: translateY(0);
}
}
</style>
</head>
<body class="bg-[#0a0a0a] pt-20">

	<header class="fixed top-0 left-0 right-0 z-50 glass-effect">
		<div class="container mx-auto px-4 py-4">
			<div class="flex items-center justify-between">

				<%-- Logo and Nav --%>
				<div class="flex items-center gap-8">
					<h1
						class="text-2xl font-black tracking-tight text-red-600 cursor-pointer"
						onclick="location.href='${root}/movie'">CINEFLIX</h1>

					<nav class="hidden md:flex items-center gap-6">
						<a href="${root}/movie"
							class="text-white hover:text-red-500 transition-colors font-medium">Home</a>
						<a href="#"
							class="text-white/60 hover:text-white transition-colors text-sm">Movies</a>
						<a href="#"
							class="text-white/60 hover:text-white transition-colors text-sm">TV
							Shows</a> <a href="${root}/my-lists/allMyLists"
							class="text-white/60 hover:text-white transition-colors text-sm">My
							Lists</a>
					</nav>
				</div>

				<%-- Search and Actions --%>
				<div class="flex items-center gap-3">
					<div class="relative flex items-center" id="searchWrapper">

						<%-- The Search Input Container (Toggled by Button) --%>
						<div id="searchBarContainer"
							class="hidden items-center bg-black/60 border border-white/20 rounded-full px-4 py-1.5 transition-all duration-300 animate-fade-in">
							<i data-lucide="search" class="w-4 h-4 text-gray-400 mr-2"></i> <input
								id="searchInput" type="text" placeholder="Search movies..."
								class="bg-transparent border-none outline-none text-white text-sm placeholder:text-gray-500 w-48 md:w-64" />
							<span class="text-[10px] font-mono text-gray-500 ml-2">⌘ K</span>
						</div>

						<%-- The Trigger Icon --%>
						<button id="searchBtn"
							class="text-white/80 hover:text-white transition-colors p-2">
							<i data-lucide="search" class="w-6 h-6"></i>
						</button>

						<%-- Advanced Results Dropdown --%>
						<div id="searchResults"
							class="hidden absolute top-14 right-0 w-80 md:w-96 bg-[#141414] border border-white/10 rounded-xl overflow-hidden z-[100] search-dropdown-shadow animate-fade-in">
							<div id="emptyState"
								class="p-10 flex flex-col items-center justify-center text-center">
								<div
									class="w-12 h-12 bg-white/5 rounded-full flex items-center justify-center mb-4">
									<i data-lucide="film" class="text-gray-500 w-6 h-6"></i>
								</div>
								<p class="text-white text-sm font-medium">Start typing to
									search movies</p>
							</div>

							<div id="resultsList" class="max-h-96 overflow-y-auto">
								<%-- Results will be injected here via JS --%>
							</div>
						</div>
					</div>

					<sec:authorize access="isAuthenticated()">
						<div class="relative">
							<%-- Profile Trigger (Circle with letter as in screenshot) --%>
							<button id="profileDropdownBtn" class="focus:outline-none">
								<div class="h-9 w-9 rounded-full bg-[#3d1a1a] border border-white/20 flex items-center justify-center overflow-hidden">
									<span class="text-white text-sm font-bold uppercase">
										<sec:authorize access="principal instanceof T(org.springframework.security.core.userdetails.User)">
											<sec:authentication property="principal.username" var="userEmail" />
										</sec:authorize> 
										<sec:authorize access="principal instanceof T(org.springframework.security.oauth2.core.user.DefaultOAuth2User)">
											<sec:authentication property="principal.attributes['email']" var="userEmail" />
										</sec:authorize> 
										${userEmail.substring(0,1)}
									</span>
								</div>
							</button>

							<%-- The Dropdown (Matching the Screenshot) --%>
							<div id="profileDropdown" class="hidden absolute right-0 mt-3 dropdown-menu-custom z-[60] shadow-2xl">
								<div class="px-4 py-3 text-sm text-gray-400 border-b border-white/10">
									${userEmail}
								</div>
								
								<a href="<c:url value='/profile' />" class="dropdown-item">
									<i data-lucide="user" class="mr-3 w-5 h-5"></i> My Profile
								</a>
								
								<sec:authorize access="hasAuthority('Admin')">
									<a href="<c:url value='${root }/admin' />" class="dropdown-item">
										<i data-lucide="shield" class="mr-3 w-5 h-5"></i> Admin Dashboard
									</a>
								</sec:authorize>

								<form id="logoutForm" action="<c:url value='/logout' />" method="post" class="border-t border-white/10">
									<sec:csrfInput />
									<button type="submit" class="w-full dropdown-item dropdown-item-signout">
										<i data-lucide="log-out" class="mr-3 w-5 h-5 text-red-500"></i> Sign Out
									</button>
								</form>
							</div>
						</div>
					</sec:authorize>

					<sec:authorize access="!isAuthenticated()">
						<a href="<c:url value='/login' />"
							class="text-sm font-medium text-white bg-primary hover:bg-primary/90 px-4 py-2 rounded transition-colors">
							Sign In </a>
					</sec:authorize>
				</div>
			</div>
		</div>
	</header>

	<main class="container mx-auto px-4 pb-20">
		<jsp:doBody />
	</main>

	<script>
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

    // Single Search Listener
    searchInput.addEventListener('input', async (e) => {
        const query = e.target.value.trim();
        
        if (query.length > 0) {
            searchResults.classList.remove('hidden');
            try {
                // FIXED PATH: matches your @RequestMapping("movie") + @GetMapping("/search")
                const response = await fetch(`${root}/movie/search?query=` + encodeURIComponent(query));
                const movies = await response.json();

                emptyState.classList.add('hidden');
                resultsList.classList.remove('hidden');
                resultsList.innerHTML = ''; // Clear previous results

                if (movies && movies.length > 0) {
                    movies.forEach(movie => {
                    	
                        const movieHtml = `
                            <div onclick="window.location.href='${pageContext.request.contextPath}/movie-detail?id=\${movie.id}'" 
                                 class="group px-4 py-3 hover:bg-red-600 transition-all cursor-pointer flex items-center gap-4 border-b border-white/5">
                                <div class="w-10 h-14 bg-gray-800 rounded shadow-md flex-shrink-0 overflow-hidden">
                                    <img src="${pageContext.request.contextPath}/static/movies/\${movie.poster}" class="w-full h-full object-cover" />
                                </div>
                                <div class="flex-1 min-w-0 text-left">
                                    <p class="text-white text-sm font-bold truncate group-hover:text-white">\${movie.title}</p>
                                    <p class="text-gray-400 text-xs group-hover:text-red-100 transition-colors">
                                        \${movie.year} • \${movie.genre}
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
</script>
</body>
</html>