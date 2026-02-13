package com.java.spring.movie.controller;

import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.context.HttpSessionSecurityContextRepository;
import org.springframework.stereotype.Controller;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import com.java.spring.movie.controller.input.SignUpForm;
import com.java.spring.movie.exception.AppBussinessException;
import com.java.spring.movie.model.repo.service.SignUpService;

import jakarta.servlet.http.HttpServletRequest;
import lombok.RequiredArgsConstructor;

@Controller
@RequestMapping("signup")
@RequiredArgsConstructor
public class SignUpController {
	
	private final AuthenticationManager authenticationManager;
	
	private final SignUpService signUpService;

	@GetMapping
	String signUp() {
		return "signup";
	}
	
	@PostMapping
	String signUp(HttpServletRequest request,
			SignUpForm form,
			BindingResult result
			) {
		
		if(result.hasErrors()) {
			return "signup";
		}
		
		try {
			
			signUpService.createAccount(form);
			
			var authencation = authenticationManager.authenticate(form.getToken());
			
			var securityContext = SecurityContextHolder.getContext();
			securityContext.setAuthentication(authencation);
			
			var session = request.getSession(true);
			session.setAttribute(HttpSessionSecurityContextRepository.SPRING_SECURITY_CONTEXT_KEY, securityContext);
			
			return "redirect:/movie";
			
		} catch (AppBussinessException e) {
			result.rejectValue("email", null, e.getMessage());
			return "signup";
			
		}
	}
	
	@ModelAttribute("form")
	SignUpForm signUpForm() {
		return new SignUpForm();
	}
	
}
