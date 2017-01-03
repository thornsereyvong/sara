package com.app.configuration;

import org.springframework.context.MessageSource;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ResourceBundleMessageSource;
import org.springframework.http.HttpHeaders;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.config.annotation.EnableWebMvc;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;
import org.springframework.web.servlet.view.InternalResourceViewResolver;

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
		headers.add("dbUsername", "posadmin");
		headers.add("ip", "192.168.1.111");
		headers.add("port", "3306");
		headers.add("dbPassword","password");
		return headers; 
	}
	
	
	@Bean
	public String URL(){
		//String  url = "http://116.212.139.10:8888/api/";
		//String  url = "http://192.168.0.111:8080/api/";
		String  url = "http://localhost:8080/BalancikaCRM/";
		//String  url = "http://bmgcorpapi.balancikaapps.com/";
		//String  url = "http://balancikaapi.balancikaapps.com/";
		//String  url = "http://api.balancikaapps.com/";
		//String  url = "http://demoapi.balancikaapps.com/";
		//String  url = "http://192.168.10.5:8881/server/";
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
	public CommonsMultipartResolver multipartResolver() {
	    CommonsMultipartResolver multipartResolver = new CommonsMultipartResolver();
	    multipartResolver.setMaxUploadSize(5242880);
	    return new CommonsMultipartResolver();
	}
	
	@Bean
	public MessageSource messageSource(){
		ResourceBundleMessageSource messageSource = new ResourceBundleMessageSource();
		messageSource.setDefaultEncoding("UTF-8");
		messageSource.setBasename("messages");
		return messageSource;
	}
}
