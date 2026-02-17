<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>
<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">

<app:layout>
	<div class="min-h-screen bg-[#0a0a0a] text-white">

		<%-- Hero Section: Matches Screenshot Style --%>
		<div class="relative h-[85vh] overflow-hidden">
			<%-- Background Backdrop --%>
			<img
				src="${pageContext.request.contextPath}/static/movies/${movie.poster}"
				alt="${movie.title}" class="w-full h-full object-cover" />

			<%-- Overlay Gradients: Darker for Cineflix feel --%>
			<div
				class="absolute inset-0 bg-gradient-to-t from-[#0a0a0a] via-transparent to-transparent"></div>
			<div
				class="absolute inset-0 bg-gradient-to-r from-[#0a0a0a] via-[#0a0a0a]/60 to-transparent"></div>

			<%-- Back Button --%>
			<a href="${pageContext.request.contextPath}/"
				class="absolute top-28 left-8 z-10 flex items-center gap-2 text-white/70 hover:text-white transition-colors">
				<i data-lucide="arrow-left" class="w-5 h-5"></i> <span>Back</span>
			</a>

			<%-- Movie Info Overlay --%>
			<div class="absolute bottom-20 left-0 right-0 p-8 md:px-16">
				<div class="container mx-auto">
					<h1 class="text-5xl md:text-7xl font-black mb-6 tracking-tight">
						<c:out value="${movie.title}" />
					</h1>

					<%-- Metadata Row --%>
					<div
						class="flex flex-wrap items-center gap-6 text-sm font-medium text-gray-300 mb-6">
						<div class="flex items-center gap-1.5 text-yellow-500">
							<i data-lucide="star" class="w-5 h-5 fill-current"></i> <span
								class="text-white text-lg font-bold">${movie.rating}</span> <span
								class="text-gray-500">/ 10</span>
						</div>
						<div class="flex items-center gap-2">
							<i data-lucide="clock" class="w-4 h-4"></i> <span>${movie.duration}</span>
						</div>
						<div class="flex items-center gap-2">
							<i data-lucide="calendar" class="w-4 h-4"></i> <span>${movie.year}</span>
						</div>
						<c:if test="${not empty movie.director}">
							<span class="text-gray-400">Directed by <span
								class="text-white">${movie.director}</span></span>
						</c:if>
					</div>

					<%-- Genres --%>
					<div class="flex flex-wrap gap-3 mb-8">
						<c:forEach var="g" items="${movie.genre}">
							<span
								class="bg-white/10 backdrop-blur-md px-4 py-1.5 rounded-full text-xs font-bold tracking-wider uppercase border border-white/10">
								${g} </span>
						</c:forEach>
					</div>

					<p
						class="text-gray-300 text-lg max-w-3xl mb-8 leading-relaxed line-clamp-3">
						<c:out value="${movie.description}" />
					</p>

					<%-- Actions: Styled like "Watch Now" and "Add to List" --%>
					<div class="flex items-center gap-4">
						<button
							class="flex items-center gap-3 bg-[#e50914] hover:bg-[#b20710] text-white px-10 py-4 rounded-md font-bold transition-all hover:scale-105 active:scale-95 shadow-lg shadow-red-600/20">
							<i data-lucide="play" class="w-6 h-6 fill-current"></i> Watch Now
						</button>
						<button
							class="flex items-center gap-3 bg-white/10 hover:bg-white/20 backdrop-blur-md text-white border border-white/20 px-10 py-4 rounded-md font-bold transition-all">
							<i data-lucide="plus" class="w-6 h-6"></i> Add to List
						</button>
					</div>
				</div>
			</div>
		</div>
		
		<%-- Content Body --%>
		<div class="container mx-auto px-4 py-12">
			<div class="grid grid-cols-1 lg:grid-cols-3 gap-12">

				<%-- Left Column: Trailer Section (Takes 2/3 of the width) --%>
				<div class="lg:col-span-2">
					<c:if test="${not empty movie.trailerUrl}">
						<section class="mb-12">
							<h2
								class="text-3xl font-bold mb-8 flex items-center gap-3 text-white">
								<span class="w-1.5 h-8 bg-red-600 rounded-full"></span> Trailer
							</h2>
							<div
								class="aspect-video w-full rounded-2xl overflow-hidden border border-white/10 shadow-2xl bg-black">
								<iframe src="${movie.trailerUrl}" class="w-full h-full"
									frameborder="0"
									allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture"
									allowfullscreen></iframe>
							</div>
						</section>
					</c:if>
				</div>

				<%-- Right Column: Review Submission Form (Takes 1/3 of the width) --%>
				<div class="lg:col-span-1 pt-0 lg:pt-16">
					<div class="sticky top-24">
						<app:review-form reviews="${movie.reviews}" movieId="${movie.id}" />
					</div>
				</div>

			</div>

			<%-- Similar Movies: Placed below the Trailer/Review grid --%>
			<c:if test="${not empty similarMovies}">
				<section class="mt-20">
					<app:movie-carousel title="Similar Movies"
						allmovies="${similarMovies}" />
				</section>
			</c:if>
		</div>
	</div>
	
</app:layout>
<app:footer />