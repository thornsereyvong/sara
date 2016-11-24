package com.app.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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
import com.app.entities.CrmTaskStatus;
import com.app.entities.MeDataSource;


@RestController
@RequestMapping("/")
public class CrmTaskStatusController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private MainController mainController;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task_status/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllTaskStatus(HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());				
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task_status/list", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task_status/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addTaskStatus(@RequestBody CrmTaskStatus status,HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());	
		
		status.setMeDataSource(dataSource);
		
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task_status/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task_status/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> TaskStatusID(@PathVariable("id") String id,HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());	
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task_status/list/"+id, HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task_status/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateTaskStatus(@RequestBody CrmTaskStatus status,HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());	
		status.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task_status/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/task_status/remove/{statusID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteTaskStatus(@PathVariable("statusID") int statusID,HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());	
		CrmTaskStatus status = new CrmTaskStatus();
		status.setTaskStatusId(statusID);
		status.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/task_status/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
