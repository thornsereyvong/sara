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

import com.app.entities.CrmMeeting;
import com.app.entities.MeDataSource;
import com.fasterxml.jackson.databind.ObjectMapper;


@RestController
@RequestMapping(value="/")
public class CrmMeetingController {
	
	//private final String URL = "";
	@Autowired
	private ObjectMapper objectMapper;
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	private MeDataSource dataSource = new MeDataSource();
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllmeeting(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/list/{meetingId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findmeetingById(@PathVariable("meetingId") String meetingId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/list/"+meetingId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addmeeting(@RequestBody CrmMeeting meeting, HttpServletRequest req){
		meeting.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(meeting,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updatemeeting(@RequestBody CrmMeeting meeting, HttpServletRequest req){
		meeting.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(meeting,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/remove/{meetingId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deletemeeting(@PathVariable("meetingId") String meetingId, HttpServletRequest req){
		CrmMeeting meeting = new CrmMeeting();
		meeting.setMeetingId(meetingId);
		meeting.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/remove/", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/list-by-lead/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listMeetingByLeadId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/list/lead/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting/list-by-opportunity/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listMeetingByOpportunityId(@PathVariable("id") String id, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/list/opp/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="meeting/list/module/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listMeetingByRelateId(@PathVariable("id") String id, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting/list/module/"+id, HttpMethod.POST, request, Map.class);		
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
