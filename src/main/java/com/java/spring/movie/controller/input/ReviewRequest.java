package com.java.spring.movie.controller.input;

import lombok.Data;

@Data
public class ReviewRequest {
    private String movieId;
    private double rating;
    private String content;
}
