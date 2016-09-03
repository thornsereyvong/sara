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

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

@Controller
public class MainController {

	@Autowired
	private CrmCampaignController campController;

	@Autowired
	private CrmUserController userController;

	@Autowired
	private CrmLeadController leadController;

	@Autowired
	private CrmOpportunityController oppController;

	@Autowired
	private CrmCustomerController custController;

	@Autowired
	private CrmContactController contactController;

	@Autowired
	private CrmCaseController caseController;

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

	/* -- Front Page -- */

	@RequestMapping({ "/", "/index", "/home" })
	public String index(ModelMap model, HttpSession session, HttpServletRequest request) {
		model.addAttribute("menu", "index");

		return "index";
	}

	@RequestMapping("/category-type")
	public String categoryType(ModelMap model) {
		
		model.addAttribute("menu", "categoryType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "categoryType";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/role-management")
	public String roleManagement(ModelMap model) {
		model.addAttribute("menu", "roleManagement");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "roleManagement";
		}else{
			return "permission";
		}
		
	}
	
	// Sale Order path	
	@RequestMapping("/sale-order/add")
	public String sale_order(ModelMap model) {		
		model.addAttribute("menu", "Add Sale Order");		
		return "saleOrder";		
	}
	@RequestMapping("/sale-order/list")
	public String listSaleOrder(ModelMap model) {		
		model.addAttribute("menu", "List Sale Order");		
		return "saleOrderList";			
	}
	@RequestMapping("/sale-order/edit/{saleId}")
	public String editSaleOrder(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "Edit Sale Order");	
		model.addAttribute("saleId", saleId);	
		return "saleOrderEdit";		
	}
	
	@RequestMapping("/sale-order/print/{saleId}")
	public String printSaleOrder(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "Print Sale Order");	
		model.addAttribute("saleId", saleId);	
		return "saleOrderPrint";		
	}
	
	// End Sale Order path
	
	// Quotation Path
	@RequestMapping("/quote/add")
	public String quote(ModelMap model) {		
		model.addAttribute("menu", "Add Quotation");		
		return "quote";		
	}
	@RequestMapping("/quote/list")
	public String listQuote(ModelMap model) {		
		model.addAttribute("menu", "List Quotation");		
		return "quoteList";			
	}
	@RequestMapping("/quote/edit/{saleId}")
	public String editQuote(ModelMap model,@PathVariable("saleId") String saleId) {		
		model.addAttribute("menu", "Edit Quotation");	
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
	public String createRole(ModelMap model) {
		model.addAttribute("menu", "createRole");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "createRole";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-role/{custID}")
	public String updateRole(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateRole");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			String json;
			try {
				json = new ObjectMapper().writeValueAsString(roleController.getRoleID(custID));
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
	public String viewRoleManagement(ModelMap model) {
		model.addAttribute("menu", "viewRoleManagement");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "viewRoleManagement";
		}else{
			return "permission";
		}	
		
	}

	@RequestMapping("/user-management")
	public String userManagement(ModelMap model, HttpSession session, HttpServletRequest request) {
		model.addAttribute("menu", "userManagement");
		session.setAttribute("userId", userController.getUserNameByName(getPrincipal()));
		
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "userManagement";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/campaing-status")
	public String campaignStatus(ModelMap model) {
		model.addAttribute("menu", "campaignStatus");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "campaignStatus";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/campaing-type")
	public String campaignType(ModelMap model) {
		model.addAttribute("menu", "campaignType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "campaignType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/lead-status")
	public String leadStatus(ModelMap model) {
		model.addAttribute("menu", "leadStatus");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "leadStatus";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/lead-sources")
	public String leadSources(ModelMap model) {
		model.addAttribute("menu", "leadSources");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "leadSources";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/industries")
	public String industries(ModelMap model) {
		model.addAttribute("menu", "industries");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "industries";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/account-type")
	public String accountType(ModelMap model) {
		model.addAttribute("menu", "accountType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "accountType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/opportunity-type")
	public String opportunityType(ModelMap model) {
		model.addAttribute("menu", "opportunityType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "opportunityType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/opportunity-stage")
	public String opportunityStage(ModelMap model) {
		model.addAttribute("menu", "opportunityStage");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "opportunityStage";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/case-status")
	public String caseStatus(ModelMap model) {
		model.addAttribute("menu", "caseStatus");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "caseStatus";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/case-type")
	public String caseType(ModelMap model) {
		model.addAttribute("menu", "caseType");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "caseType";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/call-status")
	public String callStatus(ModelMap model) {
		model.addAttribute("menu", "callStatus");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "callStatus";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/meeting-status")
	public String meetingStatus(ModelMap model) {
		model.addAttribute("menu", "meetingStatus");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "meetingStatus";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/task-status")
	public String taskStatus(ModelMap model) {
		model.addAttribute("menu", "taskStatus");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
		if(camMap.get("role").equals("CRM_ADMIN")){
			return "taskStatus";
		}else{
			return "permission";
		}	
		
	}

	@RequestMapping("/login")
	public String login(ModelMap model) {

		return "login";
	}

	/* marketing */

	/* campaign */
	
	@RequestMapping("/create-campaign")
	public String campaigns(ModelMap model) {
		model.addAttribute("menu", "createCampaigns");
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");

		if (camMap.get("roleAccess").equals("YES")) {
			return "createCampaigns";
		} else {
			return "permission";

		}

	}

	@RequestMapping(value = "/update-campaign/{camID}", method = RequestMethod.GET)
	public String updateCampaigns(ModelMap model, @PathVariable String camID) {
		model.addAttribute("menu", "updateCampaigns");

		Map<String, Object> camMap = getRoleDetailsOfModule("CA");

		if (camMap.get("roleAccess").equals("YES")) {

			if (camMap.get("roleEdit").equals("YES")) {

				String json;
				String parent;
				try {
					json = new ObjectMapper().writeValueAsString(campController.findCampaignById(camID));
					parent = new ObjectMapper().writeValueAsString(campController.campNotQu(camID));
					model.addAttribute("campaign", json);
					model.addAttribute("parent", parent);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}

				return "updateCampaigns";

			} else {
				return "permission";
			}

		} else {
			return "permission";
		}

	}

	@RequestMapping("/list-campaigns")
	public String listCampaigns(ModelMap model) {
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");

		model.addAttribute("menu", "listCampaigns");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {

			return "listCampaigns";

		} else {

			return "permission";

		}

	}

	@RequestMapping("/view-campaigns")
	public String viewCampaigns(ModelMap model) {

		model.addAttribute("menu", "viewCampaigns");

		Map<String, Object> camMap = getRoleDetailsOfModule("CA");

		model.addAttribute("role_delete", camMap.get("roleDelete"));

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
	public String createLeads(ModelMap model) {
		model.addAttribute("menu", "createLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("LE");

		if (camMap.get("roleAccess").equals("YES")) {
			return "createLeads";
		} else {
			return "permission";

		}

	}

	@RequestMapping("/list-leads")
	public String listLeads(ModelMap model) {
		model.addAttribute("menu", "listLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("LE");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {
			return "listLeads";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/view-leads")
	public String viewLeads(ModelMap model) {

		model.addAttribute("menu", "viewLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("LE");

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
	public String updateLeads(ModelMap model, @PathVariable String leadID) {
		model.addAttribute("menu", "updateLeads");

		Map<String, Object> camMap = getRoleDetailsOfModule("CA");

		if (camMap.get("roleAccess").equals("YES")) {

			if (camMap.get("roleEdit").equals("YES")) {

				String json;
				try {
					json = new ObjectMapper().writeValueAsString(leadController.findLeadById(leadID));
					model.addAttribute("lead", json);

				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}

				return "updateLeads";

			} else {
				return "permission";
			}

		} else {
			return "permission";
		}

	}

	@RequestMapping("/convert-lead/{leadID}")
	public String convertLead(ModelMap model, @PathVariable String leadID) {
		model.addAttribute("menu", "convertLead");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
			
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(leadController.findLeadById(leadID));
					model.addAttribute("conLead", json);

				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
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
	public String createContact(ModelMap model) {
		model.addAttribute("menu", "createContacts");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CO");
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createContacts";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/list-contacts")
	public String listContacts(ModelMap model) {
		model.addAttribute("menu", "listContacts");

		Map<String, Object> camMap = getRoleDetailsOfModule("CO");
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listContacts";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-contacts")
	public String viewContacts(ModelMap model) {
		model.addAttribute("menu", "viewContacts");
		Map<String, Object> camMap = getRoleDetailsOfModule("CO");
		
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
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

	@RequestMapping("/update-contact/{oppID}")
	public String updateContacts(ModelMap model, @PathVariable String oppID) {
		model.addAttribute("menu", "updateContacts");
		Map<String, Object> camMap = getRoleDetailsOfModule("CO");
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(contactController.findContactById(oppID));
					model.addAttribute("contact", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
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
	public String createOpportunity(ModelMap model) {
		model.addAttribute("menu", "createOpportunity");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP");
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createOpportunity";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-opportunity/{oppID}")
	public String updateOpportunity(ModelMap model, @PathVariable String oppID) {
		model.addAttribute("menu", "updateOpportunity");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP");
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(oppController.findOpportunity(oppID));
					model.addAttribute("opp", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateOpportunity";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/list-opportunity")
	public String listOpportunity(ModelMap model) {
		model.addAttribute("menu", "listOpportunity");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP");
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listOpportunity";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-opportunity")
	public String viewOpportunity(ModelMap model) {
		model.addAttribute("menu", "viewOpportunity");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("OP");

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
	public String listCalls(ModelMap model) {
		model.addAttribute("menu", "listCalls");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL");
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listCalls";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/create-call")
	public String createCall(ModelMap model) {
		model.addAttribute("menu", "createCall");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL");
		
		
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createCall";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/view-calls")
	public String viewCalls(ModelMap model) {
		model.addAttribute("menu", "viewCalls");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL");
		
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			if (camMap.get("roleView").equals("YES")) {
				
				return "viewCalls";
			}else{
				return "permission";
			}
			
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/update-call/{custID}")
	public String updateCall(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateCall");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_CL");
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(callController.CallID(custID));
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
	public String listMeetings(ModelMap model) {
		model.addAttribute("menu", "listMeetings");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME");
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listMeetings";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/create-meeting")
	public String createMeeting(ModelMap model) {
		model.addAttribute("menu", "create-Meeting");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME");
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createMeeting";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/view-meetings")
	public String viewMeeting(ModelMap model) {
		model.addAttribute("menu", "viewMeeting");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME");
		
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
	public String updateMeeting(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateMeeting");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_ME");
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(meetingController.findmeetingById(custID));
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
	public String listTasks(ModelMap model) {
		model.addAttribute("menu", "listTasks");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA");
		
		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listTasks";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/create-task")
	public String createTask(ModelMap model) {
		model.addAttribute("menu", "createTask");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA");
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createTask";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-tasks")
	public String tasks(ModelMap model) {
		model.addAttribute("menu", "viewTasks");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA");

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
	public String updateTask(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateTask");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_TA");

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(taskController.findtaskById(custID));
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
	public String listEvents(ModelMap model) {
		model.addAttribute("menu", "listEvents");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "listEvents";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/create-event")
	public String createEvent(ModelMap model) {
		model.addAttribute("menu", "createEvent");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV");

	
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "createEvent";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-events")
	public String viewEvent(ModelMap model) {
		model.addAttribute("menu", "viewEvents");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV");

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
	public String updateEvent(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateEvent");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_EV");

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(eventController.findEventById(custID));
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

	/* Meetings */
	@RequestMapping("/list-notes")
	public String listNotes(ModelMap model) {
		model.addAttribute("menu", "listNotes");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "listNotes";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/create-note")
	public String createNote(ModelMap model) {
		model.addAttribute("menu", "createNote");
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO");

		if (camMap.get("roleAccess").equals("YES")) {
			
			return "createNote";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-notes")
	public String viewNote(ModelMap model) {
		model.addAttribute("menu", "viewNotes");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO");

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
	public String updateNote(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateNote");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("AC_NO");

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(noteController.NoteID(custID));
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
	public String createCase(ModelMap model) {
		model.addAttribute("menu", "createCase");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CS");

		if (camMap.get("roleAccess").equals("YES")) {
			
			return "createCase";
		}else{
			return "permission";
		}
		
		
	}

	@RequestMapping("/list-cases")
	public String listCases(ModelMap model) {
		model.addAttribute("menu", "listCases");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CS");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			
			return "listCases";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-cases")
	public String viewCases(ModelMap model) {
		model.addAttribute("menu", "viewCases");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CS");

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleView").equals("YES")) {
				return "viewCases";
			}else{
				return "permission";	
			}
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/update-case/{custID}")
	public String updateCase(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateCase");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CS");

		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(caseController.findCaseById(custID));
					model.addAttribute("cases", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
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
	public String createLocation(ModelMap model) {
		model.addAttribute("menu", "createLocation");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC");

		
		if (camMap.get("roleAccess").equals("YES")) {
			return "createLocation";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/list-locations")
	public String listLocation(ModelMap model) {
		model.addAttribute("menu", "listLocations");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			return "listLocations";
		}else{
			return "permission";
		}
		
	}

	@RequestMapping("/view-locations")
	public String viewLocation(ModelMap model) {
		model.addAttribute("menu", "viewLocations");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC");

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
	public String updateLocation(ModelMap model, @PathVariable String custID) {
		
		model.addAttribute("menu", "updateLocation");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("LOC");

		model.addAttribute("role_delete", camMap.get("roleDelete"));
		
		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(locationController.EventLocationID(custID));
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
	public String listCustomer(ModelMap model) {
		model.addAttribute("menu", "listCustomer");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST");

		model.addAttribute("role_list", camMap.get("roleList"));
		model.addAttribute("role_delete", camMap.get("roleDelete"));

		if (camMap.get("roleAccess").equals("YES")) {
			return "listCustomer";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/view-customers")
	public String viewCustomer(ModelMap model) {
		model.addAttribute("menu", "viewCustomer");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST");

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
	public String createCustomer(ModelMap model) {
		model.addAttribute("menu", "createCustomer");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST");

		if (camMap.get("roleAccess").equals("YES")) {
			return "createCustomer";
		} else {
			return "permission";
		}

	}

	@RequestMapping("/update-customer/{custID}")
	public String updateCustomer(ModelMap model, @PathVariable String custID) {
		model.addAttribute("menu", "updateCustomer");
		
		Map<String, Object> camMap = getRoleDetailsOfModule("CUST");

		if (camMap.get("roleAccess").equals("YES")) {
			if (camMap.get("roleEdit").equals("YES")) {
				String json;
				try {
					json = new ObjectMapper().writeValueAsString(custController.findCustomerID(custID));
					model.addAttribute("cust", json);
				} catch (JsonProcessingException e) {
					e.printStackTrace();
				}
				return "updateCustomer";
			}else{
				return "permission";
			}
		}else{
			return "permission";
		}
		
	}

	/* close customer */

	/* Other */

	/* File Layout */

	@RequestMapping("head")
	public String head(ModelMap model) {
		return "layout/head";

	}

	@RequestMapping("header")
	public String header(ModelMap model, HttpSession session, HttpServletRequest request) {
		
	
			session.setAttribute("SESSION", getPrincipal());
			session.setAttribute("users", userController.getUserById(getPrincipal()));
			return "layout/header";
	
		
		
	}

	@RequestMapping("menu")
	public String menu(ModelMap model) {
		Map<String, Object> camMap = getRoleDetailsOfModule("CA");
		
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

	private String getPrincipal() {
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
	public Map<String, Object> getRoleDetailsOfModule(String moduleId) {

		HttpEntity<String> request = new HttpEntity<String>(header);
		ResponseEntity<Map> response = restTemplate.exchange(URL + "api/role_detail/list/user/" + getPrincipal() + "/"
				+ moduleId, HttpMethod.GET, request, Map.class);
		Map<String, Object> userMap = (HashMap<String, Object>) response.getBody();
		if (userMap.get("DATA") != null) {
			return (Map<String, Object>) userMap.get("DATA");
		}
		return null;
	}

}
