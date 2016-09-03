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


import com.app.entities.CrmContact;
import com.app.utilities.RestUtil;
import com.fasterxml.jackson.databind.ObjectMapper;


@RestController
@RequestMapping(value="/")
public class CrmContactController {
	
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
	@RequestMapping(value="/contact/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllContact(){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/list", HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/list/validate/{contact}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getContact(@PathVariable("contact") String contact){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/list/validate/"+contact, HttpMethod.GET, request, Map.class);
		try{
			if(RestUtil.isError(response.getStatusCode())){
				 return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			}else{
				return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			}	
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/list/{contact}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findContactById(@PathVariable("contact") String contact){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/list/"+contact, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addContact(@RequestBody CrmContact contact){
		HttpEntity<Object> request = new HttpEntity<Object>(contact,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateContact(@RequestBody CrmContact contact){
		
		HttpEntity<Object> request = new HttpEntity<Object>(contact,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/remove/{contact}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("contact") String contact){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/remove/"+contact, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
