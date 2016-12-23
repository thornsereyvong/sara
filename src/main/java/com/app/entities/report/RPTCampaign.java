package com.app.entities.report;

import java.util.Date;

import com.app.entities.CrmCampaign;
import com.app.entities.CrmCampaignStatus;
import com.app.entities.CrmCampaignType;
import com.app.entities.CrmUser;
import com.app.entities.MeDataSource;


public class RPTCampaign {
	
	private String campID;
	private String campName;
	private Date startDate;
	private Date endDate;
	private CrmCampaignStatus status;
	private CrmCampaignType type;
	private String description;
	private CrmCampaign parent;
	private CrmUser assignTo;
	private double budget;
	private double actualCost;
	private double expectedCost;
	private double expectedRevenue;
	private int numSend;
	private int expectedResponse;
	private String createdBy;
	private Date createdDate;
	private Date modifiedDate;
	private String modifiedBy;
	private MeDataSource meDataSource;
	
	public String getCampID() {
		return campID;
	}
	public void setCampID(String campID) {
		this.campID = campID;
	}
	public String getCampName() {
		return campName;
	}
	public void setCampName(String campName) {
		this.campName = campName;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public CrmCampaignStatus getStatus() {
		return status;
	}
	public void setStatus(CrmCampaignStatus status) {
		this.status = status;
	}
	public CrmCampaignType getType() {
		return type;
	}
	public void setType(CrmCampaignType type) {
		this.type = type;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	public CrmCampaign getParent() {
		return parent;
	}
	public void setParent(CrmCampaign parent) {
		this.parent = parent;
	}
	public CrmUser getAssignTo() {
		return assignTo;
	}
	public void setAssignTo(CrmUser assignTo) {
		this.assignTo = assignTo;
	}
	public double getBudget() {
		return budget;
	}
	public void setBudget(double budget) {
		this.budget = budget;
	}
	public double getActualCost() {
		return actualCost;
	}
	public void setActualCost(double actualCost) {
		this.actualCost = actualCost;
	}
	public double getExpectedCost() {
		return expectedCost;
	}
	public void setExpectedCost(double expectedCost) {
		this.expectedCost = expectedCost;
	}
	public double getExpectedRevenue() {
		return expectedRevenue;
	}
	public void setExpectedRevenue(double expectedRevenue) {
		this.expectedRevenue = expectedRevenue;
	}
	public int getNumSend() {
		return numSend;
	}
	public void setNumSend(int numSend) {
		this.numSend = numSend;
	}
	public int getExpectedResponse() {
		return expectedResponse;
	}
	public void setExpectedResponse(int expectedResponse) {
		this.expectedResponse = expectedResponse;
	}
	public String getCreatedBy() {
		return createdBy;
	}
	public void setCreatedBy(String createdBy) {
		this.createdBy = createdBy;
	}
	public Date getCreatedDate() {
		return createdDate;
	}
	public void setCreatedDate(Date createdDate) {
		this.createdDate = createdDate;
	}
	public Date getModifiedDate() {
		return modifiedDate;
	}
	public void setModifiedDate(Date modifiedDate) {
		this.modifiedDate = modifiedDate;
	}
	public String getModifiedBy() {
		return modifiedBy;
	}
	public void setModifiedBy(String modifiedBy) {
		this.modifiedBy = modifiedBy;
	}
	public MeDataSource getMeDataSource() {
		return meDataSource;
	}
	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
	
	
	

}
