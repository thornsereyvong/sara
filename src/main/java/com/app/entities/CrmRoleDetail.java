package com.app.entities;


public class CrmRoleDetail {

	private int roleDetailId;
	private CrmModule module;
	private String roleAccess;
	private String roleDelete;
	private String roleEdit;
	private String roleExport;
	private String roleImport;
	private String roleList;
	private String roleView;
	
	/*@ManyToOne(fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	@JoinColumn(name="RM_RoleID", nullable = true)
	private CrmRole role;*/

	

	public String getRoleAccess() {
		return roleAccess;
	}

	public CrmModule getModule() {
		return module;
	}

	public void setModule(CrmModule module) {
		this.module = module;
	}

	public void setRoleAccess(String roleAccess) {
		this.roleAccess = roleAccess;
	}

	public String getRoleDelete() {
		return roleDelete;
	}

	public void setRoleDelete(String roleDelete) {
		this.roleDelete = roleDelete;
	}

	public String getRoleEdit() {
		return roleEdit;
	}

	public void setRoleEdit(String roleEdit) {
		this.roleEdit = roleEdit;
	}

	public String getRoleExport() {
		return roleExport;
	}

	public void setRoleExport(String roleExport) {
		this.roleExport = roleExport;
	}

	public String getRoleImport() {
		return roleImport;
	}

	public void setRoleImport(String roleImport) {
		this.roleImport = roleImport;
	}

	public String getRoleList() {
		return roleList;
	}

	public void setRoleList(String roleList) {
		this.roleList = roleList;
	}

	public String getRoleView() {
		return roleView;
	}

	public void setRoleView(String roleView) {
		this.roleView = roleView;
	}

	public int getRoleDetailId() {
		return roleDetailId;
	}

	public void setRoleDetailId(int roleDetailId) {
		this.roleDetailId = roleDetailId;
	}

	/*public CrmRole getRole() {
		return role;
	}

	public void setRole(CrmRole role) {
		this.role = role;
	}*/
}
