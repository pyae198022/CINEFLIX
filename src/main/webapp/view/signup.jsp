<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib prefix="app" tagdir="/WEB-INF/tags"%>
<%@ taglib prefix="sec"
	uri="http://www.springframework.org/security/tags"%>
<%@ taglib prefix="c" uri="jakarta.tags.core"%>
<%@ taglib prefix="sf" uri="http://www.springframework.org/tags/form"%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Sign Up</title>
<!-- Tailwind CSS CDN -->
<script src="https://cdn.tailwindcss.com"></script>
<script>
	tailwind.config = {
		theme : {
			extend : {
				fontFamily : {
					sans : [ 'Inter', 'sans-serif' ],
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
<body
	class="bg-gray-900 flex items-center justify-center min-h-screen p-4">

	<!-- Signup Form Container -->
	<div
		class="bg-gray-800 text-white p-8 rounded-2xl shadow-2xl w-full max-w-md space-y-6">

		<!-- Header -->
		<div class="text-center">
			<h1 class="text-3xl font-bold">Create an Account</h1>
			<p class="text-gray-400 mt-2">Sign up to get started</p>
		</div>

		<!-- Signup Form -->
		<sf:form class="space-y-6" action="signup" method="post"
			modelAttribute="form">
			<!-- Name Input -->
			<!-- Name -->
			<div>
				<label for="name" class="block text-sm font-medium text-gray-300">Name</label>
				<sf:input path="name"
					cssClass="mt-1 block w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-xl
                        focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition duration-300"
					placeholder="Enter Customer Name" />
				<sf:errors path="name" cssClass="text-red-400 text-sm" />
			</div>

			<!-- Email -->
			<div>
				<label for="email" class="block text-sm font-medium text-gray-300">Email
					Address</label>
				<sf:input path="email" type="email"
					cssClass="mt-1 block w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-xl
                        focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition duration-300"
					placeholder="your.email@example.com" />
				<sf:errors path="email" cssClass="text-red-400 text-sm" />
			</div>

			<!-- Password -->
			<div>
				<label for="password"
					class="block text-sm font-medium text-gray-300">Password</label>
				<sf:password path="password"
					cssClass="mt-1 block w-full px-4 py-2 bg-gray-700 border border-gray-600 rounded-xl
                           focus:outline-none focus:border-indigo-500 focus:ring-1 focus:ring-indigo-500 transition duration-300"
					placeholder="••••••••" />
				<sf:errors path="password" cssClass="text-red-400 text-sm" />
			</div>

			<!-- Sign Up Button -->
			<div>
				<button type="submit"
					class="w-full flex justify-center py-2 px-4 border border-transparent rounded-xl shadow-sm text-sm font-semibold text-white bg-indigo-600 hover:bg-indigo-700 focus:outline-none focus:ring-2 focus:ring-offset-2 focus:ring-indigo-500 transition duration-300">
					Sign Up</button>
			</div>
		</sf:form>

		<!-- Or separator -->
		<div class="flex items-center">
			<div class="flex-grow border-t border-gray-600"></div>
			<span class="mx-4 text-gray-400 text-sm">Or</span>
			<div class="flex-grow border-t border-gray-600"></div>
		</div>

		<!-- Social Sign-Up Buttons -->
		<div class="space-y-4">
			<!-- Google Sign Up -->
			<a
				href="${pageContext.request.contextPath }/oauth2/authorization/google"
				class="w-full flex items-center justify-center px-4 py-2 border border-gray-600 rounded-xl shadow-sm text-sm font-medium text-white bg-gray-700 hover:bg-gray-600 transition duration-300">
				<svg class="w-5 h-5 mr-2" fill="currentColor" viewBox="0 0 24 24"
					aria-hidden="true">
                    <path
						d="M12.0003 4.28292C14.1206 4.28292 15.867 5.0933 17.1524 6.33129L19.8665 3.61708C17.7663 1.57322 15.0116 0.449707 12.0003 0.449707C7.30931 0.449707 3.26442 2.80931 1.09675 6.44853L5.16723 9.38792C6.18241 6.27641 8.87524 4.28292 12.0003 4.28292ZM23.4471 11.0003H22.1848V11.0003H12.0003V13.882H18.7845C18.667 15.0232 18.2396 16.1422 17.5516 17.0673L21.0451 19.9863C22.6106 17.817 23.4471 15.0415 23.4471 11.0003Z"
						fill="currentColor" />
                    <path
						d="M5.16723 9.38792L1.09675 6.44853C0.297405 7.82869 -0.0967534 9.40051 -0.0967534 11.0003C-0.0967534 12.5999 0.297405 14.1718 1.09675 15.5519L5.16723 12.6125C4.69742 11.7583 4.41727 10.7428 4.41727 9.69796C4.41727 8.6531 4.69742 7.63756 5.16723 6.78335Z"
						fill="currentColor" />
                    <path
						d="M12.0003 22.8824C8.87524 22.8824 6.18241 20.8889 5.16723 17.7774L1.09675 20.7168C3.26442 24.356 7.30931 26.7156 12.0003 26.7156C15.0116 26.7156 17.7663 25.5921 19.8665 23.5482L17.1524 20.834C15.867 22.072 14.1206 22.8824 12.0003 22.8824ZM19.5312 18.2255C19.8242 17.7884 20.0768 17.2917 20.2741 16.7583L17.5516 17.0673C17.206 17.587 16.7842 18.0676 16.3025 18.5135C15.8208 18.9594 15.284 19.3444 14.7077 19.6644L17.5516 17.0673L19.5312 18.2255Z"
						fill="currentColor" />
                </svg> Sign up with Google
			</a>
		</div>

		<!-- Login Link -->
		<div class="text-center text-sm text-gray-400 mt-4">
			Already have an account? <a
				href="${pageContext.request.contextPath }/authenticate"
				class="font-medium text-indigo-400 hover:text-indigo-300">Sign
				in here</a>
		</div>
	</div>
</body>
</html>