package com.java.spring.movie.model.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.spring.movie.model.entity.Review;

public interface ReviewRepo extends JpaRepository<Review, String>{

}
