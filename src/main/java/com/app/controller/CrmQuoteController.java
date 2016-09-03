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

import com.app.entities.Quote;
import com.app.utilities.RestUtil;

@RestController
@RequestMapping(value="/")
public class CrmQuoteController {
		
		RestTemplate  restTemplate = new RestTemplate();
		
		@Autowired
		private HttpHeaders header;
		
		@Autowired
		private String URL;
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list-content",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getContentQuote(){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list", HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list-content-by-id/{saleId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> getContentQuoteId(@PathVariable("saleId") String saleId){	
			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list/edit/"+saleId, HttpMethod.GET, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}	
		
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/itemChange",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> changeItem(@RequestBody String obj){			
			HttpEntity<String> request = new HttpEntity<String>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/item_change", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/qty-available",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> qtyAvailable(@RequestBody String obj){			
			HttpEntity<String> request = new HttpEntity<String>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/qty_available", HttpMethod.POST, request, Map.class);
			try{
				if(RestUtil.isError(response.getStatusCode()) ){
					return null;
				}else{
					return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
				}	
			}catch (Exception e) {}
			
			return null;
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list-all-quote",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> listQuote(){
			HttpEntity<Object> request = new HttpEntity<Object>(header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list_all", HttpMethod.GET, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/list/{saleId}",method = RequestMethod.GET)
		public ResponseEntity<Map<String, Object>> listQuote(@PathVariable("saleId") String saleId){
			System.out.println(saleId);
			HttpEntity<Object> request = new HttpEntity<Object>(header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/list/"+saleId, HttpMethod.GET, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/insert-quote",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> insertQuote(@RequestBody Quote obj){
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/add", HttpMethod.POST, request, Map.class);
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/delete-quote/{saleId}",method = RequestMethod.DELETE)
		public ResponseEntity<Map<String, Object>> deleteQuote(@PathVariable("saleId") String saleId){			
			HttpEntity<String> request = new HttpEntity<String>(header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/remove/"+saleId, HttpMethod.DELETE, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/edit-quote",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> editQuote(@RequestBody Quote obj){	
			System.out.println(obj.getSaleId());
			HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/edit", HttpMethod.PUT, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			
		}
		
		@SuppressWarnings({ "unchecked", "rawtypes" })
		@RequestMapping(value="/quote/check-entry-no",method = RequestMethod.POST)
		public ResponseEntity<Map<String, Object>> checkEntryNo(@RequestBody String obj){			
			HttpEntity<String> request = new HttpEntity<String>(obj,header);			
			ResponseEntity<Map> response = restTemplate.exchange(URL+"api/quote/check_entry_no", HttpMethod.POST, request, Map.class);			
			return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
			
		}
		
}
