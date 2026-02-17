<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<meta name="_csrf" content="${_csrf.token}" />
<meta name="_csrf_header" content="${_csrf.headerName}" />


<app:layout title="Admin Dashboard">
	<div class="min-h-screen bg-[#0a0a0a] text-white font-sans">
		<main class="container mx-auto px-4 pt-24 pb-16">
			<%-- Header Section --%>
			<div class="flex items-center justify-between mb-8">
				<div>
					<h1 class="text-3xl font-bold">Admin Dashboard</h1>
					<p class="text-gray-400">Manage your movie catalog</p>
				</div>
				<button onclick="openAddModal()"
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
											class="p-2 hover:bg-white/10 rounded-full"
											data-id="${movie.id}" data-title="${movie.title}"
											data-year="${movie.year}" data-rating="${movie.rating}"
											data-duration="${movie.duration}"
											data-director="${movie.director}"
											data-trailer="${movie.trailerUrl}"
											data-genre="<c:forEach var='g' items='${movie.genre}' varStatus='s'>${g}${!s.last ? ',' : ''}</c:forEach>"
											data-description="${fn:escapeXml(movie.description)}">
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
			class="hidden fixed inset-0 z-[100] flex items-center justify-center p-4 bg-black/90 backdrop-blur-sm">
			<div
				class="bg-[#141414] border border-white/10 w-full max-w-lg max-h-[95vh] overflow-y-auto rounded-xl shadow-2xl relative">

				<%-- Close Button --%>
				<button onclick="closeModal()"
					class="absolute top-4 right-4 text-gray-400 hover:text-white transition-colors">
					<i data-lucide="x" class="w-6 h-6"></i>
				</button>

				<div class="p-6 border-b border-white/10">
					<h2 id="modalTitle" class="text-xl font-bold">Edit Movie</h2>
				</div>

				<form id="movieForm" class="p-6 space-y-5"
					enctype="multipart/form-data">
					<input type="hidden" id="movieId" name="id">

					<%-- Title --%>
					<div>
						<label class="block text-sm font-medium text-gray-300 mb-1.5">Title
							*</label> <input type="text" id="title" name="title" required
							class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 focus:ring-1 focus:ring-red-600 outline-none transition-all">
					</div>

					<%-- Year, Rating, Duration --%>
					<div class="grid grid-cols-3 gap-4">
						<div>
							<label class="block text-sm font-medium text-gray-300 mb-1.5">Year</label>
							<input type="number" id="year" name="year"
								class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">
						</div>
						<div>
							<label class="block text-sm font-medium text-gray-300 mb-1.5">Rating</label>
							<input type="number" step="0.1" id="rating" name="rating"
								class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">
						</div>
						<div>
							<label class="block text-sm font-medium text-gray-300 mb-1.5">Duration</label>
							<input type="text" id="duration" name="duration"
								placeholder="2h 7m"
								class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">
						</div>
					</div>

					<%-- Genre --%>
					<div>
						<label class="block text-sm font-medium text-gray-300 mb-1.5">Genre
							(comma-separated)</label> <input type="text" id="genre" name="genre"
							placeholder="Adventure, Fantasy"
							class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">
					</div>

					<%-- Director --%>
					<div>
						<label class="block text-sm font-medium text-gray-300 mb-1.5">Director</label>
						<input type="text" id="director" name="director"
							class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">
					</div>

					<%-- Description --%>
					<div>
						<label class="block text-sm font-medium text-gray-300 mb-1.5">Description
							*</label>
						<textarea id="description" name="description" rows="4" required
							class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none resize-none"></textarea>
					</div>

					<%-- Poster --%>
					<div>
						<label class="block text-sm font-medium text-gray-300 mb-1.5">Poster</label>
						<div class="space-y-2">
							<input type="file" id="posterFile" name="posterFile"
								accept="image/*"
								class="block w-full text-sm text-gray-400 file:mr-4 file:py-2 file:px-4 file:rounded-md file:border-0 file:bg-white/10 file:text-white hover:file:bg-white/20 cursor-pointer bg-[#0a0a0a] border border-white/10 rounded-md">
							<input type="text" id="posterUrl" name="posterUrl"
								placeholder="Or enter image URL"
								class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">

						</div>
					</div>

					<%-- Trailer --%>
					<div>
						<label class="block text-sm font-medium text-gray-300 mb-1.5">Trailer
							URL</label> <input type="text" id="trailerUrl" name="trailerUrl"
							class="w-full bg-[#0a0a0a] border border-white/10 rounded-md px-4 py-2.5 focus:border-red-600 outline-none">
					</div>

					<%-- Submit Button --%>
					<div class="pt-4">
						<button type="submit" id="saveBtn"
							class="w-full bg-[#e50914] hover:bg-[#b20710] text-white font-bold py-3 rounded-md transition-colors shadow-lg">
							<span id="btnText">Update Movie</span>
						</button>
					</div>
				</form>
			</div>
		</div>
	</div>
