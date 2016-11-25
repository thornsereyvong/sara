package com.app.controller;

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

import com.app.entities.CrmOpportunityStage;
import com.app.entities.MeDataSource;



@RestController
@RequestMapping("/")
public class CrmOpportunityStageController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllOpportunityStage(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addStage(@RequestBody CrmOpportunityStage stage, HttpServletRequest req){
		stage.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(stage,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> oppStageID(@PathVariable("id") String id, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/list/"+id, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateStage(@RequestBody CrmOpportunityStage stage, HttpServletRequest req){
		stage.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(stage,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/op_stage/remove/{stageId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteStage(@PathVariable("stageId") int stageId, HttpServletRequest req){
		CrmOpportunityStage stage = new CrmOpportunityStage();
		stage.setOsId(stageId);
		stage.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(stage, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/op_stage/remove/", HttpMethod.POST, request, Map.class);
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
