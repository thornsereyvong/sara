package com.app.entities;

import java.io.Serializable;

public class CustomerGroup implements Serializable{

	private static final long serialVersionUID = 1L;

	private String custGroupId;
	
	private String custGroupName;

	public String getCustGroupId() {
		return custGroupId;
	}

	public void setCustGroupId(String custGroupId) {
		this.custGroupId = custGroupId;
	}

	public String getCustGroupName() {
		return custGroupName;
	}

	public void setCustGroupName(String custGroupName) {
		this.custGroupName = custGroupName;
	}
}
