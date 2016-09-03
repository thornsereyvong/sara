package com.app.entities;


public class CrmUser{


	private String userID;
	

	private String username;

	private String password;
	

	private String userType;
	

	private String userKey;
	

	private int status;


	private String parentID;

	private CrmRole role;
	
	

	public CrmUser(){
		
	}
	
	public String getUserID() {
		return userID;
	}

	public void setUserID(String userID) {
		this.userID = userID;
	}

	public String getUsername() {
		return username;
	}

	public void setUsername(String username) {
		this.username = username;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getUserType() {
		return userType;
	}

	public void setUserType(String userType) {
		this.userType = userType;
	}

	public String getUserKey() {
		return userKey;
	}

	public void setUserKey(String userKey) {
		this.userKey = userKey;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public CrmRole getRole() {
		return role;
	}

	public void setRole(CrmRole role) {
		this.role = role;
	}

	public String getParentID() {
		return parentID;
	}
	public void setParentID(String parentID) {
		this.parentID = parentID;
	}
	/*public List<CrmDatabaseConfiguration> getDatabase() {
		return database;
	}
	public void setDatabase(List<CrmDatabaseConfiguration> database) {
		this.database = database;
	}*/
}
