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

import com.app.entities.CrmLeadProject;
import com.app.entities.MeDataSource;

@RestController
@RequestMapping("/project")
public class LeadProjectController {

	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addLeadProject(@RequestBody CrmLeadProject leadProject, HttpServletRequest req){
		leadProject.setDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(leadProject,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/project/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateLeadProject(@RequestBody CrmLeadProject leadProject, HttpServletRequest req){
		leadProject.setDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(leadProject,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/project/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/remove/{id}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteLeadProject(@PathVariable("id") int id, HttpServletRequest req){
		CrmLeadProject leadProject = new CrmLeadProject();
		leadProject.setId(id);
		leadProject.setDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(leadProject,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/project/remove", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/view/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findLeadProjectById(@PathVariable("id") int id, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/project/view/"+id, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listLeadProjects(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/project/list", HttpMethod.POST, request, Map.class);
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
