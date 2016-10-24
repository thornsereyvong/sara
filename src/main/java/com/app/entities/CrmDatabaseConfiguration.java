package com.app.entities;

public class CrmDatabaseConfiguration{

	private String dbID;
	
	private String dbName;
	
	private String dbIP;
	
	private String dbUsername;
	
	private String dbPassword;
	
	private String dbPort;
	
	public String getDbID() {
		return dbID;
	}
	public void setDbID(String dbID) {
		this.dbID = dbID;
	}
	public String getDbName() {
		return dbName;
	}
	public void setDbName(String dbName) {
		this.dbName = dbName;
	}

	public String getDbIP() {
		return dbIP;
	}
	public void setDbIP(String dbIP) {
		this.dbIP = dbIP;
	}
	public String getDbPort() {
		return dbPort;
	}
	public void setDbPort(String dbPort) {
		this.dbPort = dbPort;
	}
	public String getDbUsername() {
		return dbUsername;
	}
	public void setDbUsername(String dbUsername) {
		this.dbUsername = dbUsername;
	}
	public String getDbPassword() {
		return dbPassword;
	}
	public void setDbPassword(String dbPassword) {
		this.dbPassword = dbPassword;
	}
}
