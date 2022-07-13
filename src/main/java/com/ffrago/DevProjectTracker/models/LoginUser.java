package com.ffrago.DevProjectTracker.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class LoginUser {

	@NotEmpty(message = "Email is required!")
	@Email(message = "Please enter a valid email!")
	private String userEmail;

	@NotEmpty(message = "Password is required!")
	@Size(min = 8, max = 200, message = "Incorrect password!")
	private String userPassword;

	public LoginUser() {

	}

	public String getUserEmail() {
		return userEmail;
	}

	public void setUserEmail(String userEmail) {
		this.userEmail = userEmail;
	}

	public String getUserPassword() {
		return userPassword;
	}

	public void setUserPassword(String userPassword) {
		this.userPassword = userPassword;
	}

}
