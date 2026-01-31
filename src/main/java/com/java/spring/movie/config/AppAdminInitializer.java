package com.java.spring.movie.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.annotation.PropertySource;
import org.springframework.context.event.ContextRefreshedEvent;
import org.springframework.context.event.EventListener;
import org.springframework.security.crypto.password.PasswordEncoder;

import com.java.spring.movie.model.entity.Account;
import com.java.spring.movie.model.entity.Account.Role;
import com.java.spring.movie.model.repo.AccountRepo;

import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;

@Configuration
@RequiredArgsConstructor
@PropertySource(value = "classpath:/admin-user.properties")
public class AppAdminInitializer {

	@Autowired
	private AccountRepo repo;
	
	@Autowired
	private PasswordEncoder encoder;
	
	@Value("${app.admin.username}")
	private String username;
	
	@Value("${app.admin.email}")
	private String email;
	
	@Value("${app.admin.password}")
	private String password;
	
	@Transactional
	@EventListener(classes = ContextRefreshedEvent.class)
	public void init() {

		if(repo.count() == 0L) {
			
			var admin = new Account();
			admin.setName(username);
			admin.setEmail(email);
			admin.setRole(Role.Admin);
			admin.setPassword(encoder.encode(password));
			repo.save(admin);
		}
	}
}
