package com.java.spring.movie.model;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.core.io.ClassPathResource;
import org.springframework.stereotype.Component;

import com.java.spring.movie.model.repo.service.MovieService;

@Component
public class DataLoader implements CommandLineRunner{

	
	@Autowired
	private MovieService movieService;

	public DataLoader(MovieService movieService) {
        this.movieService = movieService;
    }

    @Override
    public void run(String... args) throws Exception {
        // 1. Get the movie.txt file from resources
        String filePath = new ClassPathResource("movies.txt").getFile().getAbsolutePath();
        
        // 2. Clear existing data if necessary or just run the import
        movieService.importMoviesFromFile(filePath);
    }
}
