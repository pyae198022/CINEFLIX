<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib tagdir="/WEB-INF/tags" prefix="app" %>

<%@ attribute name="title" required="true" type="java.lang.String" %>
<%@ attribute name="allmovies" required="true" type="java.util.List" %>

<link rel="stylesheet" href="/static/css/app.css" />


<script src="https://cdn.tailwindcss.com"></script>
<script src="https://unpkg.com/lucide@latest"></script>


<section class="py-8">
    <%-- Header with Navigation --%>
    <div class="flex items-center justify-between mb-6">
        <h2 class="text-2xl font-bold text-white">${title}</h2>
        
        <div class="flex items-center gap-2">
            <button
                onclick="scrollCarousel('${title.replaceAll('[^a-zA-Z0-9]', '')}', 'left')"
                class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center transition-all border border-white/5"
            >
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M15 18l-6-6 6-6"/>
                </svg>
            </button>
            <button
                onclick="scrollCarousel('${title.replaceAll('[^a-zA-Z0-9]', '')}', 'right')"
                class="w-10 h-10 rounded-full bg-white/10 hover:bg-white/20 flex items-center justify-center transition-all border border-white/5"
            >
                <svg class="w-5 h-5 text-white" fill="none" stroke="currentColor" stroke-width="2" viewBox="0 0 24 24">
                    <path d="M9 18l6-6-6-6"/>
                </svg>
            </button>
        </div>
    </div>

    <%-- Carousel Container --%>
    <div
        id="carousel-${title.replaceAll('[^a-zA-Z0-9]', '')}"
        class="flex overflow-x-auto gap-4 md:gap-6 scroll-smooth no-scrollbar -mx-4 px-4"
        style="scrollbar-width: none; -ms-overflow-style: none;" >
        <c:forEach var="m" items="${allmovies}">
            <%-- Use the movie-card.tag here --%>
            <app:movie-card movie="${m }"></app:movie-card>
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
