package com.app.controller;

import java.io.IOException;
import java.util.HashMap;
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

import com.app.entities.CrmCollaboration;
import com.app.entities.CrmCollaborationDetails;
import com.app.entities.MeDataSource;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping(value="/")
public class CrmCollaborateController {
	
		
		@Autowired
		private RestTemplate  restTemplate;
		
		@Autowired
		private HttpHeaders header;
		
		@Autowired
		private String URL;
		
		@Autowired
		private MeDataSource dataSource;
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/lead/user",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> getCollaborateByLeadIdByUsername(@RequestBody String obj, HttpServletRequest req){
			ObjectMapper mapper = new ObjectMapper();
			Map<String, String> map = new HashMap<String, String>();
			try {
				 map = mapper.readValue(obj, Map.class);
			} catch (IOException e) {
				e.printStackTrace();
			}
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/list/"+map.get("moduleId").toString(), HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/module/{moduleId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getCollaborateByRelated(@PathVariable("moduleId") String moduleId, HttpServletRequest req){
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/list/"+moduleId, HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/lead/{leadId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getCollaborateByLeadId(@PathVariable("leadid") String leadId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/opportunity/{oppId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getCollaborateByOpportunityId(@PathVariable("oppId") String oppId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/opportunity/username",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> getCollaborateByOpportunityIdByUsername(@RequestBody String obj){			
			HttpEntity<String> request = new HttpEntity<String>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/list", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/add",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> addCollaborate(@RequestBody CrmCollaboration collaboration, HttpServletRequest req){	
			collaboration.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(collaboration,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/add", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/edit",method = RequestMethod.PUT)
		public ResponseEntity<Map<String, Object>> editCollaboration(@RequestBody CrmCollaboration collaboration, HttpServletRequest req){	
			collaboration.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(collaboration,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/edit", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/delete/{collabId}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteCollaboration(@PathVariable("collabId") int collabId, HttpServletRequest req){	
			CrmCollaboration collaboration = new CrmCollaboration();
			collaboration.setColId(collabId);
			collaboration.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(collaboration, header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/remove/", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/delete-detail/{collabId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> deleteDetailCollaborate(@PathVariable("collabId") String collabId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/like",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> likePost(@RequestBody String obj, HttpServletRequest req){	
			System.out.println(obj.toString());
			Map<String, Object> map = new HashMap<String, Object>();
			try {
				map = new ObjectMapper().readValue(obj, Map.class);
			} catch (IOException e) {
				e.printStackTrace();
			}
			String likeStatus = map.get("likeStatus").toString();
			String username = map.get("username").toString();
			int collapId = (int)map.get("collapId");
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/like/like/"+likeStatus+"/"+collapId+"/"+username, HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
				
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/add/comment",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> addComment(@RequestBody CrmCollaborationDetails obj, HttpServletRequest req){	
			obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/details/add", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/comment/remove/{comId}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deletedComment(@PathVariable("comId") int comId, HttpServletRequest req){	
			CrmCollaborationDetails details = new CrmCollaborationDetails();
			details.setCommentId(comId);
			details.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(details, header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"/api/collaboration/details/remove/", HttpMethod.POST, request, Map.class);			
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
