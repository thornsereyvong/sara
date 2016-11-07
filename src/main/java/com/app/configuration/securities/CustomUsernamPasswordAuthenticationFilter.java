package com.app.configuration.securities;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

public class CustomUsernamPasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		final String databaseName = request.getParameter("company");
		request.getSession().setAttribute("databaseName", databaseName);		
		request.getSession().setAttribute("userActivity", request.getParameter("crm_username"));
		return super.attemptAuthentication(request, response);
	}
}
