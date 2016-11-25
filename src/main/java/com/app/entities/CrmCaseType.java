package com.app.entities;


public class CrmCaseType {

	private int caseTypeId;
	private String caseTypeName;
	private String caseTypeDes;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getCaseTypeId() {
		return caseTypeId;
	}

	public void setCaseTypeId(int caseTypeId) {
		this.caseTypeId = caseTypeId;
	}

	public String getCaseTypeName() {
		return caseTypeName;
	}

	public void setCaseTypeName(String caseTypeName) {
		this.caseTypeName = caseTypeName;
	}

	public String getCaseTypeDes() {
		return caseTypeDes;
	}

	public void setCaseTypeDes(String caseTypeDes) {
		this.caseTypeDes = caseTypeDes;
	}
	
}
