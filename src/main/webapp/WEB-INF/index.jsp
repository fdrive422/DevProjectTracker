<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ page isErrorPage="true" %>
<!DOCTYPE html>
<html lang="en">

<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<!-- Apply saved theme before first paint (no flash) -->
	<script src="/views/js/theme.js"></script>
	<!-- My CSS -->
	<link rel="stylesheet" href="/../views/css/main.css" />
	<title>Sign in · DevProjectTracker</title>
</head>

<body class="body-bg">

	<button type="button" class="icon-btn toggle-floating" data-theme-toggle aria-label="Toggle theme"></button>

	<main class="auth-wrap">
		<div class="auth-hero">
			<div class="eyebrow">dev · project · tracker</div>
			<h1>Developer Project Tracker</h1>
			<p>Track the status of software projects through deployment.</p>
		</div>

		<div class="auth-grid">
			<div class="card auth-card">
				<form:form action="/register" method="post" modelAttribute="newUser" class="form">
					<h2>Register</h2>
					<div class="field">
						<form:label path="firstName">First Name</form:label>
						<form:errors path="firstName" class="error" />
						<form:input path="firstName" type="text" class="input" />
					</div>
					<div class="field">
						<form:label path="lastName">Last Name</form:label>
						<form:errors path="lastName" class="error" />
						<form:input path="lastName" type="text" class="input" />
					</div>
					<div class="field">
						<form:label path="email">Email</form:label>
						<form:errors path="email" class="error" />
						<form:input path="email" type="email" class="input" />
					</div>
					<div class="field">
						<form:label path="password">Password</form:label>
						<form:errors path="password" class="error" />
						<form:password path="password" class="input" />
					</div>
					<div class="field">
						<form:label path="confirm">Confirm Password</form:label>
						<form:errors path="confirm" class="error" />
						<form:password path="confirm" class="input" />
					</div>
					<input type="submit" value="Register" class="btn btn-primary shimmer">
				</form:form>
			</div>

			<div class="card auth-card">
				<form:form action="/login" method="post" modelAttribute="newLogin" class="form">
					<h2>Login</h2>
					<div class="field">
						<form:label path="userEmail">Email</form:label>
						<form:errors path="userEmail" class="error" />
						<form:input path="userEmail" type="email" class="input" />
					</div>
					<div class="field">
						<form:label path="userPassword">Password</form:label>
						<form:errors path="userPassword" class="error" />
						<form:password path="userPassword" class="input" />
					</div>
					<input type="submit" value="Login" class="btn btn-primary shimmer">
				</form:form>
			</div>
		</div>
	</main>

</body>

</html>
