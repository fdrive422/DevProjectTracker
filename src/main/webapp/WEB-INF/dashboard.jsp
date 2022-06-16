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
<!-- YOUR own local CSS -->
<link rel="stylesheet" href="../views/css/main.css" />
<!-- Bootstrap -->
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet"
	integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3"
	crossorigin="anonymous">
<script src="js/app.js" type="text/javascript"></script>
<title>Dashboard</title>
</head>
<body class="body-css">

	<div class="blurred-box text-center ">
		<div
			class="p-1 blurred-box d-flex justify-content-between align-items-center">

			<p class="navbar-brand">
				<strong>Developer Project Tracker for
					${loggedInUser.firstName}</strong>
			</p>
			<p class="navbar-brand">
				<em>.....</em>
			</p>
		</div>
		<div class="mb-3 text-center">
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
						<li class="m-1 nav-item"><a class="nav-link" href="/">SIGN
								OUT</a></li>
					</ul>
				</div>
			</nav>
		</div>
	</div>

	<div
		class="card container d-flex col-12 mx-auto justify-content-between bg-transparent mt-4 mb-4 p-4">
		<div class="d-flex justify-content-between">
			<div class="my-2">
				<h1>Project Dashboard</h1>
				<%-- <h4>Welcome,<c:out value="${loggedInUser.firstName}" /></h4>	 --%>
				<br>
				<h4>Team Projects</h4>
			</div>
		</div>
		<table class="table table-striped table-bg-transparent my-3">
			<thead>
				<tr class="bg-transparent">
					<th>ID</th>
					<th>Project</th>
					<th>Team Lead</th>
					<th>Due Date</th>
					<th>Actions</th>
				</tr>
			<tbody>
				<c:forEach items="${projects}" var="project">
					<tr class="bg-transparent"">
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
			<table class="table table-striped table-bg-transparent my-3">
				<thead>
					<tr class="bg-transparent">
						<th>ID</th>
						<th>Project</th>
						<th>Team Lead</th>
						<th>Due Date</th>
						<th class="text-center">Actions</th>
					</tr>
				<tbody>
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
											<a href="/projects/${project.id}/edit" class="mx-1">Edit Project</a>
											<form:form action="/projects/${project.id}/delete" method="delete">
												<input type="submit" value="Delete" class="btn btn-danger">
											</form:form>
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
		
		</div>
	
	</div>

	<!-- 		// cards // -->


	<section class="wrapper">
		<div class="container">
			<div class="row">
				<div class="container h-100 bg-transparent">
					<div class="row align-items-between h-100">
						<div class="col-6 mx-auto">
							<div class="card h-100 justify-content-between bg-transparent">
								<c:forEach items="${projects}" var="project">
									<!-- <img src="..." class="card-img-top" alt="..."> -->
									<h5 class="card-title text-center my-3">
										Project: <a href="projects/${project.id}"><c:out
												value="${project.title}" /></a>
									</h5>
									<div class="card-body">
										<p>
											<strong> Description:</strong> ${project.description}
										</p>
										<p>
											<strong> Owner:</strong> ${project.leader.firstName}
											${project.leader.lastName}
										</p>
										<p>
											<strong> Language:</strong> ${project.language}
										</p>
										<p>
											<strong> Deploy Date:</strong> ${project.dueDate}
										</p>
									</div>
									<div class="card-footer">
										<small class="text-muted">Last updated <fmt:formatDate
												type="both" dateStyle="medium" timeStyle="short"
												value="${project.createdAt}" /></small>
									</div>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>

