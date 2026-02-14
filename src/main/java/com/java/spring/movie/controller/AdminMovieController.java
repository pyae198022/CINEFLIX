package com.java.spring.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminMovieController {

	private final MovieService movieService;
	
	@GetMapping
	String adminPage(ModelMap model) {
		
		var allMovies = movieService.findAllMovie();
		
		if (!allMovies.isEmpty()) {
            model.addAttribute("allmovies", allMovies);
        }

		return "admin-page";
	}
	
}
