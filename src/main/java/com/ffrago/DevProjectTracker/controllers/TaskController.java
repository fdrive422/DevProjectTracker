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

import com.ffrago.DevProjectTracker.models.Project;
import com.ffrago.DevProjectTracker.models.Task;
import com.ffrago.DevProjectTracker.models.User;
import com.ffrago.DevProjectTracker.services.ProjectService;
import com.ffrago.DevProjectTracker.services.TaskService;
import com.ffrago.DevProjectTracker.services.UserService;

@Controller
public class TaskController {

	@Autowired
	private TaskService taskService;

	@Autowired
	private UserService userService;

	@Autowired
	private ProjectService projectService;

	/****** ADD TASK TO PROJECT ******/

	@GetMapping("/projects/{id}/tasks")
	public String newTask(@PathVariable("id") Long id, @ModelAttribute("newTask") Task task, Model viewModel,
			HttpSession session) {

		if (session.getAttribute("loggedInUser") != null) {

			User user = (User) session.getAttribute("loggedInUser");
			User taskCreator = userService.findById(user.getId());
			viewModel.addAttribute("taskCreator", taskCreator);

			Project project = projectService.showOne(id);
			viewModel.addAttribute("project", project);
			viewModel.addAttribute("tasks", project.getTasks());

			return "projectTasks.jsp";
		}

		return "redirect:/projects";
	}

	@PostMapping("/projects/{id}/tasks/create")
	public String createTask(@PathVariable("id") Long id, @Valid @ModelAttribute("newTask") Task task,
			BindingResult result) {

		if (result.hasErrors()) {
			return "projectTasks.jsp";
		}

		taskService.createTask(task);
		return "redirect:/projects/{id}/tasks";
	}

	/****** COMPLETE TASK ******/

	@DeleteMapping("/projects/{project_id}/tasks/{task_id}/delete")
	public String deleteTask(@PathVariable("project_id") Long id, @PathVariable("task_id") Long id2) {

		taskService.deleteTask(id2);
		return "redirect:/projects/{project_id}/tasks";
	}

}
