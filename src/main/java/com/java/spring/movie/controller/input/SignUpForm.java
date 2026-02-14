package com.java.spring.movie.controller.input;

import jakarta.validation.constraints.NotBlank;
import lombok.Data;

@Data
public class SignUpForm {

	@NotBlank(message = "Please Eneter member name")
	private String name;
	
	@NotBlank(message = "Please Eneter member email")
	private String email;
	
	@NotBlank(message = "Please Eneter member password")
	private String password;
	
}
