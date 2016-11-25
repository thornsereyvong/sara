package com.app.entities;


public class CrmCasePriority {

	private int priorityId;
	

	private String priorityName;

	private String priorityDes;
	
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getPriorityId() {
		return priorityId;
	}

	public void setPriorityId(int priorityId) {
		this.priorityId = priorityId;
	}

	public String getPriorityName() {
		return priorityName;
	}

	public void setPriorityName(String priorityName) {
		this.priorityName = priorityName;
	}

	public String getPriorityDes() {
		return priorityDes;
	}

	public void setPriorityDes(String priorityDes) {
		this.priorityDes = priorityDes;
	}

}
