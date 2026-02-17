package com.java.spring.movie.controller;

import java.util.List;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.java.spring.movie.controller.output.MovieSearchDto;
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
            model.addAttribute("movie", movies.get(0));
            
            model.addAttribute("allmovies", movies);
        }

        model.addAttribute("totalCount", movies.size());

        return "movie-home";
    }
    
    @GetMapping("/search")
    @ResponseBody
    public List<MovieSearchDto> searchMovies(@RequestParam String query) {
        return movieService.searchByTitleOrGenre(query);
    }
    
}
