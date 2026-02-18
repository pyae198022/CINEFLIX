<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>

<app:layout title="${movie.title}">
	<div class="min-h-screen bg-[#0f0f0f] text-white pt-24 px-4 md:px-10">
		<div class="container mx-auto mb-6">
			<a
				href="${pageContext.request.contextPath}/movie-detail?id=${movie.id}"
				class="inline-flex items-center gap-2 text-gray-400 hover:text-white transition-colors group">
				<i data-lucide="arrow-left"
				class="w-5 h-5 group-hover:-translate-x-1 transition-transform"></i>
				<span class="text-sm font-medium tracking-wide">Back</span>
			</a>
		</div>

		<div class="container mx-auto grid grid-cols-1 lg:grid-cols-12 gap-6">
			<div class="lg:col-span-8 xl:col-span-9">
				<%-- Video Container --%>
				<div
					class="w-full aspect-video bg-black rounded-xl overflow-hidden shadow-2xl border border-white/5">
					<iframe id="main-player" src="${movie.trailerUrl}?autoplay=1&rel=0"
						class="w-full h-full" frameborder="0"
						allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
						allowfullscreen></iframe>
				</div>

				<%-- Movie Metadata --%>
				<div class="mt-4">
					<h1 class="text-xl md:text-2xl font-bold tracking-tight">${movie.title}</h1>
					<div
						class="flex flex-wrap items-center justify-between mt-3 pb-4 border-b border-white/10 gap-4">
						<div class="flex items-center gap-8">
							<div class="flex items-center gap-2 cursor-pointer group"
								onclick="location.href='${root}/movie'">
								<div
									class="bg-red-600 p-1.5 rounded-lg group-hover:bg-red-700 transition-colors">
									<i data-lucide="play" class="w-6 h-6 text-white fill-current"></i>
								</div>
								<h1 class="text-2xl font-black tracking-tighter text-white">
									CINE<span class="text-red-600">FLIX</span>
								</h1>
							</div>

							<nav class="hidden md:flex items-center gap-6"></nav>
						</div>
						<div
							class="flex items-center bg-[#111111] rounded-full p-1 border border-white/10 w-fit">
							<%-- Like Button --%>
							<button id="like-btn" onclick="sendReaction('like')"
								class="flex items-center gap-2 px-5 py-2 rounded-l-full transition-all border-r border-white/5 group 
              							 ${movie.liked ? 'bg-blue-600/20' : 'hover:bg-white/5'}">
								<i data-lucide="thumbs-up"
									class="w-5 h-5 ${movie.liked ? 'text-blue-500 fill-current' : 'text-gray-400 group-hover:text-white'}"></i>
								<span id="like-count" class="text-white font-bold text-sm">${movie.formattedLikes}</span>
							</button>

							<%-- Dislike Button --%>
							<button id="dislike-btn" onclick="sendReaction('dislike')"
								class="flex items-center px-5 py-2 rounded-r-full transition-all group 
              							 ${movie.disliked ? 'bg-red-600/20' : 'hover:bg-white/5'}">
								<i data-lucide="thumbs-down"
									class="w-5 h-5 ${movie.disliked ? 'text-red-500 fill-current' : 'text-gray-400 group-hover:text-white'}"></i>
							</button>
						</div>
					</div>

					<div class="mt-4 p-4 bg-white/5 rounded-xl border border-white/5">
						<div class="flex gap-3 text-sm font-bold mb-2 text-gray-200">
							<span>${movie.formattedViews} views</span> <span>${movie.year}</span>
							<span class="text-red-500">#${movie.genre[0]}</span>
						</div>
						<p class="text-sm text-gray-300 leading-relaxed">${movie.description}</p>
					</div>
				</div>
			</div>

			<%-- RIGHT COLUMN: Suggestions --%>
			<div class="lg:col-span-4 xl:col-span-3">
				<div
					class="bg-[#111] rounded-xl border border-white/10 overflow-hidden flex flex-col h-[75vh]">
					<div
						class="p-4 border-b border-white/10 bg-[#181818] flex justify-between items-center">
						<div>
							<h3 class="font-bold text-sm">Related Movies</h3>
							<p class="text-[10px] text-gray-400 uppercase tracking-tighter">Up
								Next • Suggestions</p>
						</div>
						<i data-lucide="chevron-down" class="w-4 h-4 text-gray-500"></i>
					</div>
					<div class="flex-1 overflow-y-auto custom-scrollbar p-3 space-y-4">
						<c:forEach var="item" items="${suggestions}">
							<c:if test="${item.id != movie.id}">
								<a
									href="${pageContext.request.contextPath}/movie/watch?id=${item.id}"
									class="flex gap-3 group cursor-pointer p-1 rounded-lg hover:bg-white/5 transition-all">
									<div
										class="relative w-32 h-20 flex-shrink-0 rounded-lg overflow-hidden bg-black border border-white/5">
										<img
											src="${pageContext.request.contextPath}/static/movies/${item.poster}"
											class="w-full h-full object-cover group-hover:scale-110 transition-transform duration-500" />
										<div
											class="absolute bottom-1 right-1 bg-black/80 text-[9px] px-1 rounded font-bold text-white">${item.duration}</div>
									</div>
									<div class="flex-1 min-w-0 flex flex-col justify-center">
										<h4
											class="text-[13px] font-bold line-clamp-2 leading-tight group-hover:text-red-500 transition-colors">${item.title}</h4>
										<p class="text-[11px] text-gray-500 mt-1 truncate">${item.director}</p>
										<div class="flex items-center gap-1 mt-0.5">
											<span class="text-[11px] font-bold text-yellow-500">${item.rating}</span>
											<i data-lucide="star"
												class="w-2.5 h-2.5 fill-current text-yellow-500"></i>
										</div>
									</div>
								</a>
							</c:if>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>
</app:layout>