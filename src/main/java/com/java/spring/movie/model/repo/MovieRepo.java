package com.java.spring.movie.model.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.spring.movie.controller.output.MovieSearchDto;
import com.java.spring.movie.model.entity.Movie;

public interface MovieRepo extends JpaRepository<Movie, String>{

	List<Movie> findByGenreContaining(String primaryGenre);

	@Query("""
	        SELECT m
	        FROM Movie m
	        WHERE LOWER(m.title) LIKE LOWER(CONCAT('%', :query, '%'))
	           OR EXISTS (
	               SELECT g FROM m.genre g WHERE LOWER(g) LIKE LOWER(CONCAT('%', :query, '%'))
	           )
	    """)
	List<Movie> searchMovies(@Param("query") String query);
	
	

}
