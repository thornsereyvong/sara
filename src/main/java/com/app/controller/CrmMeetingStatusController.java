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

import com.app.entities.CrmMeetingStatus;
import com.app.entities.MeDataSource;




@RestController
@RequestMapping("/")
public class CrmMeetingStatusController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting_status/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllMeetingStatus(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting_status/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting_status/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addMeetingStatus(@RequestBody CrmMeetingStatus status, HttpServletRequest req){
		status.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(status, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting_status/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting_status/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> MeetingStatusID(@PathVariable("id") String id, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting_status/list/"+id, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting_status/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateMeetingStatus(@RequestBody CrmMeetingStatus status, HttpServletRequest req){
		status.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(status,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting_status/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/meeting_status/remove/{statusID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteMeetingStatus(@PathVariable("statusID") int statusID, HttpServletRequest req){
		CrmMeetingStatus status = new CrmMeetingStatus();
		status.setStatusId(statusID);
		status.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(status, header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/meeting_status/remove", HttpMethod.POST, request, Map.class);
		
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
