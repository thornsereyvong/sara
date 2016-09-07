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

import com.app.entities.CrmNote;


@RestController
@RequestMapping("/")
public class CrmNoteController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllNote(){
		
		HttpEntity<String> request = new HttpEntity<String>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list", HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addNote(@RequestBody CrmNote obj){
		
		System.out.println(obj.getNoteDes());
		
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/add", HttpMethod.POST, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> NoteID(@PathVariable("id") String id){
		
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list/"+id, HttpMethod.GET, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateNote(@RequestBody CrmNote obj){
		
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/edit", HttpMethod.PUT, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/remove/{statusID}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteNote(@PathVariable("statusID") String statusID){
		
		HttpEntity<String> request = new HttpEntity<String>(statusID,header);
		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/remove/"+statusID, HttpMethod.DELETE, request, Map.class);
		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
}
