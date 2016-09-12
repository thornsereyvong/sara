package com.app.entities;

import java.util.List;

public class CrmCollaboration {

	private int colId;
	
	private String colDes;
	
	private String colUser;
	
	private List<CrmCollaborationTags> tags;
	
	private String createDate;

	public int getColId() {
		return colId;
	}

	public void setColId(int colId) {
		this.colId = colId;
	}

	public String getColDes() {
		return colDes;
	}

	public void setColDes(String colDes) {
		this.colDes = colDes;
	}

	public String getColUser() {
		return colUser;
	}

	public void setColUser(String colUser) {
		this.colUser = colUser;
	}
	
	public List<CrmCollaborationTags> getTags() {
		return tags;
	}

	public void setTags(List<CrmCollaborationTags> tags) {
		this.tags = tags;
	}
	
	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}
}
