package com.app.entities;

public class HBUMarketSurveyDetails{

	private int msDetailId;
	private String custId;
	private String compId;
	private short surveyValue;
	private MeDataSource meDataSource;

	public int getMsDetailId() {
		return msDetailId;
	}

	public void setMsDetailId(int msDetailId) {
		this.msDetailId = msDetailId;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getCompId() {
		return compId;
	}

	public void setCompId(String compId) {
		this.compId = compId;
	}

	public short getSurveyValue() {
		return surveyValue;
	}

	public void setSurveyValue(short surveyValue) {
		this.surveyValue = surveyValue;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
}
