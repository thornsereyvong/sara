package com.app.entities;

public class MeDataSource {
	private String ip;
	private String un;
	private String pw;
	private String db;
	private String port = "3306";
	private String userid;
	
	public String getIp() {
		return ip;
	}
	public void setIp(String ip) {
		this.ip = ip;
	}
	public String getUn() {
		return un;
	}
	public void setUn(String un) {
		this.un = un;
	}
	public String getPw() {
		return pw;
	}
	public void setPw(String pw) {
		this.pw = pw;
	}
	public String getDb() {
		return db;
	}
	public void setDb(String db) {
		this.db = db;
	}
	public String getPort() {
		return port;
	}
	public void setPort(String port) {
		this.port = port;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}	
	
	public MeDataSource(String ip, String un, String pw, String db, String port, String userid) {
		this.ip = ip;
		this.un = un;
		this.pw = pw;
		this.db = db;
		this.port = port;
		this.userid = userid;
	}
	public MeDataSource() {
}
}