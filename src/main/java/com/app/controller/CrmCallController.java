package com.app.controller;

import java.util.Map;

import javax.servlet.http.HttpServletRequest;

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

import com.app.entities.CrmCall;
import com.app.entities.MeDataSource;




@RestController
@RequestMapping("/")
public class CrmCallController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllCall(HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/add", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addCall(@RequestBody CrmCall call, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		System.out.println(req.getSession().getAttribute("databaseName").toString());
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		call.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(call,header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/add", HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> CallID(@PathVariable("id") String id, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/view/"+id, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCall(@RequestBody CrmCall call, HttpServletRequest req){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		call.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(call, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/remove/{callID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteCall(@PathVariable("callID") String callID, HttpServletRequest req){
		CrmCall call = new CrmCall();
		call.setCallId(callID);
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		call.setMeDataSource(dataSource);
		HttpEntity<Object> request = new HttpEntity<Object>(call, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/remove", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/list-by-lead/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listCallByLeadId(@PathVariable("id") String id, HttpServletRequest req){	
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list/lead/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call/list-by-opportunity/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listCallByOpportunityId(@PathVariable("id") String id, HttpServletRequest req){		
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list/opp/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="call/list/module/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listCallByRelateId(@PathVariable("id") String id, HttpServletRequest req){		
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb(req.getSession().getAttribute("databaseName").toString());
		dataSource.setIp(req.getSession().getAttribute("ip").toString());
		dataSource.setPort(req.getSession().getAttribute("port").toString());
		dataSource.setUn(req.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(req.getSession().getAttribute("passworddb").toString());
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/call/list/module/"+id, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
}
