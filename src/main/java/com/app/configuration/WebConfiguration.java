package com.app.configuration;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

import com.app.entities.CrmDatabaseConfiguration;
import com.app.entities.RestTemplateErrorHandler;
import com.fasterxml.jackson.databind.ObjectMapper;

@Configuration
@EnableWebMvc
@ComponentScan(basePackages = "com.app")

public class WebConfiguration extends WebMvcConfigurerAdapter {

	@Bean
	public InternalResourceViewResolver getInternalResourceViewResolver(){
		InternalResourceViewResolver irv = new InternalResourceViewResolver();
		irv.setPrefix("/WEB-INF/jspFile/");
		irv.setSuffix(".jsp");
		return irv;
	}
	
	@Override
	public void addResourceHandlers(ResourceHandlerRegistry registry) {
		registry.addResourceHandler("resources/**").addResourceLocations("resources/");
	}
	
	@Bean
	public HttpHeaders headsers(){
		HttpHeaders headers = new HttpHeaders();
		headers.add("Authorization", "Basic V0VCQVBJOldFQkFQSQ==");
		headers.add("dbIP", "192.168.0.2");
		headers.add("dbPort", "3306");
		headers.add("dbName", "systemdatabase");
		headers.add("dbUsername", "posadmin");
		headers.add("dbPassword", "Pa$$w0rd");
		return headers; 
	}
	
	
	@Bean
	public String URL(){
		String  url = "http://localhost:8080/BalancikaCRM/";
		//String  url = "http://balancikaapi.balancikaapps.com/";
		//String  url = "http://api.balancikaapps.com/";
		return url;
	}
	
	@Bean
	public ObjectMapper objectMapper(){
		return new ObjectMapper();
	}
	
	@Bean 
	public RestTemplate restTemplate(){
		RestTemplate restTemplate = new RestTemplate();
		restTemplate.setErrorHandler(new RestTemplateErrorHandler());
		return restTemplate;
	}
	
	@Bean
	public CrmDatabaseConfiguration config(){
		return new CrmDatabaseConfiguration();
	}
}
