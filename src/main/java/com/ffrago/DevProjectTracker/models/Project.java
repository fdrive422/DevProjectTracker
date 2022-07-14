package com.ffrago.DevProjectTracker.models;

import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.JoinTable;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.PreUpdate;
import javax.persistence.Table;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

//import org.springframework.scheduling.config.Task;

@Entity
@Table(name = "projects")

public class Project {

	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;

	@NotEmpty(message = "Project Title is required!")
	@Size(min = 2, max = 200, message = "Title must be be at least 2 characters")
	private String title;

	@NotEmpty(message = "Project Description is required!")
	@Size(min = 5, max = 200, message = "Descrioption must be be at least 5 characters")
	private String description;

	@NotEmpty(message = "Program Lanaguge is required!")
	@Size(min = 2, max = 200, message = "Languge must be be at least 2 characters")
	private String language;

	@NotEmpty(message = "Program Phase is required!")
	@Size(min = 2, max = 200, message = "Phase must be be at least 2 characters")
	private String phase;

	@NotEmpty(message = "Date is required!")

	private String dueDate;

	public String getLanguage() {
		return language;
	}

	public void setLanguage(String language) {
		this.language = language;
	}

	public String getPhase() {
		return phase;
	}

	public void setPhase(String phase) {
		this.phase = phase;
	}

	@Column(updatable = false)
	private Date createdAt;
	private Date updatedAt;

	@ManyToOne(fetch = FetchType.LAZY)
	@JoinColumn(name = "user_id")
	private User leader;

	@ManyToMany(fetch = FetchType.LAZY)
	@JoinTable(name = "joins", joinColumns = @JoinColumn(name = "project_id"), inverseJoinColumns = @JoinColumn(name = "user_id"))
	private List<User> projectJoiners;

	@OneToMany(mappedBy = "projectTask", fetch = FetchType.LAZY, cascade = CascadeType.ALL)
	private List<Task> tasks;

	public Project() {

	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}

	public Date getCreatedAt() {
		return createdAt;
	}

	public void setCreatedAt(Date createdAt) {
		this.createdAt = createdAt;
	}

	public Date getUpdatedAt() {
		return updatedAt;
	}

	public void setUpdatedAt(Date updatedAt) {
		this.updatedAt = updatedAt;
	}

	public User getLeader() {
		return leader;
	}

	public void setLeader(User leader) {
		this.leader = leader;
	}

	public List<User> getProjectJoiners() {
		return projectJoiners;
	}

	public void setProjectJoiners(List<User> projectJoiners) {
		this.projectJoiners = projectJoiners;
	}

	public List<Task> getTasks() {
		return tasks;
	}

	public void setTasks(List<Task> tasks) {
		this.tasks = tasks;
	}

	@PrePersist
	protected void onCreate() {
		this.createdAt = new Date();
	}

	@PreUpdate
	protected void onUpdate() {
		this.updatedAt = new Date();
	}

}
