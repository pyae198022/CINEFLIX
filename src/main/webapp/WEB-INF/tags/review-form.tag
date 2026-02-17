<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ attribute name="reviews" required="false" type="java.util.List"%>
<%@ attribute name="movieId" required="true" type="java.lang.String"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<meta name="_csrf" content="${_csrf.token}"/>
<meta name="_csrf_header" content="${_csrf.headerName}"/>

<link rel="stylesheet" href="${pageContext.request.contextPath}/static/css/index.css">

<%-- Form Container --%>
<div id="review-container" class="w-full p-0">
    <form id="review-form" data-movie-id="${movieId}" 
          class="bg-[#111111] rounded-2xl p-6 border border-white/10 shadow-2xl transition-all">
        
        <h3 class="text-xl font-bold mb-6 text-white tracking-tight flex items-center gap-2">
            <span class="w-1 h-5 bg-red-600 rounded-full"></span> Write a Review
        </h3>

        <div class="space-y-6">
            <%-- Star Rating --%>
            <div>
                <label class="block text-xs font-bold uppercase tracking-widest mb-3 text-gray-500">Your Rating</label>
                <div class="flex items-center gap-2" id="star-rating-container">
                    <%-- Stars injected by index.js --%>
                </div>
                <input type="hidden" id="rating-value" value="0">
            </div>

            <%-- Textarea --%>
            <div>
                <label for="content" class="block text-xs font-bold uppercase tracking-widest mb-3 text-gray-500">Your Thoughts</label>
                <textarea id="content"
                    placeholder="What did you think of the movie?"
                    class="w-full bg-[#0a0a0a] border border-white/5 rounded-xl p-4 min-h-[140px] focus:ring-1 focus:ring-red-600 focus:border-red-600 outline-none transition-all text-white placeholder-gray-700 resize-none"
                    maxlength="1000"></textarea>
                <div class="flex justify-between items-center mt-2">
                    <p id="char-count" class="text-[10px] font-mono text-gray-600 uppercase">0 / 1000</p>
                </div>
            </div>

            <%-- Red Submit Button --%>
            <button type="submit" id="submit-btn" disabled
                class="w-full bg-red-600 hover:bg-red-700 text-white py-3.5 rounded-xl font-black uppercase tracking-widest text-xs disabled:opacity-20 disabled:grayscale transition-all flex items-center justify-center gap-3 shadow-lg shadow-red-900/20">
                <i data-lucide="send" class="w-4 h-4"></i>
                <span id="btn-text">Post Review</span>
            </button>
        </div>
    </form>
</div>

<%-- Recent Reviews List --%>
<div class="w-full mt-12 space-y-4">
    <%-- Header Section of Reviews --%>
<div class="flex justify-between items-center mb-6">
    <h3 class="text-xl font-bold text-white tracking-tight">
        Recent Reviews <span class="text-gray-600 ml-2 text-sm">(${not empty reviews ? reviews.size() : 0})</span>
    </h3>
    <c:if test="${fn:length(reviews) > 3}">
        <button id="see-all-btn" class="group flex items-center gap-2 text-red-600 text-xs font-bold uppercase tracking-widest hover:text-red-400 transition-all">
            <span id="see-all-text">See All</span>
            <i data-lucide="chevron-down" id="see-all-icon" class="w-4 h-4 transition-transform duration-300"></i>
        </button>
    </c:if>
</div>

    <div id="reviews-wrapper" class="space-y-4">
        <c:forEach var="review" items="${reviews}" varStatus="status">
            <div class="review-item bg-[#111111]/50 p-5 rounded-2xl border border-white/5 flex gap-5 transition-all group ${status.index >= 3 ? 'hidden' : ''}">
                <div class="w-12 h-12 rounded-full bg-gradient-to-br from-red-600/20 to-red-900/40 flex items-center justify-center flex-shrink-0 border border-white/5">
                    <i data-lucide="user" class="text-red-500 w-5 h-5"></i>
                </div>
                <div class="flex-1">
                    <div class="flex justify-between items-center mb-2">
                        <span class="font-bold text-sm text-white group-hover:text-red-500 transition-colors">${review.author}</span>
                        <div class="flex items-center gap-1.5 px-2 py-1 bg-black/40 rounded-lg border border-white/5">
                            <i data-lucide="star" class="w-3 h-3 text-yellow-500 fill-current"></i>
                            <span class="font-black text-xs text-yellow-500">${review.rating}</span>
                        </div>
                    </div>
                    <p class="text-gray-400 text-sm leading-relaxed mb-3 italic">"${review.content}"</p>
                    <span class="text-[9px] text-gray-700 uppercase font-black tracking-widest">${review.date}</span>
                </div>
            </div>
        </c:forEach>
    </div>

    <c:if test="${empty reviews}">
        <div class="text-center py-10 border border-dashed border-white/10 rounded-xl">
            <p class="text-gray-500 italic">No reviews yet. Be the first to share your thoughts!</p>
        </div>
    </c:if>
</div>

<script src="${pageContext.request.contextPath}/static/js/index.js"></script>