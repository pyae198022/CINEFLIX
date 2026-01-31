<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="title" required="false" rtexprvalue="true"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ taglib prefix="sc"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html>
<head>
<c:set value="${pageContext.request.contextPath}" var="root"
	scope="request"></c:set>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>${not empty title ? title : 'CINEFLIX'}</title>

<link rel="stylesheet" href="/static/css/index.css" />
<link rel="stylesheet" href="/static/css/app.css" />

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>

</head>
<body class="pt-20">


	<header class="fixed top-0 left-0 right-0 z-50 glass-effect">
		<div class="container mx-auto px-4 py-4">
			<div class="flex items-center justify-between">

				<div class="flex items-center gap-8">
					<h1 class="text-2xl font-black tracking-tight text-red-600">
						CINEFLIX</h1>

					<nav class="hidden md:flex items-center gap-6">
						<a href="/movie"
							class="text-white/90 hover:text-white transition-colors font-medium">Home</a>
						<a href="#"
							class="text-white/60 hover:text-white transition-colors">Movies</a>
						<a href="#"
							class="text-white/60 hover:text-white transition-colors">Movie Series
							</a> <a href="#"
							class="text-white/60 hover:text-white transition-colors">My
							List</a>
					</nav>
				</div>

				<div class="flex items-center gap-4">
					<div class="relative">
						<div id="searchContainer"
							class="flex items-center transition-all duration-300">
							<input id="searchInput" type="text"
								placeholder="Search movies..."
								class="hidden bg-gray-800/50 border-none outline-none text-white placeholder:text-gray-400 rounded-full px-4 py-2 w-48 mr-2 animate-fade-in" />
							<button id="searchBtn"
								class="text-white/80 hover:text-white transition-colors">
								<i data-lucide="search"></i>
							</button>
						</div>
					</div>

					<button
						class="text-white/80 hover:text-white transition-colors relative">
						<i data-lucide="bell"></i> <span
							class="absolute -top-1 -right-1 w-2 h-2 bg-red-600 rounded-full"></span>
					</button>

					<button
						class="w-8 h-8 rounded bg-gradient-to-br from-red-600 to-red-400 flex items-center justify-center">
						<i data-lucide="user" class="text-white w-5 h-5"></i>
					</button>
				</div>
			</div>
		</div>
	</header>

	<main class="container mx-auto px-4">
		<jsp:doBody />
	</main>
	<script>
 // Initialize Icons
    lucide.createIcons();

    // Search Toggle Logic (Replacing React useState)
    const searchBtn = document.getElementById('searchBtn');
    const searchInput = document.getElementById('searchInput');
    const searchContainer = document.getElementById('searchContainer');
    let searchOpen = false;

    searchBtn.addEventListener('click', () => {
    	searchOpen = !searchOpen;
    	if (searchOpen) {
    		searchInput.classList.remove('hidden');
    		searchContainer.classList.add('bg-white/10', 'rounded-full', 'px-2');
    		searchInput.focus();
    	} else {
    		searchInput.classList.add('hidden');
    		searchContainer.classList.remove('bg-white/10', 'rounded-full', 'px-2');
    	}
    });
    </script>
</body>
</html>