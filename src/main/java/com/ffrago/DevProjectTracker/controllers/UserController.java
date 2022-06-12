package com.ffrago.DevProjectTracker.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;

import com.ffrago.DevProjectTracker.models.LoginUser;
import com.ffrago.DevProjectTracker.models.User;
import com.ffrago.DevProjectTracker.services.ProjectService;
import com.ffrago.DevProjectTracker.services.UserService;

@Controller
public class UserController {

	@Autowired
	private UserService userService;

	@Autowired
	private ProjectService projectService;

	@GetMapping("/")
	public String index(@ModelAttribute("newUser") User user, @ModelAttribute("newLogin") LoginUser loginUser) {

		return "index.jsp";
	}

	/****** REGISTER USER ******/

	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User user, BindingResult result, HttpSession session,
			@ModelAttribute("newLogin") LoginUser loginUser) {

		// validate user
		userService.validate(user, result);
		if (result.hasErrors()) {
			return "index.jsp";
		}

		// register user
		userService.registerUser(user);

		// put user in session
		session.setAttribute("loggedInUser", user);
		return "redirect:/dashboard";

	}

	/****** LOGIN USER ******/

	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser loginUser, BindingResult result,
			HttpSession session, @ModelAttribute("newUser") User user) {

		// authenticate user
		userService.authenticateUser(loginUser, result);
		if (result.hasErrors()) {
			return "index.jsp";
		}

		User loggedInUser = userService.findByEmail(loginUser.getUserEmail());

		// put user in session
		session.setAttribute("loggedInUser", loggedInUser);
		return "redirect:/dashboard";
	}

	/****** LOGOUT ******/

	@GetMapping("/logout")
	public String logout(HttpSession session) {

		session.invalidate();
		return "redirect:/";
	}

	/****** DASHBOARD ******/

	@GetMapping("/dashboard")
	public String dashboard(HttpSession session) {

		if (session.getAttribute("loggedInUser") != null) {

			return "redirect:/projects";
		}

		return "redirect:/";
	}

	@GetMapping("/projects")
	public String allProjects(Model viewModel, HttpSession session) {

		if (session.getAttribute("loggedInUser") != null) {
			User user = (User) session.getAttribute("loggedInUser");
			User userLoggedIn = userService.findById(user.getId());

			viewModel.addAttribute("userLoggedIn", userLoggedIn);
			viewModel.addAttribute("projects", projectService.getAllProjects());

			return "dashboard.jsp";

		}

		return "redirect:/";
	}
}
