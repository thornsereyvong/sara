package com.app.configuration;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletRegistration;

import org.springframework.web.WebApplicationInitializer;
import org.springframework.web.context.support.AnnotationConfigWebApplicationContext;
import org.springframework.web.servlet.DispatcherServlet;

public class WebInitializer implements WebApplicationInitializer {

	@Override
	public void onStartup(ServletContext servlet) throws ServletException {
		AnnotationConfigWebApplicationContext ac = new AnnotationConfigWebApplicationContext();
		ac.register(WebConfiguration.class);
		ac.setServletContext(servlet);
		
		ServletRegistration.Dynamic sd = servlet.addServlet("server", new DispatcherServlet(ac));
		sd.setLoadOnStartup(1);
		sd.addMapping("/");
		
	}

}
