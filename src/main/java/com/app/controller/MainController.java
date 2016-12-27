package com.app.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpEntity;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpMethod;
import org.springframework.http.ResponseEntity;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.client.RestTemplate;

import com.app.entities.MeDataSource;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {

	@Autowired
	private CrmUserController userController;

	@Autowired
	private CrmMeetingController meetingController;

	@Autowired
	private CrmTaskController taskController;

	@Autowired
	private CrmEventController eventController;

	@Autowired
	private CrmCallController callController;

	@Autowired
	private CrmEventLocationController locationController;

	@Autowired
	private CrmNoteController noteController;

	@Autowired
	private CrmRoleManagementController roleController;

	@Autowired
	private RestTemplate restTemplate;

	@Autowired
	private HttpHeaders header;

	@Autowired
	private String URL;
	
	@Autowired
	private MeDataSource dataSource;

	/* -- Front Page -- */

	@RequestMapping({ "/", "/index", "/home" })
	public String index(ModelMap model, HttpSession session, HttpServletRequest request) {
		model.addAttribute("menu", "index");

		return "index";
	}

	@RequestMapping("/category-type")
	public String categoryType(ModelMap model, HttpServletRequest req) {
		
		model.addAttribute("menu", "categoryType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "categoryType";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/role-management")
	public String roleManagement(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "roleManagement");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA",req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "roleManagement";
		}else{
			return "permission";
		}
		
	}
	
	
	// article path	
		@RequestMapping("/create-article")
		public String article(ModelMap model) {		
			model.addAttribute("menu", "creatArticle");		
			return "createArticle";		
		}
		
		@RequestMapping("/list-articles")
		public String listArticle(ModelMap model, HttpServletRequest req) {		
			model.addAttribute("menu", "listArticles");
			Map<String, Object> camMap = getRoleDetailsOfModule("ART", req);
			model.addAttribute("role_list", camMap.get("roleList"));
			model.addAttribute("role_delete", camMap.get("roleDelete"));
			if (camMap.get("roleAccess").equals("YES")) {
				return "listArticle";
			} else {
				return "permission";
			}				
		}
		
		@RequestMapping("/update-article/{articleId}")
		public String editArticle(ModelMap model,@PathVariable("articleId") String articleId) {		
			model.addAttribute("menu", "updateArticle");	
			model.addAttribute("articleId", articleId);	
			return "updateArticle";		
		}
	
		@RequestMapping("/view-article/{articleId}")
		public String viewArticle(ModelMap model,@PathVariable("articleId") String articleId) {		
			model.addAttribute("menu", "viewArticle");	
			model.addAttribute("articleId", articleId);	
			return "viewArticle";		
		}
		
		// End article path
	
	
	// Sale Order path	
	@RequestMapping("/sale-order/add")
	public String sale_order(ModelMap model) {		
		model.addAttribute("menu", "saleOrder");		
		return "saleOrder";		
	}
	@RequestMapping("/sale-order/list")
	public String listSaleOrder(ModelMap model) {		
		model.addAttribute("menu", "saleOrderList");		
		return "saleOrderList";			
	}
	@RequestMapping("/sale-order/edit/{saleId}")
	public String editSaleOrder(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "saleOrderEdit");	
		model.addAttribute("saleId", saleId);	
		return "saleOrderEdit";		
	}
	
	@RequestMapping("/sale-order/print/{saleId}")
	public String printSaleOrder(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "saleOrderPrint");	
		model.addAttribute("saleId", saleId);	
		return "saleOrderPrint";		
	}
	
	// End Sale Order path
	
	// Quotation Path
	@RequestMapping("/quote/add")
	public String quote(ModelMap model) {		
		model.addAttribute("menu", "quote");		
		return "quote";		
	}
	@RequestMapping("/quote/list")
	public String listQuote(ModelMap model) {		
		model.addAttribute("menu", "quoteList");		
		return "quoteList";			
	}
	@RequestMapping("/quote/edit/{saleId}")
	public String editQuote(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "quoteEdit");	
		model.addAttribute("saleId", saleId);	
		return "quoteEdit";		
	}
	@RequestMapping("/quote/print/{saleId}")
	public String printQuote(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "Print Quotation");	
		model.addAttribute("saleId", saleId);	
		return "quotePrint";		
	}
	// End Quotation Path
	
	
	
	@RequestMapping("/create-role")
	public String createRole(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createRole");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA",req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "createRole";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-role/{custID}")
	public String updateRole(ModelMap model, @PathVariable String custID, HttpServletRequest req) {
		model.addAttribute("menu", "updateRole");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			String json;
			try {
				json = new ObjectMapper().writeValueAsString(roleController.getRoleID(custID, req));
				model.addAttribute("role", json);
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			return "updateRole";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-role-management")
	public String viewRoleManagement(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "viewRoleManagement");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "viewRoleManagement";
		}else{
			return "permission";
		}	
		
	}

	@RequestMapping("/user-management")
	public String userManagement(ModelMap model, HttpSession session, HttpServletRequest request) {
		model.addAttribute("menu", "userManagement");
		session.setAttribute("userId", userController.getUserNameByName(getPrincipal(), request));
		
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", request);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "userManagement";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/campaing-status")
	public String campaignStatus(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "campaignStatus");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "campaignStatus";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/campaing-type")
	public String campaignType(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "campaignType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "campaignType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/lead-status")
	public String leadStatus(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "leadStatus");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "leadStatus";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/lead-sources")
	public String leadSources(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "leadSources");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "leadSources";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/industries")
	public String industries(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "industries");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "industries";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/account-type")
	public String accountType(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "accountType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "accountType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/opportunity-type")
	public String opportunityType(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "opportunityType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "opportunityType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/opportunity-stage")
	public String opportunityStage(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "opportunityStage");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "opportunityStage";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/case-status")
	public String caseStatus(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "caseStatus");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "caseStatus";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/case-type")
	public String caseType(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "caseType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "caseType";
		}else{
			return "permission";
		}
		
	}
	
	@RequestMapping("/case-priority")
	public String casePriority(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "casePriority");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "casePriority";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/call-status")
	public String callStatus(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "callStatus");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "callStatus";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/meeting-status")
	public String meetingStatus(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "meetingStatus");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "meetingStatus";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/task-status")
	public String taskStatus(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "taskStatus");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "taskStatus";
		}else{
			return "permission";
		}	
		
	}

	@RequestMapping("/login")
	public String login(ModelMap model, HttpServletRequest request) {
		model.addAttribute("title", "App Login | CRM");
		request.getSession().setAttribute("usernamedb", "posadmin");
		request.getSession().setAttribute("passworddb", "Pa$$w0rd");
		request.getSession().setAttribute("ip", "192.168.123.2");
		request.getSession().setAttribute("port", "3306");
		dataSource.setIp(request.getSession().getAttribute("ip").toString());
		dataSource.setPort(request.getSession().getAttribute("port").toString());
		dataSource.setUn(request.getSession().getAttribute("usernamedb").toString());
		dataSource.setPw(request.getSession().getAttribute("passworddb").toString());
		return "login";
	}

	/* marketing */

	/* campaign */
	
	@RequestMapping("/create-campaign")
	public String campaigns(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "createCampaigns");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
		if (camMap.get("roleAccess").equals("YES")) {
			return "createCampaigns";
		} else {
			return "permission";

		}
	}

	@RequestMapping(value = "/update-campaign/{campID}", method = RequestMethod.GET)
	public String updateCampaigns(ModelMap model, @PathVariable("campID") String campID, HttpServletRequest req) {
		model.addAttribute("menu", "updateCampaigns");

		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);

		if (camMap.get("roleAccess").equals("YES")) {

			if (camMap.get("roleEdit").equals("YES")) {
				model.addAttribute("campId", campID);
				return "updateCampaigns";

			} else {
				return "permission";
			}

		} else {
			return "permission";
		}

	}

	@RequestMapping("/list-campaigns")
	public String listCampaigns(ModelMap model,HttpServletRequest req) {
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);

		model.addAttribute("menu", "listCampaigns");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {

			return "listCampaigns";

		} else {

			return "permission";

		}

	}

	@RequestMapping("/view-campaign/{campId}")
	public String viewCampaigns(ModelMap model,@PathVariable("campId") String campId,HttpServletRequest req) {

		model.addAttribute("menu", "viewCampaigns");
		model.addAttribute("campId", campId);
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		model.addAttribute("permission", getRoleDetailsAllModule(req));
		
		if (camMap.get("roleAccess").equals("NO")) {
			return "permission";
		} else if (camMap.get("roleAccess").equals("YES")) {

			if (camMap.get("roleView").equals("YES")) {
				return "viewCampaigns";
			} else {
				return "permission";
			}
		}

		return "permission";

	}

	/* Close campaign */

	/* lead */
	
	@RequestMapping("/create-lead")
	public String createLeads(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "createLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("LE", req);

		if (camMap.get("roleAccess").equals("YES")) {
			return "createLeads";
		} else {
			return "permission";

		}

	}

	@RequestMapping("/list-leads")
	public String listLeads(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("LE", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {
			return "listLeads";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/view-lead/{leadId}")
	public String viewLeads(ModelMap model, @PathVariable("leadId") String leadId, HttpServletRequest req) {

		model.addAttribute("menu", "viewLeads");
		model.addAttribute("leadId", leadId);
		Map<String, Object> camMap = getRoleDetailsOfModule("LE", req);
		model.addAttribute("permission", getRoleDetailsAllModule(req));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("NO")) {
			return "permission";
		} else if (camMap.get("roleAccess").equals("YES")) {

			if (camMap.get("roleView").equals("YES")) {
				return "viewLeads";
			} else {
				return "permission";
			}
		}

		return "permission";

	}

	@RequestMapping("/update-lead/{leadID}")
	public String updateLeads(ModelMap model, @PathVariable String leadID,HttpServletRequest req) {
		model.addAttribute("menu", "updateLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);

		if (camMap.get("roleAccess").equals("YES")) {

			if (camMap.get("roleEdit").equals("YES")) {
				model.addAttribute("leadId", leadID);
				return "updateLeads";

			} else {
				return "permission";
			}

		} else {
			return "permission";
		}

	}

	@RequestMapping("/convert-lead/{leadID}")
	public String convertLead(ModelMap model, @PathVariable String leadID,HttpServletRequest req) {
		model.addAttribute("menu", "convertLead");
		model.addAttribute("leadId", leadID);
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA", req);
			
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				
				return "convertLead";
			}else{
				return "permission";
			}
		}else{
			return "permission";
		}
		

		
	}

	/* close lead */

	/* close marketing */

	/* sale */

	/* contact */

	@RequestMapping("/create-contact")
	public String createContact(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "createContacts");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CO", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createContacts";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/list-contacts")
	public String listContacts(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "listContacts");

		Map<String, Object> camMap = getRoleDetailsOfModule("CO", req);
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listContacts";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-contact/{conID}")
	public String viewContacts(ModelMap model, @PathVariable String conID,HttpServletRequest req) {
		model.addAttribute("menu", "viewContacts");
		model.addAttribute("conId", conID);
		Map<String, Object> camMap = getRoleDetailsOfModule("CO", req);
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		model.addAttribute("permission", getRoleDetailsAllModule(req));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewContacts";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-contact/{conID}")
	public String updateContacts(ModelMap model, @PathVariable String conID,HttpServletRequest req) {
		model.addAttribute("menu", "updateContacts");
		model.addAttribute("conId", conID);
		Map<String, Object> camMap = getRoleDetailsOfModule("CO", req);
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {				
				return "updateContacts";
			}else{
				return "permission";
			}
		}else{
			return "permission";
		}
	}

	/* close contact */

	/* Opportunity */
	@RequestMapping("/create-opportunity")
	public String createOpportunity(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "createOpportunity");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createOpportunity";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-opportunity/{oppID}")
	public String updateOpportunity(ModelMap model, @PathVariable String oppID,HttpServletRequest req) {
		model.addAttribute("menu", "updateOpportunity");
		model.addAttribute("oppId", oppID);
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				
				return "updateOpportunity";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/list-opportunity")
	public String listOpportunity(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "listOpportunity");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP", req);
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listOpportunity";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-opportunity/{oppId}")
	public String viewOpportunity(ModelMap model,@PathVariable("oppId") String oppId, HttpServletRequest req) {
		model.addAttribute("menu", "viewOpportunity");
		model.addAttribute("oppId", oppId);
		Map<String, Object> camMap = getRoleDetailsOfModule("OP", req);
		model.addAttribute("permission", getRoleDetailsAllModule(req));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewOpportunity";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	/* Close Opportunity */
	/* close sale */

	/* Activities */

	/* Call */
	@RequestMapping("/list-calls")
	public String listCalls(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listCalls");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL", req);
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listCalls";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/create-call")
	public String createCall(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createCall");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL", req);
		
		
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createCall";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/view-call/{callId}")
	public String viewCalls(ModelMap model, @PathVariable String callId, HttpServletRequest req) {
		model.addAttribute("menu", "viewCalls");
		model.addAttribute("callId", callId);
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL", req);
		
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			if (camMap.get("roleView").equals("YES")) {
				
				return "viewCall";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/update-call/{callId}")
	public String updateCall(ModelMap model, @PathVariable String callId, HttpServletRequest req) {
		model.addAttribute("menu", "updateCall");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(callController.CallID(callId, req));
					model.addAttribute("calls", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateCall";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	/* Close Call */

	/* Meetings */
	@RequestMapping("/list-meetings")
	public String listMeetings(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "listMeetings");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME", req);
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listMeetings";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/create-meeting")
	public String createMeeting(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "create-Meeting");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createMeeting";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/view-meeting/{meetId}")
	public String viewMeeting(ModelMap model, @PathVariable("meetId") String meetId, HttpServletRequest req) {
		model.addAttribute("menu", "viewMeeting");
		model.addAttribute("meetId", meetId);
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME", req);
		
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewMeeting";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/update-meeting/{custID}")
	public String updateMeeting(ModelMap model, @PathVariable String custID,HttpServletRequest req) {
		model.addAttribute("menu", "updateMeeting");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(meetingController.findmeetingById(custID,req));
					model.addAttribute("meeting", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateMeeting";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
		
	}

	@RequestMapping("/list-tasks")
	public String listTasks(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "listTasks");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA", req);
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listTasks";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/create-task")
	public String createTask(ModelMap model,HttpServletRequest req) {
		model.addAttribute("menu", "createTask");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA", req);
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createTask";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-task/{taskId}")
	public String tasks(ModelMap model, @PathVariable("taskId") String taskId, HttpServletRequest req) {
		model.addAttribute("menu", "viewTasks");
		model.addAttribute("taskId", taskId);
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA", req);

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewTasks";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-task/{custID}")
	public String updateTask(ModelMap model, @PathVariable String custID, HttpServletRequest req) {
		model.addAttribute("menu", "updateTask");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA", req);

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(taskController.findtaskById(custID, req));
					model.addAttribute("task", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateTask";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
		
	}

	@RequestMapping("/list-events")
	public String listEvents(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listEvents");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "listEvents";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/create-event")
	public String createEvent(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createEvent");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV", req);

	
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "createEvent";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-event/{eventId}")
	public String viewEvent(ModelMap model, @PathVariable("eventId") String eventId,HttpServletRequest req) {
		model.addAttribute("menu","viewEvents");
		model.addAttribute("eventId", eventId);
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewEvents";
			}else{
				return "permission";
			}
	
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/update-event/{custID}")
	public String updateEvent(ModelMap model, @PathVariable String custID,HttpServletRequest req) {
		model.addAttribute("menu", "updateEvent");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV", req);

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(eventController.findEventById(custID, req));
					model.addAttribute("event", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateEvent";
			}else{
				return "permission";
			}
	
		}else{
			return "permission";
		}
		
	}

	/* Close Meetings */

	/* Note */
	@RequestMapping("/list-notes")
	public String listNotes(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listNotes");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "listNotes";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/create-note")
	public String createNote(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createNote");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO", req);

		if (camMap.get("roleAccess").equals("YES")) {
			
			return "createNote";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-note/{noteId}")
	public String viewNote(ModelMap model, @PathVariable("noteId") String noteId, HttpServletRequest req) {
		model.addAttribute("menu", "viewNotes");
		model.addAttribute("noteId", noteId);
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO", req);

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewNotes";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
	}

	@RequestMapping("/update-note/{custID}")
	public String updateNote(ModelMap model, @PathVariable String custID, HttpServletRequest req) {
		model.addAttribute("menu", "updateNote");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO", req);

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(noteController.NoteID(custID, req));
					model.addAttribute("note", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateNote";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	/* Close Meetings */

	/* Close Activities */

	/* Support */
	@RequestMapping("/create-case")
	public String createCase(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createCase");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CS", req);

		if (camMap.get("roleAccess").equals("YES")) {
			
			return "createCase";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/list-cases")
	public String listCases(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listCases");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CS", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "listCases";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-case/{caseId}")
	public String viewCases(ModelMap model, @PathVariable("caseId") String caseId, HttpServletRequest req) {
		model.addAttribute("menu", "viewCases");
		model.addAttribute("caseId", caseId);
		Map<String, Object> camMap = getRoleDetailsOfModule("CS", req);
		model.addAttribute("permission", getRoleDetailsAllModule(req));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewCase";
			}else{
				return "permission";	
			}
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-case/{caseId}")
	public String updateCase(ModelMap model, @PathVariable("caseId") String caseId, HttpServletRequest req) {
		model.addAttribute("menu", "updateCase");
		model.addAttribute("caseId", caseId);
		Map<String, Object> camMap = getRoleDetailsOfModule("CS", req);

		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {				
				return "updateCase";
			}else{
				return "permission";	
			}
		}else{
			return "permission";
		}
		
		
	}

	/* Support */
	@RequestMapping("/create-location")
	public String createLocation(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createLocation");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC", req);

		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createLocation";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/list-locations")
	public String listLocation(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listLocations");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listLocations";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-location/{locId}")
	public String viewLocation(ModelMap model, @PathVariable("locId") String locId, HttpServletRequest req) {
		model.addAttribute("menu", "viewLocations");
		model.addAttribute("locId", locId);
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC", req);

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewLocations";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-location/{custID}")
	public String updateLocation(ModelMap model, @PathVariable String custID, HttpServletRequest req) {
		
		model.addAttribute("menu", "updateLocation");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC", req);

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(locationController.EventLocationID(custID, req));
					model.addAttribute("locations", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateLocation";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	/* Close Support */

	/* Close Page */

	/* Other */

	/* customer */

	@RequestMapping("/list-customers")
	public String listCustomer(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listCustomer");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST", req);

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {
			return "listCustomer";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/view-customer/{custId}")
	public String viewCustomer(ModelMap model, @PathVariable("custId") String custId,HttpServletRequest req) {
		model.addAttribute("menu", "viewCustomer");
		model.addAttribute("custId", custId);
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST", req);
		model.addAttribute("permission", getRoleDetailsAllModule(req));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {
			if(camMap.get("roleView").equals("YES")){
				return "viewCustomer";
			}else{
				return "permission";
			}
			
		} else {
			return "permission";
		}
		
		
		
	}

	@RequestMapping("/create-customer")
	public String createCustomer(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createCustomer");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST", req);

		if (camMap.get("roleAccess").equals("YES")) {
			return "createCustomer";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/update-customer/{custID}")
	public String updateCustomer(ModelMap model, @PathVariable String custID, HttpServletRequest req) {
		model.addAttribute("menu", "updateCustomer");
		model.addAttribute("custId", custID);
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST", req);

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				
				return "updateCustomer";
			}else{
				return "permission";
			}
		}else{
			return "permission";
		}
		
	}

	/* close customer */

	
	
	
	@RequestMapping("/list-employee")
	public String listEmpoyee(ModelMap model) {
		model.addAttribute("menu", "ListEmployee");		
		return "emloyeeList";
	}
	
	@RequestMapping("/create-employee")
	public String createEmpoyee(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createEmployee");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST", req);

		if (camMap.get("roleAccess").equals("YES")) {
			return "employee";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/update-employee/{custID}")
	public String updateEmpoyee(ModelMap model, @PathVariable String custID, HttpServletRequest req) {
		model.addAttribute("menu", "updateEmployee");
		model.addAttribute("custId", custID);
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST", req);

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				
				return "employeeEdit";
			}else{
				return "permission";
			}
		}else{
			return "permission";
		}
		
	}

	/* close employee */
	
	
	/*HBU Module*/
	@RequestMapping("/list-competitors")
	public String listCompetitor(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "listCompetitors");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("COM", req);
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listCompetitors";
		} else {
			return "permission";
		}

	}
	
	@RequestMapping("/market-survey")
	public String marketSurvey(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "marketSurvey");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("MS", req);
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "marketSurvey";
		} else {
			return "permission";
		}

	}
	
	@RequestMapping("/create-competitor")
	public String createCompetitor(ModelMap model, HttpServletRequest req) {
		model.addAttribute("menu", "createCompetitor");
		Map<String, Object> camMap = getRoleDetailsOfModule("COM", req);
		if (camMap.get("roleAccess").equals("YES")) {
			return "createCompetitor";
		} else {
			return "permission";
		}
	}
	/*End of HBU Module*/
	
	
	/* Other */

	/* File Layout */

	@RequestMapping("head")
	public String head(ModelMap model, HttpServletRequest request) {
		request.getSession().setAttribute("usernamedb", "posadmin");
		request.getSession().setAttribute("passworddb", "Pa$$w0rd");
		request.getSession().setAttribute("ip", "192.168.123.2");
		request.getSession().setAttribute("port", "3306");
		return "layout/head";
	}

	@RequestMapping("header")
	public String header(ModelMap model, HttpSession session, HttpServletRequest request) {
		
		session.setAttribute("SESSION", getPrincipal());
		session.setAttribute("users", userController.getUserById(getPrincipal(), request));
		return "layout/header";
	}

	@RequestMapping("menu")
	public String menu(ModelMap model,HttpServletRequest req) {
		Map<String, Object> camMap = getRoleDetailsOfModule("CA",req);
		
		model.addAttribute("role_CRM_ADMIN", camMap.get("role"));
		
		return "layout/menu";
	}

	@RequestMapping("footer")
	public String footer(ModelMap model) {

		return "layout/footer";
	}

	@RequestMapping("permission")
	public String permission(ModelMap model) {

		return "permission";
	}

	/* Close File Layout */

	public String getPrincipal() {
		String userName = null;
		Object principal = SecurityContextHolder.getContext().getAuthentication().getPrincipal();

		if (principal instanceof UserDetails) {
			userName = ((UserDetails) principal).getUsername();
			// session.setAttribute("SESSION_NAME",
			// ((UserDetails)principal).getUsername());
		} else {
			userName = principal.toString();
		}
		return userName;
	}
	

	@SuppressWarnings({ "rawtypes", "unchecked" })
	public Map<String, Object> getRoleDetailsOfModule(String moduleId,HttpServletRequest req) {
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req, getPrincipal());		
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL + "api/role_detail/list/user/" + getPrincipal() + "/"
				+ moduleId, HttpMethod.POST, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>) response.getBody();
		if (userMap.get("DATA") != null) {
			return (Map<String, Object>) userMap.get("DATA");
		}
		return null;
	}
	@SuppressWarnings({ "rawtypes", "unchecked" })
	public String getRoleDetailsAllModule(HttpServletRequest req) {
		
		MeDataSource dataSource = new MeDataSource();		
		dataSource = dataSource.getMeDataSourceByHttpServlet(req, getPrincipal());		
		
		HttpEntity<Object> request = new HttpEntity<Object>(dataSource, header);
		ResponseEntity<Map> response = restTemplate.exchange(URL + "api/role/list/role_by_user", HttpMethod.POST, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>) response.getBody();
		if (userMap.get("DATA") != null) {
			try {
				String json = new ObjectMapper().writeValueAsString(userMap.get("DATA"));
				return json;
			} catch (JsonProcessingException e) {
				e.printStackTrace();
			}
			
		}
		return null;
	}
	
	
	
	@RequestMapping("/upload")
	public String uploadFile(ModelMap model) {
		return "uploadFile";
	}

}
