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

import com.app.entities.CrmNote;
import com.app.entities.MeDataSource;


@RestController
@RequestMapping("/")
public class CrmNoteController {
	
	//private final String URL = "";
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getAllNote(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addNote(@RequestBody CrmNote note, HttpServletRequest req){
		note.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(note,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list/{id}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> NoteID(@PathVariable("id") String id, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list/"+id, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateNote(@RequestBody CrmNote note, HttpServletRequest req){
		note.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(note,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/remove/{noteId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteNote(@PathVariable("noteId") String noteId, HttpServletRequest req){
		CrmNote note = new CrmNote();
		note.setNoteId(noteId);
		note.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(note,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/remove", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list/lead/{relateId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listNoteByRelateLead(@PathVariable("relateId") String relateId, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list/lead/"+relateId, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list/opp/{relateId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listNoteByRelateOpp(@PathVariable("relateId") String relateId, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list/opp/"+relateId, HttpMethod.POST, request, Map.class);		
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());		
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/note/list/module/{relateId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listNoteByRelate(@PathVariable("relateId") String relateId, HttpServletRequest req){		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);		
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/note/list/module/"+relateId, HttpMethod.POST, request, Map.class);		
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
