package com.java.spring.movie.exception;

public class AppBussinessException extends RuntimeException{

	private static final long serialVersionUID = 1L;

	public AppBussinessException(String message) {
		super(message);

	}
}
