package com.java.spring.movie.model.repo.service;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.data.jpa.repository.Modifying;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.java.spring.movie.controller.output.MovieSearchDto;
import com.java.spring.movie.exception.AppBussinessException;
import com.java.spring.movie.model.entity.Movie;
import com.java.spring.movie.model.entity.Review;
import com.java.spring.movie.model.repo.MovieRepo;
import com.java.spring.movie.model.repo.ReviewRepo;

import jakarta.servlet.ServletContext;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MovieService {

	private final MovieRepo movieRepository;
	private final ReviewRepo reviewRepository;
	private final ServletContext servletContext;

	@Transactional
	public void importMoviesFromFile(String filePath) {
		try (BufferedReader br = new BufferedReader(new FileReader(filePath))) {
			String line;
			while ((line = br.readLine()) != null) {
				if (line.trim().isEmpty())
					continue;

				String[] data = line.split(",");
				String type = data[0].trim();

				switch (type) {
				case "MOVIE":
					processMovie(data);
					break;
				case "GENRE":
					processGenre(data);
					break;
				case "REVIEW":
					processReview(data);
					break;
				default:
					System.err.println("Unknown type: " + type);
				}
			}
		} catch (IOException e) {
			System.err.println("Error reading movie file: " + e.getMessage());
		}
	}

	private void processMovie(String[] data) {
	    String id = data[1].trim();
	    Movie movie = movieRepository.findById(id).orElse(new Movie());

	    movie.setId(id);
	    movie.setTitle(data[2].trim());
	    movie.setYear(Integer.parseInt(data[3].trim()));
	    movie.setRating(Double.parseDouble(data[4].trim()));
	    movie.setDuration(data[5].trim());
	    movie.setDescription(data[6].trim());
	    movie.setPoster(data[7].trim());
	    movie.setTrailerUrl(data[8].trim());
	    movie.setDirector(data[9].trim());

	    if (movie.getGenre() == null)
	        movie.setGenre(new ArrayList<>());
	    
	    // Safety check for the Long wrapper type
	    if (movie.getViewCount() == 0) {
	        movie.setViewCount(0L); 
	    }
	    
	    movieRepository.save(movie);
	}

	private void processGenre(String[] data) {
	    String movieId = data[1].trim();
	    String genreName = data[2].trim();

	    movieRepository.findById(movieId).ifPresent(movie -> {
	        // Double check viewCount here too in case existing DB data is null
	        if (movie.getViewCount() == 0) movie.setViewCount(0L);
	        
	        if (!movie.getGenre().contains(genreName)) {
	            movie.getGenre().add(genreName);
	            movieRepository.save(movie);
	        }
	    });
	}

	private void processReview(String[] data) {
		String movieId = data[2].trim();
		movieRepository.findById(movieId).ifPresent(movie -> {
			Review review = new Review();
			review.setId(data[1].trim());
			review.setAuthor(data[3].trim());
			review.setRating(Double.parseDouble(data[4].trim()));
			review.setContent(data[5].trim());
			review.setDate(data[6].trim());
			review.setMovie(movie);
			reviewRepository.save(review);
		});
	}

	public List<Movie> findAllMovie() {

		var allMovie = movieRepository.findAll();
		return allMovie;
	}

	public Movie findById(String id) {
		return movieRepository.findById(id).orElse(null);
	}

	public List<MovieSearchDto> searchByTitleOrGenre(String query) {
		return movieRepository.searchMovies(query).stream()
				.map(m -> new MovieSearchDto(m.getId(), m.getTitle(), m.getYear(), m.getPoster(), m.getGenre()
				// works
				)).toList();
	}

	@Transactional
	public void saveMovie(String id, String title, Integer year, Double rating, String duration, String genre,
			String description, String director, String trailerUrl, MultipartFile posterFile, String posterUrl)
			throws IOException {

		Movie movie;
		if (id != null && !id.isBlank()) {
			movie = movieRepository.findById(id).orElseThrow(() -> new AppBussinessException("Movie not found: " + id));
		} else {
			movie = new Movie();
			movie.setId(java.util.UUID.randomUUID().toString());
		}

		movie.setTitle(title);
		movie.setYear(year);
		movie.setRating(rating);
		movie.setDuration(duration);
		movie.setDescription(description);
		movie.setDirector(director);
		movie.setTrailerUrl(trailerUrl);

		if (genre != null && !genre.isBlank()) {
			List<String> genres = Arrays.stream(genre.split(",")).map(String::trim)
					.collect(java.util.stream.Collectors.toCollection(ArrayList::new));
			movie.setGenre(genres);
		}

		if (posterFile != null && !posterFile.isEmpty()) {
			String uploadDir = servletContext.getRealPath("/static/movies/");

			File dir = new File(uploadDir);
			if (!dir.exists()) {
				dir.mkdirs();
			}

			String fileName = System.currentTimeMillis() + "_" + posterFile.getOriginalFilename();
			File saveFile = new File(uploadDir, fileName);

			posterFile.transferTo(saveFile);

			movie.setPoster(fileName);

		} else if (posterUrl != null && !posterUrl.isBlank()) {
			movie.setPoster(posterUrl);
		}

		movieRepository.save(movie);
	}

	@Transactional
	public void deleteMovie(String id) {
		movieRepository.deleteById(id);
	}

	public List<Movie> findSimilarMovies(Movie movie) {
		if (movie.getGenre() == null || movie.getGenre().isEmpty())
			return List.of();

		return movieRepository.findAll().stream().filter(m -> !m.getId().equals(movie.getId()))
				// Checks if there is any overlap between the two genre lists
				.filter(m -> m.getGenre().stream().anyMatch(movie.getGenre()::contains)).limit(6).toList();
	}


	@Transactional
	public Movie getMovieForWatching(String id) {
	    movieRepository.incrementViewCount(id);
	    return movieRepository.findById(id)
	            .orElseThrow(() -> new AppBussinessException("Movie not found: " + id));
	}
	
	public Map<String, String> toggleReaction(String movieId, String userId, String type) {
	    Movie movie = movieRepository.findById(movieId).orElseThrow();
	    Map<String, String> resp = new HashMap<>();

	    if ("like".equals(type)) {
	        if (movie.getLikedUserIds().contains(userId)) {
	            movie.getLikedUserIds().remove(userId);
	            resp.put("liked", "false"); // Match JS 'data.liked'
	        } else {
	            movie.getLikedUserIds().add(userId);
	            movie.getDislikedUserIds().remove(userId);
	            resp.put("liked", "true");
	        }
	        resp.put("disliked", "false");
	    } else if ("dislike".equals(type)) {
	        if (movie.getDislikedUserIds().contains(userId)) {
	            movie.getDislikedUserIds().remove(userId);
	            resp.put("disliked", "false"); // Match JS 'data.disliked'
	        } else {
	            movie.getDislikedUserIds().add(userId);
	            movie.getLikedUserIds().remove(userId);
	            resp.put("disliked", "true");
	        }
	        resp.put("liked", "false");
	    }

	    movieRepository.save(movie);
	    resp.put("likes", movie.getFormattedLikes());
	    return resp;
	}
	
	@Transactional
    public boolean toggleWatchlist(String movieId, String userId) {
        Movie movie = movieRepository.findById(movieId)
                .orElseThrow(() -> new AppBussinessException("Movie not found"));

        boolean added;
        if (movie.getWatchlistUserIds().contains(userId)) {
            movie.getWatchlistUserIds().remove(userId);
            added = false;
        } else {
            movie.getWatchlistUserIds().add(userId);
            added = true;
        }

        movieRepository.save(movie);
        return added;
    }

    /**
     * Fetches all movies that the user has added to their list.
     */
    public List<Movie> getWatchlistForUser(String userId) {
        return movieRepository.findWatchlistByUserId(userId);
    }
}
