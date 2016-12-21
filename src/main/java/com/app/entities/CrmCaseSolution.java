package com.app.entities;

public class CrmCaseSolution{
	
	private String caseId;
	private CrmCaseStatus status;
	private String resolvedBy;
	private String resolution;
	private String convertResolvedDate;
	private String convertFollowupDate;
	private CrmCaseArticle article;
	private MeDataSource meDataSource;

	public String getResolution() {
		return resolution;
	}

	public void setResolution(String resolution) {
		this.resolution = resolution;
	}

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

	public String getResolvedBy() {
		return resolvedBy;
	}

	public void setResolvedBy(String resolvedBy) {
		this.resolvedBy = resolvedBy;
	}

	public String getConvertResolvedDate() {
		return convertResolvedDate;
	}

	public void setConvertResolvedDate(String convertResolvedDate) {
		this.convertResolvedDate = convertResolvedDate;
	}

	public String getConvertFollowupDate() {
		return convertFollowupDate;
	}

	public void setConvertFollowupDate(String convertFollowupDate) {
		this.convertFollowupDate = convertFollowupDate;
	}

	public CrmCaseArticle getArticle() {
		return article;
	}

	public void setArticle(CrmCaseArticle article) {
		this.article = article;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
}
