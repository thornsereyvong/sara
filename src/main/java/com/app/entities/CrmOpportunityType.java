package com.app.entities;

public class CrmOpportunityType {

	private int otId;
	private String otName;
	private String otDes;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getOtId() {
		return otId;
	}

	public void setOtId(int otId) {
		this.otId = otId;
	}

	public String getOtName() {
		return otName;
	}

	public void setOtName(String otName) {
		this.otName = otName;
	}

	public String getOtDes() {
		return otDes;
	}

	public void setOtDes(String otDes) {
		this.otDes = otDes;
	}

}
