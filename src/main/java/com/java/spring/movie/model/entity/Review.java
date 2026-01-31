package com.java.spring.movie.model.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "reviews")
public class Review {

    @Id
    private String id;

    private String author;
    private double rating;

    @Column(columnDefinition = "TEXT")
    private String content;

    private String date; // In production, consider using LocalDate or LocalDateTime

    @ManyToOne
    @JoinColumn(name = "movie_id")
    private Movie movie;

}