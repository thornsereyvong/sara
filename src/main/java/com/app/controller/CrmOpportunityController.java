package com.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;


import com.app.entities.CrmOpportunity;

import com.fasterxml.jackson.databind.ObjectMapper;


@RestController
@RequestMapping(value="/")
public class CrmOpportunityController {
	
	//private final String URL = "";
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllOpportunity(){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/list", HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/list/{opp}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findOpportunity(@PathVariable("opp") String opp){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/list/"+opp, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addOpportunity(@RequestBody CrmOpportunity opp){
		HttpEntity<Object> request = new HttpEntity<Object>(opp,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateOpportunity(@RequestBody CrmOpportunity opp){
		HttpEntity<Object> request = new HttpEntity<Object>(opp,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/edit", HttpMethod.PUT, request, Map.class);	
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/remove/{opp}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteOpportunity(@PathVariable("opp") String opp){
		HttpEntity<String> request = new HttpEntity<String>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/remove/"+opp, HttpMethod.DELETE, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