</app:layout>

<script>
const modal = document.getElementById('movieModal');
const movieForm = document.getElementById('movieForm');
const btnText = document.getElementById('btnText');
const modalTitle = document.getElementById('modalTitle');

const csrfToken = document.querySelector('meta[name="_csrf"]').content;
const csrfHeader = document.querySelector('meta[name="_csrf_header"]').content;

function openAddModal() {
    movieForm.reset();
    document.getElementById('movieId').value = '';
    modalTitle.innerText = 'Add Movie';
    btnText.innerText = 'Save Movie';
    modal.classList.remove('hidden');
    document.body.style.overflow = 'hidden';
}

function editMovieFromBtn(btn) {
    modal.classList.remove('hidden');
    document.body.style.overflow = 'hidden';

    modalTitle.innerText = 'Edit Movie';
    btnText.innerText = 'Update Movie';

    document.getElementById("movieId").value = btn.dataset.id;
    document.getElementById("title").value = btn.dataset.title;
    document.getElementById("year").value = btn.dataset.year;
    document.getElementById("rating").value = btn.dataset.rating;
    document.getElementById("duration").value = btn.dataset.duration;
    document.getElementById("genre").value = btn.dataset.genre;
    document.getElementById("description").value = btn.dataset.description;
    document.getElementById("director").value = btn.dataset.director || '';
    document.getElementById("trailerUrl").value = btn.dataset.trailer || '';
}

function closeModal() {
    modal.classList.add('hidden');
    document.body.style.overflow = 'auto';
}

movieForm.addEventListener('submit', async (e) => {
    e.preventDefault();

    const formData = new FormData(movieForm);
    const movieId = document.getElementById('movieId').value;

    const url = movieId
        ? '${pageContext.request.contextPath}/admin/movie/update'
        : '${pageContext.request.contextPath}/admin/movie/add';

    try {
        const response = await fetch(url, {
            method: 'POST',
            headers: {
                [csrfHeader]: csrfToken
            },
            body: formData
        });

        if (response.ok) {
            alert("Movie saved successfully!");
            location.reload();
        } else {
            const text = await response.text();
            console.error("Server error:", text);
            alert("Failed to save movie");
        }
    } catch (error) {
        console.error("Error:", error);
        alert("Server error");
    }
});

async function deleteMovie(id) {
    if (!confirm("Are you sure you want to delete this movie?")) return;

    // Use a URLSearchParams to send the ID properly in a POST request
    const params = new URLSearchParams();
    params.append('id', id);

    try {
        const response = await fetch('${pageContext.request.contextPath}/admin/movie/delete', {
            method: 'POST', // Match the Controller mapping
            headers: {
                [csrfHeader]: csrfToken,
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: params
        });

        if (response.ok) {
            alert("Movie deleted successfully");
            location.reload();
        } else {
            const errorText = await response.text();
            console.error("Delete failed:", errorText);
            alert("Failed to delete movie: " + errorText);
        }
    } catch (error) {
        console.error("Delete error:", error);
        alert("Server error occurred while deleting");
    }
}
</script>

