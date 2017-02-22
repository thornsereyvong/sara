package com.app.entities;

import org.springframework.web.multipart.commons.CommonsMultipartFile;

public class MailMessage {
	private String from;
	private String to;
	private String subject;
	private String msg;
	private String Cc;
	private String Bcc;
	private CommonsMultipartFile attachment;
	public String getFrom() {
		return from;
	}
	public void setFrom(String from) {
		this.from = from;
	}
	public String getTo() {
		return to;
	}
	public void setTo(String to) {
		this.to = to;
	}
	public String getSubject() {
		return subject;
	}
	public void setSubject(String subject) {
		this.subject = subject;
	}
	public String getMsg() {
		return msg;
	}
	public void setMsg(String msg) {
		this.msg = msg;
	}
	public String getCc() {
		return Cc;
	}
	public void setCc(String cc) {
		Cc = cc;
	}
	public String getBcc() {
		return Bcc;
	}
	public void setBcc(String bcc) {
		Bcc = bcc;
	}
	public CommonsMultipartFile getAttachment() {
		return attachment;
	}
	public void setAttachment(CommonsMultipartFile attachment) {
		this.attachment = attachment;
	}
}
