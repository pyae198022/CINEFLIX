package com.java.spring.movie.model.repo.service;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.java.spring.movie.controller.input.SignUpForm;
import com.java.spring.movie.exception.AppBussinessException;
import com.java.spring.movie.model.entity.Account;
import com.java.spring.movie.model.entity.Account.Role;
import com.java.spring.movie.model.repo.AccountRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class SignUpService {

	private final AccountRepo accountRepo;
	
	private final PasswordEncoder passwordEncoder;
	
	@Transactional
	public void createAccount(SignUpForm form) {
		
		// check email duplication
		if (accountRepo.countByEmail(form.getEmail()) != 0L) {
			throw new AppBussinessException("Your email is already used.");
		}
		
		// create new user
		var member = new Account();
		member.setEmail(form.getEmail());
		member.setName(form.getName());
		member.setPassword(passwordEncoder.encode(form.getPassword()));
		member.setRole(Role.Member);
		accountRepo.saveAndFlush(member);
	}
}
