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
<title>Project Tasks</title>
</head>
<body class="body-bg" >

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
					<li class="nav-item mx-3"><a class="nav-link" href="/dashboard"><img src="/views/img/home.svg" title="Dashboard"></a></li>
					<li class="nav-item mx-3"><a class="nav-link" href="/projects/new"><img src="/views/img/plus-circle.svg" title="Add Project"></a></li>
					<li class="nav-item mx-3"><a class="nav-link" href="/"><img src="/views/img/log-out.svg" title="Sign-Out"></a></li>
				</ul>

			</div>
		</nav>
	</div>
	</div>

	<div class="card container mt-4 mb-4 p-4 bg-transparent">
		<div class="d-flex col-12 mx-auto justify-content-between">
			<div class="row">
				<h3>Open Task List</h3>
				<div class="mt-4 row">
					<div class="col-sm-3"><h6>Project Title:</h6></div>
					<div class="col-sm-5"><h6>${project.title}</h6></div>
					<%-- <div class="col-sm-5"><h6><a class="text-decoration-none" href="projects/${project.id}"><c:out value="${project.title}" /></a></h6></div> --%>
				</div>
				<div class="mt-2 row">
					<div class="col-sm-3"><h6>Project Lead By:</h6></div>
					<div class="col-sm-5"><h6>${project.leader.firstName} ${project.leader.lastName}</h6></div>
				</div>
			</div>
		</div>
		<div class="col-12 mx-auto">
			<form:form action="/projects/${id}/tasks/create" method="post"
				modelAttribute="newTask" class="p-4 bg-transparent text-dark">
				<div class="form-group">
					<form:label path="ticket" class="">Add a task / feature to the scope of this project: </form:label>
					<form:errors path="ticket" class="text-danger" />
					<form:textarea path="ticket" class="form-control bg-light" />
				</div>
				<div>
					<form:errors path="creator" class="error" />
					<form:input type="hidden" path="creator" value="${taskCreator.id}"
						class="form-control" />
				</div>
				<div>
					<form:errors path="creator" class="error" />
					<form:input type="hidden" path="projectTask" value="${project.id}"
						class="form-control" />
				</div>
				<p class="d-flex col-9 my-2">
					<input type="submit" value="Add Task" class="shimmer shimmer:hover btn btn-outline-primary mt-1 btn-sm">
				</p>
			</form:form>
		</div>
		<div class="my-5">
		<h5>Current Task List:</h5>
			<table class="table table-hover ">
				<thead>
					<tr>
						<th>Task / Feature Description</th>
						<th>Task Owner</th>
						<th>Date Added</th>
						<th>Action</th>
					</tr>
				<tbody>
					<c:forEach items="${tasks}" var="task">
					<tr>
						<td>${task.ticket}</td>
						<td><c:out value="${task.creator.firstName}" /></td>
						<td><fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${task.createdAt}" /></td>
						<td> 
							<c:if
								test="${task.creator.id == loggedInUser.id || project.leader.id == loggedInUser.id}">
									<form:form action="/projects/${project.id}/tasks/${task.id}/delete" method="delete">
										<input type="submit" class="form-check-input" type="checkbox" value="" id="formCheckDefault">
										<label class="form-check-label" for="formCheckDefault"></label>Complete 
									</form:form>
							</c:if>
						</td>
					<tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>