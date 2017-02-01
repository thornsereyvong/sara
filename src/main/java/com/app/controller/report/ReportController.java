package com.app.controller.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.client.RestTemplate;

import com.app.entities.MeDataSource;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
@RequestMapping("report/")
public class ReportController {

	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	private HttpHeaders header;

	@Autowired
	private String URL;
	
	
	@RequestMapping({ "marketing/campaign/top-campaign"})
	public String topCampaign(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "topCampaign");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA_0001",req);
		if(camMap.get("access").equals("YES")){
			return "reportApp/marketing/topCampaign";
		}else{
			return "permission";
		}
	}
	
	@RequestMapping({ "marketing/campaign/lead-by-campaign"})
	public String leadByCampaign(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "leadByCampaign");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA_0002",req);
		if(camMap.get("access").equals("YES")){
			return "reportApp/marketing/leadByCampaign";
		}else{
			return "permission";
		}
		
		
	}
	
	@RequestMapping({ "marketing/lead/report-lead"})
	public String leadReport(ModelMap model) {
		model.addAttribute("menu", "leadReport");
		return "reportApp/marketing/leadReport";
	}
	
	@RequestMapping({ "support/case"})
	public String caseReport(ModelMap model) {
		model.addAttribute("menu", "reportCase");
		return "reportApp/support/caseReport";
	}
	
	
	
	
	
	
	
	
	// end report URL
	
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
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> getRoleDetailsOfModule_old(String moduleId,HttpServletRequest req) {
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req, getPrincipal());		
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL + "api/role_detail/list/user/" + getPrincipal() + "/"
				+ moduleId, HttpMethod.POST, request, Map.class);

		Map<String, Object> userMap = (HashMap<String, Object>) response.getBody();
		
		
		
		if (userMap.get("DATA") != null) {
			return (Map<String, Object>) userMap.get("DATA");
		}
		return new HashMap<>();
	}
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> getRoleDetailsOfModule(String moduleId,HttpServletRequest req) {
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req, getPrincipal());		
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL + "api/module/role-detail/" + getPrincipal() + "/"
				+ moduleId, HttpMethod.POST, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>) response.getBody();	
		ArrayList<Map<String, Object>> mapData = (ArrayList<Map<String, Object>>) response.getBody().get("DATA");
		userMap = (Map<String, Object>) mapData.get(0);
		return userMap;
	}
	
	
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getRoleDetailsAllModule(HttpServletRequest req) {
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req, getPrincipal());		
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL + "api/role/list/role_by_user", HttpMethod.POST, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>) response.getBody();
		if (userMap.get("DATA") != null) {
			try {
				String json = new ObjectMapper().writeValueAsString(userMap.get("DATA"));
				return json;
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}
	
	private String getErrorMessage(HttpServletRequest request, String key){
		Exception exception = (Exception) request.getSession().getAttribute(key);
		String error = "";
		if (exception instanceof BadCredentialsException) {
			error = exception.getMessage();
		}
		return error;
	}
	
}
