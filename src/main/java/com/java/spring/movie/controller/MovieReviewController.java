package com.java.spring.movie.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.spring.movie.controller.input.ReviewRequest;
import com.java.spring.movie.model.entity.Review;
import com.java.spring.movie.model.repo.service.MovieReviewService;

@Controller
@RequestMapping("/reviews")
public class MovieReviewController {

    @Autowired
    private MovieReviewService reviewService;

    @PostMapping("/add")
    @ResponseBody
    public ResponseEntity<?> addReview(@RequestBody ReviewRequest request) {

        String username = SecurityContextHolder.getContext()
                .getAuthentication().getName();

        Review review = new Review();
        review.setAuthor(username);
        review.setRating(request.getRating());
        review.setContent(request.getContent());

        reviewService.saveReview(review, request.getMovieId());

        return ResponseEntity.ok("{\"message\":\"Review posted!\"}");
    }
}
