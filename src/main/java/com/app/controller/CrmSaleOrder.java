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
import com.app.entities.SaleOrder;

@RestController
@RequestMapping(value="/")
public class CrmSaleOrder {
	
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/list-content-by-id/{saleId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getContentQuoteId(@PathVariable("saleId") String saleId){			
		HttpEntity<String> request = new HttpEntity<String>(header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/list/edit/"+saleId, HttpMethod.GET, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/list-all-sale-order",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listQuote(){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/list", HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/list/{saleId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listQuote(@PathVariable("saleId") String saleId){
		HttpEntity<Object> request = new HttpEntity<Object>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/list"+saleId, HttpMethod.GET, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/insert-sale-order",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> insertQuote(@RequestBody SaleOrder obj){
		
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/delete-sale-order/{saleId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteQuote(@PathVariable("saleId") String saleId){			
		HttpEntity<String> request = new HttpEntity<String>(header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/remove/"+saleId, HttpMethod.DELETE, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/edit-sale-order",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> editQuote(@RequestBody SaleOrder obj){			
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/edit", HttpMethod.PUT, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/check-entry-no",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> checkEntryNo(@RequestBody String obj){			
		HttpEntity<String> request = new HttpEntity<String>(obj,header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/check_entry_no", HttpMethod.POST, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
}
