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

import com.app.entities.CrmOpportunityStage;



@RestController
@RequestMapping("/")
public class CrmOpportunityStageController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllOpportunityStage(){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/list", HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addStage(@RequestBody CrmOpportunityStage stage){
		
		HttpEntity<Object> request = new HttpEntity<Object>(stage,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> oppStageID(@PathVariable("id") String id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/list/"+id, HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateStage(@RequestBody CrmOpportunityStage stage){
		
		HttpEntity<Object> request = new HttpEntity<Object>(stage,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/remove/{stage}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteStage(@PathVariable("stage") String stage){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/remove/"+stage, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
