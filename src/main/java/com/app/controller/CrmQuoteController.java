package com.app.controller;

import java.io.IOException;
import java.util.HashMap;
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
import com.app.entities.Quote;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping(value="/")
public class CrmQuoteController {
		
		RestTemplate  restTemplate = new RestTemplate();
		
		@Autowired
		private HttpHeaders header;
		
		@Autowired
		private String URL;
		
		@Autowired
		private MeDataSource dataSource;
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list-content",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getContentQuote(HttpServletRequest req){			
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list-content-by-id/{saleId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getContentQuoteId(@PathVariable("saleId") String saleId, HttpServletRequest req){	
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list/edit/"+saleId, HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}	
		
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/itemChange",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> changeItem(@RequestBody String obj, HttpServletRequest req){	
			Map<String, String> map = new HashMap<String, String>();
			try {
				map = new ObjectMapper().readValue(obj, Map.class);
			} catch (IOException e) {
				e.printStackTrace();
			}
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/item_change/"+map.get("priceCode")+"/"+map.get("itemId"), HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/qty-available",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> qtyAvailable(@RequestBody String obj, HttpServletRequest req){
			Map<String, String> map = new HashMap<String, String>();
			try {
				map = new ObjectMapper().readValue(obj, Map.class);
			} catch (IOException e) {
				e.printStackTrace();
			}
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/qty_available/"+map.get("itemId")+"/"+map.get("locationId"), HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}	
			
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list-all-quote",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> listQuote(HttpServletRequest req){
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list_all", HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list/{saleId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> listQuote(@PathVariable("saleId") String saleId, HttpServletRequest req){
			System.out.println(saleId);
			HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list/"+saleId, HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/insert-quote",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> insertQuote(@RequestBody Quote obj, HttpServletRequest req){
			obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/add", HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/delete-quote/{saleId}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteQuote(@PathVariable("saleId") String saleId, HttpServletRequest req){	
			Quote quote = new Quote();
			quote.setSaleId(saleId);
			quote.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(quote, header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/remove/", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/edit-quote",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> editQuote(@RequestBody Quote obj, HttpServletRequest req){	
			obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/edit", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/check-entry-no",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> checkEntryNo(@RequestBody String obj, HttpServletRequest req){	
			Map<String, String> map = new HashMap<String, String>();
			try {
				map = new ObjectMapper().readValue(obj, Map.class);
			} catch (IOException e) {
				e.printStackTrace();
			}
			HttpEntity<String> request = new HttpEntity<String>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/check_entry_no/"+map.get("quoteId"), HttpMethod.POST, request, Map.class);			
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
