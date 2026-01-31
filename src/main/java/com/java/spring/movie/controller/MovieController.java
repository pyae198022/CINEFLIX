package com.java.spring.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("movie")
public class MovieController {

    private final MovieService movieService;

    @GetMapping
    public String totalMovies(ModelMap model) {
        // Fetch all movies from MySQL
        var movies = movieService.findAllMovie();
        
        // Pick the first movie to display in your JSP Hero section
        if (!movies.isEmpty()) {
            model.addAttribute("movie", movies.get(0));
            
         // NEW: This is for the Carousel section (the whole list)
            model.addAttribute("allmovies", movies);
        }

        // Optional: pass total count if you need it elsewhere
        model.addAttribute("totalCount", movies.size());

        return "movie-home";
    }
}
