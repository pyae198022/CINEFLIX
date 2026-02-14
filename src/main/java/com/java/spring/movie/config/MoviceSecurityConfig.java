package com.java.spring.movie.config;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.authentication.rememberme.JdbcTokenRepositoryImpl;
import org.springframework.security.web.authentication.rememberme.PersistentTokenRepository;

import com.java.spring.movie.model.repo.service.AppAuthFailureHandler;
import com.java.spring.movie.model.repo.service.OAuth2LoginSuccessHandler;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class MoviceSecurityConfig {
	
	private final OAuth2LoginSuccessHandler oAuth2LoginSuccessHandler;
	
    @Bean
    SecurityFilterChain httpSecurity(HttpSecurity http) throws Exception {

        http.authorizeHttpRequests(req -> {
            req.requestMatchers("/", "/signup", "/login", "/movie/**", "/movie-detail/**", "/static/**", "/error").permitAll();
            req.requestMatchers("/admin/**").hasAuthority("Admin");
            req.requestMatchers("/member/**").hasAnyAuthority("Admin", "Member");
            req.anyRequest().authenticated();
        });
        http.formLogin(login -> {
            login.loginPage("/login");
            login.loginProcessingUrl("/login");
            login.defaultSuccessUrl("/movie", true);
            login.failureHandler(new AppAuthFailureHandler());
        });
        
        http.oauth2Login(oauth -> {
            oauth.loginPage("/login");
            oauth.successHandler(oAuth2LoginSuccessHandler);
        });
        
        http.rememberMe(remember -> remember
                .tokenRepository(tokenRepository(null)) 
                .key("mySecretKey123")                 
                .tokenValiditySeconds(7 * 24 * 60 * 60) 
        );

        http.logout(logout -> logout.logoutSuccessUrl("/movie"));

        return http.build();
    }

    @Bean
    PasswordEncoder passwordEncoder() {
        return new BCryptPasswordEncoder();
    }

    @Bean
    AuthenticationManager authenticationManager(AuthenticationConfiguration config) throws Exception {
        return config.getAuthenticationManager();
    }

	@Bean
	PersistentTokenRepository tokenRepository(DataSource datasource) {
		
		var bean = new JdbcTokenRepositoryImpl();
		bean.setDataSource(datasource);
		// first time only
		//bean.setCreateTableOnStartup(true);
		return bean;
	}

}
