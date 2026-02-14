<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<app:layout title="">
	<div class="min-h-screen bg-[#0a0a0a] text-white">
		<main class="container mx-auto px-4 pt-24 pb-16">

			<%-- Header Section --%>
			<div class="flex items-center justify-between mb-8">
				<div>
					<h1 class="text-3xl font-bold">Admin Dashboard</h1>
					<p class="text-gray-400">Manage your movie catalog</p>
				</div>
				<button onclick="openModal()"
					class="flex items-center gap-2 bg-red-600 hover:bg-red-700 text-white px-4 py-2 rounded-lg transition-colors">
					<i data-lucide="plus" class="w-4 h-4"></i> Add Movie
				</button>
			</div>

			<%-- Movies Table --%>
			<div
				class="rounded-lg border border-white/10 bg-black/20 overflow-hidden">
				<table class="w-full text-left border-collapse">
					<thead class="bg-white/5 text-gray-400 text-sm uppercase">
						<tr>
							<th class="p-4 font-medium">Poster</th>
							<th class="p-4 font-medium">Title</th>
							<th class="p-4 font-medium">Year</th>
							<th class="p-4 font-medium">Rating</th>
							<th class="p-4 font-medium">Genre</th>
							<th class="p-4 font-medium text-right">Actions</th>
						</tr>
					</thead>
					<tbody id="movieTableBody" class="divide-y divide-white/5">
						<c:forEach var="movie" items="${allmovies}">
							<tr class="hover:bg-white/5 transition-colors">
								<td class="p-4"><img
									src="${pageContext.request.contextPath}/static/movies/${movie.poster}"
									class="w-12 h-16 object-cover rounded shadow-md" /></td>
								<td class="p-4 font-medium">${movie.title}</td>
								<td class="p-4 text-gray-300">${movie.year}</td>
								<td class="p-4 text-gray-300">${movie.rating}</td>
								<td class="p-4 text-sm text-gray-400"><c:forEach var="g"
										items="${movie.genre}" varStatus="status">
										<c:out value="${g}" />${!status.last ? ', ' : ''}
                   				</c:forEach></td>
								<td class="p-4 text-right">
									<div class="flex items-center justify-end gap-2">
										<button onclick="editMovieFromBtn(this)" 
											data-id="${movie.id}"
											data-title="${movie.title}" 
											data-year="${movie.year}"
											data-rating="${movie.rating}"
											data-duration="${movie.duration}"
											data-genre="<c:forEach var='g' items='${movie.genre}' varStatus='s'>${g}${!s.last ? ',' : ''}</c:forEach>"
											data-description="${fn:escapeXml(movie.description)}"
											>
											<i data-lucide="pencil" class="w-4 h-4"></i>
										</button>
										<button onclick="deleteMovie('${movie.id}')"
											class="p-2 hover:bg-red-500/20 rounded-full text-red-500">
											<i data-lucide="trash-2" class="w-4 h-4"></i>
										</button>
									</div>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</main>

		<%-- Add/Edit Modal --%>
		<div id="movieModal"
			class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/80 backdrop-blur-sm">
			<div
				class="bg-[#141414] border border-white/10 w-full max-w-lg max-h-[90vh] overflow-y-auto rounded-xl shadow-2xl">
				<div
					class="p-6 border-b border-white/10 flex justify-between items-center">
					<h2 id="modalTitle" class="text-xl font-bold">Add Movie</h2>
					<button onclick="closeModal()"
						class="text-gray-400 hover:text-white">
						<i data-lucide="x"></i>
					</button>
				</div>

				<form id="movieForm" class="p-6 space-y-4"
					enctype="multipart/form-data">
					<input type="hidden" id="movieId" name="id">

					<div>
						<label class="block text-sm font-medium mb-1">Title *</label> <input
							type="text" id="title" required
							class="w-full bg-black border border-white/20 rounded px-3 py-2 focus:border-red-500 outline-none">
					</div>

					<div class="grid grid-cols-3 gap-3">
						<div>
							<label class="block text-sm font-medium mb-1">Year</label> <input
								type="number" id="year"
								class="w-full bg-black border border-white/20 rounded px-3 py-2 outline-none">
						</div>
						<div>
							<label class="block text-sm font-medium mb-1">Rating</label> <input
								type="number" step="0.1" id="rating"
								class="w-full bg-black border border-white/20 rounded px-3 py-2 outline-none">
						</div>
						<div>
							<label class="block text-sm font-medium mb-1">Duration</label> <input
								type="text" id="duration" placeholder="2h 30m"
								class="w-full bg-black border border-white/20 rounded px-3 py-2 outline-none">
						</div>
					</div>

					<div>
						<label class="block text-sm font-medium mb-1">Genre
							(comma-separated)</label> <input type="text" id="genre"
							placeholder="Action, Drama"
							class="w-full bg-black border border-white/20 rounded px-3 py-2 outline-none">
					</div>

					<div>
						<label class="block text-sm font-medium mb-1">Description
							*</label>
						<textarea id="description" rows="3" required
							class="w-full bg-black border border-white/20 rounded px-3 py-2 outline-none"></textarea>
					</div>

					<div>
						<label class="block text-sm font-medium mb-1">Poster Image</label>
						<input type="file" id="posterFile" accept="image/*"
							class="w-full text-sm text-gray-400 file:mr-4 file:py-2 file:px-4 file:rounded file:border-0 file:bg-red-600 file:text-white hover:file:bg-red-700">
					</div>

					<div class="pt-4">
						<button type="submit" id="saveBtn"
							class="w-full bg-red-600 hover:bg-red-700 text-white font-bold py-2 rounded transition-colors flex items-center justify-center gap-2">
							<span id="btnText">Save Movie</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</app:layout>
