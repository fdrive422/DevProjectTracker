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

	<div class="text-center ">
		<div
			class="p-3 d-flex justify-content-between align-items-center">

<%-- 			<p class="navbar-brand">
				<strong>Developer Project Tracker for
					${loggedInUser.firstName}</strong>
			</p>
			<p class="navbar-brand">
				<em>.....</em>
			</p> --%>
		</div>
		<div class="mx-4 mb-3 text-center nav">
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
		<table class="table table-bg-transparent my-3">
			<thead>
				<tr class="bg-transparent">
					<th>ID</th>
					<th>Project</th>
					<th>Team Lead</th>
					<th>Deploy Date</th>
					<th>Actions</th>
				</tr>
			<tbody>
				<c:forEach items="${projects}" var="project">
					<tr class="bg-transparent text-dark">
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
			<table class="table table-bg-transparent my-3">
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
											<a href="/projects/${project.id}/edit" class="btn btn-outline-dark mx-1"> Edit</a>
											<form:form action="/projects/${project.id}/delete" method="delete">
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
				</tbody>
			</table>
		</div>
	</div>

<!-- HORIZANTAL CARDS -->
<div class="container bg-transparent py-3">
  <div class="title h1">Project Summary Cards</div>
  <!-- Card Start -->
	<c:forEach items="${projects}" var="project">
	<c:if test="${project.projectJoiners.contains(userLoggedIn) || loggedInUser.id == project.leader.id}">
  <div class="card bg-transparent mb-4 p-4">
    <div class="row ">
      <div class="col-md-7 px-3">
        <div class="card-block px-3">
          <h4 class="card-title"> Project Title: ${project.title}</h4>
          <br>
          <p class="card-text"> <strong>Description of Project:</strong> ${project.description}</p>
          <p class="card-text"> <strong>Project Lead:</strong> ${project.leader.firstName}</p>
          <p class="card-text"> <strong>Program Language:</strong> ${project.language} </p>
          <p class="card-text"> <strong>Delpoyment Date:</strong> ${project.dueDate}</p>
          <br>
          <a href="/projects/${id}/project" class="mt-auto btn btn-primary  ">Read More</a>
        </div>
      </div>
      <!-- Carousel start -->
      <div class="col-md-5">
      
        <div id="CarouselTest" class="carousel slide" data-ride="carousel">
          <img class="card-block" src="../views/img/DevProj3.png" alt="">
          <ol class="carousel-indicators">
            <li data-target="#CarouselTest" data-slide-to="0" class="active"></li>
            <li data-target="#CarouselTest" data-slide-to="1"></li>
            <li data-target="#CarouselTest" data-slide-to="2"></li>

          </ol>
          <div class="carousel-inner">
            <div class="carousel-item active">
              <img class="d-block" src="../views/img/DevProj1.jpeg" alt="">
            </div>
            <div class="carousel-item">
              <img class="d-block" src="../views/img/DevProj2.png" alt="">
            </div>
            <div class="carousel-item">
              <img class="d-block" src="../views/img/DevProj3.png" alt="">
            </div>
            <a class="carousel-control-prev" href="#CarouselTest" role="button" data-slide="prev">
    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
            <a class="carousel-control-next" href="#CarouselTest" role="button" data-slide="next">
    <span class="carousel-control-next-icon" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
          </div>
        </div>
      </div>
      <!-- End of carousel -->
    </div>
  </div>
  </c:if>
      </c:forEach>
  <!-- End of card -->

</div>

<%-- <div class="container">
  <div class="card float-left bg-transparent">
    <div class="row ">

      <div class="col-sm-7">
        <div class="card-block">
          <!--           <h4 class="card-title">Small card</h4> -->
          <p>Wetgple text to build your own card.</p>
          <p>Change around the content for awsomenes</p>
          <a href="/projects/${id}/tasks" class="btn btn-primary btn-sm">Read More</a>
        </div>
      </div>

      <div class="col-sm-5">
        <img class="d-block w-100" src="../views/img/DevProj2.png" alt="">
      </div>
    </div>
  </div>

 
    <div class="card float-right bg-transparent">
      <div class="row">
        <div class="col-sm-5">
          <img class="d-block w-100" src="../views/img/DevProj3.png" alt="">
        </div>
        <div class="col-sm-7">
          <div class="card-block">
            <!--           <h4 class="card-title">Small card</h4> -->
            <p>Copy paste the HTML and CSS.</p>
            <p>Change around the content for awsomenes</p>
            <br>
            <a href="#" class="btn btn-primary btn-sm float-right">Read More</a>
          </div>
        </div>
 
      </div>
    </div>
  </div> --%>
 
<!--  <br>
<br>
<section class="wrapper">
  <div class="container">
    <div class="row">
      <div class="col text-center mb-5">
         <h1 class="display-4">Bootstrap 4 Cards With Background Image</h1>
  <p class="lead">Lorem ipsum dolor sit amet at enim hac integer volutpat maecenas pulvinar. </p>
      </div>
    </div>
  <div class="row">
 <div class="col-sm-12 col-md-6 col-lg-4 mb-4"><div class="card text-white card-has-bg click-col" style="background-image:url('https://source.unsplash.com/600x900/?tech,street');">
         <img class="card-img d-none" src="https://source.unsplash.com/600x900/?tech,street" alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
        <div class="card-img-overlay d-flex flex-column">
         <div class="card-body">
            <small class="card-meta mb-2">Thought Leadership</small>
            <h4 class="card-title mt-0 "><a class="text-white" herf="#">Goverment Lorem Ipsum Sit Amet Consectetur dipisi?</a></h4>
           <small><i class="far fa-clock"></i> October 15, 2020</small>
          </div>
          <div class="card-footer">
           <div class="media">
  <img class="mr-3 rounded-circle" src="https://assets.codepen.io/460692/internal/avatars/users/default.png" alt="Generic placeholder image" style="max-width:50px">
  <div class="media-body">
    <h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
     <small>Director of UI/UX</small>
  </div>
