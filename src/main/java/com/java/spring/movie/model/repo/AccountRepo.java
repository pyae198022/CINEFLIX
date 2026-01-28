package com.java.spring.movie.model.repo;

import org.springframework.data.jpa.repository.JpaRepository;

import com.java.spring.movie.model.entity.Account;

public interface AccountRepo extends JpaRepository<Account, Integer>{

	long countByEmail(String email);

}
