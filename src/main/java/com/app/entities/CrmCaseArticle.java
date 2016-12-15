package com.app.entities;

public class CrmCaseArticle {
	private String articleId;
	private String articleTitle;
	private String articleKey;
	private AmeItem item;
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

	public String getArticleTitle() {
		return articleTitle;
	}

	public void setArticleTitle(String articleTitle) {
		this.articleTitle = articleTitle;
	}

	public String getArticleKey() {
		return articleKey;
	}

	public void setArticleKey(String articleKey) {
		this.articleKey = articleKey;
	}	

	public AmeItem getItem() {
		return item;
	}

	public void setItem(AmeItem item) {
		this.item = item;
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
