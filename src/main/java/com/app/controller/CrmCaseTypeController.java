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






import com.app.entities.CrmCaseType;
import com.app.entities.MeDataSource;


@RestController
@RequestMapping("/")
public class CrmCaseTypeController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/case_type/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCaseType(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case_type/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/case_type/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCaseType(@RequestBody CrmCaseType status){
		
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case_type/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/case_type/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> CaseTypeID(@PathVariable("id") String id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case_type/list/"+id, HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/case_type/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCaseType(@RequestBody CrmCaseType status){
		
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case_type/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/case_type/remove/{statusID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCaseType(@PathVariable("statusID") String statusID){
		
		HttpEntity<String> request = new HttpEntity<String>(statusID,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case_type/remove/"+statusID, HttpMethod.DELETE, request, Map.class);
		
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
