package com.ffrago.DevProjectTracker.services;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.ffrago.DevProjectTracker.models.Task;
import com.ffrago.DevProjectTracker.repositories.TaskRepository;

@Service
public class TaskService {
	
	@Autowired
	private TaskRepository taskRepository;

	// Get All Tasks
	public List<Task> getAllTasks() {
		
		return taskRepository.findAll();
	}
	
	// Create Task
	public Task createTask(Task task) {
		
		return taskRepository.save(task);
	}
	
	// Show Task
	public Task showTask(Long id) {
		
		return taskRepository.findById(id).orElse(null);
	}
	
	// Edit Task
	public Task updateTask(Task task) {
		
		return taskRepository.save(task);
	}
	
	// Delete Task
	public void deleteTask(Long id) {
		
		taskRepository.deleteById(id);
	}

}
