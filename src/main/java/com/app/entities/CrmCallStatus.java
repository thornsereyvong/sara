package com.app.entities;


public class CrmCallStatus {
	private int callStatusId;
	private String callStatusName;
	private String callStatusDes;
	private MeDataSource meDataSource;
	
	public final MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public final void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getCallStatusId() {
		return callStatusId;
	}

	public void setCallStatusId(int callStatusId) {
		this.callStatusId = callStatusId;
	}

	public String getCallStatusName() {
		return callStatusName;
	}

	public void setCallStatusName(String callStatusName) {
		this.callStatusName = callStatusName;
	}

	public String getCallStatusDes() {
		return callStatusDes;
	}

	public void setCallStatusDes(String callStatusDes) {
		this.callStatusDes = callStatusDes;
	}
}
