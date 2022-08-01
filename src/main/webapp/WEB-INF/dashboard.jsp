<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- for Bootstrap CSS -->
<link rel="stylesheet" href="/webjars/bootstrap/css/bootstrap.min.css" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- My CSS -->
<link rel="stylesheet" href="/../views/css/main.css"/>
<title>Dashboard</title>
</head>
<body class="body-bg">

	<div class="mt-3 text-center ">
		<div class="mx-4 d-flex justify-content-between align-items-center">
			<h1>Developer Project Tracker</h1>
			<p class="mx-3"> Welcome, ${loggedInUser.firstName}</p>
		</div>	
	<div class="mt-2 mx-4 mb-3 text-center nav">
		<nav class="navbar navbar-expand-lg navbar-light bg-transparent">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<%-- <li class="m-1 nav-item"><a class="nav-link" href="/dashboard">DASHBOARD </a></li>
					<li class="m-1 nav-item"><a class="nav-link" href="/projects/new">ADD PROJECT</a></li>
					<li class="m-1 nav-item"><a class="nav-link" href="/">SIGN OUT</a></li> --%>
					<li class="nav-item mx-3"><a class="nav-link" href="/dashboard"><img src="/views/img/home.svg"> </a></li>
					<li class="nav-item mx-3"><a class="nav-link" href="/projects/new"><img src="/views/img/plus-circle.svg"></a></li>
					<li class="nav-item mx-3"><a class="nav-link" href="/"><img src="/views/img/log-out.svg"> </a></li>
				</ul>
			</div>
		</nav>
	</div>
	</div>

	<div
		class="card container d-flex col-12 mx-auto justify-content-between bg-transparent mt-4 mb-4 p-4">
		<div class="d-flex justify-content-between">
			<div class="my-2">
				<h2> Open Project List</h2>
			</div>
		</div>
		
		<!-- TEAM TABLE -->
		<table class="table table-hover table-bg-transparent my-3">
			<thead>
				<tr class="bg-transparent">
					<th>Project</th>
					<th>Team Lead</th>
					<th>Deploy Date</th>
					<th>Actions</th>
				</tr>
			<tbody>
				<c:forEach items="${projects}" var="project">
					<tr class="bg-transparent text-dark">
						<td><a class="text-decoration-none" href="projects/${project.id}"><c:out value="${project.title}" /></a></td>
						<td>${project.leader.firstName}</td>
						<td>${project.dueDate}</td>
						<td><c:if test="${loggedInUser.id != project.leader.id}">
								<c:choose>
									<c:when test="${project.projectJoiners.contains(userLoggedIn)}"> </c:when>
									<c:otherwise>
										<a class="text-decoration-none" href="/projects/${project.id}/join">Join Team</a>
									</c:otherwise>
								</c:choose>
							</c:if>
						</td>
					</tr>
				</c:forEach>
			</tbody>
		</table>
	</div>
	
	<!-- MY PROJECT CARDS -->
	<div class= "card container d-flex col-12 mx-auto justify-content-between bg-transparent mt-4 mb-4 p-4">
		<div class="my-2">
				<h2> ${loggedInUser.firstName}'s Project List</h2>
		<div class= "display-card bg-transparent mx-auto p-5">
		<c:forEach items="${projects}" var="project">
			<c:if
				test="${project.projectJoiners.contains(userLoggedIn) || loggedInUser.id == project.leader.id}">
				<div class="card sml-card bg-transparent col-5 mx-auto mb-4 p-4">
					<div class="row ">
						<div class="col-12">
							<div class="card-block">
								<h4 class="card-title"> <strong>${project.title}</strong></h4>
								<br>
								<p class="card-text"> <strong>Description:</strong> ${project.description} </p>
								<p class="card-text"> <strong>Lead:</strong> ${project.leader.firstName} </p>
								<p class="card-text"> <strong>Deployment:</strong> ${project.dueDate} </p>
								<br> 
								<a href="/projects/${project.id}" class="mb-2 btn btn-outline-primary btn-sm mx-2 ">More Details</a>
								<c:choose>
										<c:when test="${loggedInUser.id == project.leader.id}">
											<%-- <form:form action="/projects/${project.id}/delete" method="delete">
												<input type="submit" value="Close Project" class="btn btn-outline-danger">
											</form:form> --%>
										</c:when>
										<c:otherwise>
											<a href="/projects/${project.id}/leave" class="mb-2 btn btn-outline-secondary btn-sm">Leave Team</a>
										</c:otherwise>
									</c:choose>
							</div>
						</div>
					</div>
				</div>
			</c:if>
		</c:forEach>
		</div>
		</div>
	</div>

</body>
</html>
