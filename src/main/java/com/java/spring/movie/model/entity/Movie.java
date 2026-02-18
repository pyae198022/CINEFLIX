package com.java.spring.movie.model.entity;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

import com.java.spring.movie.utility.ViewCountFormatter;

import jakarta.persistence.CascadeType;
import jakarta.persistence.CollectionTable;
import jakarta.persistence.Column;
import jakarta.persistence.ElementCollection;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.OneToMany;
import jakarta.persistence.Table;
import jakarta.persistence.Transient;
import lombok.Data;

@Entity
@Data
@Table(name = "movies")
public class Movie {

    @Id
    private String id;

    private String title;
    private int year;
    private double rating;
    private String duration;
    
    @Column(columnDefinition = "TEXT")
    private String description;
    @Column(name = "view_count")
    private long viewCount = 0L;
    
    private String poster;
    private String backdrop;
    private String trailerUrl;
    private String director;
    
    @Transient 
    private boolean liked;

    // Added for Dislike button highlighting support
    @Transient
    private boolean disliked;
    
    @Transient
    private boolean inWatchlist;
    
    @ElementCollection
    @CollectionTable(name = "movie_genres", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "genre")
    private List<String> genre = new ArrayList<>();

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<CastMember> cast = new ArrayList<>();

    @OneToMany(mappedBy = "movie", cascade = CascadeType.ALL, orphanRemoval = true)
    private List<Review> reviews = new ArrayList<>();
    
    @ElementCollection
    @CollectionTable(name = "movie_likes", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "user_id")
    private Set<String> likedUserIds = new HashSet<>();

    @ElementCollection
    @CollectionTable(name = "movie_dislikes", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "user_id")
    private Set<String> dislikedUserIds = new HashSet<>();
    
    @ElementCollection
    @CollectionTable(name = "movie_watchlist", joinColumns = @JoinColumn(name = "movie_id"))
    @Column(name = "user_id")
    private Set<String> watchlistUserIds = new HashSet<>();
    
    
    
    public String getFormattedLikes() {
        return ViewCountFormatter.format((long) likedUserIds.size());
    }
    
    public int getLikeCount() {
        return likedUserIds.size();
    }

    public int getDislikeCount() {
        return dislikedUserIds.size();
    }
    
    public String getFormattedViews() {
        return ViewCountFormatter.format(this.viewCount);
    }
    
    public boolean isLiked() {
        return liked;
    }

    public boolean isDisliked() {
        return disliked;
    }

}

