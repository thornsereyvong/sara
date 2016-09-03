package com.app.entities;

import java.util.List;




public class CrmLeadSource{


	
	
	private int sourceID;
	
	private String sourceName;

	
	private String description;
	
	
	private List<CrmLead> lead;
	
	
	private List<CrmOpportunity> opportunities;

	public List<CrmLead> getLead() {
		return lead;
	}

	public void setLead(List<CrmLead> lead) {
		this.lead = lead;
	}

	public int getSourceID() {
		return sourceID;
	}

	public void setSourceID(int sourceID) {
		this.sourceID = sourceID;
	}

	public String getSourceName() {
		return sourceName;
	}

	public void setSourceName(String sourceName) {
		this.sourceName = sourceName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public List<CrmOpportunity> getOpportunities() {
		return opportunities;
	}

	public void setOpportunities(List<CrmOpportunity> opportunities) {
		this.opportunities = opportunities;
	}
	
	
}
