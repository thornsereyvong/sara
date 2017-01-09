package com.app.controller.hbu;

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

import com.app.entities.HBUItemCompetitor;
import com.app.entities.HBUItemCustomer;
import com.app.entities.MeDataSource;

@RestController
@RequestMapping("/item")
public class HRUItemController {
	
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/view/{itemId}", method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findHBUItemById(HttpServletRequest req, @PathVariable("itemId") String itemId){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/item/view/"+itemId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/add", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> listCompetitor(HttpServletRequest req, @RequestBody HBUItemCompetitor itemCompetitor){
		itemCompetitor.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(itemCompetitor, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/item/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/add/customer", method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> listCustomer(HttpServletRequest req, @RequestBody HBUItemCustomer itemCustomer){
		itemCustomer.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(itemCustomer, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/item/add/customer", HttpMethod.POST, request, Map.class);
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
