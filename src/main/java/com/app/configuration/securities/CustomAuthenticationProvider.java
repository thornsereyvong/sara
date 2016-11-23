package com.app.configuration.securities;


import java.util.ArrayList;
import java.util.List;



import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.core.GrantedAuthority;
import org.springframework.stereotype.Component;

import com.app.entities.CrmUser;
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
		CrmUser user = userService.findUserByUsername(username);
		 if (user == null || !user.getUsername().equalsIgnoreCase(username)) {
             throw new BadCredentialsException("Username not found.");
         }
  
         if (!password.equals(new PasswordEncrypt().BalDecrypt(user.getPassword()))) {
             throw new BadCredentialsException("Wrong password.");
         }
         return new UsernamePasswordAuthenticationToken(username, password, getGrantedAuthorities(user));
	}

	@Override
	public boolean supports(Class<?> authentication) {
		return (UsernamePasswordAuthenticationToken.class.isAssignableFrom(authentication));
	}
	
	private List<GrantedAuthority> getGrantedAuthorities(CrmUser user) {
		return new ArrayList<GrantedAuthority>();
	}
}
