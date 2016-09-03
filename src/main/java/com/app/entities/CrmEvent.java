package com.app.entities;

import java.util.Date;


public class CrmEvent{
	
	
	private String evId;
	
	
	private String evName;
	
	private CrmEventLocation evlocation;
	
	private Date evStartDate;
	
	
	private Date evEndDate;
	
	
	private String evDuration;
	
	
	private double evBudget;
	
	
	private String evDes;
	
	
	private CrmUser assignTo;
	
	
	private String evCreateBy;
	
	
	private Date evCreateDate;
	
	
	private String evModifiedBy;
	
	
	private Date evModifiedDate;

	public String getEvId() {
		return evId;
	}

	public void setEvId(String evId) {
		this.evId = evId;
	}

	public String getEvName() {
		return evName;
	}

	public void setEvName(String evName) {
		this.evName = evName;
	}

	public CrmEventLocation getEvlocation() {
		return evlocation;
	}

	public void setEvlocation(CrmEventLocation evlocation) {
		this.evlocation = evlocation;
	}

	public Date getEvStartDate() {
		return evStartDate;
	}

	public void setEvStartDate(Date evStartDate) {
		this.evStartDate = evStartDate;
	}

	public Date getEvEndDate() {
		return evEndDate;
	}

	public void setEvEndDate(Date evEndDate) {
		this.evEndDate = evEndDate;
	}

	public String getEvDuration() {
		return evDuration;
	}

	public void setEvDuration(String evDuration) {
		this.evDuration = evDuration;
	}

	public double getEvBudget() {
		return evBudget;
	}

	public void setEvBudget(double evBudget) {
		this.evBudget = evBudget;
	}

	public String getEvDes() {
		return evDes;
	}

	public void setEvDes(String evDes) {
		this.evDes = evDes;
	}

	public CrmUser getAssignTo() {
		return assignTo;
	}

	public void setAssignTo(CrmUser assignTo) {
		this.assignTo = assignTo;
	}

	public String getEvCreateBy() {
		return evCreateBy;
	}

	public void setEvCreateBy(String evCreateBy) {
		this.evCreateBy = evCreateBy;
	}

	public Date getEvCreateDate() {
		return evCreateDate;
	}

	public void setEvCreateDate(Date evCreateDate) {
		this.evCreateDate = evCreateDate;
	}

	public String getEvModifiedBy() {
		return evModifiedBy;
	}

	public void setEvModifiedBy(String evModifiedBy) {
		this.evModifiedBy = evModifiedBy;
	}

	public Date getEvModifiedDate() {
		return evModifiedDate;
	}

	public void setEvModifiedDate(Date evModifiedDate) {
		this.evModifiedDate = evModifiedDate;
	}
}
