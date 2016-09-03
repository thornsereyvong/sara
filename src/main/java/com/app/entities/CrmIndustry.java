package com.app.entities;


import java.util.List;




public class CrmIndustry {



	private int industID;

	private String industName;
	
	
	private String description;
	
	private List<CrmLead> lead;
	
	public List<CrmLead> getLead() {
		return lead;
	}

	public void setLead(List<CrmLead> lead) {
		this.lead = lead;
	}

	public int getIndustID() {
		return industID;
	}

	public void setIndustID(int industID) {
		this.industID = industID;
	}

	public String getIndustName() {
		return industName;
	}

	public void setIndustName(String industName) {
		this.industName = industName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}
	
	
}
