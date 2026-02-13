package com.java.spring.movie.controller.output;

import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class MovieSearchDto{

	private String id;
    private String title;
    private int year;
    private String poster;
    private List<String> genre;
}
