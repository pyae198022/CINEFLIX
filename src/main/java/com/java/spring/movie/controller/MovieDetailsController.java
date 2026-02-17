package com.java.spring.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("movie-detail")
@RequiredArgsConstructor
public class MovieDetailsController {
	
	private final MovieService movieService;

	@GetMapping
	public String movieDetails(@RequestParam("id") String id, ModelMap model) {
	        var movie = movieService.findById(id);
	        var similarMovies = movieService.findSimilarMovies(movie);
	        
	        if (movie == null) {
	            return "redirect:/error";
	        }

	        model.addAttribute("movie", movie);
	        model.addAttribute("similarMovies", similarMovies);
	        
	        return "movie-details"; 
	}
}
