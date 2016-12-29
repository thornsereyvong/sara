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
		final String str = request.getParameter("company");
		String[] data = str.split(",");
		String databaseName = data[0];
		request.getSession().setAttribute("databaseName", databaseName);
		request.getSession().setAttribute("company", data[1]);
		request.getSession().setAttribute("userActivity", request.getParameter("crm_username"));
		dataSource.setDb(request.getSession().getAttribute("databaseName").toString());
		return super.attemptAuthentication(request, response);
	}
}
