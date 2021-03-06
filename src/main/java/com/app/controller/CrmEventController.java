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

import com.app.entities.CrmEvent;
import com.app.entities.MeDataSource;


@RestController
@RequestMapping(value="/")
public class CrmEventController {
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	private MeDataSource dataSource = new MeDataSource();
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllevent(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/list/{eventId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findEventById(@PathVariable("eventId") String eventId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/list/"+eventId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addEvent(@RequestBody CrmEvent event, HttpServletRequest req){
		event.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(event,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateEvent(@RequestBody CrmEvent event, HttpServletRequest req){
		event.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(event,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/remove/{eventId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteEvent(@PathVariable("eventId") String eventId, HttpServletRequest req){
		CrmEvent event = new CrmEvent();
		event.setEvId(eventId);
		event.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(event, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/remove", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/list-by-lead/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listEventByLeadId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/list/lead/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/event/list-by-opportunity/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listEventByOpportunityId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/list/opp/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="event/list/module/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listTaskByRelateId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/event/list/module/"+id, HttpMethod.POST, request, Map.class);		
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
