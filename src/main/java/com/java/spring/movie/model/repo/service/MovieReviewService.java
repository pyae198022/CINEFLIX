package com.java.spring.movie.model.repo.service;

import java.time.LocalDate;
import java.time.format.DateTimeFormatter;

import org.springframework.stereotype.Service;

import com.java.spring.movie.exception.AppBussinessException;
import com.java.spring.movie.model.entity.Review;
import com.java.spring.movie.model.repo.MovieRepo;
import com.java.spring.movie.model.repo.ReviewRepo;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class MovieReviewService {

    private final ReviewRepo reviewRepository;
    private final MovieRepo movieRepository;

    @Transactional
    public void saveReview(Review review, String movieId) {

        var movie = movieRepository.findById(movieId)
                .orElseThrow(() -> new AppBussinessException("Movie not found"));

        review.setMovie(movie);
        review.setDate(LocalDate.now()
            .format(DateTimeFormatter.ofPattern("dd MMM yyyy")));

        reviewRepository.save(review);
    }

}

