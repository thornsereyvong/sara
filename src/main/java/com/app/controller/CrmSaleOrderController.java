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
import com.app.entities.SaleOrder;
import com.fasterxml.jackson.databind.ObjectMapper;

@RestController
@RequestMapping(value="/")
public class CrmSaleOrderController {
	
	RestTemplate  restTemplate = new RestTemplate();
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/status/{saleId}/{status}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> updateStatus(@PathVariable("saleId") String saleId,@PathVariable("status") String status, HttpServletRequest req){			
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/edit/post_status/"+saleId+"/"+status, HttpMethod.POST, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/list-content-by-id/{saleId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getContentQuoteId(@PathVariable("saleId") String saleId, HttpServletRequest req){			
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/list/edit/"+saleId, HttpMethod.POST, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());			
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/list-all-sale-order",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listQuote(HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/list", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/list/{saleId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listQuote(@PathVariable("saleId") String saleId, HttpServletRequest req){
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/list"+saleId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/insert-sale-order",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> insertQuote(@RequestBody SaleOrder obj, HttpServletRequest req){
		obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/delete-sale-order/{saleId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteQuote(@PathVariable("saleId") String saleId, HttpServletRequest req){
		SaleOrder saleOrder = new SaleOrder();
		saleOrder.setSaleId(saleId);
		saleOrder.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(saleOrder, header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/remove/", HttpMethod.POST, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/edit-sale-order",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> editQuote(@RequestBody SaleOrder obj, HttpServletRequest req){
		obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/edit", HttpMethod.POST, request, Map.class);			
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/sale-order/check-entry-no",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> checkEntryNo(@RequestBody String obj, HttpServletRequest req){	
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(obj, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getClass(),header);			
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/sale_order/check_entry_no/"+map.get("saleId"), HttpMethod.POST, request, Map.class);			
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
