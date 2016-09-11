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
		@RequestMapping(value="/collaborate/list/lead/user",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getCollaborateByLeadIdByUsername(@RequestBody String obj){			
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
		@RequestMapping(value="/collaborate/list/opportunity/username",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getCollaborateByOpportunityIdByUsername(@RequestBody String obj){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/add",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> addCollaborate(@RequestBody String collab){			
			HttpEntity<String> request = new HttpEntity<String>(collab,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/add",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> addCollaborateDetail(@RequestBody String collab){			
			HttpEntity<String> request = new HttpEntity<String>(collab,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/edit",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> editCollaborate(@RequestBody String collab){			
			HttpEntity<String> request = new HttpEntity<String>(collab,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/collaborate/delete/{collabId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> deleteCollaborate(@PathVariable("collabId") String collabId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
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
		@RequestMapping(value="/collaborate/like",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> likePost(@RequestBody String obj){									
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
				
		
}
