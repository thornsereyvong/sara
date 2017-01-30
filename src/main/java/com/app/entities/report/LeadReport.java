package com.app.entities.report;

import com.app.entities.MeDataSource;

public class LeadReport {
	private String startDate;
	private String endDate;
	private String dateType;
	private String status;
	private String source;
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
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getSource() {
		return source;
	}
	public void setSource(String source) {
		this.source = source;
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
	
}
