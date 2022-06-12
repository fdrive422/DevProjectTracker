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
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<title>Show Project</title>
</head>
<body>

	<div class="container border rounded mt-4 p-4">
		<div class="d-flex  mx-auto justify-content-between mb-3">
	    	<h1 class="text-dark">Project Details</h1>
	        <p>
	        	<a href="/projects" class="btn btn-outline-secondary">Back to Dashboard</a>
	        </p>
	   	</div>
	   	<div class="border rounded p-4 bg-light mx-auto mb-4">
        	
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
                		${project.phase}
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
                		<a href="/projects/${project.id}/edit" class="btn btn-outline-warning mx-1">Edit Project</a>
                		<a href="/projects/${id}/tasks" class="btn btn-outline-primary">View/Add Tasks</a>

                	</c:if>
              	</div>
     	</div>
	</div>
	

</body>
</html>