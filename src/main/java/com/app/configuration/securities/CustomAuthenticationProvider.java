package com.app.configuration.securities;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.stereotype.Component;

import com.app.entities.CrmUserLogin;
import com.app.service.impl.UserServiceImpl;
import com.app.utilities.PasswordEncrypt;

@Component
public class CustomAuthenticationProvider implements AuthenticationProvider{

	@Autowired
	private UserServiceImpl userService;
	
	@Override
	public Authentication authenticate(Authentication authentication) throws AuthenticationException {
		String username = authentication.getName().trim();
		String password = authentication.getCredentials().toString().trim();
		CrmUserLogin user = userService.findUserByUsername(username);
		 if (user == null  || (!user.getUserID().equalsIgnoreCase(username) && !user.getUsername().equalsIgnoreCase(username))) {
             throw new BadCredentialsException("Invalid Username and password!");
         }
  
         if (!password.equals(new PasswordEncrypt().BalDecrypt(user.getPassword()))) {
             throw new BadCredentialsException("Invalid Username and password!");
         }
         if(!user.getUserApp().getAppId().equals("CRM")){
        	 throw new BadCredentialsException("You have no permission! Please contact your administrator!");
         }
        return new UsernamePasswordAuthenticationToken(user.getUsername(), password, null);
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}
	
}
