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
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/../views/css/main.css"/>
<title>Project Tasks</title>
</head>
<body class="body-css" >

	<div class="mt-5 mx-4 mb-3 text-center nav">
		<nav class="navbar navbar-expand-lg navbar-light bg-transparent">
			<button class="navbar-toggler" type="button" data-toggle="collapse"
				data-target="#navbarNav" aria-controls="navbarNav"
				aria-expanded="false" aria-label="Toggle navigation">
				<span class="navbar-toggler-icon"></span>
			</button>
			<div class="collapse navbar-collapse" id="navbarNav">
				<ul class="navbar-nav">
					<li class="m-1 nav-item"><a class="nav-link"
						href="/dashboard">DASHBOARD </a></li>
					<li class="m-1 nav-item"><a class="nav-link"
						href="/projects/new">ADD PROJECT</a></li>
					<li class="m-1 nav-item"><a class="nav-link" href="/">SIGN OUT</a></li>
				</ul>
			</div>
		</nav>
	</div>

	<div class="card container mt-4 p-4 bg-transparent">
		<div class="d-flex col-12 mx-auto justify-content-between">
			<div class="my-3">
				<h1>Project Task</h1>
				<br>
				<h5>Project Title: <c:out value="${project.title}" /></h5>
				<h5>Project Owner: <c:out value="${project.leader.firstName}" /></h5>
			</div>
<!-- 			<div class="my-2 row align-items-center">
			</div> -->
		</div>
		<div class="col-12 mx-auto">
			<form:form action="/projects/${id}/tasks/create" method="post"
				modelAttribute="newTask" class="p-4 bg-transparent text-dark">
				<div class="form-group">
					<form:label path="ticket" class="">Add a task / feature to project scope: </form:label>
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
					<input type="submit" value="Add Task" class="btn btn-outline-dark">
				</p>
			</form:form>
		</div>
		<div class="my-5">
		<h5>Current Task List:</h5>
			<table class="table table-hover ">
				<thead>
					<tr>
						<th>Task / Feature Description</th>
						<th>Added By</th>
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
									<form:form action="/projects/${project.id}/tasks/${task.id}/delete"
									method="delete">
									<!-- <input type="submit" value="Completed" class="btn btn-danger mb-3"> -->
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