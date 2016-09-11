package com.app.entities;


import java.time.LocalDateTime;
import java.util.Date;

public class CrmCall {
	private String callId;
	private String callSubject;
	private String startDate;
	private String callDuration;
	private CrmCallStatus callStatus;
	private String callRelatedToModuleType;
	private String callRelatedToFieldId;
	private String callDes;
	private CrmUser callAssignTo;
	private String callCreateBy;
	private LocalDateTime callCreateDate;
	private String callModifiedBy;
	private Date callModifiedDate;
	
	public String getCallId() {
		return callId;
	}
	public void setCallId(String callId) {
		this.callId = callId;
	}
	public String getCallSubject() {
		return callSubject;
	}
	public void setCallSubject(String callSubject) {
		this.callSubject = callSubject;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getCallDuration() {
		return callDuration;
	}
	public void setCallDuration(String callDuration) {
		this.callDuration = callDuration;
	}
	public CrmCallStatus getCallStatus() {
		return callStatus;
	}
	public void setCallStatus(CrmCallStatus callStatus) {
		this.callStatus = callStatus;
	}
	public String getCallRelatedToModuleType() {
		return callRelatedToModuleType;
	}
	public void setCallRelatedToModuleType(String callRelatedToModuleType) {
		this.callRelatedToModuleType = callRelatedToModuleType;
	}
	public String getCallRelatedToFieldId() {
		return callRelatedToFieldId;
	}
	public void setCallRelatedToFieldId(String callRelatedToFieldId) {
		this.callRelatedToFieldId = callRelatedToFieldId;
	}
	public String getCallDes() {
		return callDes;
	}
	public void setCallDes(String callDes) {
		this.callDes = callDes;
	}
	public CrmUser getCallAssignTo() {
		return callAssignTo;
	}
	public void setCallAssignTo(CrmUser callAssignTo) {
		this.callAssignTo = callAssignTo;
	}
	public String getCallCreateBy() {
		return callCreateBy;
	}
	public void setCallCreateBy(String callCreateBy) {
		this.callCreateBy = callCreateBy;
	}
	
	public LocalDateTime getCallCreateDate() {
		return callCreateDate;
	}
	public void setCallCreateDate(LocalDateTime callCreateDate) {
		this.callCreateDate = callCreateDate;
	}
	public String getCallModifiedBy() {
		return callModifiedBy;
	}
	public void setCallModifiedBy(String callModifiedBy) {
		this.callModifiedBy = callModifiedBy;
	}
	public Date getCallModifiedDate() {
		return callModifiedDate;
	}
	public void setCallModifiedDate(Date callModifiedDate) {
		this.callModifiedDate = callModifiedDate;
	}
	
}
