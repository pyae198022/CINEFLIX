🎬 Cineflix - Movie Streaming Platform

Cineflix is a high-performance, cinematic web application designed for discovering, tracking, and reviewing movies. Built with a Spring Boot backend and a custom JSP/JSTL frontend, it delivers a modern streaming experience with a dark-themed UI.

🛠️ Tech Stack

Backend: Java 17, Spring Boot 3.x, Spring Data JPA

Database: MySQL 8.0

Frontend: JSP (JavaServer Pages), JSTL, Tailwind CSS

Scripts: Vanilla JavaScript (ES6+)

Data Format: Custom CSV/Text-based Data Loader

✨ Core Features

🎞️ Dynamic Discovery

Hero Section: Dynamically showcases a "Featured Movie" with high-resolution backdrops and metadata.

Interactive Carousels: Smooth, horizontal scrolling categories for Trending, New Releases, and Genres.

📝 User Engagement

My List (Watchlist): A personalized space to save and manage movies for future viewing.

Review System: Real-time feedback loop allowing users to rate films and post text reviews.

Trailer Integration: Embedded YouTube player for instant trailer viewing.

🔍 Advanced Filtering

Sidebar Navigation: Filter movies by genres such as Action, Sci-Fi, Horror, and Crime.

Search & Sort: View "All Movies" sorted by rating or release year.

⚙️ Installation & Setup

1. Clone the Repository:

git clone https://github.com/pyae198022/cineflix.git

2. Database Configuration:

Create a MySQL database named cineflix_db and update your application.properties:
spring.datasource.url=jdbc:mysql://localhost:3306/cineflix_db
spring.datasource.username=YOUR_USERNAME
spring.datasource.password=YOUR_PASSWORD

3. Run the App:
   
mvn spring-boot:run
