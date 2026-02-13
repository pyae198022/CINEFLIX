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
	        // Fetch movie from DB
	        var movie = movieService.findById(id);
	        
	        if (movie == null) {
	            return "redirect:/error"; // Handle movie not found
	        }

	        model.addAttribute("movie", movie);
	        return "movie-details"; // This should match your JSP file name
	}
}
