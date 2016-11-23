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
import com.app.entities.CrmContact;
import com.app.entities.MeDataSource;
import com.app.utilities.RestUtil;


@RestController
@RequestMapping(value="/")
public class CrmContactController {
	
	@Autowired
	private MainController mainController;
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/view/{userId}/{custId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> viewContact( @PathVariable("userId") String userId, @PathVariable("custId") String custId, HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/view/"+custId+"/"+userId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/startup/{username}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getStartup(@PathVariable("username") String username,HttpServletRequest req){		
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/startup/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/startup/{username}/{conId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getStartupWithEdit(@PathVariable("username") String username ,@PathVariable("conId") String conId,HttpServletRequest req){	
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/startup/"+username+"/"+conId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/list", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getAllContact(HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());
		
		System.out.println(dataSource.toString());
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/list/validate/{contact}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getContact(@PathVariable("contact") String contact){	
		HttpEntity<String> request = new HttpEntity<String>(header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/list/validate/"+contact, HttpMethod.GET, request, Map.class);
		try{
			if(RestUtil.isError(response.getStatusCode())){
				 return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			}else{
				return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			}	
		}catch (Exception e) {
			throw new RuntimeException(e);
		}
		
	}
	
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/list/{contact}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findContactById(@PathVariable("contact") String contact, HttpServletRequest req){	
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());		
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/list/"+contact, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/add/startup",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addStartup(@RequestBody String obj,HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/startup/"+obj, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addContact(@RequestBody CrmContact contact, HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());		
		contact.setMeDataSource(dataSource);
		
		HttpEntity<Object> request = new HttpEntity<Object>(contact,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/edit",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> updateContact(@RequestBody CrmContact contact, HttpServletRequest req){
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());		
		contact.setMeDataSource(dataSource);
		
		HttpEntity<Object> request = new HttpEntity<Object>(contact,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/edit", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/contact/remove/{contact}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("contact") String contact,HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req,mainController.getPrincipal());
		CrmContact con = new CrmContact();
		con.setConID(contact);
		con.setMeDataSource(dataSource);
		
		HttpEntity<Object> request = new HttpEntity<Object>(con,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/contact/remove", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
}
