<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="movie" required="true" type="com.java.spring.movie.model.entity.Movie" %>


<link rel="stylesheet" href="/static/css/app.css" />
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>
<c:set value="${pageContext.request.contextPath}" var="root"
	scope="request"></c:set>

<a href="${root}/movie-detail?id=${movie.id}" 
   class="movie-card flex-shrink-0 w-[200px] md:w-[240px] group block relative cursor-pointer transition-transform duration-300 hover:scale-105 no-underline">
    
    <%-- Poster Container --%>
    <div class="relative aspect-[2/3] rounded-lg overflow-hidden shadow-lg">
        <img src="${pageContext.request.contextPath}/static/movies/${movie.poster}" 
             alt="${movie.title}" 
             class="w-full h-full object-cover" />
        
        <%-- Hover Overlay --%>
        <div class="absolute inset-0 bg-gradient-to-t from-black/90 via-black/40 to-transparent opacity-0 group-hover:opacity-100 transition-opacity duration-300">
            <div class="absolute bottom-0 left-0 right-0 p-4">
                
                <%-- Rating Info --%>
                <div class="flex items-center gap-1 mb-1">
                    <svg class="w-4 h-4 text-yellow-500 fill-current" viewBox="0 0 24 24">
                        <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/>
                    </svg>
                    <span class="text-white font-bold text-sm">${movie.rating}</span>
                </div>

                <%-- Genre List --%>
                <p class="text-[10px] md:text-xs text-gray-300 mb-3 truncate">
                    <c:forEach var="g" items="${movie.genre}" varStatus="status">
                        ${g}${!status.last ? ' • ' : ''}
                    </c:forEach>
                </p>

                <%-- Action UI (Replaced <button> with <div> to fix HTML validation) --%>
                <div class="flex items-center gap-2">
                    <div class="flex-1 flex items-center justify-center gap-1 bg-red-600 hover:bg-red-700 text-white py-2 rounded text-sm font-medium transition-colors">
                        <svg class="w-3 h-3 fill-current" viewBox="0 0 24 24">
                            <path d="M8 5v14l11-7z"/>
                        </svg>
                        Play
                    </div>
                    <div class="w-9 h-9 flex items-center justify-center bg-gray-700/80 hover:bg-gray-600 rounded transition-colors backdrop-blur-sm">	
                        <svg class="w-4 h-4 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                            <path d="M12 5v14M5 12h14" />
                        </svg>
                    </div>
                </div>
            </div>
        </div>

        <%-- Static Rating Badge (Top Right) --%>
        <div class="absolute top-2 right-2 bg-black/70 backdrop-blur-md px-2 py-1 rounded flex items-center gap-1 border border-white/10">
            <svg class="w-3 h-3 text-yellow-500 fill-current" viewBox="0 0 24 24">
                <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/>
            </svg>
            <span class="text-white text-[10px] font-bold">${movie.rating}</span>
        </div>
    </div>

    <%-- Title and Year --%>
    <div class="mt-3 px-1">
        <h3 class="font-semibold text-white truncate text-sm md:text-base">${movie.title}</h3>
        <p class="text-xs md:text-sm text-gray-500">${movie.year}</p>
    </div>
</a>
