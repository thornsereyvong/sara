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

import com.app.entities.CrmUser;
import com.app.entities.MeDataSource;

@RestController
public class CrmDashboardController {
	
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/dashboard/startup/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> dashboardStartup(@PathVariable("username") String username, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/dashboard/view/"+username, HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/dashboard/conf",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> dashboardConf(@RequestBody CrmUser user, HttpServletRequest req){
		
		user.setDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));		
		HttpEntity<Object> request = new HttpEntity<Object>(user, header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/dashboard/conf", HttpMethod.POST, request, Map.class);		
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
