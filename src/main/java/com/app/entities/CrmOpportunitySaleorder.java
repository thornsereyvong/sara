package com.app.entities;

public class CrmOpportunitySaleorder{
	private int opSaleId;
	private String opId;
	private String saleId;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getOpSaleId() {
		return opSaleId;
	}

	public void setOpSaleId(int opSaleId) {
		this.opSaleId = opSaleId;
	}

	public String getOpId() {
		return opId;
	}

	public void setOpId(String opId) {
		this.opId = opId;
	}

	public String getSaleId() {
		return saleId;
	}

	public void setSaleId(String saleId) {
		this.saleId = saleId;
	}
}
