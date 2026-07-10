<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<script src="/views/js/theme.js"></script>
<link rel="stylesheet" href="/../views/css/main.css" />
<!-- CDN datepicker (dueDate is a formatted String) -->
<link href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker.css" rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.js"></script>
<title>Edit Project · DevProjectTracker</title>
</head>

<body class="body-bg">

	<header class="topbar">
		<div class="topbar-inner">
			<a href="/dashboard" class="brand"><span class="brand-dot"></span>DevProjectTracker</a>
			<div class="topbar-spacer"></div>
			<span class="avatar">${fn:substring(loggedInUser.firstName, 0, 1)}</span>
			<span class="welcome">Welcome, <strong>${loggedInUser.firstName}</strong></span>
			<nav class="nav">
				<a class="nav-link" href="/dashboard" title="Dashboard" aria-label="Dashboard">
					<svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M3 9l9-7 9 7v11a2 2 0 0 1-2 2H5a2 2 0 0 1-2-2z"></path><polyline points="9 22 9 12 15 12 15 22"></polyline></svg>
				</a>
				<a class="nav-link" href="/projects/new" title="Add Project" aria-label="Add Project">
					<svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><circle cx="12" cy="12" r="10"></circle><line x1="12" y1="8" x2="12" y2="16"></line><line x1="8" y1="12" x2="16" y2="12"></line></svg>
				</a>
				<a class="nav-link" href="/" title="Sign Out" aria-label="Sign Out">
					<svg class="icon" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M9 21H5a2 2 0 0 1-2-2V5a2 2 0 0 1 2-2h4"></path><polyline points="16 17 21 12 16 7"></polyline><line x1="21" y1="12" x2="9" y2="12"></line></svg>
				</a>
				<button type="button" class="icon-btn" data-theme-toggle aria-label="Toggle theme"></button>
			</nav>
		</div>
	</header>

	<main class="page">
		<div class="page-head">
			<div class="eyebrow">edit</div>
			<h2>Edit Project</h2>
		</div>

		<section class="panel">
			<form:form action="/projects/${id}/update" method="put" modelAttribute="editProject" class="form">
				<div class="field">
					<form:label path="title">Project Title</form:label>
					<form:errors path="title" class="error" />
					<form:input path="title" class="input" />
				</div>
				<div class="field">
					<form:label path="description">Project Description</form:label>
					<form:errors path="description" class="error" />
					<form:textarea path="description" class="textarea" rows="3" />
				</div>
				<div class="field">
					<form:label path="language">Project Language</form:label>
					<form:errors path="language" class="error" />
					<form:input path="language" class="input" />
				</div>
				<div class="field">
					<form:label path="phase">Project Phase</form:label>
					<form:errors path="phase" class="error" />
					<form:input path="phase" class="input" />
				</div>
				<div class="field">
					<form:label path="dueDate">Deployment Date</form:label>
					<form:errors path="dueDate" class="error" />
					<form:input type="text" path="dueDate" id="datefield" class="date input" />
				</div>
				<div>
					<form:errors path="leader" class="error" />
					<form:input type="hidden" path="leader" value="${loggedInUser.id}" />
				</div>
				<div class="actions" style="margin-top:8px">
					<a href="/projects" class="btn btn-secondary btn-sm shimmer">Cancel</a>
					<input type="submit" value="Update" class="btn btn-primary btn-sm shimmer">
				</div>
			</form:form>
		</section>
	</main>

</body>

<script type="text/javascript">
	$(".date").datepicker({
		format : "MM d yyyy",
	});
</script>

</html>
