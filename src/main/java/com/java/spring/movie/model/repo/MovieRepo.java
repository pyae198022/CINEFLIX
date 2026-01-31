package com.java.spring.movie.model.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.spring.movie.model.entity.Movie;

public interface MovieRepo extends JpaRepository<Movie, String>{

}
