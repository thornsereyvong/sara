package com.app.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.app.entities.CrmLead;
import com.app.entities.MeDataSource;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.google.gson.Gson;
import com.google.gson.JsonObject;


@RestController
@RequestMapping(value="/")
public class CrmLeadController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/list",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getAllLead(@RequestBody String json, HttpServletRequest req){	
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(json, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/list/user/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/convert/startup/{username}/{leadId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> convertLeadStartup(@PathVariable("username") String username, @PathVariable("leadId") String leadId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/convert/startup/"+username+"/"+leadId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/list_all",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllleads(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/list_all", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());	
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/list/{leadID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findLeadById(@PathVariable("leadID") String leadID, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/list/"+leadID, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/view",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> viewLead(@RequestBody String obj, HttpServletRequest req){
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(obj, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/view/"+map.get("leadId")+"/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/view/{leadId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> viewLeadById(@PathVariable("leadId") String leadId, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/view", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/add/startup",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addLeadOnStartup(@RequestBody String json, HttpServletRequest req){
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(json, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/add/startup/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addLead(@RequestBody CrmLead lead, HttpServletRequest req){
		lead.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(lead,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/convert",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> leadConvert(@RequestBody String lead, HttpServletRequest req){
		Gson gson = new Gson();
		JsonObject json = gson.fromJson(lead, JsonObject.class);
		JsonObject newObj = new JsonObject();
		newObj.addProperty("db", req.getSession().getAttribute("databaseName").toString());
		newObj.addProperty("ip", req.getSession().getAttribute("ip").toString());
		newObj.addProperty("port", req.getSession().getAttribute("port").toString());
		newObj.addProperty("un", req.getSession().getAttribute("usernamedb").toString());
		newObj.addProperty("pw", req.getSession().getAttribute("passworddb").toString());
		newObj.addProperty("userid", getPrincipal());
		json.add("DATASOURCE", newObj);
		
		System.out.println("----------------------------------- sssssss------------------------------");
		
		
		HttpEntity<Object> request = new HttpEntity<Object>(gson.toJson(json),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/convert", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/edit/startup/{leadId}/{username}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> editLeadOnStartup(@PathVariable("leadId") String leadId, @PathVariable("username") String username, HttpServletRequest req){
		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req, getPrincipal());
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/edit/startup/"+leadId+"/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateLead(@RequestBody CrmLead lead, HttpServletRequest req){
		lead.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(lead,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/edit/status",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateLeadStatusToConverted(@RequestBody String json, HttpServletRequest req){
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(json, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/edit/status/"+map.get("leadID")+"/"+map.get("custId")+"/"+map.get("opId"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/remove/{leadID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteLead(@PathVariable("leadID") String leadID, HttpServletRequest req){
		CrmLead lead = new CrmLead();
		lead.setLeadID(leadID);
		lead.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(lead, header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/remove/", HttpMethod.POST, request, Map.class);
		 
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	///api/lead/edit/startup
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead/startup",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> startupViewLead(@RequestBody String json, HttpServletRequest req){
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(json, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/lead/edit/startup/"+map.get("leadId")+"/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	private String getPrincipal() {
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
