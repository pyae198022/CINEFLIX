package com.java.spring.movie.controller;

import java.io.IOException;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("admin")
@RequiredArgsConstructor
public class AdminMovieController {
	
	private final MovieService movieService;

    @GetMapping
    String adminPage(ModelMap model) {
        model.addAttribute("allmovies", movieService.findAllMovie());
        return "admin-page";
    }
    
    
    @PostMapping("/movie/add")
    @ResponseBody
    public ResponseEntity<?> addMovie(
            @RequestParam String title,
            @RequestParam Integer year,
            @RequestParam Double rating,
            @RequestParam String duration,
            @RequestParam String genre,
            @RequestParam String description,
            @RequestParam String director,
            @RequestParam String trailerUrl,
            @RequestParam(required = false) MultipartFile posterFile,
            @RequestParam(required = false) String posterUrl // must match service
    ) throws IOException {
        movieService.saveMovie(null, title, year, rating, duration,
                genre, description, director, trailerUrl, posterFile, posterUrl);
        return ResponseEntity.ok().build();
    }

    @PostMapping("/movie/update")
    @ResponseBody
    public ResponseEntity<?> updateMovie(
            @RequestParam String id,
            @RequestParam String title,
            @RequestParam Integer year,
            @RequestParam Double rating,
            @RequestParam String duration,
            @RequestParam String genre,
            @RequestParam String description,
            @RequestParam String director,
            @RequestParam String trailerUrl,
            @RequestParam(required = false) MultipartFile posterFile,
            @RequestParam(required = false) String posterUrl // must match service
    ) throws IOException {
        movieService.saveMovie(id, title, year, rating, duration,
                genre, description, director, trailerUrl, posterFile, posterUrl);
        return ResponseEntity.ok().build();
    }
    

    @PostMapping("/movie/delete")
    @ResponseBody
    public ResponseEntity<?> deleteMovie(@RequestParam("id") String id) {
        try {
            movieService.deleteMovie(id);
            return ResponseEntity.ok().build(); 
        } catch (Exception e) {
            // Log the error to your console so you can see why it failed
            e.printStackTrace(); 
            return ResponseEntity.internalServerError().body(e.getMessage());
        }
    }

}
