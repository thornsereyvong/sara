package com.app.entities;

import java.time.LocalDateTime;
import java.util.Set;

public class CrmCollaboration{
	private int colId;
	private String colDes;
	private String colUser;
	private Set<CrmCollaborationTags> tags;
	private Set<CrmCollaborationDetails> details;
	private LocalDateTime colCreateDate;
	private String colRelatedToModuleId;
	private String colRelatedToModuleName;
	private String colActivityType;
	private String colActivityId;
	private String colOwn;
	private String createDate;
	private int like;
	private boolean checkLike;

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

	public LocalDateTime getColCreateDate() {
		return colCreateDate;
	}

	public void setColCreateDate(LocalDateTime colCreateDate) {
		this.colCreateDate = colCreateDate;
	}

	public Set<CrmCollaborationTags> getTags() {
		return tags;
	}

	public void setTags(Set<CrmCollaborationTags> tags) {
		this.tags = tags;
	}
	
	public String getCreateDate() {
		return createDate;
	}

	public void setCreateDate(String createDate) {
		this.createDate = createDate;
	}

	public String getColRelatedToModuleId() {
		return colRelatedToModuleId;
	}

	public void setColRelatedToModuleId(String colRelatedToModuleId) {
		this.colRelatedToModuleId = colRelatedToModuleId;
	}

	public String getColRelatedToModuleName() {
		return colRelatedToModuleName;
	}

	public void setColRelatedToModuleName(String colRelatedToModuleName) {
		this.colRelatedToModuleName = colRelatedToModuleName;
	}

	public String getColActivityType() {
		return colActivityType;
	}

	public void setColActivityType(String colActivityType) {
		this.colActivityType = colActivityType;
	}

	public String getColActivityId() {
		return colActivityId;
	}

	public void setColActivityId(String colActivityId) {
		this.colActivityId = colActivityId;
	}

	public String getColOwn() {
		return colOwn;
	}

	public void setColOwn(String colOwn) {
		this.colOwn = colOwn;
	}

	public Set<CrmCollaborationDetails> getDetails() {
		return details;
	}

	public void setDetails(Set<CrmCollaborationDetails> details) {
		this.details = details;
	}

	public int getLike() {
		return like;
	}

	public void setLike(int like) {
		this.like = like;
	}

	public boolean isCheckLike() {
		return checkLike;
	}

	public void setCheckLike(boolean checkLike) {
		this.checkLike = checkLike;
	}
}
