package com.app.controller.report;



import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;


@Controller
@RequestMapping("report/")
public class ReportController {

	@RequestMapping({ "marketing/campaign/top-campaign"})
	public String index(ModelMap model) {
		model.addAttribute("menu", "topCampaign");
		return "reportApp/marketing/topCampaign";
	}

}
