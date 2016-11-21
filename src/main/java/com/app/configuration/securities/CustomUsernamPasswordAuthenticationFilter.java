package com.app.configuration.securities;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;

import com.app.entities.MeDataSource;

public class CustomUsernamPasswordAuthenticationFilter extends UsernamePasswordAuthenticationFilter{
	
	@Autowired
	private MeDataSource dataSource;
	
	@Override
	public Authentication attemptAuthentication(HttpServletRequest request, HttpServletResponse response) throws AuthenticationException {
		final String databaseName = request.getParameter("company");
		dataSource.setDb(databaseName);
		request.getSession().setAttribute("databaseName", databaseName);		
		request.getSession().setAttribute("userActivity", request.getParameter("crm_username"));
		return super.attemptAuthentication(request, response);
	}
}
