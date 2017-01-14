package com.app.entities;

import java.time.LocalDateTime;
import java.util.Date;
import java.util.List;

public class CrmRole {
	
	private String roleId;
	private String roleName;
	private String description;
	private List<CrmRoleDetail> roleDetails;
	private String createBy;
	private LocalDateTime createDate;
	private String modifyBy;
	private LocalDateTime modifyDate;
	private int roleStatus;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

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

	

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public void setModifyDate(LocalDateTime modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
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
