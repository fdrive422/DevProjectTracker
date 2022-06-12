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
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="js/app.js" type="text/javascript"></script>
<title>Dashboard</title>
</head>
<body>

	<div
		class="card container d-flex col-12 mx-auto justify-content-between mt-4 mb-4 p-4">
		<div class="d-flex justify-content-between">
			<div class="my-2">
				<h1>Project Dashboard
				</h1>
				<h4>Welcome,<c:out value="${loggedInUser.firstName}" /></h4>	
				<br>
				<h4>Team Projects</h4>
			</div>
			<div class="d-inline my-2">
				<a href="/projects/new" class="btn btn-outline-primary">Add Project</a> <a
					href="/logout" class="btn btn-outline-secondary">Logout</a>
			</div>
		</div>
		<table class="table table-striped table-primary my-3">
			<thead>
				<tr>
					<th>ID</th>
					<th>Project</th>
					<th>Team Lead</th>
					<th>Due Date</th>
					<th>Actions</th>
				</tr>
			<tbody>
				<c:forEach items="${projects}" var="project">
					<tr class="table-light">
						<td>${project.id}</td>
						<td><a href="projects/${project.id}"><c:out
									value="${project.title}" /></a></td>
						<td>${project.leader.firstName}</td>
						<td>${project.dueDate}</td>
						<td><c:if test="${loggedInUser.id != project.leader.id}">
								<c:choose>
									<c:when test="${project.projectJoiners.contains(userLoggedIn)}">
									</c:when>
									<c:otherwise>
										<a href="/projects/${project.id}/join">Join Team</a>
									</c:otherwise>
								</c:choose>
							</c:if></td>
					</tr>
				</c:forEach>
			</tbody>
		</table>

		<div class="col-12 mx-auto">
			<h4 class="my-3">Your Projects</h4>
			<table class="table table-striped table-primary my-3">
				<thead>
					<tr>
						<th>ID</th>
						<th>Project</th>
						<th>Team Lead</th>
						<th>Due Date</th>
						<th class="text-center">Actions</th>
					</tr>
				<tbody>
					<c:forEach items="${projects}" var="project">
						<tr class="table-light">
							<c:if
								test="${project.projectJoiners.contains(userLoggedIn) || loggedInUser.id == project.leader.id}">
								<td>${project.id}</td>
								<td><a href="projects/${project.id}"><c:out
											value="${project.title}" /></a></td>
								<td>${project.leader.firstName}</td>
								<td>${project.dueDate}</td>
								<td class="d-flex justify-content-center"><c:choose>
										<c:when test="${loggedInUser.id == project.leader.id}">
											<a href="/projects/${project.id}/edit" class="mx-1">Edit
												Project</a>
											<%-- 									<form:form action="/projects/${project.id}/delete" method="delete">
										<input type="submit" value="Delete" class="btn btn-danger">
									</form:form> --%>
										</c:when>
										<c:otherwise>
											<a href="/projects/${project.id}/leave">Leave Team</a>
										</c:otherwise>
									</c:choose></td>
							</c:if>
						</tr>
					</c:forEach>
				</tbody>
			</table>
<!-- 			<div class="d-inline-flex row row-cols-1 row-cols-md-3 g-4">
				<div class="col">
					<div class="card h-100"> -->
					<div class="container h-100">
    			<div class="row align-items-center h-100">
        			<div class="col-6 mx-auto">
          				<div class="card h-100 border-primary justify-content-center">
						<c:forEach items="${projects}" var="project">
							<!-- <img src="..." class="card-img-top" alt="..."> -->
							<h5 class="card-title text-center my-3">
								Project: <a href="projects/${project.id}"><c:out
										value="${project.title}" /></a>
							</h5>
							<div class="card-body">
								<p><strong> Description:</strong> ${project.description}</p>
								<p><strong> Owner:</strong> ${project.leader.firstName} ${project.leader.lastName}</p>
								<p><strong> Language:</strong> ${project.language}</p>
								<p><strong> Deploy Date:</strong> ${project.dueDate}</p>
							</div>
							<div class="card-footer">
								<small class="text-muted">Last updated <fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${project.createdAt}" /></small>
							</div>
						</c:forEach>
					</div>
				</div>
			</div>
		</div>
	</div>




</body>
</html>