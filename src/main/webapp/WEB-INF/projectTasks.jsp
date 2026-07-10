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
<title>Project Tasks · DevProjectTracker</title>
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
			<div class="eyebrow">tasks</div>
			<h2>Open Task List</h2>
		</div>

		<section class="panel">
			<dl class="detail-grid" style="margin-bottom:22px">
				<dt>Project Title</dt>
				<dd>${project.title}</dd>
				<dt>Project Lead By</dt>
				<dd>${project.leader.firstName} ${project.leader.lastName}</dd>
			</dl>

			<form:form action="/projects/${id}/tasks/create" method="post" modelAttribute="newTask" class="form">
				<div class="field">
					<form:label path="ticket">Add a task / feature to the scope of this project</form:label>
					<form:errors path="ticket" class="error" />
					<form:textarea path="ticket" class="textarea" />
				</div>
				<div>
					<form:errors path="creator" class="error" />
					<form:input type="hidden" path="creator" value="${taskCreator.id}" />
				</div>
				<div>
					<form:errors path="creator" class="error" />
					<form:input type="hidden" path="projectTask" value="${project.id}" />
				</div>
				<div class="actions">
					<input type="submit" value="Add Task" class="btn btn-primary btn-sm shimmer">
				</div>
			</form:form>
		</section>

		<section class="panel">
			<div class="panel-head">
				<h3>Current Task List</h3>
			</div>
			<div class="table-wrap">
				<table class="table">
					<thead>
						<tr>
							<th>Task / Feature Description</th>
							<th>Task Owner</th>
							<th>Date Added</th>
							<th class="col-actions">Action</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${tasks}" var="task">
							<tr>
								<td>${task.ticket}</td>
								<td><c:out value="${task.creator.firstName}" /></td>
								<td><fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${task.createdAt}" /></td>
								<td class="col-actions">
									<c:if test="${task.creator.id == loggedInUser.id || project.leader.id == loggedInUser.id}">
										<form:form action="/projects/${project.id}/tasks/${task.id}/delete" method="delete">
											<button type="submit" class="complete-btn" title="mark this task complete">
												<svg class="icon" style="width:16px;height:16px" xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><path d="M22 11.08V12a10 10 0 1 1-5.93-9.14"></path><polyline points="22 4 12 14.01 9 11.01"></polyline></svg>
												complete
											</button>
										</form:form>
									</c:if>
								</td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
		</section>
	</main>

</body>
</html>
