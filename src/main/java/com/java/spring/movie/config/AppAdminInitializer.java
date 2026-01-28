package com.java.spring.movie.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.java.spring.movie.model.entity.Account;
import com.java.spring.movie.model.entity.Account.Role;
import com.java.spring.movie.model.repo.AccountRepo;

import jakarta.transaction.Transactional;

public class AppAdminInitializer {

	@Autowired
	private AccountRepo repo;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Transactional
	@EventListener(classes = ContextRefreshedEvent.class)
	public void init() {

		if(repo.count() == 0L) {
			
			var admin = new Account();
			admin.setName("Admin User");
			admin.setEmail("admin@gmail.com");
			admin.setRole(Role.Admin);
			admin.setPassword(encoder.encode("admin"));
			repo.save(admin);
		}
	}
}
