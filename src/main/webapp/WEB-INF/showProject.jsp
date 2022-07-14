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
<link rel="stylesheet" href="/../views/css/main.css" />
<title>Show Project</title>
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
					<li class="m-1 nav-item"><a class="nav-link" href="/dashboard">DASHBOARD </a></li>
					<li class="m-1 nav-item"><a class="nav-link" href="/projects/new">ADD PROJECT</a></li>
					<li class="m-1 nav-item"><a class="nav-link" href="/">SIGN OUT</a></li>
				</ul>
			</div>
		</nav>
	</div>
	</div>

	<div class="card container mt-4 mb-4 p-4 bg-transparent">
		<div class="d-flex col-12 mx-auto justify-content-between">
			<h2 class="text-dark">Project Details</h2>
		</div>
		<div class="my-3 row align-items-center">
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"> <h6>Project Title:</h6> </div>
				<div class="col-6">${project.title}</div>
			</div>
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"> <h6>Description:</h6> </div>
				<div class="col-6">${project.description}</div>
			</div>
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"> <h6>Team Lead:</h6> </div>
				<div class="col-6">${project.leader.firstName} ${project.leader.lastName}</div>
			</div>
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"> <h6>Project ID:</h6> </div>
				<div class="col-6">#00${project.id}-${project.leader.lastName}</div>
			</div>
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"> <h6>Programing Language:</h6> </div>
				<div class="col-6">${project.language}</div>
			</div>
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"><h6>Project Phase:</h6> </div>
				<div class="col-6"> ${project.phase}, as of <fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${project.updatedAt}"/></div>
			</div>
			<div class="row g-3 mx-2 my-2">
				<div class="col-3"> <h6>Deployment Date:</h6> </div>
				<div class="col-6">${project.dueDate}</div>
			</div>
			<div class="d-flex col-9 my-2">
				<c:if test="${project.projectJoiners.contains(userLoggedIn) || project.leader.id == userLoggedIn.id }">
				<a href="/projects/${id}/tasks" class="btn btn-outline-primary btn-sm mt-4 mx-2">View | Add Tasks</a>
					<c:choose>
					<c:when test="${loggedInUser.id == project.leader.id}">
						<a href="/projects/${project.id}/edit" class="btn btn-outline-primary btn-sm mt-4 mx-2">Edit Project</a>
					<form:form action="/projects/${project.id}/delete" method="delete">
						<input type="submit" value="Close Project" class="mx-2 btn btn-outline-danger btn-sm mt-4">
					</form:form>
					</c:when>
					</c:choose>
				</c:if>
			</div>	
		</div>
	</div>

</body>
</html>

