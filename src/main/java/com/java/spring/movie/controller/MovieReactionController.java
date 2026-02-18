package com.java.spring.movie.controller;

import java.security.Principal;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@RestController
@RequestMapping("/api/movies")
@RequiredArgsConstructor
public class MovieReactionController {

    private final MovieService movieService;
    @PostMapping("/{movieId}/react")
    public ResponseEntity<?> handleReaction(
            @PathVariable String movieId, 
            @RequestParam String type, 
            Principal principal) {
        
        if (principal == null) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Login required");
        }

        // Returns a map with "likes", "userLiked", and "userDisliked"
        Map<String, String> response = movieService.toggleReaction(movieId, principal.getName(), type);
        return ResponseEntity.ok(response);
    }
    
    
}