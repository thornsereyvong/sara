package com.app.controller;

import java.util.HashMap;
import java.util.List;
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

import com.app.entities.CrmUser;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;


@RestController
@RequestMapping(value="/")
public class CrmUserController {
	
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
	@RequestMapping(value="/user/list/subordinate/{username}",method = RequestMethod.GET)
	public String getUserById(@PathVariable("username") String username){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/subordinate/"+username, HttpMethod.GET, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>)response.getBody();
		if(userMap.get("DATA") != null){
			Gson convert = new Gson();
			List<CrmUser> arrUser =  (List<CrmUser>) userMap.get("DATA");
			return convert.toJson(arrUser);
       }
		return null;	
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/username/{username}",method = RequestMethod.GET)
	public String getUserNameByName(@PathVariable("username") String username){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/"+username, HttpMethod.GET, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>)response.getBody();
		String userId = "";
		if(userMap.get("DATA") != null){
			/*Gson convert = new Gson();
			CrmUser user =  (CrmUser) userMap.get("DATA");
			return convert.toJson(user);*/
			Map<String, Object> map = (Map<String, Object>) userMap.get("DATA");
			
			userId = (String) map.get("userID");
       }
		return userId;	
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/subordinate/admin/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> TaskStatusID(@PathVariable("username") String username){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/subordinate/"+username, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/id/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getUserReport(@PathVariable("id") String id){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/id/"+id, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllUser(){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list", HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCampaign(@RequestBody CrmUser user){
		
		HttpEntity<Object> request = new HttpEntity<Object>(user,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCampaign(@RequestBody CrmUser user){
		
		HttpEntity<Object> request = new HttpEntity<Object>(user,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/remove/{userID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("userID") String userID){
		
		HttpEntity<String> request = new HttpEntity<String>(userID,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/remove/"+userID, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> userDetail(@PathVariable("username") String username){		
		HttpEntity<Object> request = new HttpEntity<Object>(header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/"+username, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/login/{username}/{password}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> loginUser(@PathVariable("username") String username, @PathVariable("password") String password){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/login/web/"+username+"/"+password, HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
