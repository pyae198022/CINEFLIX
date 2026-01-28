package com.java.spring.movie.model.repo.service;

import java.io.IOException;

import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

public class AppAuthFailureHandler  implements AuthenticationFailureHandler{

	@Override
	public void onAuthenticationFailure(HttpServletRequest request, HttpServletResponse response,
			AuthenticationException exception) throws IOException, ServletException {
		
		var messaage = switch(exception) {
		case UsernameNotFoundException e -> "Please check login ID";
		case BadCredentialsException e -> "Please check password";
		default -> "Authentication Failed";
        };
        
        response.sendRedirect(request.getContextPath().concat("/login?error=%s".formatted(messaage)));
		}
}
