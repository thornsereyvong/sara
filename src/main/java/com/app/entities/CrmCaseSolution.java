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
	private boolean createArt;
	private String key;
	private String createBy;
	private String itemId;
	private String title;
	
	private String escalateTo;
	private String currentAssign;
	
	
	
	public String getEscalateTo() {
		return escalateTo;
	}

	public void setEscalateTo(String escalateTo) {
		this.escalateTo = escalateTo;
	}

	public String getCurrentAssign() {
		return currentAssign;
	}

	public void setCurrentAssign(String currentAssign) {
		this.currentAssign = currentAssign;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public boolean isCreateArt() {
		return createArt;
	}

	public void setCreateArt(boolean createArt) {
		this.createArt = createArt;
	}

	public String getKey() {
		return key;
	}

	public void setKey(String key) {
		this.key = key;
	}

	public String getCreateBy() {
		return createBy;
	}

	public void setCreateBy(String createBy) {
		this.createBy = createBy;
	}

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
