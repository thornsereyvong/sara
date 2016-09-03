package com.app.entities;


import java.util.Date;




public class CrmCase {

	
	private String caseId;
	
	private CrmCaseStatus status;

	private CrmCaseType type;
	
	private CrmCasePriority priority;
	
	
	private CrmCustomer customer;
	
	
	private CrmContact contact;
	
	private String subject;
	
	
	private String des;
	
	
	private String resolution;
	
	
	private CrmUser assignTo;
	
	
	private String createBy;
	
	
	private Date createDate;
	
	
	private String modifyBy;
	
	
	private Date modifyDate;


	public String getCaseId() {
		return caseId;
	}


	public void setCaseId(String caseId) {
		this.caseId = caseId;
	}


	public CrmCaseStatus getStatus() {
		return status;
	}


	public void setStatus(CrmCaseStatus status) {
		this.status = status;
	}


	public CrmCaseType getType() {
		return type;
	}


	public void setType(CrmCaseType type) {
		this.type = type;
	}


	public CrmCasePriority getPriority() {
		return priority;
	}


	public void setPriority(CrmCasePriority priority) {
		this.priority = priority;
	}


	public CrmCustomer getCustomer() {
		return customer;
	}


	public void setCustomer(CrmCustomer customer) {
		this.customer = customer;
	}


	public CrmContact getContact() {
		return contact;
	}


	public void setContact(CrmContact contact) {
		this.contact = contact;
	}


	public String getSubject() {
		return subject;
	}


	public void setSubject(String subject) {
		this.subject = subject;
	}


	public String getDes() {
		return des;
	}


	public void setDes(String des) {
		this.des = des;
	}


	public String getResolution() {
		return resolution;
	}


	public void setResolution(String resolution) {
		this.resolution = resolution;
	}


	public CrmUser getAssignTo() {
		return assignTo;
	}


	public void setAssignTo(CrmUser assignTo) {
		this.assignTo = assignTo;
	}


	public String getCreateBy() {
		return createBy;
	}


	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}


	public Date getCreateDate() {
		return createDate;
	}


	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}


	public String getModifyBy() {
		return modifyBy;
	}


	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}


	public Date getModifyDate() {
		return modifyDate;
	}


	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	
}
