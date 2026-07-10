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
<title>Project Details · DevProjectTracker</title>
</head>
<body class="body-bg">

	<header class="topbar">
		<div class="topbar-inner">
			<a href="/dashboard" class="brand"><span class="brand-dot"></span><span class="brand-text">DevProjectTracker</span></a>
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
			<div class="eyebrow">project</div>
			<h2>Project Details</h2>
		</div>

		<section class="panel">
			<dl class="detail-grid">
				<dt>Project Title</dt>
				<dd>${project.title}</dd>

				<dt>Description</dt>
				<dd>${project.description}</dd>

				<dt>Team Lead</dt>
				<dd>${project.leader.firstName} ${project.leader.lastName}</dd>

				<dt>Project ID</dt>
				<dd class="mono">#00${project.id}-${project.leader.firstName}</dd>

				<dt>Programming Language</dt>
				<dd>${project.language}</dd>

				<dt>Project Phase</dt>
				<dd>
					<span class="chip" data-phase="${project.phase}">${project.phase}</span>
					<c:set var="phaseUpdated" value="${not empty project.updatedAt ? project.updatedAt : project.createdAt}" />
					<span class="mono" style="color:var(--muted)">last updated <fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${phaseUpdated}"/></span>
				</dd>

				<dt>Deployment Date</dt>
				<dd>${project.dueDate}</dd>
			</dl>

			<c:if test="${project.projectJoiners.contains(userLoggedIn) || project.leader.id == userLoggedIn.id }">
				<div class="actions" style="margin-top:24px">
					<a href="/projects/${id}/tasks" class="btn btn-primary btn-sm shimmer">View | Add Tasks</a>
					<c:choose>
						<c:when test="${loggedInUser.id == project.leader.id}">
							<a href="/projects/${project.id}/edit" class="btn btn-secondary btn-sm shimmer">Edit Project</a>
							<form:form action="/projects/${project.id}/delete" method="delete">
								<input type="submit" value="Close Project" class="btn btn-danger btn-sm shimmer">
							</form:form>
						</c:when>
					</c:choose>
				</div>
			</c:if>
		</section>
	</main>

</body>
</html>
