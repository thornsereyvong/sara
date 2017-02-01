package com.app.controller.report;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("report/")
public class ReportController {

	/*Marketing Report*/
	
	@RequestMapping({ "marketing/campaign/top-campaign"})
	public String topCampaign(ModelMap model) {
		model.addAttribute("menu", "topCampaign");
		return "reportApp/marketing/topCampaign";
	}
	
	@RequestMapping({ "marketing/campaign/lead-by-campaign"})
	public String leadByCampaign(ModelMap model) {
		model.addAttribute("menu", "leadByCampaign");
		return "reportApp/marketing/leadByCampaign";
	}
	
	@RequestMapping({ "marketing/lead/report-lead"})
	public String leadReport(ModelMap model) {
		model.addAttribute("menu", "leadReport");
		return "reportApp/marketing/leadReport";
	}
	
	
	/*Sale Report*/
	@RequestMapping({ "sales/opportunity"})
	public String opportunityReport(ModelMap model) {
		model.addAttribute("menu", "reportOpportunity");
		return "reportApp/sales/reportOpportunity";
	}
	
	
	/*Support Report*/
	
	@RequestMapping({ "support/case"})
	public String caseReport(ModelMap model) {
		model.addAttribute("menu", "reportCase");
		return "reportApp/support/caseReport";
	}

}
