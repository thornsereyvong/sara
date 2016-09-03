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

import com.app.entities.CrmOpportunityType;


@RestController
@RequestMapping("/")
public class CrmOpportunityTypeController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_type/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllOpportunity(){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_type/list", HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_type/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> oppTypeID(@PathVariable("id") String id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_type/list/"+id, HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_type/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addType(@RequestBody CrmOpportunityType type){
		
		HttpEntity<Object> request = new HttpEntity<Object>(type,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_type/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_type/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateType(@RequestBody CrmOpportunityType type){
		
		HttpEntity<Object> request = new HttpEntity<Object>(type,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_type/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_type/remove/{typeID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteType(@PathVariable("typeID") String typeID){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_type/remove/"+typeID, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
