package com.app.entities.report;

import java.util.Date;

import com.app.entities.MeDataSource;


public class CustomerReportFilter {
	
	private String dateType;
	private Date startDate;
	private Date endDate;
	private MeDataSource dataSource;
	
	public String getDateType() {
		return dateType;
	}
	public void setDateType(String dateType) {
		this.dateType = dateType;
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
	public MeDataSource getDataSource() {
		return dataSource;
	}
	public void setDataSource(MeDataSource dataSource) {
		this.dataSource = dataSource;
	}
}
