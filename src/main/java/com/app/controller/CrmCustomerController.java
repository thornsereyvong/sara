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

import com.app.entities.CrmCustomer;
import com.app.entities.MeDataSource;

@RestController
@RequestMapping("/")
public class CrmCustomerController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/view/{userId}/{custId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> viewCustomer( @PathVariable("userId") String userId, @PathVariable("custId") String custId, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/view/"+custId+"/"+userId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCustomer(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/startup",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCustomerStartup(HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/add/startup", HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/startup/{custId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCustomerStartupById(@PathVariable("custId") String custId, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/edit/startup/"+custId, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCustomer(@RequestBody CrmCustomer customer, HttpServletRequest req){
		customer.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(customer,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/list/{custID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findCustomerID(@PathVariable("custID") String custID, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/list/"+custID, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCustomer(@RequestBody CrmCustomer customer, HttpServletRequest req){
		customer.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(customer,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/customer/remove/{custId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCustomer(@PathVariable("custId") String custId, HttpServletRequest req){
		CrmCustomer customer = new CrmCustomer();
		customer.setCustID(custId);
		customer.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(customer, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/customer/remove/", HttpMethod.POST, request, Map.class);
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
