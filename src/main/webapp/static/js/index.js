document.addEventListener('DOMContentLoaded', () => {
    const form = document.getElementById('review-form');
    const starContainer = document.getElementById('star-rating-container');
    const ratingInput = document.getElementById('rating-value');
    const textarea = document.getElementById('content');
    const charCount = document.getElementById('char-count');
    const submitBtn = document.getElementById('submit-btn');
    const btnText = document.getElementById('btn-text');
    
    const seeAllBtn = document.getElementById('see-all-btn');
    const seeAllText = document.getElementById('see-all-text');
    const seeAllIcon = document.getElementById('see-all-icon');
    let isExpanded = false;
    let currentRating = 0;

    // --- LOGGED IN LOGIC ---
    if (form && starContainer) {
        // Star Injection
        for (let i = 1; i <= 5; i++) {
            const star = document.createElementNS("http://www.w3.org/2000/svg", "svg");
            star.setAttribute("viewBox", "0 0 24 24");
            star.setAttribute("fill", "none");
            star.setAttribute("stroke", "currentColor");
            star.setAttribute("stroke-width", "2");
            star.classList.add('star-icon');
            star.innerHTML = '<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>';

            star.addEventListener('mouseenter', () => highlightStars(i));
            star.addEventListener('mouseleave', () => highlightStars(currentRating));
            star.addEventListener('click', () => {
                currentRating = i;
                ratingInput.value = i;
                validateForm();
            });
            starContainer.appendChild(star);
        }

        function highlightStars(count) {
            const stars = starContainer.querySelectorAll('.star-icon');
            stars.forEach((s, index) => {
                index < count ? s.classList.add('active') : s.classList.remove('active');
            });
        }

        textarea.addEventListener('input', () => {
            charCount.innerText = `${textarea.value.length} / 1000`;
            validateForm();
        });

        function validateForm() {
            const hasContent = textarea.value.trim().length >= 5;
            const hasRating = currentRating > 0;
            submitBtn.disabled = !(hasContent && hasRating);
        }

        form.addEventListener('submit', async (e) => {
            e.preventDefault();
            const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
            const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');

            submitBtn.disabled = true;
            const originalText = btnText.innerText;
            btnText.innerText = "Posting...";

            try {
                const headers = { 'Content-Type': 'application/json' };
                if (csrfHeader && csrfToken) headers[csrfHeader] = csrfToken;

                const response = await fetch(`${window.location.origin}/reviews/add`, {
                    method: 'POST',
                    headers: headers,
                    body: JSON.stringify({
                        movieId: form.getAttribute('data-movie-id'),
                        rating: parseInt(ratingInput.value),
                        content: textarea.value.trim()
                    })
                });

                if (response.ok) window.location.reload();
                else {
                    alert("Error: " + response.status);
                    submitBtn.disabled = false;
                    btnText.innerText = originalText;
                }
            } catch (error) {
                alert("Network error.");
                submitBtn.disabled = false;
                btnText.innerText = originalText;
            }
        });
    }

    // --- GLOBAL LOGIC ---
    if (seeAllBtn) {
        seeAllBtn.addEventListener('click', () => {
            const hiddenReviews = document.querySelectorAll('.review-item');
            isExpanded = !isExpanded;
            hiddenReviews.forEach((review, index) => {
                if (index >= 3) review.classList.toggle('hidden', !isExpanded);
            });
            seeAllText.innerText = isExpanded ? "Show Less" : "See All";
            seeAllIcon.style.transform = isExpanded ? "rotate(180deg)" : "rotate(0deg)";
        });
    }

    if (window.lucide) window.lucide.createIcons();
});