package com.app.entities;


import java.util.Date;


public class CrmNote{


	private String noteId;
	

	private String noteSubject;

	private String noteRelatedToModuleType;
	

	private String noteRelatedToModuleId;
	

	private String noteDes;
	
	
	private String noteCreateBy;
	
	private Date noteCreateDate;
	

	private String noteModifiedBy;

	private Date noteModifiedDate;

	public String getNoteId() {
		return noteId;
	}

	public void setNoteId(String noteId) {
		this.noteId = noteId;
	}

	public String getNoteSubject() {
		return noteSubject;
	}

	public void setNoteSubject(String noteSubject) {
		this.noteSubject = noteSubject;
	}

	public String getNoteRelatedToModuleType() {
		return noteRelatedToModuleType;
	}

	public void setNoteRelatedToModuleType(String noteRelatedToModuleType) {
		this.noteRelatedToModuleType = noteRelatedToModuleType;
	}

	public String getNoteRelatedToModuleId() {
		return noteRelatedToModuleId;
	}

	public void setNoteRelatedToModuleId(String noteRelatedToModuleId) {
		this.noteRelatedToModuleId = noteRelatedToModuleId;
	}

	public String getNoteDes() {
		return noteDes;
	}

	public void setNoteDes(String noteDes) {
		this.noteDes = noteDes;
	}

	public String getNoteCreateBy() {
		return noteCreateBy;
	}

	public void setNoteCreateBy(String noteCreateBy) {
		this.noteCreateBy = noteCreateBy;
	}

	public Date getNoteCreateDate() {
		return noteCreateDate;
	}

	public void setNoteCreateDate(Date noteCreateDate) {
		this.noteCreateDate = noteCreateDate;
	}

	public String getNoteModifiedBy() {
		return noteModifiedBy;
	}

	public void setNoteModifiedBy(String noteModifiedBy) {
		this.noteModifiedBy = noteModifiedBy;
	}

	public Date getNoteModifiedDate() {
		return noteModifiedDate;
	}

	public void setNoteModifiedDate(Date noteModifiedDate) {
		this.noteModifiedDate = noteModifiedDate;
	}
	
}
