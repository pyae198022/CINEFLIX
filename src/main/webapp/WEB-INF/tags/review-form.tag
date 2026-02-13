<%@ tag language="java" pageEncoding="UTF-8" %>
<%@ attribute name="reviews" required="false" type="java.util.List" %>
<%@ attribute name="movieId" required="true" type="java.lang.String" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%-- 
    Container matches the width of the Trailer/Cast sections 
    max-w-4xl limits the review width for better readability on large screens
--%>
<div class="w-full">
    <%-- Write a Review Card --%>
    <div class="bg-[#141414] rounded-xl p-6 md:p-8 border border-white/5 mb-12 shadow-2xl">
        <form action="/submitReview" method="post" class="space-y-6">
            <h3 class="text-xl font-bold text-white">Write a Review</h3>
            
            <input type="hidden" name="movieId" value="${movieId}" />

            <%-- Name --%>
            <div class="space-y-2">
                <label for="author" class="text-sm font-medium text-gray-400">Your Name</label>
                <input
                    id="author"
                    name="author"
                    type="text"
                    placeholder="Enter your name"
                    class="w-full bg-[#262626] border-none text-white px-4 py-3 rounded-md focus:ring-2 focus:ring-red-600 outline-none placeholder:text-gray-500"
                    required
                />
            </div>

            <%-- Rating --%>
            <div class="space-y-2">
                <label class="text-sm font-medium text-gray-400">Rating</label>
                <div class="flex items-center gap-2 text-2xl">
                    <c:forEach var="star" begin="1" end="5">
                        <input type="radio" id="star${star}" name="rating" value="${star}" class="hidden peer" required />
                        <label for="star${star}" class="cursor-pointer text-gray-600 hover:text-yellow-500 peer-checked:text-yellow-500 transition-colors">
                            <i data-lucide="star"></i>
                        </label>
                    </c:forEach>
                </div>
            </div>

            <%-- Review Text --%>
            <div class="space-y-2">
                <label for="content" class="text-sm font-medium text-gray-400">Your Review</label>
                <textarea
                    id="content"
                    name="content"
                    placeholder="Share your thoughts about this movie..."
                    class="w-full bg-[#262626] border-none text-white min-h-[120px] p-4 rounded-md focus:ring-2 focus:ring-red-600 outline-none resize-none placeholder:text-gray-500"
                    maxlength="1000"
                    required
                ></textarea>
            </div>

            <button type="submit" class="bg-red-600 hover:bg-red-700 text-white px-8 py-3 rounded font-bold transition-all transform active:scale-95">
                Submit Review
            </button>
        </form>
    </div>

    <%-- Reviews List --%>
    <div class="space-y-4">
        <h3 class="text-2xl font-bold text-white mb-6">Reviews (${not empty reviews ? reviews.size() : 0})</h3>
        
        <c:forEach var="review" items="${reviews}">
            <div class="bg-[#141414] p-6 rounded-xl border border-white/5 flex gap-4 transition-hover hover:border-white/10">
                <div class="w-10 h-10 rounded-full bg-red-600/10 flex items-center justify-center flex-shrink-0">
                    <i data-lucide="user" class="text-red-600 w-5 h-5"></i>
                </div>
                
                <div class="flex-1">
                    <div class="flex justify-between items-center mb-1">
                        <span class="font-bold text-white">${review.author}</span>
                        <div class="flex items-center gap-1 text-yellow-500">
                            <i data-lucide="star" class="w-3 h-3 fill-current"></i>
                            <span class="font-bold text-xs">${review.rating}</span>
                        </div>
                    </div>
                    <p class="text-gray-400 text-sm leading-relaxed mb-2">${review.content}</p>
                    <span class="text-[10px] text-gray-600 uppercase font-medium">${review.date}</span>
                </div>
            </div>
        </c:forEach>
    </div>
</div>