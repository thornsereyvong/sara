package com.app.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.app.entities.CrmUser;
import com.app.entities.MeDataSource;
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
	@RequestMapping(value="/user/list/subordinate/{username}",method = RequestMethod.POST)
	public String getUserById(@PathVariable("username") String username, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/subordinate/"+username, HttpMethod.POST, request, Map.class);
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
	public String getUserNameByName(@PathVariable("username") String username, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/"+username, HttpMethod.POST, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>)response.getBody();
		String userId = "";
		if(userMap.get("DATA") != null){
			Map<String, Object> map = (Map<String, Object>) userMap.get("DATA");
			userId = (String) map.get("userID");
       }
		return userId;	
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/subordinate/admin/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> TaskStatusID(@PathVariable("username") String username, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/subordinate/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/id/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getUserReport(@PathVariable("id") String id, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/id/"+id, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllUser(HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list_all", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCampaign(@RequestBody CrmUser user, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		user.setDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(user,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCampaign(@RequestBody CrmUser user, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		user.setDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(user,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/remove/{userID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("userID") String userID, HttpServletRequest req){
	MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		CrmUser user = new CrmUser();
		user.setUserID(userID);
		user.setDataSource(dataSource);
		HttpEntity<String> request = new HttpEntity<String>(userID,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> userDetail(@PathVariable("username") String username, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/login",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> loginUser(@ModelAttribute CrmUser user, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		user.setDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(user, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/login/web/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/user/list/tags",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listTagsUser(HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/user/list/user_tags", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	
	public String getPrincipal() {
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails) principal).getUsername();
		} else {
			userName = principal.toString();
		}
		return userName;
	}
	
	
}
