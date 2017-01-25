package com.app.controller.report;

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

import com.app.entities.MeDataSource;
import com.app.entities.report.CampaingReport;
import com.app.viewresolver.CampaignExcelView;

@RestController
@RequestMapping(value="/report/campaign")
public class CampaignReportController {
	
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/top-campaign",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> topCampaign(@RequestBody CampaingReport campaingReport, HttpServletRequest req){
		campaingReport.setDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(campaingReport, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/report/campaign/top-campaign", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/lead-by-campaign",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> LeadByCampaign(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/report/campaign/lead-by-campaign", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/startup/{userId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> campaignReportStartup(@PathVariable("userId") String userId, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, userId), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"/api/report/campaign/startup/"+userId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	
	public String getPrincipal() {
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
