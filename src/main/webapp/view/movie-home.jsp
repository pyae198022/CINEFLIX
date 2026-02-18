<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<app:layout title="Movie Home">
	<c:if test="${not empty movie}">
		<section
			class="relative h-[85vh] min-h-[600px] overflow-hidden bg-black text-white font-sans">
			<%-- Background Image --%>
			<div class="absolute inset-0">
				<img src="${root}/static/movies/${movie.poster}"
					alt="${movie.title}" class="w-full h-full object-cover" />
				<%-- Gradient Overlays --%>
				<div
					class="absolute inset-0 bg-gradient-to-r from-black via-black/80 to-transparent"></div>
				<div
					class="absolute inset-0 bg-gradient-to-t from-black via-transparent to-transparent"></div>
			</div>

			<%-- Content --%>
			<div class="relative container mx-auto px-4 h-full flex items-center">
				<div class="max-w-2xl">

					<%-- Title --%>
					<h1
						class="text-5xl md:text-7xl font-black mb-4 leading-tight tracking-tight">
						<c:out value="${movie.title}" />
					</h1>

					<%-- Meta Info --%>
					<div class="flex items-center gap-4 mb-6 text-gray-400">
						<div class="flex items-center gap-1">
							<svg class="w-5 h-5 text-yellow-500 fill-current"
								viewBox="0 0 24 24">
                        <path
									d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z" />
                    </svg>
							<span class="text-white font-semibold"><c:out
									value="${movie.rating}" /></span>
						</div>
						<span>•</span> <span><c:out value="${movie.duration}" /></span> <span>•</span>
						<span> <c:forEach var="g" items="${movie.genre}"
								varStatus="status">
								<c:out value="${g}" />${!status.last ? ', ' : ''}
                    </c:forEach>
						</span>
					</div>

					<%-- Description --%>
					<p class="text-lg text-gray-300 mb-8 leading-relaxed max-w-xl">
						<c:out value="${movie.description}" />
					</p>

					<%-- Buttons --%>
					<div class="flex items-center gap-4">
						<a
							href="${pageContext.request.contextPath}/movie/watch?id=${movie.id}"
							class="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-8 py-4 rounded font-semibold transition-all duration-300 transform hover:scale-105 hover:shadow-lg hover:shadow-red-600/30">
							<svg size="20" class="w-5 h-5 fill-current" viewBox="0 0 24 24">
								<path d="M8 5v14l11-7z" /></svg> Watch Now
						</a>
						<div
							onclick="toggleWatchlist('${movie.id}', this); event.preventDefault(); event.stopPropagation();"
							class="flex items-center gap-2 px-8 py-4 rounded font-semibold transition-all duration-300 transform hover:scale-105 cursor-pointer text-white
     							${movie.inWatchlist ? 'bg-green-600 hover:bg-green-700' : 'bg-gray-600/80 hover:bg-gray-600'}">

							<svg size="20" class="w-5 h-5" fill="none" stroke="currentColor"
								stroke-width="2" viewBox="0 0 24 24">
       								 <path
									d="${movie.inWatchlist ? 'M20 6L9 17l-5-5' : 'M12 5v14M5 12h14'}" />
    							</svg>

							<span class="btn-text"> ${movie.inWatchlist ? 'In Your List' : 'Add to List'}
							</span>
						</div>
					</div>
				</div>
			</div>
		</section>

		<%-- 2. CAROUSEL SECTION --%>
		<div class="container mx-auto px-4 -mt-40 relative z-20 pb-20">
			<%-- Changed movies="${movie}" to movies="${allMovies}" --%>
			<app:movie-carousel title="🔥 Trending Now" allmovies="${trendingMovies}" />
			<app:movie-carousel title="⭐ Top Rated" allmovies="${topMovies}" />
			<app:movie-carousel title="🆕 New Releases" allmovies="${newMovies}" />

		</div>
	</c:if>

	<c:if test="${empty movie}">
		<div
			class="bg-black text-white h-screen flex items-center justify-center">
			<p class="text-2xl">No movies found. Total Count: ${totalCount}</p>
		</div>
	</c:if>
</app:layout>
<app:footer />