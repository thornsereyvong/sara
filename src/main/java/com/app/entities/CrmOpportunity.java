package com.app.entities;

import java.util.Date;
import java.util.List;



public class CrmOpportunity {

	private String opId;
	private String opName;
	private double opAmount;
	private CrmCustomer customer;
	private String opCloseDate;
	private CrmOpportunityType opTypeID;
	private CrmOpportunityStage opStageId;
	private int opProbability;
	private CrmLeadSource opLeadSourceID;
	private String opNextStep;
	private CrmCampaign opCampId;
	private String opDes;
	private CrmUser opAssignedTo;
	private String opCreateBy;
	private Date opCreateDate;
	private String opModifyBy;
	private Date opModifyDate;
	

	private PriceCode priceCode;
	private AmeClass ameClass;
	private double totalAmount;
	private double disInvDol;
	private double disInvPer;
	private double totalDis;
	private double totalSTax;
	private double totalVTax;
	
	private List<CrmOpportunityDetails> details;
	
	
	public List<CrmOpportunityDetails> getDetails() {
		return details;
	}

	public void setDetails(List<CrmOpportunityDetails> details) {
		this.details = details;
	}

	public PriceCode getPriceCode() {
		return priceCode;
	}

	public void setPriceCode(PriceCode priceCode) {
		this.priceCode = priceCode;
	}

	public AmeClass getAmeClass() {
		return ameClass;
	}

	public void setAmeClass(AmeClass ameClass) {
		this.ameClass = ameClass;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public double getDisInvDol() {
		return disInvDol;
	}

	public void setDisInvDol(double disInvDol) {
		this.disInvDol = disInvDol;
	}

	public double getDisInvPer() {
		return disInvPer;
	}

	public void setDisInvPer(double disInvPer) {
		this.disInvPer = disInvPer;
	}

	public double getTotalDis() {
		return totalDis;
	}

	public void setTotalDis(double totalDis) {
		this.totalDis = totalDis;
	}

	public double getTotalSTax() {
		return totalSTax;
	}

	public void setTotalSTax(double totalSTax) {
		this.totalSTax = totalSTax;
	}

	public double getTotalVTax() {
		return totalVTax;
	}

	public void setTotalVTax(double totalVTax) {
		this.totalVTax = totalVTax;
	}

	public String getOpId() {
		return opId;
	}

	public void setOpId(String opId) {
		this.opId = opId;
	}

	public String getOpName() {
		return opName;
	}

	public void setOpName(String opName) {
		this.opName = opName;
	}

	public double getOpAmount() {
		return opAmount;
	}

	public void setOpAmount(double opAmount) {
		this.opAmount = opAmount;
	}

	public CrmCustomer getCustomer() {
		return customer;
	}

	public void setCustomer(CrmCustomer customer) {
		this.customer = customer;
	}

	public String getOpCloseDate() {
		return opCloseDate;
	}

	public void setOpCloseDate(String opCloseDate) {
		this.opCloseDate = opCloseDate;
	}

	public CrmOpportunityType getOpTypeID() {
		return opTypeID;
	}

	public void setOpTypeID(CrmOpportunityType opTypeID) {
		this.opTypeID = opTypeID;
	}

	public CrmOpportunityStage getOpStageId() {
		return opStageId;
	}

	public void setOpStageId(CrmOpportunityStage opStageId) {
		this.opStageId = opStageId;
	}

	public int getOpProbability() {
		return opProbability;
	}

	public void setOpProbability(int opProbability) {
		this.opProbability = opProbability;
	}

	public CrmLeadSource getOpLeadSourceID() {
		return opLeadSourceID;
	}

	public void setOpLeadSourceID(CrmLeadSource opLeadSourceID) {
		this.opLeadSourceID = opLeadSourceID;
	}

	public String getOpNextStep() {
		return opNextStep;
	}

	public void setOpNextStep(String opNextStep) {
		this.opNextStep = opNextStep;
	}

	public CrmCampaign getOpCampId() {
		return opCampId;
	}

	public void setOpCampId(CrmCampaign opCampId) {
		this.opCampId = opCampId;
	}

	public String getOpDes() {
		return opDes;
	}

	public void setOpDes(String opDes) {
		this.opDes = opDes;
	}

	public CrmUser getOpAssignedTo() {
		return opAssignedTo;
	}

	public void setOpAssignedTo(CrmUser opAssignedTo) {
		this.opAssignedTo = opAssignedTo;
	}

	public String getOpCreateBy() {
		return opCreateBy;
	}

	public void setOpCreateBy(String opCreateBy) {
		this.opCreateBy = opCreateBy;
	}

	public Date getOpCreateDate() {
		return opCreateDate;
	}

	public void setOpCreateDate(Date opCreateDate) {
		this.opCreateDate = opCreateDate;
	}

	public String getOpModifyBy() {
		return opModifyBy;
	}

	public void setOpModifyBy(String opModifyBy) {
		this.opModifyBy = opModifyBy;
	}

	public Date getOpModifyDate() {
		return opModifyDate;
	}

	public void setOpModifyDate(Date opModifyDate) {
		this.opModifyDate = opModifyDate;
	}
	
	

}
