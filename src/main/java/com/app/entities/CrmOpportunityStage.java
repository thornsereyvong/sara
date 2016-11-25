package com.app.entities;

public class CrmOpportunityStage {

	private int osId;
	private String osName;
	private String osDes;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getOsId() {
		return osId;
	}

	public void setOsId(int osId) {
		this.osId = osId;
	}

	public String getOsName() {
		return osName;
	}

	public void setOsName(String osName) {
		this.osName = osName;
	}

	public String getOsDes() {
		return osDes;
	}

	public void setOsDes(String osDes) {
		this.osDes = osDes;
	}

}
