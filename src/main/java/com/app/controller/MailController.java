package com.app.controller;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import com.app.entities.MailMessage;

@RestController
@RequestMapping("/mail")
public class MailController {

RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/call_status/list",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> sendEmail(@RequestBody MailMessage mailMessage, @RequestParam CommonsMultipartFile attachFile){
		mailMessage.setAttachement(attachFile);
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/mail/send", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
}
