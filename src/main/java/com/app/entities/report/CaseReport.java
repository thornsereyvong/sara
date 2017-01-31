package com.app.entities.report;

import com.app.entities.MeDataSource;

public class CaseReport {

	private String startDate;
	private String endDate;
	private String status;
	private String type;
	private String origin;
	private String priority;
	private String product;
	private String customer;
	private String contact;
	private String assignTo;
	private MeDataSource dataSource;
	
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
	
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	
	public String getOrigin() {
		return origin;
	}
	public void setOrigin(String origin) {
		this.origin = origin;
	}
	
	public String getProduct() {
		return product;
	}
	public void setProduct(String product) {
		this.product = product;
	}
	
	public String getCustomer() {
		return customer;
	}
	public void setCustomer(String customer) {
		this.customer = customer;
	}
	
	public String getContact() {
		return contact;
	}
	public void setContact(String contact) {
		this.contact = contact;
	}
	
	public String getAssignTo() {
		return assignTo;
	}
	
	public void setAssignTo(String assignTo) {
		this.assignTo = assignTo;
	}
	
	public MeDataSource getDataSource() {
		return dataSource;
	}
	
	public void setDataSource(MeDataSource dataSource) {
		this.dataSource = dataSource;
	}

	public String getPriority() {
		return priority;
	}

	public void setPriority(String priority) {
		this.priority = priority;
	}
	
}