<app:footer></app:footer>

<script>
    const modal = document.getElementById('movieModal');
    const movieForm = document.getElementById('movieForm');
    
    function editMovieFromBtn(btn){

    	openModal();
    	document.getElementById("title").value = btn.dataset.title;
   	    document.getElementById("year").value = btn.dataset.year;
   	    document.getElementById("rating").value = btn.dataset.rating;
   	    document.getElementById("duration").value = btn.dataset.duration;
   	    document.getElementById("genre").value = btn.dataset.genre;
   	    document.getElementById("description").value = btn.dataset.description;
    }

    
    function openModal() {
        movieForm.reset();
        document.getElementById('movieId').value = '';
        document.getElementById('modalTitle').innerText = 'Add Movie';
        modal.classList.remove('hidden');
    }

    function closeModal() {
        modal.classList.add('hidden');
    }

    function editMovie(movie) {
        openModal();
        document.getElementById('modalTitle').innerText = 'Edit Movie';
        document.getElementById('movieId').value = movie.id;
        
        // Fill form fields
        for (const key in movie) {
            const input = movieForm.elements[key];
            if (input && key !== 'posterFile') input.value = movie[key];
        }
    }
    

    movieForm.addEventListener('submit', async (e) => {
        e.preventDefault();
        const formData = new FormData(movieForm);
        const isEdit = !!document.getElementById('movieId').value;
        const url = isEdit ? '${root}/admin/movie/update' : '${root}/admin/movie/add';

        try {
            const response = await fetch(url, {
                method: 'POST',
                body: formData
            });
            
            if (response.ok) {
                location.reload(); // Refresh to see changes
            } else {
                alert("Failed to save movie");
            }
        } catch (error) {
            console.error("Error:", error);
        }
    });

    async function deleteMovie(id) {
        if (!confirm("Are you sure?")) return;
        
        const response = await fetch(`${root}/admin/movie/delete?id=` + id, { method: 'DELETE' });
        if (response.ok) location.reload();
    }
</script>