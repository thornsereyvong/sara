package com.app.service.impl;

import java.util.HashMap;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Repository;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.client.RestTemplate;

import com.app.entities.CrmUserLogin;
import com.app.entities.MeDataSource;
import com.app.service.UserService;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;

@Repository
public class UserServiceImpl implements UserService{
	
	@Autowired
	private String URL; 
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private MeDataSource dataSource;           
	
	@Transactional
	@SuppressWarnings({ "rawtypes", "unchecked" })
	@Override
	public CrmUserLogin findUserByUsername(String username) {
		try{
			RestTemplate restTemplate = new RestTemplate();
			CrmUserLogin user = new CrmUserLogin();
			user.setUsername(username);
			user.setDataSource(dataSource);
			HttpEntity<Object> req = new HttpEntity<Object>(user, header);
			/* Call from Web Service with URL+"/api/user/login/web" */
	        ResponseEntity<Map> response = restTemplate.exchange(URL+"/api/user/login/web", HttpMethod.POST , req , Map.class);
	        Map<String, Object> map = (HashMap<String, Object>)response.getBody();
	        if(map.get("DATA") != null){
	        	 ObjectMapper mapper = new ObjectMapper();
	             String  json =  mapper.writeValueAsString(map.get("DATA")); // Convert from HashMap to JSON String object
	             Gson converter = new Gson();
	             CrmUserLogin userResult = converter.fromJson(json, CrmUserLogin.class); // Convert JSON to CrmUser Object
	             return userResult;
	        }
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
}
