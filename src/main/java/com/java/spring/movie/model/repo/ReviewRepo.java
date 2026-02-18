package com.java.spring.movie.model.repo;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;

import com.java.spring.movie.model.entity.Review;

public interface ReviewRepo extends JpaRepository<Review, String>{

	@Query("SELECT AVG(r.rating) FROM Review r WHERE r.movie.id = :movieId")
    Double getAverageRating(@Param("movieId") String movieId);
}
