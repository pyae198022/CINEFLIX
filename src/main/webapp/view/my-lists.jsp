<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>

<app:layout title="My Watchlist">
	<main class="container mx-auto px-4 pt-24 pb-16">
		<div
			class="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4 mb-8">
			<div>
				<h1 class="text-3xl font-bold mb-1">My List</h1>
				<p id="movie-count" class="text-gray-500">0 movies saved</p>
			</div>

			<div id="sort-container" class="hidden">
				<select id="sort-by"
					class="border rounded-md p-2 bg-white w-[180px]">
					<option value="date-added">Date Added</option>
					<option value="rating">Rating</option>
					<option value="title">Title</option>
				</select>
			</div>
		</div>

		<div id="empty-state"
			class="hidden flex flex-col items-center justify-center py-20 text-center">
			<div
				class="w-20 h-20 rounded-full bg-gray-200 flex items-center justify-center mb-6">
				<svg xmlns="http://www.w3.org/2000/svg" width="40" height="40"
					viewBox="0 0 24 24" fill="none" stroke="currentColor"
					stroke-width="2" stroke-linecap="round" stroke-linejoin="round"
					class="text-gray-400">
					<rect width="18" height="18" x="3" y="3" rx="2" />
					<path d="m9 8 3 3 3-3" />
					<path d="m9 13 3 3 3-3" /></svg>
			</div>
			<h2 class="text-xl font-semibold mb-2">Your watchlist is empty</h2>
			<p class="text-gray-500 mb-6 max-w-md">Start adding movies you
				want to watch later!</p>
			<a href="/"
				class="bg-black text-white px-6 py-2 rounded-md hover:bg-gray-800">Browse
				Movies</a>
		</div>

		<div id="movie-grid"
			class="grid grid-cols-2 sm:grid-cols-3 md:grid-cols-4 lg:grid-cols-5 xl:grid-cols-6 gap-4">
		</div>
	</main>
</app:layout>