package com.app.entities;

import java.util.Date;

public class SaleOrderDetails{
	private int crmSaleDetailsId;
	private String saleId;
	private int lineNo;
	private String itemId;
	private String uomId;
	private String locationId;
	private double saleQuantity;
	private double unitPrice;
	private double totalAmt;
	private double COGSUnit;
	private double COGSAC1;
	private double COGSAC2;
	private double COGSAC3;
	private double COGSAC4;
	private double COGSAC5;
	private double COGSTotal;
	private String postStatus;
	private int jId;
	private double netTotalAmt;
	private double disDol;
	private double disPer;
	private double STaxDol;
	private double STaxPer;
	private double VTaxDol;
	private double VTaxPer;
	private String itemStatus;
	private double reportPrice;
	private int accId;
	private String des;
	private double factor;
	private String clientId;
	private double RKSPrice;
	private short isVariable;
	private String classId;
	private String generateCommission;
	private double disInv;
	private String schPayPeriodID;
	private String schTermStart;
	private String schTermEnd;
	private String schProgramTypeID;
	private String schSchoolGradeId;
	private String schClsGradeID;
	private String schSessionId;
	private String schStatus;
	private Date schSD;
	private Date schTD;
	private Date schSA;
	private Date schTA;

	public int getCrmSaleDetailsId() {
		return crmSaleDetailsId;
	}

	public void setCrmSaleDetailsId(int crmSaleDetailsId) {
		this.crmSaleDetailsId = crmSaleDetailsId;
	}

	public String getSaleId() {
		return saleId;
	}

	public void setSaleId(String saleId) {
		this.saleId = saleId;
	}

	public int getLineNo() {
		return lineNo;
	}

	public void setLineNo(int lineNo) {
		this.lineNo = lineNo;
	}

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getUomId() {
		return uomId;
	}

	public void setUomId(String uomId) {
		this.uomId = uomId;
	}

	public String getLocationId() {
		return locationId;
	}

	public void setLocationId(String locationId) {
		this.locationId = locationId;
	}

	public double getSaleQuantity() {
		return saleQuantity;
	}

	public void setSaleQuantity(double saleQuantity) {
		this.saleQuantity = saleQuantity;
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

	public double getCOGSUnit() {
		return COGSUnit;
	}

	public void setCOGSUnit(double cOGSUnit) {
		COGSUnit = cOGSUnit;
	}

	public double getCOGSAC1() {
		return COGSAC1;
	}

	public void setCOGSAC1(double cOGSAC1) {
		COGSAC1 = cOGSAC1;
	}

	public double getCOGSAC2() {
		return COGSAC2;
	}

	public void setCOGSAC2(double cOGSAC2) {
		COGSAC2 = cOGSAC2;
	}

	public double getCOGSAC3() {
		return COGSAC3;
	}

	public void setCOGSAC3(double cOGSAC3) {
		COGSAC3 = cOGSAC3;
	}

	public double getCOGSAC4() {
		return COGSAC4;
	}

	public void setCOGSAC4(double cOGSAC4) {
		COGSAC4 = cOGSAC4;
	}

	public double getCOGSAC5() {
		return COGSAC5;
	}

	public void setCOGSAC5(double cOGSAC5) {
		COGSAC5 = cOGSAC5;
	}

	public double getCOGSTotal() {
		return COGSTotal;
	}

	public void setCOGSTotal(double cOGSTotal) {
		COGSTotal = cOGSTotal;
	}

	public String getPostStatus() {
		return postStatus;
	}

	public void setPostStatus(String postStatus) {
		this.postStatus = postStatus;
	}

	public int getjId() {
		return jId;
	}

	public void setjId(int jId) {
		this.jId = jId;
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

	public double getSTaxDol() {
		return STaxDol;
	}

	public void setSTaxDol(double sTaxDol) {
		STaxDol = sTaxDol;
	}

	public double getSTaxPer() {
		return STaxPer;
	}

	public void setSTaxPer(double sTaxPer) {
		STaxPer = sTaxPer;
	}

	public double getVTaxDol() {
		return VTaxDol;
	}

	public void setVTaxDol(double vTaxDol) {
		VTaxDol = vTaxDol;
	}

	public double getVTaxPer() {
		return VTaxPer;
	}

	public void setVTaxPer(double vTaxPer) {
		VTaxPer = vTaxPer;
	}

	public String getItemStatus() {
		return itemStatus;
	}

	public void setItemStatus(String itemStatus) {
		this.itemStatus = itemStatus;
	}

	public double getReportPrice() {
		return reportPrice;
	}

	public void setReportPrice(double reportPrice) {
		this.reportPrice = reportPrice;
	}

	public int getAccId() {
		return accId;
	}

	public void setAccId(int accId) {
		this.accId = accId;
	}

	public String getDes() {
		return des;
	}

	public void setDes(String des) {
		this.des = des;
	}

	public double getFactor() {
		return factor;
	}

	public void setFactor(double factor) {
		this.factor = factor;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public double getRKSPrice() {
		return RKSPrice;
	}

	public void setRKSPrice(double rKSPrice) {
		RKSPrice = rKSPrice;
	}

	public short getIsVariable() {
		return isVariable;
	}

	public void setIsVariable(short isVariable) {
		this.isVariable = isVariable;
	}

	public String getClassId() {
		return classId;
	}

	public void setClassId(String classId) {
		this.classId = classId;
	}

	public String getGenerateCommission() {
		return generateCommission;
	}

	public void setGenerateCommission(String generateCommission) {
		this.generateCommission = generateCommission;
	}

	public double getDisInv() {
		return disInv;
	}

	public void setDisInv(double disInv) {
		this.disInv = disInv;
	}

	public String getSchPayPeriodID() {
		return schPayPeriodID;
	}

	public void setSchPayPeriodID(String schPayPeriodID) {
		this.schPayPeriodID = schPayPeriodID;
	}

	public String getSchTermStart() {
		return schTermStart;
	}

	public void setSchTermStart(String schTermStart) {
		this.schTermStart = schTermStart;
	}

	public String getSchTermEnd() {
		return schTermEnd;
	}

	public void setSchTermEnd(String schTermEnd) {
		this.schTermEnd = schTermEnd;
	}

	public String getSchProgramTypeID() {
		return schProgramTypeID;
	}

	public void setSchProgramTypeID(String schProgramTypeID) {
		this.schProgramTypeID = schProgramTypeID;
	}

	public String getSchSchoolGradeId() {
		return schSchoolGradeId;
	}

	public void setSchSchoolGradeId(String schSchoolGradeId) {
		this.schSchoolGradeId = schSchoolGradeId;
	}

	public String getSchClsGradeID() {
		return schClsGradeID;
	}

	public void setSchClsGradeID(String schClsGradeID) {
		this.schClsGradeID = schClsGradeID;
	}

	public String getSchSessionId() {
		return schSessionId;
	}

	public void setSchSessionId(String schSessionId) {
		this.schSessionId = schSessionId;
	}

	public String getSchStatus() {
		return schStatus;
	}

	public void setSchStatus(String schStatus) {
		this.schStatus = schStatus;
	}

	public Date getSchSD() {
		return schSD;
	}

	public void setSchSD(Date schSD) {
		this.schSD = schSD;
	}

	public Date getSchTD() {
		return schTD;
	}

	public void setSchTD(Date schTD) {
		this.schTD = schTD;
	}

	public Date getSchSA() {
		return schSA;
	}

	public void setSchSA(Date schSA) {
		this.schSA = schSA;
	}

	public Date getSchTA() {
		return schTA;
	}

	public void setSchTA(Date schTA) {
		this.schTA = schTA;
	}
}
