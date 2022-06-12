package com.ffrago.DevProjectTracker.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ffrago.DevProjectTracker.models.Project;
import com.ffrago.DevProjectTracker.models.User;
import com.ffrago.DevProjectTracker.repositories.ProjectRepository;

@Service
public class ProjectService {
	
	@Autowired
	private ProjectRepository projectRepository;
	
	// Get All Projects
	public List<Project> getAllProjects() {
		
		return projectRepository.findAll();
	}
	
	
	// Create Project
	public Project createProject(Project project) {
		
		return projectRepository.save(project);
	}
	
	
	// Show Project
	public Project showOne(Long id) {
		
		return projectRepository.findById(id).orElse(null);
	}
	
	
	// Edit Project
	public Project updateProject(Project project) {
		
		return projectRepository.save(project);
	}
	
	// Delete Project
	public void deleteProject(Long id) {
		
		projectRepository.deleteById(id);
	}
	
	// Join Project
	public void joinProject(Project project, User user) {
		
		List<User> projectJoiners = project.getProjectJoiners();
		projectJoiners.add(user);
		projectRepository.save(project);
	}
	
	// Leave Project
	public void leaveProject(Project project, User user) {
		
		List<User> projectJoiners = project.getProjectJoiners();
		projectJoiners.remove(user);
		projectRepository.save(project);
		
	}

}
