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

import com.app.entities.CrmCustomer;



@RestController
@RequestMapping("/")
public class CrmCustomerController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCustomer(){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/list", HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCustomer(@RequestBody CrmCustomer customer){
		
		HttpEntity<Object> request = new HttpEntity<Object>(customer,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/list/{custID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findCustomerID(@PathVariable("custID") String custID){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/list/"+custID, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCustomer(@RequestBody CrmCustomer customer){
		
		HttpEntity<Object> request = new HttpEntity<Object>(customer,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/remove/{customer}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCustomer(@PathVariable("customer") String customer){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/remove/"+customer, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
