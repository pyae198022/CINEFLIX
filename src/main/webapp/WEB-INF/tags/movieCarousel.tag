<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="allmovies" required="true" type="java.util.List" %>

<section class="py-8">
    <%-- Header with Navigation --%>
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-white">${title}</h2>
        
        <div class="flex items-center gap-2">
            <button
                onclick="scrollCarousel('${title.replaceAll('[^a-zA-Z0-9]', '')}', 'left')"
                class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center transition-all border border-white/5"
            >
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M15 18l-6-6 6-6"/></svg>
            </button>
            <button
                onclick="scrollCarousel('${title.replaceAll('[^a-zA-Z0-9]', '')}', 'right')"
                class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center transition-all border border-white/5"
            >
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24"><path d="M9 18l6-6-6-6"/></svg>
            </button>
        </div>
    </div>

    <%-- Carousel Container --%>
    <div
        id="carousel-${title.replaceAll('[^a-zA-Z0-9]', '')}"
        class="flex overflow-x-auto gap-4 md:gap-6 scroll-smooth no-scrollbar -mx-4 px-4"
        style="scrollbar-width: none; -ms-overflow-style: none;"
    >
        <c:forEach var="m" items="${allmovies}">
            <div class="min-w-[180px] md:min-w-[240px] group cursor-pointer transition-transform duration-500 hover:scale-105">
                <div class="relative aspect-[2/3] rounded-xl overflow-hidden shadow-2xl mb-3 border border-white/10">
                    <img 
                        src="${pageContext.request.contextPath}/static/movies/${m.poster}" 
                        alt="${m.title}"
                        class="w-full h-full object-cover"
                    />

                    <%-- Rating Badge (Top Right) --%>
                    <div class="absolute top-2 right-2 bg-black/60 backdrop-blur-md px-2 py-1 rounded-md flex items-center gap-1 border border-white/10">
                        <svg class="w-3 h-3 text-yellow-500 fill-current" viewBox="0 0 24 24">
                            <path d="M12 17.27L18.18 21l-1.64-7.03L22 9.24l-7.19-.61L12 2 9.19 8.63 2 9.24l5.46 4.73L5.82 21z"/>
                        </svg>
                        <span class="text-white text-[11px] font-bold">${m.rating}</span>
                    </div>

                    <%-- Hover Play Button Overlay --%>
                    <div class="absolute inset-0 bg-gradient-to-t from-black/80 via-transparent to-transparent opacity-0 group-hover:opacity-100 transition-all duration-300 flex items-center justify-center">
                        <div class="bg-red-600 text-white p-3 rounded-full scale-75 group-hover:scale-100 transition-transform duration-300 shadow-xl">
                             <svg class="w-6 h-6 fill-current" viewBox="0 0 24 24"><path d="M8 5v14l11-7z"/></svg>
                        </div>
                    </div>
                </div>
                
                <%-- Movie Metadata --%>
                <h3 class="font-bold text-white text-sm md:text-base truncate drop-shadow-md">
                    <c:out value="${m.title}" />
                </h3>
                <div class="flex items-center gap-2 text-xs text-gray-400 mt-1">
                    <span>${m.year}</span>
                    <span>•</span>
                    <span class="truncate">
                        <c:forEach var="g" items="${m.genre}" varStatus="status">
                            ${g}${!status.last ? ', ' : ''}
                        </c:forEach>
                    </span>
                </div>
            </div>
        </c:forEach>
    </div>
</section>

<script>
    function scrollCarousel(id, direction) {
        const carousel = document.getElementById('carousel-' + id);
        const scrollAmount = window.innerWidth < 768 ? 220 : 400;
        carousel.scrollBy({ 
            left: direction === 'left' ? -scrollAmount : scrollAmount, 
            behavior: 'smooth' 
        });
    }
</script>