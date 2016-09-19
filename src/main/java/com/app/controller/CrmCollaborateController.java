package com.app.controller;

import java.util.Map;

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

import com.app.entities.CrmCollaboration;
import com.app.entities.CrmCollaborationDetails;

@RestController
@RequestMapping(value="/")
public class CrmCollaborateController {
	
		
		@Autowired
		private RestTemplate  restTemplate;
		
		@Autowired
		private HttpHeaders header;
		
		@Autowired
		private String URL;
		
		
		
		
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/lead/user",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> getCollaborateByLeadIdByUsername(@RequestBody String obj){			
			HttpEntity<String> request = new HttpEntity<String>(obj,header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/list", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/list/module/{leadId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getCollaborateByRelated(@PathVariable("leadid") String leadId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
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
		public ResponseEntity<Map<String, Object>> addCollaborate(@RequestBody CrmCollaboration collaboration){			
			HttpEntity<Object> request = new HttpEntity<Object>(collaboration,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/add", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/edit",method = RequestMethod.PUT)
		public ResponseEntity<Map<String, Object>> editCollaboration(@RequestBody CrmCollaboration collaboration){			
			HttpEntity<Object> request = new HttpEntity<Object>(collaboration,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/edit", HttpMethod.PUT, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/delete/{collabId}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteCollaboration(@PathVariable("collabId") String collabId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/remove/"+collabId, HttpMethod.DELETE, request, Map.class);			
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
		public ResponseEntity<Map<String, Object>> likePost(@RequestBody String obj){	
			System.out.println(obj.toString());
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/like/like", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
				
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/add/comment",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> addComment(@RequestBody CrmCollaborationDetails obj){									
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/collaboration/details/add", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/comment/remove/{comId}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deletedComment(@PathVariable("comId") int comId){									
			HttpEntity<Object> request = new HttpEntity<Object>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"/api/collaboration/details/remove/"+comId, HttpMethod.PUT, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		
}