</div>
          </div>
        </div>
      </div></div>
     <div class="col-sm-12 col-md-6 col-lg-4 mb-4"><div class="card text-white card-has-bg click-col" style="background-image:url('https://source.unsplash.com/600x900/?tree,nature');">
         <img class="card-img d-none" src="https://source.unsplash.com/600x900/?tree,nature" alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
        <div class="card-img-overlay d-flex flex-column">
         <div class="card-body">
            <small class="card-meta mb-2">Thought Leadership</small>
            <h4 class="card-title mt-0 "><a class="text-white" herf="#">Goverment Lorem Ipsum Sit Amet Consectetur dipisi?</a></h4>
           <small><i class="far fa-clock"></i> October 15, 2020</small>
          </div>
          <div class="card-footer">
           <div class="media">
  <img class="mr-3 rounded-circle" src="https://assets.codepen.io/460692/internal/avatars/users/default.png" alt="Generic placeholder image" style="max-width:50px">
  <div class="media-body">
    <h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
     <small>Director of UI/UX</small>
  </div>
</div>
          </div>
        </div>
      </div></div>
  <div class="col-sm-12 col-md-6 col-lg-4 mb-4"><div class="card text-white card-has-bg click-col" style="background-image:url('https://source.unsplash.com/600x900/?computer,design');">
         <img class="card-img d-none" src="https://source.unsplash.com/600x900/?computer,design" alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
        <div class="card-img-overlay d-flex flex-column">
         <div class="card-body">
            <small class="card-meta mb-2">Thought Leadership</small>
            <h4 class="card-title mt-0 "><a class="text-white" herf="#">Goverment Lorem Ipsum Sit Amet Consectetur dipisi?</a></h4>
           <small><i class="far fa-clock"></i> October 15, 2020</small>
          </div>
          <div class="card-footer">
           <div class="media">
  <img class="mr-3 rounded-circle" src="https://assets.codepen.io/460692/internal/avatars/users/default.png" alt="Generic placeholder image" style="max-width:50px">
  <div class="media-body">
    <h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
     <small>Director of UI/UX</small>
  </div>
</div>
          </div>
        </div>
      </div></div>
   
    <div class="col-sm-12 col-md-6 col-lg-4 mb-4"><div class="card text-white card-has-bg click-col" style="background-image:url('https://source.unsplash.com/600x900/?tech,street');">
         <img class="card-img d-none" src="https://source.unsplash.com/600x900/?tech,street" alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
        <div class="card-img-overlay d-flex flex-column">
         <div class="card-body">
            <small class="card-meta mb-2">Thought Leadership</small>
            <h4 class="card-title mt-0 "><a class="text-white" herf="#">Goverment Lorem Ipsum Sit Amet Consectetur dipisi?</a></h4>
           <small><i class="far fa-clock"></i> October 15, 2020</small>
          </div>
          <div class="card-footer">
           <div class="media">
  <img class="mr-3 rounded-circle" src="https://assets.codepen.io/460692/internal/avatars/users/default.png" alt="Generic placeholder image" style="max-width:50px">
  <div class="media-body">
    <h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
     <small>Director of UI/UX</small>
  </div>
</div>
          </div>
        </div>
      </div></div>
     <div class="col-sm-12 col-md-6 col-lg-4 mb-4"><div class="card text-white card-has-bg click-col" style="background-image:url('https://source.unsplash.com/600x900/?tree,nature');">
         <img class="card-img d-none" src="https://source.unsplash.com/600x900/?tree,nature" alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
        <div class="card-img-overlay d-flex flex-column">
         <div class="card-body">
            <small class="card-meta mb-2">Thought Leadership</small>
            <h4 class="card-title mt-0 "><a class="text-white" herf="#">Goverment Lorem Ipsum Sit Amet Consectetur dipisi?</a></h4>
           <small><i class="far fa-clock"></i> October 15, 2020</small>
          </div>
          <div class="card-footer">
           <div class="media">
  <img class="mr-3 rounded-circle" src="https://assets.codepen.io/460692/internal/avatars/users/default.png" alt="Generic placeholder image" style="max-width:50px">
  <div class="media-body">
    <h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
     <small>Director of UI/UX</small>
  </div>
</div>
          </div>
        </div>
      </div></div>
  <div class="col-sm-12 col-md-6 col-lg-4 mb-4"><div class="card text-white card-has-bg click-col" style="background-image:url('https://source.unsplash.com/600x900/?computer,design');">
         <img class="card-img d-none" src="https://source.unsplash.com/600x900/?computer,design" alt="Goverment Lorem Ipsum Sit Amet Consectetur dipisi?">
        <div class="card-img-overlay d-flex flex-column">
         <div class="card-body">
            <small class="card-meta mb-2">Thought Leadership</small>
            <h4 class="card-title mt-0 "><a class="text-white" herf="#">Goverment Lorem Ipsum Sit Amet Consectetur dipisi?</a></h4>
           <small><i class="far fa-clock"></i> October 15, 2020</small>
          </div>
          <div class="card-footer">
           <div class="media">
  <img class="mr-3 rounded-circle" src="https://assets.codepen.io/460692/internal/avatars/users/default.png" alt="Generic placeholder image" style="max-width:50px">
  <div class="media-body">
    <h6 class="my-0 text-white d-block">Oz Coruhlu</h6>
     <small>Director of UI/UX</small>
  </div>
</div>
          </div>
        </div>
      </div></div>
  
</div>
  
</div>
</section>
 -->
	
</body>
</html>
