package com.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;

import com.app.entities.MeDataSource;


@RestController
@RequestMapping("/")
public class CompanyController {

	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/config", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getDatabaseName(){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb("systemdatabase");
		dataSource.setIp("192.168.0.2");
		dataSource.setPort("3306");
		dataSource.setUn("posadmin");
		dataSource.setPw("Pa$$w0rd");
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/config/database/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/database", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> listDatabases(){
		MeDataSource dataSource = new MeDataSource();
		dataSource.setDb("systemdatabase");
		dataSource.setIp("192.168.0.2");
		dataSource.setPort("3306");
		dataSource.setUn("posadmin");
		dataSource.setPw("Pa$$w0rd");
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/config/database/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
}
