package com.app.entities;

import java.util.Date;
import java.util.List;


public class SaleOrder{
	private String saleId;
	private String saleType;
	private String saleReference;
	private Date saleDate; 
	private int periodM;
	private int periodY; 
	private String custId;
	private String priceCode; 
	private String postStatus; 
	private String pmtStatus; 
	private int jId;
	private String pmtSchId;  
	private String empId; 
	private double totalAmount;
	private double disInvDol;
	private double disInvPer;
	private double totalDis; 
	private double totalSTax;
	private double totalVTax;
	private double netTotalAmt;
	private double pmtToDate;
	private double cash;
	private double cashCard;
	private double creditCard;
	private double otherSetAmt;
	private double receiveAR;
	private Date pmtDisDate; 
	private String remark; 
	private String message; 
	private String clientId;
	private String locationId;
	private Date dueDate; 
	private String classId; 
	private String shipTo;
	private short isRead;
	private List<SaleOrderDetails> saleOrderDetails;
	private MeDataSource meDataSource;

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public String getSaleId() {
		return saleId;
	}

	public void setSaleId(String saleId) {
		this.saleId = saleId;
	}

	public String getSaleType() {
		return saleType;
	}

	public void setSaleType(String saleType) {
		this.saleType = saleType;
	}

	public String getSaleReference() {
		return saleReference;
	}

	public void setSaleReference(String saleReference) {
		this.saleReference = saleReference;
	}

	public Date getSaleDate() {
		return saleDate;
	}

	public void setSaleDate(Date saleDate) {
		this.saleDate = saleDate;
	}

	public int getPeriodM() {
		return periodM;
	}

	public void setPeriodM(int periodM) {
		this.periodM = periodM;
	}

	public int getPeriodY() {
		return periodY;
	}

	public void setPeriodY(int periodY) {
		this.periodY = periodY;
	}

	public String getCustId() {
		return custId;
	}

	public void setCustId(String custId) {
		this.custId = custId;
	}

	public String getPriceCode() {
		return priceCode;
	}

	public void setPriceCode(String priceCode) {
		this.priceCode = priceCode;
	}

	public String getPostStatus() {
		return postStatus;
	}

	public void setPostStatus(String postStatus) {
		this.postStatus = postStatus;
	}

	public String getPmtStatus() {
		return pmtStatus;
	}

	public void setPmtStatus(String pmtStatus) {
		this.pmtStatus = pmtStatus;
	}

	public int getjId() {
		return jId;
	}

	public void setjId(int jId) {
		this.jId = jId;
	}

	public String getPmtSchId() {
		return pmtSchId;
	}

	public void setPmtSchId(String pmtSchId) {
		this.pmtSchId = pmtSchId;
	}

	public String getEmpId() {
		return empId;
	}

	public void setEmpId(String empId) {
		this.empId = empId;
	}

	public double getTotalAmount() {
		return totalAmount;
	}

	public void setTotalAmount(double totalAmount) {
		this.totalAmount = totalAmount;
	}

	public double getDisInvDol() {
		return disInvDol;
	}

	public void setDisInvDol(double disInvDol) {
		this.disInvDol = disInvDol;
	}

	public double getDisInvPer() {
		return disInvPer;
	}

	public void setDisInvPer(double disInvPer) {
		this.disInvPer = disInvPer;
	}

	public double getTotalDis() {
		return totalDis;
	}

	public void setTotalDis(double totalDis) {
		this.totalDis = totalDis;
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

	public double getNetTotalAmt() {
		return netTotalAmt;
	}

	public void setNetTotalAmt(double netTotalAmt) {
		this.netTotalAmt = netTotalAmt;
	}

	public double getPmtToDate() {
		return pmtToDate;
	}

	public void setPmtToDate(double pmtToDate) {
		this.pmtToDate = pmtToDate;
	}

	public double getCash() {
		return cash;
	}

	public void setCash(double cash) {
		this.cash = cash;
	}

	public double getCashCard() {
		return cashCard;
	}

	public void setCashCard(double cashCard) {
		this.cashCard = cashCard;
	}

	public double getCreditCard() {
		return creditCard;
	}

	public void setCreditCard(double creditCard) {
		this.creditCard = creditCard;
	}

	public double getOtherSetAmt() {
		return otherSetAmt;
	}

	public void setOtherSetAmt(double otherSetAmt) {
		this.otherSetAmt = otherSetAmt;
	}

	public double getReceiveAR() {
		return receiveAR;
	}

	public void setReceiveAR(double receiveAR) {
		this.receiveAR = receiveAR;
	}

	public Date getPmtDisDate() {
		return pmtDisDate;
	}

	public void setPmtDisDate(Date pmtDisDate) {
		this.pmtDisDate = pmtDisDate;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public String getMessage() {
		return message;
	}

	public void setMessage(String message) {
		this.message = message;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getLocationId() {
		return locationId;
	}

	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}

	public Date getDueDate() {
		return dueDate;
	}

	public void setDueDate(Date dueDate) {
		this.dueDate = dueDate;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public String getShipTo() {
		return shipTo;
	}

	public void setShipTo(String shipTo) {
		this.shipTo = shipTo;
	}

	public short getIsRead() {
		return isRead;
	}

	public void setIsRead(short isRead) {
		this.isRead = isRead;
	}

	public List<SaleOrderDetails> getSaleOrderDetails() {
		return saleOrderDetails;
	}

	public void setSaleOrderDetails(List<SaleOrderDetails> saleOrderDetails) {
		this.saleOrderDetails = saleOrderDetails;
	}
}
