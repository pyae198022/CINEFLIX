package com.java.spring.movie.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("my-lists")
public class MyListMovies {

	@GetMapping("allMyLists")
	String allMovies() {
		return "my-lists";
	}
}
