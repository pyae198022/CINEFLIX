package com.java.spring.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("movie")
public class MovieController {

	@GetMapping
	String allMovie() {
		return "movie-home";
	}
}
