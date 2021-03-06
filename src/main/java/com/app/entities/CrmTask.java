package com.app.entities;

import java.util.Date;

public class CrmTask{

	private String taskId;
	private String taskSubject;
	private String startDate;
	private String dueDate;
	private String taskPriority;
	private CrmTaskStatus taskStatus;
	private String taskDes;
	private String taskRelatedToModule;
	private String taskRelatedToId;
	private CrmContact taskContact;
	private CrmUser taskAssignTo;
	private String taskCreateBy;
	private Date taskCreateDate;
	private String taskModifiedBy;
	private Date taskModifiedDate;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public String getTaskId() {
		return taskId;
	}

	public void setTaskId(String taskId) {
		this.taskId = taskId;
	}

	public String getTaskSubject() {
		return taskSubject;
	}

	public void setTaskSubject(String taskSubject) {
		this.taskSubject = taskSubject;
	}

	public String getStartDate() {
		return startDate;
	}

	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}

	public String getTaskPriority() {
		return taskPriority;
	}

	public void setTaskPriority(String taskPriority) {
		this.taskPriority = taskPriority;
	}

	public CrmTaskStatus getTaskStatus() {
		return taskStatus;
	}

	public void setTaskStatus(CrmTaskStatus taskStatus) {
		this.taskStatus = taskStatus;
	}

	public String getTaskDes() {
		return taskDes;
	}

	public void setTaskDes(String taskDes) {
		this.taskDes = taskDes;
	}

	public String getTaskRelatedToModule() {
		return taskRelatedToModule;
	}

	public void setTaskRelatedToModule(String taskRelatedToModule) {
		this.taskRelatedToModule = taskRelatedToModule;
	}

	public String getTaskRelatedToId() {
		return taskRelatedToId;
	}

	public void setTaskRelatedToId(String taskRelatedToId) {
		this.taskRelatedToId = taskRelatedToId;
	}

	public CrmContact getTaskContact() {
		return taskContact;
	}

	public void setTaskContact(CrmContact taskContact) {
		this.taskContact = taskContact;
	}

	public CrmUser getTaskAssignTo() {
		return taskAssignTo;
	}

	public void setTaskAssignTo(CrmUser taskAssignTo) {
		this.taskAssignTo = taskAssignTo;
	}

	public String getTaskCreateBy() {
		return taskCreateBy;
	}

	public void setTaskCreateBy(String taskCreateBy) {
		this.taskCreateBy = taskCreateBy;
	}

	public Date getTaskCreateDate() {
		return taskCreateDate;
	}

	public void setTaskCreateDate(Date taskCreateDate) {
		this.taskCreateDate = taskCreateDate;
	}

	public String getTaskModifiedBy() {
		return taskModifiedBy;
	}

	public void setTaskModifiedBy(String taskModifiedBy) {
		this.taskModifiedBy = taskModifiedBy;
	}

	public Date getTaskModifiedDate() {
		return taskModifiedDate;
	}

	public void setTaskModifiedDate(Date taskModifiedDate) {
		this.taskModifiedDate = taskModifiedDate;
	}
	
}
