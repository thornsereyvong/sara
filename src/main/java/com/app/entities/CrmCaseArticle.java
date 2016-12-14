package com.app.entities;

public class CrmCaseArticle {
	private String articleId;
	private String atricleTitle;
	private String articleKey;
	private String articleItemId;
	private String articleDes;
	private String convertCreateDate;
	private String articleCreateBy;
	private String convertModifiedDate;
	private String articleModifiedBy;
	private MeDataSource meDataSource;

	public String getArticleId() {
		return articleId;
	}

	public void setArticleId(String articleId) {
		this.articleId = articleId;
	}

	public String getAtricleTitle() {
		return atricleTitle;
	}

	public void setAtricleTitle(String atricleTitle) {
		this.atricleTitle = atricleTitle;
	}

	public String getArticleKey() {
		return articleKey;
	}

	public void setArticleKey(String articleKey) {
		this.articleKey = articleKey;
	}	

	public String getArticleItemId() {
		return articleItemId;
	}

	public void setArticleItemId(String articleItemId) {
		this.articleItemId = articleItemId;
	}

	public String getArticleDes() {
		return articleDes;
	}

	public void setArticleDes(String articleDes) {
		this.articleDes = articleDes;
	}

	public String getConvertModifiedDate() {
		return convertModifiedDate;
	}

	public void setConvertModifiedDate(String convertModifiedDate) {
		this.convertModifiedDate = convertModifiedDate;
	}

	public String getConvertCreateDate() {
		return convertCreateDate;
	}

	public void setConvertCreateDate(String convertCreateDate) {
		this.convertCreateDate = convertCreateDate;
	}

	public String getArticleCreateBy() {
		return articleCreateBy;
	}

	public void setArticleCreateBy(String articleCreateBy) {
		this.articleCreateBy = articleCreateBy;
	}

	
	public String getArticleModifiedBy() {
		return articleModifiedBy;
	}

	public void setArticleModifiedBy(String articleModifiedBy) {
		this.articleModifiedBy = articleModifiedBy;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
}
