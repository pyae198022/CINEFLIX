package com.java.spring.movie.model.repo.service;

import org.springframework.security.core.userdetails.User;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import com.java.spring.movie.model.repo.AccountRepo;

import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class CustomUserDetailsService implements UserDetailsService {

	private final AccountRepo accountRepo;

	@Override
	public UserDetails loadUserByUsername(String email) throws UsernameNotFoundException {

		var account = accountRepo.findByEmail(email)
				.orElseThrow(() -> new UsernameNotFoundException("User not found"));

		return User.builder().username(account.getEmail()).password(account.getPassword())
				.authorities(account.getRole().name()).build();
	}
}
