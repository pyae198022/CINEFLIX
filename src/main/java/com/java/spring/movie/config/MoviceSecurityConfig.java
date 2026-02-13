package com.java.spring.movie.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;

import com.java.spring.movie.model.repo.service.AppAuthFailureHandler;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class MoviceSecurityConfig {

	private final CustomAunthencationSuccessHandler customAunthencationSuccessHandler;
	

	@Bean
	SecurityFilterChain httpSecurity(HttpSecurity http) throws Exception {
		
		http.authorizeHttpRequests(req -> {
			req.requestMatchers("/" ,"/signup", "/login" ,"/movie/**", "/movie-detail/**", "/static/**" ,"/error").permitAll();
			req.requestMatchers("/admin/**").hasAuthority("Admin");
			req.requestMatchers("/member/**").hasAnyAuthority("Admin", "Member");
			req.anyRequest().authenticated();
		});
		
		http.formLogin(login -> {
			login.loginPage("/login");
			login.successHandler(customAunthencationSuccessHandler); 
			login.failureHandler(new AppAuthFailureHandler());
		});
		
//		http.rememberMe(remember -> {
//			remember.tokenRepository(tokenRepository);
//		});
	
		
		http.logout(logout -> {
			logout.logoutSuccessUrl("/movie");
		});
		return http.build();
	}
	
	@Bean
	PasswordEncoder encoder() {
		return new BCryptPasswordEncoder();
	}
	
	@Bean
	AuthenticationManager authenticationManager(AuthenticationConfiguration configurer) throws Exception {
        return configurer.getAuthenticationManager();
    }	
//	
//	// Remember Me
//	@Bean
//	PersistentTokenRepository tokenRepository(DataSource datasource) {
//		
//		var bean = new JdbcTokenRepositoryImpl();
//		bean.setDataSource(datasource);
//		// first time only
//		//bean.setCreateTableOnStartup(true);
//		return bean;
//	}
	
}
