package com.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

@RestController
public class CrmDashboardController {
	
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/dashboard/startup/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> dashboardStartup(@PathVariable("username") String username){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/dashboard/view/"+username, HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
}
