package com.ffrago.DevProjectTracker.services;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.Errors;

import com.ffrago.DevProjectTracker.models.LoginUser;
import com.ffrago.DevProjectTracker.models.User;
import com.ffrago.DevProjectTracker.repositories.UserRepository;

@Service
public class UserService {

	@Autowired
	private UserRepository userRepository;
	
		// Validate User for Duplicate Email & Password Mismatch
		public void validate(User newUser, Errors errors) {
			// Password Matching
			if(!newUser.getPassword().equals(newUser.getConfirm())) {
				errors.rejectValue("password", "Mismatch", "Password does not match!!!");
			}
			// Email Duplicate
			if(userRepository.findByEmail(newUser.getEmail())!=null) {
				errors.rejectValue("email", "unique", "Email is already taken!!!");
			}
				
		}
			
		// Register User and Hash Password
		public User registerUser(User newUser) {
				
			String hashedPW = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
			newUser.setPassword(hashedPW);
			return userRepository.save(newUser);
				
		}
			
		// Find User by Email
		public User findByEmail(String email) {
				
			return userRepository.findByEmail(email);
		} 
		
		// Find User by Id
		public User findById(Long id) {
				
			return userRepository.findById(id).orElse(null);
		}
			
			
		// Authenticate User
		public boolean authenticateUser(LoginUser newLogin, Errors errors) {
				
			User user = userRepository.findByEmail(newLogin.getUserEmail());
			if(user == null) {
				errors.rejectValue("userEmail", "missingEmail", "Email not found!!!");
				return false;
			} else {
				if(!BCrypt.checkpw(newLogin.getUserPassword(), user.getPassword())) {
					errors.rejectValue("userPassword", "Matches", "Invalid Password!!!");
					return false;
				}
			}
			
			return true;
		}

}
