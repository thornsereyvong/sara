package com.app.entities;

public class HBUMarketSurvey{

	private String msId;
	private String convertMsDate;
	private AmeItem item;
	private String msCreateBy;
	private String msModifiedBy;
	private String convertModifiedDate;
	private MeDataSource meDataSource;

	public String getMsId() {
		return msId;
	}

	public void setMsId(String msId) {
		this.msId = msId;
	}


	public String getConvertMsDate() {
		return convertMsDate;
	}

	public void setConvertMsDate(String convertMsDate) {
		this.convertMsDate = convertMsDate;
	}

	public AmeItem getItem() {
		return item;
	}

	public void setItem(AmeItem item) {
		this.item = item;
	}

	public String getMsCreateBy() {
		return msCreateBy;
	}

	public void setMsCreateBy(String msCreateBy) {
		this.msCreateBy = msCreateBy;
	}

	public String getMsModifiedBy() {
		return msModifiedBy;
	}

	public void setMsModifiedBy(String msModifiedBy) {
		this.msModifiedBy = msModifiedBy;
	}

	public String getConvertModifiedDate() {
		return convertModifiedDate;
	}

	public void setConvertModifiedDate(String convertModifiedDate) {
		this.convertModifiedDate = convertModifiedDate;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
	
}
