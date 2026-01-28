<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%@ taglib prefix="app" tagdir="/WEB-INF/tags" %>
<%@ taglib prefix="sec" uri="http://www.springframework.org/security/tags" %>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <!-- Tailwind CSS CDN -->
    <script src="https://cdn.tailwindcss.com"></script>
    <script>
        tailwind.config = {
            theme: {
                extend: {
                    fontFamily: {
                        sans: ['Inter', 'sans-serif'],
                    },
                }
            }
        }
    </script>
    <style>
        body {
            font-family: 'Inter', sans-serif;
        }
    </style>
</head>
<body class="bg-gray-900 flex items-center justify-center min-h-screen p-4">

    <!-- Login Form Container -->
    <div class="bg-gray-800 text-white p-8 rounded-2xl shadow-2xl w-full max-w-md space-y-6">

        <!-- Header -->
        <div class="text-center">
            <h1 class="text-3xl font-bold">Welcome Back</h1>
            <p class="text-gray-400 mt-2">Log in to your account</p>
        </div>

        <!-- Login Form -->
        <form class="space-y-6" method="post">
        
        <c:if test="${param.error ne null}">
			<div class="alert alert-info">${param.error}</div>
		</c:if>
		
        
        <sec:csrfInput/>
            <!-- Email Input -->
            <div>
                <label for="email" class="block text-sm font-medium text-gray-300">Email Address</label>
                <input type="email" id="email" name="username" required class="form-control mt-1 block w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-xl focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition duration-300" placeholder="your.email@example.com">
            </div>

            <!-- Password Input -->
            <div>
                <label for="password" class="block text-sm font-medium text-gray-300">Password</label>
                <input type="password" id="password" name="password" required class="form-control mt-1 block w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-xl focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition duration-300" placeholder="••••••••">
            </div>

            <!-- Remember Me & Forgot Password -->
            <div class="flex items-center justify-between text-sm">
                <div class="flex items-center">
                    <input id="remember-me" name="remember-me" type="checkbox" class="h-4 w-4 text-indigo-600 focus:ring-indigo-500 border-gray-600 rounded-md">
                    <label for="remember-me" class="ml-2 block text-gray-300">Remember me</label>
                </div>
                <a href="#" class="font-medium text-indigo-400 hover:text-indigo-300">Forgot password?</a>
            </div>

            <!-- Sign In Button -->
            <div>
                <button type="submit" class="w-full flex justify-center py-2 px-4 border border-transparent rounded-xl shadow-sm text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-300">
                    Sign in
                </button>
            </div>
        </form>

        <!-- Sign Up Link -->
        <div class="text-center text-sm text-gray-400 mt-4">
            Don't have an account? <a href="${pageContext.request.contextPath }/signup" class="font-medium text-indigo-400 hover:text-indigo-300">Sign up here</a>
        </div>
    </div>
</body>
</html>