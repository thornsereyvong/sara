package com.app.entities;

public class CrmTaskStatus {


	private int taskStatusId;

	private String taskStatusName;
	

	private String taskStatusDes;

	public int getTaskStatusId() {
		return taskStatusId;
	}

	public void setTaskStatusId(int taskStatusId) {
		this.taskStatusId = taskStatusId;
	}

	public String getTaskStatusName() {
		return taskStatusName;
	}

	public void setTaskStatusName(String taskStatusName) {
		this.taskStatusName = taskStatusName;
	}

	public String getTaskStatusDes() {
		return taskStatusDes;
	}

	public void setTaskStatusDes(String taskStatusDes) {
		this.taskStatusDes = taskStatusDes;
	}
}
