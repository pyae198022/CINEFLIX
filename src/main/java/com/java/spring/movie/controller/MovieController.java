package com.java.spring.movie.controller;

import java.util.Comparator;
import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.spring.movie.controller.output.MovieSearchDto;
import com.java.spring.movie.model.entity.Movie;
import com.java.spring.movie.model.repo.service.MovieService;

import lombok.RequiredArgsConstructor;

@Controller
@RequiredArgsConstructor
@RequestMapping("movie")
public class MovieController {

    private final MovieService movieService;

    @GetMapping
    public String totalMovies(ModelMap model) {
       
        var movies = movieService.findAllMovie();
        
        if (!movies.isEmpty()) {
        	
        	var featured = movies.stream()
                    .max(Comparator.comparingDouble(m -> m.getLikeCount() * m.getRating()))
                    .orElse(movies.get(0));
            model.addAttribute("movie", featured);
            
         // 1. Trending: Sorted by views or engagement (Example: top 10)
    		List<Movie> trending = movies.stream()
    				.sorted(Comparator.comparingInt(Movie::getLikeCount).reversed())
    				.limit(8)
    				.toList();

    		// 2. New Releases (Year Descending)
    		List<Movie> newReleases = movies.stream()
    				.sorted(Comparator.comparingInt(Movie::getYear).reversed())
    				.limit(8).
    				toList();

    		// 3. Top Rated: Filtered by a rating threshold (e.g., > 4.5)
    		List<Movie> topRated = movies.stream()
    				.filter(m -> m.getRating() >= 4.5) // Direct numerical comparison
    				.sorted(Comparator.comparingDouble(Movie::getRating).reversed()) // Direct sorting
    				.limit(8).
    				toList();
    		model.addAttribute("trendingMovies", trending);
    		model.addAttribute("newMovies", newReleases);
    		model.addAttribute("topMovies", topRated);
        }

    	
        model.addAttribute("totalCount", movies.size());

        return "movie-home";
    }
    
    @GetMapping("/search")
    @ResponseBody
    public List<MovieSearchDto> searchMovies(@RequestParam String query) {
        return movieService.searchByTitleOrGenre(query);
    }
    
    @GetMapping("/watch")
    public String watchMovie(@RequestParam("id") String id, ModelMap model) {
    	
        var movie = movieService.findById(id);
        var similarMovies = movieService.findSimilarMovies(movie);
        var movieViewCount = movieService.getMovieForWatching(id);
        
        model.addAttribute("movie", movie);
        // Fetch other movies for the "Up Next" sidebar
        model.addAttribute("suggestions", similarMovies); 
        model.addAttribute("movieViewCount", similarMovies); 
        return "watch-player";
    }
    
    
    
}
