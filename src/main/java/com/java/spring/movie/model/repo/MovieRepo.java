package com.java.spring.movie.model.repo;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Modifying;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.transaction.annotation.Transactional;

import com.java.spring.movie.controller.output.MovieSearchDto;
import com.java.spring.movie.model.entity.Movie;

public interface MovieRepo extends JpaRepository<Movie, String> {

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

	@Modifying 
	@Transactional
	@Query("UPDATE Movie m SET m.viewCount = COALESCE(m.viewCount, 0) + 1 WHERE m.id = :id")
	void incrementViewCount(@Param("id") String id);
	
	@Query("SELECT m FROM Movie m JOIN m.watchlistUserIds u WHERE u = :userId")
    List<Movie> findWatchlistByUserId(@Param("userId") String userId);
}
