package com.java.spring.movie.model.repo.service;

import java.io.IOException;

import org.springframework.security.core.Authentication;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.oauth2.core.user.OAuth2User;
import org.springframework.security.web.authentication.SimpleUrlAuthenticationSuccessHandler;
import org.springframework.stereotype.Component;

import com.java.spring.movie.model.entity.Account;
import com.java.spring.movie.model.entity.Account.Role;
import com.java.spring.movie.model.repo.AccountRepo;

import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import lombok.RequiredArgsConstructor;

@Component
@RequiredArgsConstructor
public class OAuth2LoginSuccessHandler extends SimpleUrlAuthenticationSuccessHandler{


    private final AccountRepo account;

    @Override
    public void onAuthenticationSuccess(HttpServletRequest request, HttpServletResponse response,
                                        Authentication authentication) throws IOException, ServletException {
        var oAuth2User = (OAuth2User) authentication.getPrincipal();

        String email = oAuth2User.getAttribute("email");
        String name = oAuth2User.getAttribute("name");

        var member = account.findByEmail(email).orElse(null);

        if (member == null) {
            member = new Account();
            member.setName(name);
            member.setPassword(new BCryptPasswordEncoder().encode("oauthUserSecret" + System.currentTimeMillis()));
            member.setEmail(email);
            member.setRole(Role.Member);
            account.save(member);
        }

        response.sendRedirect("/movie");
    }
}
