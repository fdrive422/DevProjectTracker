package com.ffrago.DevProjectTracker.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;

import com.ffrago.DevProjectTracker.models.Project;
import com.ffrago.DevProjectTracker.models.User;
import com.ffrago.DevProjectTracker.services.ProjectService;
import com.ffrago.DevProjectTracker.services.UserService;

@Controller
public class ProjectController {

	@Autowired
	private ProjectService projectService;

	@Autowired
	private UserService userService;

	/***** CREATE PROJECT ******/

	@GetMapping("/projects/new")
	public String newProject(@ModelAttribute("newProject") Project project, HttpSession session) {

		if (session.getAttribute("loggedInUser") != null) {

			return "newProject.jsp";
		}

		return "redirect:/";
	}

	@PostMapping("/projects/create")
	public String createProject(@Valid @ModelAttribute("newProject") Project project, BindingResult result,
			HttpSession session) {

		if (result.hasErrors()) {
			return "newProject.jsp";
		}

		projectService.createProject(project);
		return "redirect:/dashboard";
	}

	/****** DISPLAY PROJECT ******/

	@GetMapping("/projects/{id}")
	public String showProject(@PathVariable("id") Long id, Model viewModel, HttpSession session) {

		if (session.getAttribute("loggedInUser") != null) {

			User user = (User) session.getAttribute("loggedInUser");
			User userLoggedIn = userService.findById(user.getId());

			Project project = projectService.showOne(id);

			viewModel.addAttribute("project", project);
			viewModel.addAttribute("userLoggedIn", userLoggedIn);

			return "showProject.jsp";
		}

		return "redirect:/dashboard";
	}

	/****** EDIT PROJECT ******/

	@GetMapping("/projects/{id}/edit")
	public String editProject(@PathVariable("id") Long id, Model viewModel, HttpSession session) {

		if (session.getAttribute("loggedInUser") != null) {

			Project project = projectService.showOne(id);
			viewModel.addAttribute("editProject", project);

			return "editProject.jsp";
		}

		return "redirect:/dashboard";
	}

	/****** UPDATE PROJECT ******/

	@PutMapping("/projects/{id}/update")
	public String updateProject(@PathVariable("id") Long id, @Valid @ModelAttribute("editProject") Project project,
			BindingResult result, Model viewModel) {

		if (result.hasErrors()) {

			return "editProject.jsp";
		}

		projectService.updateProject(project);
		return "redirect:/dashboard";
	}

	/****** DELETE PROJECT ******/

	@DeleteMapping("/projects/{id}/delete")
	public String deleteProject(@PathVariable("id") Long id) {

		projectService.deleteProject(id);
		return "redirect:/dashboard";
	}

	/****** JOIN/LEAVE PROJECT ******/

	@GetMapping("/projects/{id}/join")
	public String joinProject(@PathVariable("id") Long id, HttpSession session) {

		User user = (User) session.getAttribute("loggedInUser");
		User projectJoiner = userService.findById(user.getId());

		Project project = projectService.showOne(id);
		projectService.joinProject(project, projectJoiner);

		return "redirect:/projects";

	}

	@GetMapping("/projects/{id}/leave")
	public String leaveProject(@PathVariable("id") Long id, HttpSession session) {

		User user = (User) session.getAttribute("loggedInUser");
		User projectLeaver = userService.findById(user.getId());

		Project project = projectService.showOne(id);
		projectService.leaveProject(project, projectLeaver);

		return "redirect:/projects";

	}

}