<%-- 
	<section class="wrapper">
		<div class="container">
			<div class="row">
				<div class="col text-center mb-5">
					<h1 class="display-4">Bootstrap 4 Cards With Background Image</h1>
					<p class="lead">Lorem ipsum dolor sit amet at enim hac integer
						volutpat maecenas pulvinar.</p>
				</div>
			</div>
			<div class="row">
				<div class="col-sm-12 col-md-6 col-lg-4 mb-4">
					<div class="card text-white card-has-bg click-col"
						style="background-image: url('https://source.unsplash.com/600x900/?tech,street');">
						<img class="card-img d-none"
							src="https://source.unsplash.com/600x900/?tech,street"
							alt="">
						<div class="card-img-overlay d-flex flex-column">
							<div class="card-body">
							<c:forEach items="${projects}" var="project">
								<small class="card-meta mb-2">Project: <a href="projects/${project.id}"><c:out
												value="${project.title}" /></a></small>
								<h4 class="card-title mt-0 ">
									<a class="text-white" herf="#">Goverment Lorem Ipsum Sit
										Amet Consectetur dipisi?</a>
								</h4>
							</c:forEach>
								<small><i class="far fa-clock"></i> October 15, 2020</small>
							</div>
							<div class="card-footer">
								<div class="media">
									<img class="mr-3 rounded-circle"
										src="https://assets.codepen.io/460692/internal/avatars/users/default.png"
										alt="Generic placeholder image" style="max-width: 50px">
									<div class="media-body">
										<h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
										<small>Director of UI/UX</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-md-6 col-lg-4 mb-4">
					<div class="card text-white card-has-bg click-col"
						style="background-image: url('https://source.unsplash.com/600x900/?tree,nature');">
						<img class="card-img d-none"
							src="https://source.unsplash.com/600x900/?tree,nature"
							alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
						<div class="card-img-overlay d-flex flex-column">
							<div class="card-body">
								<small class="card-meta mb-2">Thought Leadership</small>
								<h4 class="card-title mt-0 ">
									<a class="text-white" herf="#">Goverment Lorem Ipsum Sit
										Amet Consectetur dipisi?</a>
								</h4>
								<small><i class="far fa-clock"></i> October 15, 2020</small>
							</div>
							<div class="card-footer">
								<div class="media">
									<img class="mr-3 rounded-circle"
										src="https://assets.codepen.io/460692/internal/avatars/users/default.png"
										alt="Generic placeholder image" style="max-width: 50px">
									<div class="media-body">
										<h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
										<small>Director of UI/UX</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
				<div class="col-sm-12 col-md-6 col-lg-4 mb-4">
					<div class="card text-white card-has-bg click-col"
						style="background-image: url('https://source.unsplash.com/600x900/?computer,design');">
						<img class="card-img d-none"
							src="https://source.unsplash.com/600x900/?computer,design"
							alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
						<div class="card-img-overlay d-flex flex-column">
							<div class="card-body">
								<small class="card-meta mb-2">Thought Leadership</small>
								<h4 class="card-title mt-0 ">
									<a class="text-white" herf="#">Goverment Lorem Ipsum Sit
										Amet Consectetur dipisi?</a>
								</h4>
								<small><i class="far fa-clock"></i> October 15, 2020</small>
							</div>
							<div class="card-footer">
								<div class="media">
									<img class="mr-3 rounded-circle"
										src="https://assets.codepen.io/460692/internal/avatars/users/default.png"
										alt="Generic placeholder image" style="max-width: 50px">
									<div class="media-body">
										<h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
										<small>Director of UI/UX</small>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>


			</div>
	</section> --%>



	<div class="container">
		<div class="row">
			<div class="col-lg-4">
				<div class="card card-margin">
					<div class="card-header no-border">
						<h5 class="card-title">MOM</h5>
					</div>
					<div class="card-body pt-0">
						<div class="widget-49">
							<div class="widget-49-title-wrapper">
								<div class="widget-49-date-primary">
									<span class="widget-49-date-day">09</span> <span
										class="widget-49-date-month">apr</span>
								</div>
								<div class="widget-49-meeting-info">
									<span class="widget-49-pro-title">PRO-08235 DeskOpe.
										Website</span> <span class="widget-49-meeting-time">12:00 to
										13.30 Hrs</span>
								</div>
							</div>
							<ol class="widget-49-meeting-points">
								<li class="widget-49-meeting-item"><span>Expand
										module is removed</span></li>
								<li class="widget-49-meeting-item"><span>Data
										migration is in scope</span></li>
								<li class="widget-49-meeting-item"><span>Session
										timeout increase to 30 minutes</span></li>
							</ol>
							<div class="widget-49-meeting-action">
								<a href="projects/${project.id}" class="btn btn-sm btn-flash-border-primary">View
									All</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="card card-margin">
					<div class="card-header no-border">
						<h5 class="card-title">MOM</h5>
					</div>
					<div class="card-body pt-0">
						<div class="widget-49">
							<div class="widget-49-title-wrapper">
								<div class="widget-49-date-warning">
									<span class="widget-49-date-day">13</span> <span
										class="widget-49-date-month">apr</span>
								</div>
								<div class="widget-49-meeting-info">
									<span class="widget-49-pro-title">PRO-08235 Lexa Corp.</span> <span
										class="widget-49-meeting-time">12:00 to 13.30 Hrs</span>
								</div>
							</div>
							<ol class="widget-49-meeting-points">
								<li class="widget-49-meeting-item"><span>Scheming
										module is removed</span></li>
								<li class="widget-49-meeting-item"><span>App design
										contract confirmed</span></li>
								<li class="widget-49-meeting-item"><span>Client
										request to send invoice</span></li>
							</ol>
							<div class="widget-49-meeting-action">
								<a href="#" class="btn btn-sm btn-flash-border-warning">View
									All</a>
							</div>
						</div>
					</div>
				</div>
			</div>
			<div class="col-lg-4">
				<div class="card card-margin">
					<div class="card-header no-border">
						<h5 class="card-title">MOM</h5>
					</div>
					<div class="card-body pt-0">
						<div class="widget-49">
							<div class="widget-49-title-wrapper">
								<div class="widget-49-date-success">
									<span class="widget-49-date-day">22</span> <span
										class="widget-49-date-month">apr</span>
								</div>
								<div class="widget-49-meeting-info">
									<span class="widget-49-pro-title">PRO-027865 Opera
										module</span> <span class="widget-49-meeting-time">12:00 to
										13.30 Hrs</span>
								</div>
							</div>
							<ol class="widget-49-meeting-points">
								<li class="widget-49-meeting-item"><span>Scope is
										revised and updated</span></li>
								<li class="widget-49-meeting-item"><span>Time-line
										has been changed</span></li>
								<li class="widget-49-meeting-item"><span>Received
										approval to start wire-frame</span></li>
							</ol>
							<div class="widget-49-meeting-action">
								<a href="#" class="btn btn-sm btn-flash-border-success">View
									All</a>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
