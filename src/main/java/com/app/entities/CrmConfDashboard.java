package com.app.entities;

public class CrmConfDashboard{
	
	private int confId;
	private String type;
	private String moduleId;
	private String userId;
	private int status;
	private int orderBy;
	
	private MeDataSource meDataSource;

	public int getConfId() {
		return confId;
	}

	public void setConfId(int confId) {
		this.confId = confId;
	}

	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getModuleId() {
		return moduleId;
	}

	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}

	public int getOrderBy() {
		return orderBy;
	}

	public void setOrderBy(int orderBy) {
		this.orderBy = orderBy;
	}

	public final MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public final void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

}
