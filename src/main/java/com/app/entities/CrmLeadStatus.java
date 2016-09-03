package com.app.entities;


import java.util.List;




public class CrmLeadStatus {


	private int statusID;
	
	
	private String statusName;
	
	private String description;
	
	private List<CrmLead> lead;

	public List<CrmLead> getLead() {
		return lead;
	}

	public void setLead(List<CrmLead> lead) {
		this.lead = lead;
	}

	public int getStatusID() {
		return statusID;
	}

	public void setStatusID(int statusID) {
		this.statusID = statusID;
	}

	public String getStatusName() {
		return statusName;
	}

	public void setStatusName(String statusName) {
		this.statusName = statusName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	
}
