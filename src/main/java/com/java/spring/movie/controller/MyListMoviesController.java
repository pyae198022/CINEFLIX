package com.java.spring.movie.controller;

import java.security.Principal;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.java.spring.movie.model.entity.Movie;
import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("my-lists")
@RequiredArgsConstructor
public class MyListMoviesController {
	
	private final MovieService service;

	// In MyListMovies.java
	@GetMapping("/my-list")
	public String showMyList(ModelMap model, Principal principal) {
	    if (principal != null) {
	        String userId = principal.getName();
	        List<Movie> watchlist = service.getWatchlistForUser(userId);
	        
	        // Mark each movie as 'in watchlist' so the UI displays the checkmark
	        watchlist.forEach(m -> m.setInWatchlist(true)); 
	        
	        model.addAttribute("watchlist", watchlist);
	        model.addAttribute("count", watchlist.size());
	    }
	    return "my-lists";
	}
	
	@PostMapping("watchlist/{movieId}")
	public ResponseEntity<?> toggleWatchlist(@PathVariable String movieId, Principal principal) {
	    if (principal == null) return ResponseEntity.status(HttpStatus.UNAUTHORIZED).build();

	    // Logic in service: If exists in User's watchlist, remove it; else add it.
	    boolean added = service.toggleWatchlist(movieId, principal.getName());
	    
	    Map<String, Object> response = new HashMap<>();
	    response.put("added", added);
	    return ResponseEntity.ok(response);
	}
}
