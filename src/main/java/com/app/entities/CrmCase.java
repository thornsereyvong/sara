package com.app.entities;

import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;

public class CrmCase{

	private String caseId;
	private CrmCaseStatus status;
	private CrmCaseType type;
	private CrmCasePriority priority;
	private CrmCustomer customer;
	private CrmContact contact;
	private String subject;
	private String des;
	private String resolution;
	private CrmUser assignTo;
	private String createBy;
	private LocalDateTime createDate;
	private String convertCreateDate;
	private String modifyBy;
	private Date modifyDate;
	private String resolvedBy;
	private LocalDateTime resolvedDate;
	private String convertResolvedDate;
	private String escalateTo;
	private String escalateStatus;
	private LocalDateTime followupDate;
	private LocalDateTime elapsedTime;
	private PriceCode priceCode;
	private AmeClass ameClass;
	private double totalSTax;
	private double totalVTax;
	private double totalAmt;
	private double invDisDol;
	private double invDisPer;
	private double totalDis;
	private double netTotalAmt;
	private CrmCaseOrigin origin;
	private AmeItem item;
	private List<CrmCaseDetail> details;
	private MeDataSource meDataSource;

	public String getCaseId() {
		return caseId;
	}

	public void setCaseId(String caseId) {
		this.caseId = caseId;
	}

	public CrmCaseStatus getStatus() {
		return status;
	}

	public void setStatus(CrmCaseStatus status) {
		this.status = status;
	}

	public CrmCaseType getType() {
		return type;
	}

	public void setType(CrmCaseType type) {
		this.type = type;
	}

	public CrmCasePriority getPriority() {
		return priority;
	}

	public void setPriority(CrmCasePriority priority) {
		this.priority = priority;
	}

	public CrmCustomer getCaseCustomer() {
		return customer;
	}

	public void setCustomer(CrmCustomer customer) {
		this.customer = customer;
	}

	public CrmContact getContact() {
		return contact;
	}

	public void setContact(CrmContact contact) {
		this.contact = contact;
	}

	public String getSubject() {
		return subject;
	}

	public void setSubject(String subject) {
		this.subject = subject;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

	public CrmUser getAssignTo() {
		return assignTo;
	}

	public void setAssignTo(CrmUser assignTo) {
		this.assignTo = assignTo;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

	public LocalDateTime getCreateDate() {
		return createDate;
	}

	public void setCreateDate(LocalDateTime createDate) {
		this.createDate = createDate;
	}

	public CrmCustomer getCustomer() {
		return customer;
	}

	public String getModifyBy() {
		return modifyBy;
	}

	public void setModifyBy(String modifyBy) {
		this.modifyBy = modifyBy;
	}

	public Date getModifyDate() {
		return modifyDate;
	}

	public void setModifyDate(Date modifyDate) {
		this.modifyDate = modifyDate;
	}

	public String getConvertCreateDate() {
		return convertCreateDate;
	}

	public void setConvertCreateDate(String convertCreateDate) {
		this.convertCreateDate = convertCreateDate;
	}

	public final MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public final void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public String getResolvedBy() {
		return resolvedBy;
	}

	public void setResolvedBy(String resolvedBy) {
		this.resolvedBy = resolvedBy;
	}

	public LocalDateTime getResolvedDate() {
		return resolvedDate;
	}

	public void setResolvedDate(LocalDateTime resolvedDate) {
		this.resolvedDate = resolvedDate;
	}

	public String getConvertResolvedDate() {
		return convertResolvedDate;
	}

	public void setConvertResolvedDate(String convertResolvedDate) {
		this.convertResolvedDate = convertResolvedDate;
	}

	public String getEscalateTo() {
		return escalateTo;
	}

	public void setEscalateTo(String escalateTo) {
		this.escalateTo = escalateTo;
	}

	public String getEscalateStatus() {
		return escalateStatus;
	}

	public void setEscalateStatus(String escalateStatus) {
		this.escalateStatus = escalateStatus;
	}

	public LocalDateTime getFollowupDate() {
		return followupDate;
	}

	public void setFollowupDate(LocalDateTime followupDate) {
		this.followupDate = followupDate;
	}

	public LocalDateTime getElapsedTime() {
		return elapsedTime;
	}

	public void setElapsedTime(LocalDateTime elapsedTime) {
		this.elapsedTime = elapsedTime;
	}

	public PriceCode getPriceCode() {
		return priceCode;
	}

	public void setPriceCode(PriceCode priceCode) {
		this.priceCode = priceCode;
	}

	public AmeClass getAmeClass() {
		return ameClass;
	}

	public void setAmeClass(AmeClass ameClass) {
		this.ameClass = ameClass;
	}

	public double getTotalSTax() {
		return totalSTax;
	}

	public void setTotalSTax(double totalSTax) {
		this.totalSTax = totalSTax;
	}

	public double getTotalVTax() {
		return totalVTax;
	}

	public void setTotalVTax(double totalVTax) {
		this.totalVTax = totalVTax;
	}

	public double getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(double totalAmt) {
		this.totalAmt = totalAmt;
	}

	public double getInvDisDol() {
		return invDisDol;
	}

	public void setInvDisDol(double invDisDol) {
		this.invDisDol = invDisDol;
	}

	public double getInvDisPer() {
		return invDisPer;
	}

	public void setInvDisPer(double invDisPer) {
		this.invDisPer = invDisPer;
	}

	public double getTotalDis() {
		return totalDis;
	}

	public void setTotalDis(double totalDis) {
		this.totalDis = totalDis;
	}

	public double getNetTotalAmt() {
		return netTotalAmt;
	}

	public void setNetTotalAmt(double netTotalAmt) {
		this.netTotalAmt = netTotalAmt;
	}

	public CrmCaseOrigin getOrigin() {
		return origin;
	}

	public void setOrigin(CrmCaseOrigin origin) {
		this.origin = origin;
	}

	public AmeItem getItem() {
		return item;
	}

	public void setItem(AmeItem item) {
		this.item = item;
	}

	public List<CrmCaseDetail> getDetails() {
		return details;
	}

	public void setDetails(List<CrmCaseDetail> details) {
		this.details = details;
	}
	
}
