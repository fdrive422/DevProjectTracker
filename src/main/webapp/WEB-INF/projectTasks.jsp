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
<title>Project Tasks</title>
</head>
<body>

	<div class="container border rounded mt-4 p-4">
		<div class="d-flex col-12 mx-auto justify-content-between">
			<div class="my-3">
				<h1>Project Task</h1>
				<br>
				<h5>Project Title: <c:out value="${project.title}" /></h5>
				<h5>Project Owner: <c:out value="${project.leader.firstName}" /></h5>
			</div>
			<div class="my-2 row align-items-center">
				<p><a href="/projects" class="btn btn-outline-secondary mx-1">Return to Dashboard</a> </p>
			</div>
		</div>
		<div class="col-12 mx-auto">
			<form:form action="/projects/${id}/tasks/create" method="post"
				modelAttribute="newTask" class="border rounded p-4 bg-light text-primary">
				<div class="form-group">
					<form:label path="ticket" class="">Add a task / feature to project scope: </form:label>
					<form:errors path="ticket" class="text-danger" />
					<form:textarea path="ticket" class="form-control" />
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
					<input type="submit" value="Add Task" class="btn btn-outline-primary">
				</p>
			</form:form>
		</div>
		<div class="my-5">
		<h5>Current Task List:</h5>
			<table class="table table-striped">
				<thead>
					<tr>
						<th>Task / Feature Description</th>
						<th>Added By</th>
						<th>Date Added</th>
						<th>Status</th>
					</tr>
				<tbody>
					<c:forEach items="${tasks}" var="task">
					<tr>
						<td>${task.ticket}</td>
						<td><c:out value="${task.creator.firstName}" /></td>
						<td><fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${task.createdAt}" /></td>
						<td class="form-check">
  							<input class="form-check-input" type="checkbox" value="" id="formCheckDefault">
 							<label class="form-check-label" for="formCheckDefault"></label>Done? </td>
					<tr>
				</c:forEach>
				</tbody>
			</table>
		</div>
	</div>

</body>
</html>