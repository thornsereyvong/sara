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


import com.app.entities.CrmLead;


@RestController
@RequestMapping(value="/")
public class CrmLeadController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCampaign(){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/list", HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/list/{leadID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findLeadById(@PathVariable("leadID") String leadID){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/list/"+leadID, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCampaign(@RequestBody CrmLead lead){
		
		HttpEntity<Object> request = new HttpEntity<Object>(lead,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/convert",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> leadConvert(@RequestBody String lead){
		
		HttpEntity<Object> request = new HttpEntity<Object>(lead,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/convert", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCampaign(@RequestBody CrmLead lead){
		
		HttpEntity<Object> request = new HttpEntity<Object>(lead,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/remove/{leadID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("leadID") String leadID){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/remove/"+leadID, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
