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

import com.app.entities.CrmCaseArticle;
import com.app.entities.MeDataSource;


@RestController
@RequestMapping(value="/")
public class CrmArticleController {
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/article/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getArticles(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case-article/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/article/startup",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> startupAddPage(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case-article/startup/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	/*
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/list/validate/{campName}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getCampName(@PathVariable("campName") String campName, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);	
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
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/list/"+campID, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/list/not_equal/{campID}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> campNotQu(@PathVariable("campID") String campID, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/list/not_equal/"+campID, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCampaign(@RequestBody CrmCampaign campaign, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		campaign.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/edit/startup/{campId}/{username}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> editCampaignOnStartup(@PathVariable("campId") String campId, @PathVariable("username") String username, HttpServletRequest req){
		CrmCampaign campaign = new CrmCampaign();
		campaign.setCampID(campId);
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		campaign.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/edit/startup/"+username, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/campaign/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCampaign(@RequestBody CrmCampaign campaign, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		campaign.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(campaign,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/campaign/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}*/
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/article/remove/{articleId}",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> deleteCampaign(@PathVariable("articleId") String articleId, HttpServletRequest req){
		CrmCaseArticle article = new CrmCaseArticle();
		article.setArticleId(articleId);
		article.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(article,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/case-article/remove", HttpMethod.POST, request, Map.class);
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
