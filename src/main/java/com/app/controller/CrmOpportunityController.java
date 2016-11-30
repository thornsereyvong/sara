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

import com.app.entities.CrmOpportunity;
import com.app.entities.CrmOpportunityContact;
import com.app.entities.CrmOpportunityQuotation;
import com.app.entities.CrmOpportunitySaleorder;
import com.app.entities.MeDataSource;
import com.fasterxml.jackson.databind.ObjectMapper;



@RestController
@RequestMapping(value="/")
public class CrmOpportunityController {
	
	
	@Autowired
	private RestTemplate  restTemplate;
	
	@Autowired
	private HttpHeaders header;
	
	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/product/add/detail",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addOpportunityProduct(@RequestBody CrmOpportunity opp, HttpServletRequest req){
		opp.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(opp,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/edit", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/add/startup",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getStartup(@RequestBody String json, HttpServletRequest req){	
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(json, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/add/startup/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	/*Opportunity Contact Block*/
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/contact/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addContact(@RequestBody CrmOpportunityContact obj, HttpServletRequest req){	
		
		System.err.println(obj.getOpId()+"/"+obj.getConId()+"/"+obj.getOpConType());
		obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity_contact/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/contact/delete/{opConId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteContact(@PathVariable("opConId") Integer opConId, HttpServletRequest req){	
		CrmOpportunityContact contact = new CrmOpportunityContact();
		contact.setOpConId(opConId);
		contact.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(contact, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity_contact/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/contact/list/{oppId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listContactByOpp(@PathVariable("oppId") String oppId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/startup/contact/"+oppId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	/*End Block*/
	
	
	/*Opprtunity Quote Block*/
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/quote/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addQuote(@RequestBody CrmOpportunityQuotation obj, HttpServletRequest req){
		obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity_quote/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/quote/delete/{opQuoteId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteQuote(@PathVariable("opQuoteId") Integer opQuoteId, HttpServletRequest req){	
		CrmOpportunityQuotation opQuote = new CrmOpportunityQuotation();
		opQuote.setOpQuoteId(opQuoteId);
		HttpEntity<Object> request = new HttpEntity<Object>(opQuote,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity_quote/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/quote/list/{oppId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listQuoteByOpp(@PathVariable("oppId") String oppId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/startup/quote/"+oppId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	/*End Opportunity Quote Block*/
	
	
	/*Start Opportunity SaleOrder*/
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/sale_order/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addSaleOrder(@RequestBody CrmOpportunitySaleorder obj, HttpServletRequest req){
		obj.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(obj,header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity_saleorder/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/sale_order/delete/{saleId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteSaleOrder(@PathVariable("saleId") Integer saleId, HttpServletRequest req){	
		CrmOpportunitySaleorder opSaleorder = new CrmOpportunitySaleorder();
		opSaleorder.setOpSaleId(saleId);
		opSaleorder.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(opSaleorder, header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity_saleorder/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/sale_order/list/{oppId}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> listSaleOrderByOpp(@PathVariable("oppId") String oppId, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/startup/saleorder/"+oppId, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	/*End Opportunity Block*/
	
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/edit/startup",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getStartupWithEdit(@RequestBody String obj, HttpServletRequest req){	
		System.out.println(obj);
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(obj, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()),header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/edit/startup/"+map.get("opId")+"/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
		
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/list",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> getAllOpportunity(@RequestBody String json, HttpServletRequest req){	
		System.out.println(json);
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(json, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/list/user/"+map.get("username"), HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/list_all",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> getsAllOpportunity(HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/list_all", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/list/{opp}",method = RequestMethod.GET)
	public ResponseEntity<Map<String, Object>> findOpportunity(@PathVariable("opp") String opp, HttpServletRequest req){	
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/list/"+opp, HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	

	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/add",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> addOpportunity(@RequestBody CrmOpportunity opp, HttpServletRequest req){
		System.err.println(opp.getCustomer().getCustID());
		opp.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(opp,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/add", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/edit",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateOpportunity(@RequestBody CrmOpportunity opp, HttpServletRequest req){
		opp.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(opp,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/edit", HttpMethod.POST, request, Map.class);	
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/edit/custom",method = RequestMethod.PUT)
	public ResponseEntity<Map<String, Object>> updateCustomOpportunity(@RequestBody CrmOpportunity opp, HttpServletRequest req){
		opp.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		
		dataSource.toString();
		
		HttpEntity<Object> request = new HttpEntity<Object>(opp,header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/edit/custom", HttpMethod.POST, request, Map.class);	
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
		
	}
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/remove/{opId}",method = RequestMethod.DELETE)
	public ResponseEntity<Map<String, Object>> deleteOpportunity(@PathVariable("opId") String opId, HttpServletRequest req){
		CrmOpportunity opp = new CrmOpportunity();
		opp.setOpId(opId);
		opp.setMeDataSource(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()));
		HttpEntity<Object> request = new HttpEntity<Object>(opp, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/remove/", HttpMethod.POST, request, Map.class);
		return new ResponseEntity<Map<String,Object>>(response.getBody(), response.getStatusCode());
	}
	
	
	@SuppressWarnings({ "unchecked", "rawtypes" })
	@RequestMapping(value="/opportunity/view",method = RequestMethod.POST)
	public ResponseEntity<Map<String, Object>> viewOpportunity(@RequestBody String obj, HttpServletRequest req){
		Map<String, String> map = new HashMap<String, String>();
		try {
			map = new ObjectMapper().readValue(obj, Map.class);
		} catch (IOException e) {
			e.printStackTrace();
		}
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource.getMeDataSourceByHttpServlet(req, getPrincipal()), header);	
		ResponseEntity<Map> response = restTemplate.exchange(URL+"api/opportunity/view/"+map.get("opId")+"/"+map.get("username"), HttpMethod.POST, request, Map.class);
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
