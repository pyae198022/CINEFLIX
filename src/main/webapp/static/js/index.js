document.addEventListener('DOMContentLoaded', () => {
	const starContainer = document.getElementById('star-rating-container');
	const ratingInput = document.getElementById('rating-value');
	const textarea = document.getElementById('content');
	const charCount = document.getElementById('char-count');
	const submitBtn = document.getElementById('submit-btn');
	const btnText = document.getElementById('btn-text');
	const form = document.getElementById('review-form');
	const seeAllBtn = document.getElementById('see-all-btn');
	const seeAllText = document.getElementById('see-all-text');
	const seeAllIcon = document.getElementById('see-all-icon');
	let isExpanded = false;

	let currentRating = 0;

	// 1. Create and Inject Stars
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
			if (index < count) {
				s.classList.add('active');
			} else {
				s.classList.remove('active');
			}
		});
	}

	textarea.addEventListener('input', () => {
		const length = textarea.value.length;
		charCount.innerText = `${length} / 1000`;
		validateForm();
	});

	function validateForm() {
		const hasContent = textarea.value.trim().length >= 5;
		const hasRating = currentRating > 0;
		submitBtn.disabled = !(hasContent && hasRating);
	}

	// --- CSRF FIX START ---
	form.addEventListener('submit', async (e) => {
		e.preventDefault();

		// Get CSRF details from the meta tags you added to the JSP
		const csrfToken = document.querySelector('meta[name="_csrf"]')?.getAttribute('content');
		const csrfHeader = document.querySelector('meta[name="_csrf_header"]')?.getAttribute('content');

		const movieId = form.getAttribute('data-movie-id');
		const reviewData = {
			movieId: movieId,
			rating: parseInt(ratingInput.value),
			content: textarea.value.trim()
		};

		submitBtn.disabled = true;
		const originalText = btnText.innerText;
		btnText.innerText = "Posting...";

		try {
			const headers = {
				'Content-Type': 'application/json'
			};

			// Inject the CSRF token into the headers if it exists
			if (csrfHeader && csrfToken) {
				headers[csrfHeader] = csrfToken;
			}

			const response = await fetch(`${window.location.origin}/reviews/add`, {
				method: 'POST',
				headers: headers,
				body: JSON.stringify(reviewData)
			});

			if (response.ok) {
				window.location.reload();
			} else {
				// If the error persists, it might be a security config issue on the backend
				alert("Error: " + response.statusText + " (" + response.status + ")");
				resetButton(originalText);
			}
		} catch (error) {
			console.error("Submission error:", error);
			alert("Network error. Please try again.");
			resetButton(originalText);
		}
	});

	function resetButton(text) {
		submitBtn.disabled = false;
		btnText.innerText = text;
	}

	if (window.lucide) {
		window.lucide.createIcons();
	}


	if (seeAllBtn) {
		seeAllBtn.addEventListener('click', () => {
			const hiddenReviews = document.querySelectorAll('.review-item');
			isExpanded = !isExpanded;

			hiddenReviews.forEach((review, index) => {
				// We only care about items past the first 3 (index 0, 1, 2)
				if (index >= 3) {
					if (isExpanded) {
						review.classList.remove('hidden');
						// Small entry animation
						review.style.opacity = '0';
						setTimeout(() => {
							review.style.transition = 'opacity 0.3s ease';
							review.style.opacity = '1';
						}, 10);
					} else {
						review.classList.add('hidden');
					}
				}
			});

			// Update Button UI
			if (isExpanded) {
				seeAllText.innerText = "Show Less";
				seeAllIcon.style.transform = "rotate(180deg)";
			} else {
				seeAllText.innerText = "See All";
				seeAllIcon.style.transform = "rotate(0deg)";
				// Optional: Scroll back up to the top of the reviews
				document.getElementById('reviews-wrapper').scrollIntoView({ behavior: 'smooth' });
			}
		});
	}
});