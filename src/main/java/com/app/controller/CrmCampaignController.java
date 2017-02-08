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

import com.app.entities.CrmCampaign;
import com.app.entities.MeDataSource;
import com.app.utilities.RestUtil;


@RestController
@RequestMapping(value="/")
public class CrmCampaignController {
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/view/{userId}/{campId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> viewCampaign(@PathVariable("userId") String userId, @PathVariable("campId") String campId, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()) ,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/view/"+campId+"/"+userId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCampaign(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/add/startup/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> startupAddPage(@PathVariable("username") String username, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/add/startup/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/list/validate/{campName}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getCampName(@PathVariable("campName") String campName, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/list/validate/"+campName, HttpMethod.POST, request, Map.class);
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
	@RequestMapping(value="/campaign/list/{campID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findCampaignById(@PathVariable("campID") String campID, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/list/"+campID, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/list/not_equal/{campID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> campNotQu(@PathVariable("campID") String campID, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/list/not_equal/"+campID, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCampaign(@RequestBody CrmCampaign campaign, HttpServletRequest req){
		campaign.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/edit/startup/{campId}/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> editCampaignOnStartup(@PathVariable("campId") String campId, @PathVariable("username") String username, HttpServletRequest req){
		CrmCampaign campaign = new CrmCampaign();
		campaign.setCampID(campId);
		campaign.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/edit/startup/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCampaign(@RequestBody CrmCampaign campaign, HttpServletRequest req){
		campaign.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/remove/{campId}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("campId") String campId, HttpServletRequest req){
		CrmCampaign campaign = new CrmCampaign();
		campaign.setCampID(campId);
		campaign.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/remove", HttpMethod.POST, request, Map.class);
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
