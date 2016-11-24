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

import com.app.entities.CrmTask;
import com.app.entities.MeDataSource;
import com.fasterxml.jackson.databind.ObjectMapper;


@RestController
@RequestMapping(value="/")
public class CrmTaskController {
	
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAlltask(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/list/{taskId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findtaskById(@PathVariable("taskId") String taskId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/list/"+taskId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addtask(@RequestBody CrmTask task, HttpServletRequest req){
		task.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(task,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateTask(@RequestBody CrmTask task, HttpServletRequest req){
		task.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(task,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/remove/{taskId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteTask(@PathVariable("taskId") String taskId, HttpServletRequest req){
		CrmTask task = new CrmTask();
		task.setTaskId(taskId);
		task.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(task, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/list-by-lead/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listTaskByLeadId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/list/lead/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task/list-by-opportunity/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listTaskByOpportunityId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/list/opp/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="task/list/module/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listTaskByRelateId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task/list/module/"+id, HttpMethod.POST, request, Map.class);		
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
