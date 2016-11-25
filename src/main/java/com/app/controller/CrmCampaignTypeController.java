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

import com.app.entities.CrmCampaignType;
import com.app.entities.MeDataSource;

@RestController
@RequestMapping("/")
public class CrmCampaignTypeController {

	//private final String URL = "";
		RestTemplate  restTemplate = new RestTemplate();
		
		@Autowired
		private HttpHeaders header;
		
		@Autowired
		private String URL;
		
		@Autowired
		private MeDataSource dataSource;
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/camp_type/list",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getAllCampaignType(HttpServletRequest req){
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/camp_type/list", HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/camp_type/add",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> addCampaign(@RequestBody CrmCampaignType type, HttpServletRequest req){
			type.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(type, header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/camp_type/add", HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/camp_type/list/{id}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> CampaignStatusID(@PathVariable("id") String id, HttpServletRequest req){
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/camp_type/list/"+id, HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/camp_type/edit",method = RequestMethod.PUT)
		public ResponseEntity<Map<String, Object>> updateCampaignStatus(@RequestBody CrmCampaignType type, HttpServletRequest req){
			type.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(type, header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/camp_type/edit", HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/camp_type/remove/{typeID}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("typeID") int typeID, HttpServletRequest req){
			CrmCampaignType type = new CrmCampaignType();
			type.setTypeID(typeID);
			type.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(type, header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/camp_type/remove/", HttpMethod.POST, request, Map.class);
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
