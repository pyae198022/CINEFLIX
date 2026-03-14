# 🎬 Cineflix - Movie Streaming Platform

Cineflix is a high-performance, cinematic web application designed for discovering, tracking, and reviewing movies. Built with a **Spring Boot** backend and a custom **JSP/JSTL** frontend, it delivers a modern streaming experience with a dark-themed UI inspired by industry leaders.

## 📸 Screenshots

| Home Page - Hero Section | User Reviews & Ratings & Trailer |
|:---:|:---:|
| ![Home](https://github.com/pyae198022/CINEFLIX/blob/06815962e9421420c7974b096e78499fd85cbddb/Screenshot%202569-03-14%20at%2011.54.20.png?raw=true) | ![Discovery](https://github.com/pyae198022/CINEFLIX/blob/08b42010b2fd7c52606cea57e95b8f61da525f71/Screenshot%202569-03-14%20at%2011.56.10.png?raw=true) |

| Genre Filtering | Movie Details |
|:---:|:---:|
| ![Filters](https://github.com/pyae198022/CINEFLIX/blob/08b42010b2fd7c52606cea57e95b8f61da525f71/Screenshot%202569-03-14%20at%2011.56.26.png?raw=true) | ![Details](https://github.com/pyae198022/CINEFLIX/blob/81544f1d7b97a62e03724a2b9fee8d7f19a36815/Screenshot%202569-03-14%20at%2012.16.48.png) |

| My Profile | Admin Dashoard |
|:---:|:---:|
| ![Reviews](https://github.com/pyae198022/CINEFLIX/blob/08b42010b2fd7c52606cea57e95b8f61da525f71/Screenshot%202569-03-14%20at%2011.57.06.png?raw=true) | ![Search](https://github.com/pyae198022/CINEFLIX/blob/08b42010b2fd7c52606cea57e95b8f61da525f71/Screenshot%202569-03-14%20at%2011.57.53.png?raw=true) |

---

## 🛠️ Tech Stack

* **Backend:** Java 17, Spring Boot 3.x, Spring Data JPA
* **Database:** MySQL 8.0
* **Frontend:** JSP (JavaServer Pages), JSTL, Tailwind CSS
* **Scripts:** Vanilla JavaScript (ES6+)
* **Data Management:** Custom CSV/Text-based Data Loader for bulk movie metadata.

## ✨ Core Features

### 🎞️ Dynamic Discovery
* **Hero Section:** Dynamically showcases a "Featured Movie" with high-resolution backdrops and metadata.
* **Interactive Carousels:** Smooth, horizontal scrolling categories for Trending, New Releases, and Genres.

### 📝 User Engagement
* **My List (Watchlist):** A personalized space to save and manage movies for future viewing.
* **Review System:** Real-time feedback loop allowing users to rate films and post text reviews.
* **Trailer Integration:** Embedded YouTube player for instant trailer viewing without leaving the page.

### 🔍 Advanced Filtering
* **Sidebar Navigation:** Filter movies by specific genres such as Action, Sci-Fi, Horror, and Crime.
* **Search & Sort:** Comprehensive search functionality with options to sort by rating or release year.

## 🚀 Challenges Overcome
* **Complex JSP Layouts:** Implementing a modern, responsive dark-theme UI using Tailwind CSS within a traditional JSP/JSTL environment.
* **Data Consistency:** Building a custom data loader to ensure large datasets from CSV files mapped correctly to MySQL entities via JPA.
* **Dev Environment:** Managed and optimized development on macOS, including custom terminal scripts for port management and Git workflow.

## ⚙️ Installation & Setup

### 1. Clone the Repository
```bash
git clone [https://github.com/pyae198022/cineflix.git](https://github.com/pyae198022/cineflix.git)
cd cineflix
