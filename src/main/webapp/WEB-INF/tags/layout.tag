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
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

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
							Shows</a> <a href="${root}/my-lists/my-list"
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
								<div
									class="h-9 w-9 rounded-full bg-[#3d1a1a] border border-white/20 flex items-center justify-center overflow-hidden">
									<span class="text-white text-sm font-bold uppercase"> <sec:authorize
											access="principal instanceof T(org.springframework.security.core.userdetails.User)">
											<sec:authentication property="principal.username"
												var="userEmail" />
										</sec:authorize> <sec:authorize
											access="principal instanceof T(org.springframework.security.oauth2.core.user.DefaultOAuth2User)">
											<sec:authentication property="principal.attributes['email']"
												var="userEmail" />
										</sec:authorize> ${userEmail.substring(0,1)}
									</span>
								</div>
							</button>

							
							<div id="profileDropdown"
								class="hidden absolute right-0 mt-3 dropdown-menu-custom z-[100] shadow-2xl">
								<div
									class="px-4 py-3 text-sm text-gray-400 border-b border-white/10">
									${userEmail}</div>

								<a href="<c:url value='/profile' />" class="dropdown-item">
									<i data-lucide="user" class="mr-3 w-5 h-5"></i> My Profile
								</a>

								<sec:authorize access="hasAuthority('Admin')">
									<a href="<c:url value='${root }/admin' />"
										class="dropdown-item"> <i data-lucide="shield"
										class="mr-3 w-5 h-5"></i> Admin Dashboard
									</a>
								</sec:authorize>

								<form id="logoutForm" action="<c:url value='/logout' />"
									method="post" class="border-t border-white/10">
									<sec:csrfInput />
									<button type="submit"
										class="w-full dropdown-item dropdown-item-signout">
										<i data-lucide="log-out" class="mr-3 w-5 h-5 text-red-500"></i>
										Sign Out
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

	<%-- Inside your JSP Layout file --%>
	<script>
		window.rootPath = "${pageContext.request.contextPath}";
	</script>
	<script
		src="${pageContext.request.contextPath}/static/js/applicaton.js"></script>
</body>
</html>