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
<!-- for Boostrap CSS specifically for the table -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="/../views/css/main.css"/>

<!-- For any Bootstrap that uses JS or jQuery-->
<script type="text/javascript" src="js/app.js"></script>
<script src="/webjars/jquery/jquery.min.js"></script>
<script src="/webjars/bootstrap/js/bootstrap.min.js"></script>
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/css/bootstrap-datepicker.css"
	rel="stylesheet" />
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.9.1/jquery.js"></script>
<script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.0.0/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap-datepicker/1.5.0/js/bootstrap-datepicker.js"></script>
<title>Edit Project</title>
</head>

<body class="body-css">

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


	<div class="card container bg-transparent mt-4 mb-4 p-4">
		<div class="d-flex col-12 mx-auto justify-content-between">
			<div class="my-3">
				<h1>Edit Project</h1>
			</div>
		</div>
		<div class="col-12 mx-auto">
			<form:form action="/projects/${id}/update" method="put"
				modelAttribute="editProject" class="p-4 bg-transparent text-dark">
				<div class="form-group">
					<form:label path="title" class="py-2">Project Title: </form:label>
					<form:errors path="title" class="text-danger" />
					<form:input path="title" class="form-control" />
				</div>
				<div class="form-group">
					<form:label path="description" class="py-2">Project Description: </form:label>
					<form:errors path="description" class="text-danger" />
					<form:textarea path="description" class="form-control h-25"
						rows="3" />
				</div>
				<div class="form-group">
					<form:label path="language" class="py-2">Project Language: </form:label>
					<form:errors path="language" class="text-danger" />
					<form:input path="language" class="form-control h-25" rows="3" />
				</div>
				<div class="form-group">
					<form:label path="phase" class="py-2">Project Phase: </form:label>
					<form:errors path="phase" class="text-danger" />
					<form:input path="phase" class="form-control h-25" rows="3"/>
<!--                  		<select class="form-select" aria-label="Default select">
  							<option selected="">Open this select menu</option>
  							<option value="1">Planning</option>
  							<option value="2">Development</option>
  							<option value="3">Testing</option>
						</select> -->
				</div>
				<div class="form-group">
					<form:label path="dueDate" class="py-2">Deployment Date: </form:label>
					<form:errors path="dueDate" class="text-danger" />
					<form:input type="text" path="dueDate" id="datefield"
						class="date form-control" />
				</div>
				<div>
					<form:errors path="leader" class="error" />
					<form:input type="hidden" path="leader" value="${loggedInUser.id}"
						class="form-control" />
				</div>
				<input type="submit" value="Update"
					class="btn btn-outline-dark mx-1 my-3">
 			<form:form action="/projects/${project.id}/delete" method="delete">
					<input type="submit" value="Delete"
						class="btn btn-outline-danger mx-1">
				</form:form>
					<c:forEach items="${projects}" var="project">
						<tr class="bg-transparent">
							<c:if
								test="${project.projectJoiners.contains(userLoggedIn) || loggedInUser.id == project.leader.id}">
								<td>${project.id}</td>
								<td><a href="projects/${project.id}"><c:out value="${project.title}" /></a></td>
								<td>${project.leader.firstName}</td>
								<td>${project.dueDate}</td>
								<td class="d-flex justify-content-center">
									<c:choose>
										<c:when test="${loggedInUser.id == project.leader.id}">
											<a href="/projects/${project.id}/edit" class="btn btn-outline-dark mx-1">Edit Project</a>
											<form:form action="/projects/${project.id}/delete" method="delete">
											<input type="hidden" name="_method" value="delete">
												<input type="submit" value="Delete" class="btn btn-outline-dark">
											</form:form>
										</c:when>
										<c:otherwise>
											<a href="/projects/${project.id}/leave">Leave Team</a>
										</c:otherwise>
									</c:choose></td>
							</c:if>
						</tr>
					</c:forEach>
			</form:form>
		</div>
	</div>

</body>

<script type="text/javascript">
	$(".date").datepicker({
		format : "MM d yyyy",
	});
</script>

</html>