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
	<script src="/views/js/theme.js"></script>
	<link rel="stylesheet" href="/../views/css/main.css" />
	<title>Dashboard · DevProjectTracker</title>
</head>

<body class="body-bg">

	<header class="topbar">
		<div class="topbar-inner">
			<a href="/dashboard" class="brand"><span class="brand-dot"></span><span class="brand-text">DevProjectTracker</span></a>
			<div class="topbar-spacer"></div>
			<span class="avatar">${fn:substring(loggedInUser.firstName, 0, 1)}</span>
			<span class="welcome">Welcome, <strong>${loggedInUser.firstName}</strong></span>
			<nav class="nav">
				<a class="nav-link active" href="/dashboard" title="Dashboard" aria-label="Dashboard">
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

	<main class="page stack">

		<!-- OPEN PROJECT LIST -->
		<section class="panel">
			<div class="panel-head">
				<h2>Open Project List</h2>
				<span class="chip-muted chip mono">all projects</span>
			</div>
			<div class="table-wrap">
				<table class="table">
					<thead>
						<tr>
							<th>Project</th>
							<th>Team Lead</th>
							<th>Deploy Date</th>
							<th class="col-actions">Actions</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${projects}" var="project">
							<tr>
								<td>
									<a href="projects/${project.id}" title="click for project details">
										<c:out value="${project.title}" />
									</a>
								</td>
								<td>${project.leader.firstName}</td>
								<td>${project.dueDate}</td>
								<td class="col-actions">
									<c:if test="${loggedInUser.id != project.leader.id}">
										<c:choose>
											<c:when test="${project.projectJoiners.contains(userLoggedIn)}">
												<span class="chip-muted chip mono">joined</span>
											</c:when>
											<c:otherwise>
												<a class="btn btn-secondary btn-sm shimmer" href="/projects/${project.id}/join"
													title="click to join this project and contribute">Join Project</a>
											</c:otherwise>
										</c:choose>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</section>

		<!-- MY PROJECT CARDS -->
		<section class="panel">
			<div class="panel-head">
				<h2>${loggedInUser.firstName}'s Project List</h2>
				<a class="btn btn-primary btn-sm shimmer" href="/projects/new">+ New Project</a>
			</div>
			<div class="card-grid">
				<c:forEach items="${projects}" var="project">
					<c:if test="${project.projectJoiners.contains(userLoggedIn) || loggedInUser.id == project.leader.id}">
						<article class="project-card">
							<h4>${project.title}</h4>
							<p class="meta"><strong>Description:</strong> ${project.description}</p>
							<p class="meta"><strong>Lead:</strong> ${project.leader.firstName}</p>
							<p class="meta"><strong>Deployment:</strong> ${project.dueDate}</p>
							<div class="card-actions">
								<a href="/projects/${project.id}" class="btn btn-secondary btn-sm shimmer"
									title="view project details">More Details</a>
								<c:choose>
									<c:when test="${loggedInUser.id == project.leader.id}">
										<span class="chip mono">lead</span>
									</c:when>
									<c:otherwise>
										<a href="/projects/${project.id}/leave" class="btn btn-danger btn-sm shimmer"
											title="leave this project">Leave Project</a>
									</c:otherwise>
								</c:choose>
							</div>
						</article>
					</c:if>
				</c:forEach>
			</div>
		</section>

	</main>

</body>

</html>
