package com.java.spring.movie.model.entity;

import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Entity
@Data
@Table(name = "cast_members")
public class CastMember {

    @Id
    private String id;

    private String name;
    private String characterName;
    private String photo;

    @ManyToOne
    @JoinColumn(name = "movie_id")
    private Movie movie;

}