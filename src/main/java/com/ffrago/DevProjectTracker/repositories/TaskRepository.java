package com.ffrago.DevProjectTracker.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;
import org.springframework.stereotype.Repository;

import com.ffrago.DevProjectTracker.models.Task;

@Repository
public interface TaskRepository extends CrudRepository<Task, Long> {

	List<Task> findAll();

	// All tasks belonging to a project, oldest first — used for the task list so
	// every task for the project shows (not just a stale lazy collection).
	List<Task> findByProjectTaskIdOrderByCreatedAtAsc(Long projectId);

}