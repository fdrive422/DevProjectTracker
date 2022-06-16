<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%@ page isErrorPage="true" %>
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
<title>Show Project</title>
</head>
<body class="body-css">

	<div class="blurred-box text-center " id="myHeader">
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


	<div class="card container rounded mt-4 p-4 bg-transparent">
		<div class="d-flex  mx-auto justify-content-between mb-3">
	    	<h1 class="text-dark">Project Details</h1>
<!-- 	        <p>
	        	<a href="/projects" class="btn btn-outline-secondary">Back to Dashboard</a>
	        </p> -->
	   	</div>
	   	<div class="p-4 mx-auto mb-4 bg-transparent">
        	
                <div class="row g-3 my-3">
                	<div class="col-3">
                		<h5>Project:</h5>
                	</div>
                	<div class="col-6">
                		${project.title}
                	</div>
                </div>
                <div class="row g-3 my-3">
                	<div class="col-3">
                		<h5>Description:</h5>
                	</div>
                	<div class="col-6">
                		${project.description}
                	</div>
                </div>
                <div class="row g-3 my-3">
                	<div class="col-3">
                		<h5>Language:</h5>
                	</div>
                	<div class="col-6">
                		${project.language}
                	</div>
                </div>
                <div class="row g-3 my-3">
                	<div class="col-3">
                		<h5>Phase:</h5>
                	</div>
                	<div class="col-6">
                		${project.phase} Phase, as of <fmt:formatDate type="both" dateStyle="medium" timeStyle="short" value="${project.createdAt}" />
                	</div>
                </div>
                <div class="row g-3 my-3">
                	<div class="col-3">
                		<h5>Deployment Date:</h5>
                	</div>
                	<div class="col-6">
                		${project.dueDate}
                	</div>
                	<div>
                		
                	</div>
                </div>
                <div class="d-flex col-9">
                	<c:if test="${project.projectJoiners.contains(userLoggedIn) || project.leader.id == userLoggedIn.id }">
                		<a href="/projects/${project.id}/edit" class="btn btn-outline-dark mx-2">Edit Project</a>
                	</c:if>
                		<a href="/projects/${id}/tasks" class="btn btn-outline-dark">View / Add Tasks</a>
              	</div>
     	</div>
	</div>
	

</body>
</html>