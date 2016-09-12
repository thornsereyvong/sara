package com.app.entities;

import java.time.LocalDateTime;
import java.util.Date;

public class CrmEvent{
	private String evId;
	private String evName;
	private CrmEventLocation evlocation;
	private String startDate;
	private String endDate;
	private String evDuration;
	private double evBudget;
	private String evDes;
	private CrmUser assignTo;
	private String evCreateBy;
	private LocalDateTime evCreateDate;
	private String evModifiedBy;
	private Date evModifiedDate;
	private String evRelatedToModuleType;
	private String evRelatedToModuleId;

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
	
	public String getStartDate() {
		return startDate;
	}
	
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	
	public String getEndDate() {
		return endDate;
	}

	public void setEndDate(String endDate) {
		this.endDate = endDate;
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

	public LocalDateTime getEvCreateDate() {
		return evCreateDate;
	}

	public void setEvCreateDate(LocalDateTime evCreateDate) {
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

	public String getEvRelatedToModuleType() {
		return evRelatedToModuleType;
	}

	public void setEvRelatedToModuleType(String evRelatedToModuleType) {
		this.evRelatedToModuleType = evRelatedToModuleType;
	}

	public String getEvRelatedToModuleId() {
		return evRelatedToModuleId;
	}

	public void setEvRelatedToModuleId(String evRelatedToModuleId) {
		this.evRelatedToModuleId = evRelatedToModuleId;
	}
}
