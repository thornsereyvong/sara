package com.app.entities;

public class CrmOpportunityContact{
	private int opConId;
	private String opId ;
	private String conId;
	private String opConType;
	private String opConRole;

	public int getOpConId() {
		return opConId;
	}

	public void setOpConId(int opConId) {
		this.opConId = opConId;
	}

	public String getOpId() {
		return opId;
	}

	public void setOpId(String opId) {
		this.opId = opId;
	}

	public String getConId() {
		return conId;
	}

	public void setConId(String conId) {
		this.conId = conId;
	}

	public String getOpConType() {
		return opConType;
	}

	public void setOpConType(String opConType) {
		this.opConType = opConType;
	}

	public String getOpConRole() {
		return opConRole;
	}

	public void setOpConRole(String opConRole) {
		this.opConRole = opConRole;
	}
}
