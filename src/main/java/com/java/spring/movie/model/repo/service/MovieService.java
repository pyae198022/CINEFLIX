package com.java.spring.movie.model.repo.service;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;

import org.springframework.stereotype.Service;

import com.java.spring.movie.controller.output.MovieSearchDto;
import com.java.spring.movie.model.entity.CastMember;
import com.java.spring.movie.model.entity.Movie;
import com.java.spring.movie.model.entity.Review;
import com.java.spring.movie.model.repo.CastMemberRepo;
import com.java.spring.movie.model.repo.MovieRepo;
import com.java.spring.movie.model.repo.ReviewRepo;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MovieService {

	private final MovieRepo movieRepository;

	private final CastMemberRepo castMemberRepository;

	private final ReviewRepo reviewRepository;

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
				case "CAST":
					processCast(data);
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

		movieRepository.save(movie);
	}

	private void processGenre(String[] data) {
		String movieId = data[1].trim();
		String genreName = data[2].trim();

		movieRepository.findById(movieId).ifPresent(movie -> {
			if (!movie.getGenre().contains(genreName)) {
				movie.getGenre().add(genreName);
				movieRepository.save(movie);
			}
		});
	}

	private void processCast(String[] data) {
		String movieId = data[2].trim();
		movieRepository.findById(movieId).ifPresent(movie -> {
			CastMember cast = new CastMember();
			cast.setId(data[1].trim());
			cast.setName(data[3].trim());
			cast.setCharacterName(data[4].trim());
			cast.setPhoto(data[5].trim());
			cast.setMovie(movie); // Link to parent
			castMemberRepository.save(cast);
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

	public List<Movie> findSimilarMovies(Movie movie) {
		if (movie.getGenre() == null || movie.getGenre().isEmpty()) {
			return List.of();
		}

		String primaryGenre = movie.getGenre().get(0);

		return movieRepository.findByGenreContaining(primaryGenre).stream()
				.filter(m -> !m.getId().equals(movie.getId())) // Don't show the current movie
				.limit(6)
				.toList();
	}

	  public List<MovieSearchDto> searchByTitleOrGenre(String query) {
	        return movieRepository.searchMovies(query)
	                .stream()
	                .map(m -> new MovieSearchDto(
	                        m.getId(),
	                        m.getTitle(),
	                        m.getYear(),
	                        m.getPoster(),
	                        m.getGenre() // List<String> works here
	                ))
	                .toList();
	    }

}
