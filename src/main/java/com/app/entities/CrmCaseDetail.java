package com.app.entities;

public class CrmCaseDetail{

	private int caseDetailId;
	private String caseId;
	private int lineNo;
	private String itemID;
	private String uom;
	private String locationId;
	private double salQty;
	private double unitPrice;
	private double totalAmt;
	private double disDol;
	private double disPer;
	private double vTaxDol;
	private double vTaxPer;
	private double sTaxDol;
	private double sTaxPer;
	private double disInv;
	private double netTotalAmt;
	private MeDataSource meDataSource;

	public int getCaseDetailId() {
		return caseDetailId;
	}

	public void setCaseDetailId(int caseDetailId) {
		this.caseDetailId = caseDetailId;
	}

	public String getCaseId() {
		return caseId;
	}

	public void setCaseId(String caseId) {
		this.caseId = caseId;
	}

	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	public String getItemID() {
		return itemID;
	}

	public void setItemID(String itemID) {
		this.itemID = itemID;
	}

	public String getUom() {
		return uom;
	}

	public void setUom(String uom) {
		this.uom = uom;
	}

	public String getLocationId() {
		return locationId;
	}

	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}

	public double getSalQty() {
		return salQty;
	}

	public void setSalQty(double salQty) {
		this.salQty = salQty;
	}

	public double getUnitPrice() {
		return unitPrice;
	}

	public void setUnitPrice(double unitPrice) {
		this.unitPrice = unitPrice;
	}

	public double getTotalAmt() {
		return totalAmt;
	}

	public void setTotalAmt(double totalAmt) {
		this.totalAmt = totalAmt;
	}

	public double getDisDol() {
		return disDol;
	}

	public void setDisDol(double disDol) {
		this.disDol = disDol;
	}

	public double getDisPer() {
		return disPer;
	}

	public void setDisPer(double disPer) {
		this.disPer = disPer;
	}

	public double getvTaxDol() {
		return vTaxDol;
	}

	public void setvTaxDol(double vTaxDol) {
		this.vTaxDol = vTaxDol;
	}

	public double getvTaxPer() {
		return vTaxPer;
	}

	public void setvTaxPer(double vTaxPer) {
		this.vTaxPer = vTaxPer;
	}

	public double getsTaxDol() {
		return sTaxDol;
	}

	public void setsTaxDol(double sTaxDol) {
		this.sTaxDol = sTaxDol;
	}

	public double getsTaxPer() {
		return sTaxPer;
	}

	public void setsTaxPer(double sTaxPer) {
		this.sTaxPer = sTaxPer;
	}

	public double getDisInv() {
		return disInv;
	}

	public void setDisInv(double disInv) {
		this.disInv = disInv;
	}

	public double getNetTotalAmt() {
		return netTotalAmt;
	}

	public void setNetTotalAmt(double netTotalAmt) {
		this.netTotalAmt = netTotalAmt;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
}
