package com.app.entities;

import java.util.List;

public class CrmOpportunityDetails{
	private int opDetailsId;
	private String opId;
	private int lineNo;
	private AmeItem item;
	private AmeUom uom;
	private AmeLocation location;
	private double saleQty;
	private double unitPrice;
	private double totalAmt;
	private double netTotalAmt;
	private double disDol;
	private double disPer;
	private double sTaxDol;
	private double sTaxPer;
	private double vTaxDol;
	private double vTaxPer;
	private double reportPrice;
	private double factor;
	private AmeClass ameClass;
	private double disInv;
	private List<Object> items;
	private List<Object> locations;
	private Object opportunity;

	public int getOpDetailsId() {
		return opDetailsId;
	}

	public void setOpDetailsId(int opDetailsId) {
		this.opDetailsId = opDetailsId;
	}


	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	public double getSaleQty() {
		return saleQty;
	}

	public void setSaleQty(double saleQty) {
		this.saleQty = saleQty;
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

	public double getNetTotalAmt() {
		return netTotalAmt;
	}

	public void setNetTotalAmt(double netTotalAmt) {
		this.netTotalAmt = netTotalAmt;
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

	public double getReportPrice() {
		return reportPrice;
	}

	public void setReportPrice(double reportPrice) {
		this.reportPrice = reportPrice;
	}

	public double getFactor() {
		return factor;
	}

	public void setFactor(double factor) {
		this.factor = factor;
	}

	public double getDisInv() {
		return disInv;
	}

	public void setDisInv(double disInv) {
		this.disInv = disInv;
	}

	public String getOpId() {
		return opId;
	}

	public void setOpId(String opId) {
		this.opId = opId;
	}

	public List<Object> getItems() {
		return items;
	}

	public void setItems(List<Object> items) {
		this.items = items;
	}

	public List<Object> getLocations() {
		return locations;
	}

	public void setLocations(List<Object> locations) {
		this.locations = locations;
	}

	public Object getOpportunity() {
		return opportunity;
	}

	public void setOpportunity(Object opportunity) {
		this.opportunity = opportunity;
	}

	public AmeItem getItem() {
		return item;
	}

	public void setItem(AmeItem item) {
		this.item = item;
	}

	public AmeUom getUom() {
		return uom;
	}

	public void setUom(AmeUom uom) {
		this.uom = uom;
	}

	public AmeLocation getLocation() {
		return location;
	}

	public void setLocation(AmeLocation location) {
		this.location = location;
	}

	public AmeClass getAmeClass() {
		return ameClass;
	}

	public void setAmeClass(AmeClass ameClass) {
		this.ameClass = ameClass;
	}
	
}
