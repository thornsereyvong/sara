package com.app.entities;


public class CrmOpportunityQuotation{
	private int opQuoteId;
	private String opId;
	private String quoteId;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getOpQuoteId() {
		return opQuoteId;
	}

	public void setOpQuoteId(int opQuoteId) {
		this.opQuoteId = opQuoteId;
	}

	public String getOpId() {
		return opId;
	}

	public void setOpId(String opId) {
		this.opId = opId;
	}

	public String getQuoteId() {
		return quoteId;
	}

	public void setQuoteId(String quoteId) {
		this.quoteId = quoteId;
	}
}
