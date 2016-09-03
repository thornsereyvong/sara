package com.app.entities;


import java.util.Date;
import java.util.List;



public class CrmRole {


	private String roleId;
	private String roleName;
	private String description;
	private List<CrmRoleDetail> roleDetails;
	private String createBy;
	private Date createDate;
	private String modifyBy;
	private Date modifyDate;
	private int roleStatus;
	 
	public String getRoleId() {
		return roleId;
	}

	public void setRoleId(String roleId) {
		this.roleId = roleId;
	}

	public String getRoleName() {
		return roleName;
	}

	public void setRoleName(String roleName) {
		this.roleName = roleName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public Date getCreateDate() {
		return createDate;
	}

	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public List<CrmRoleDetail> getRoleDetails() {
		return roleDetails;
	}

	public void setRoleDetails(List<CrmRoleDetail> roleDetails) {
		this.roleDetails = roleDetails;
	}

	public int getRoleStatus() {
		return roleStatus;
	}

	public void setRoleStatus(int roleStatus) {
		this.roleStatus = roleStatus;
	}
	
}
