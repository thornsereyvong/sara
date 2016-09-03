package com.app.entities;

import java.util.Date;

public class CrmMeeting {


	private String meetingId;

	private String meetingSubject;
	private Date meetingStartDate;
	private Date meetingEndDate;
	private String meetingDuration;
	private CrmMeetingStatus meetingStatus;
	private String meetingRelatedToModuleType;
	private String meetingRelatedToModuleId;
	private String meetingLocation;
	private String meetingDes;
	private CrmUser meetingAssignTo;
	private String meetingCreateBy;
	private Date meetingCreateDate;
	private String meetingModifiedBy;
	private Date meetingModifiedDate;
	
	
	
	
	
	public String getMeetingId() {
		return meetingId;
	}

	public void setMeetingId(String meetingId) {
		this.meetingId = meetingId;
	}

	public String getMeetingSubject() {
		return meetingSubject;
	}

	public void setMeetingSubject(String meetingSubject) {
		this.meetingSubject = meetingSubject;
	}

	public Date getMeetingStartDate() {
		return meetingStartDate;
	}

	public void setMeetingStartDate(Date meetingStartDate) {
		this.meetingStartDate = meetingStartDate;
	}

	public Date getMeetingEndDate() {
		return meetingEndDate;
	}

	public void setMeetingEndDate(Date meetingEndDate) {
		this.meetingEndDate = meetingEndDate;
	}

	public String getMeetingDuration() {
		return meetingDuration;
	}

	public void setMeetingDuration(String meetingDuration) {
		this.meetingDuration = meetingDuration;
	}

	public CrmMeetingStatus getMeetingStatus() {
		return meetingStatus;
	}

	public void setMeetingStatus(CrmMeetingStatus meetingStatus) {
		this.meetingStatus = meetingStatus;
	}

	public String getMeetingRelatedToModuleType() {
		return meetingRelatedToModuleType;
	}

	public void setMeetingRelatedToModuleType(String meetingRelatedToModuleType) {
		this.meetingRelatedToModuleType = meetingRelatedToModuleType;
	}

	public String getMeetingRelatedToModuleId() {
		return meetingRelatedToModuleId;
	}

	public void setMeetingRelatedToModuleId(String meetingRelatedToModuleId) {
		this.meetingRelatedToModuleId = meetingRelatedToModuleId;
	}

	public String getMeetingLocation() {
		return meetingLocation;
	}

	public void setMeetingLocation(String meetingLocation) {
		this.meetingLocation = meetingLocation;
	}

	public String getMeetingDes() {
		return meetingDes;
	}

	public void setMeetingDes(String meetingDes) {
		this.meetingDes = meetingDes;
	}

	public CrmUser getMeetingAssignTo() {
		return meetingAssignTo;
	}

	public void setMeetingAssignTo(CrmUser meetingAssignTo) {
		this.meetingAssignTo = meetingAssignTo;
	}

	public String getMeetingCreateBy() {
		return meetingCreateBy;
	}

	public void setMeetingCreateBy(String meetingCreateBy) {
		this.meetingCreateBy = meetingCreateBy;
	}

	public Date getMeetingCreateDate() {
		return meetingCreateDate;
	}

	public void setMeetingCreateDate(Date meetingCreateDate) {
		this.meetingCreateDate = meetingCreateDate;
	}

	public String getMeetingModifiedBy() {
		return meetingModifiedBy;
	}

	public void setMeetingModifiedBy(String meetingModifiedBy) {
		this.meetingModifiedBy = meetingModifiedBy;
	}

	public Date getMeetingModifiedDate() {
		return meetingModifiedDate;
	}

	public void setMeetingModifiedDate(Date meetingModifiedDate) {
		this.meetingModifiedDate = meetingModifiedDate;
	}
}
