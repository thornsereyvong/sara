package com.app.service.impl;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;



import com.app.entities.CrmUserLogin;
import com.app.service.UserService;

@Service
public class CustomUserDetailService implements UserDetailsService{
	
	@Autowired
	private UserService userService;

	@Override
	public UserDetails loadUserByUsername(String username) throws UsernameNotFoundException {
		CrmUserLogin user = userService.findUserByUsername(username);
		
		if(user == null){
			System.out.println("User not found");
			throw new UsernameNotFoundException("User not found");
		}
		
		boolean status = false;
		if(user.getStatus() == 1){
			status = true; 
		}
	
		return new org.springframework.security.core.userdetails.User(user.getUsername(), user.getPassword(), 
				status, true, true, true, null);
	}
	
}
