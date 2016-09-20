package com.app.entities;

import java.util.List;

public class CrmCustomer {

	private String custID;
	private String custName;
	private String custTel1;
	private String custTel2;
	private String custFax;
	private String custEmail;
	private String custWebsite;
	private String custAddress;
	private String facebook;
	private String line;
	private String viber;
	private String whatApp;
	private CrmIndustry industID;
	private CrmAccountType accountTypeID;
	private int approval;
	private String imageName;
	private PriceCode priceCode;
	private CustomerGroup custGroup;
	private List<CrmCase> cases;
	private List<CrmContact> contacts;
	private List<CrmOpportunity> opportunities;
	private List<CrmCustomerDetails> custDetails;

	public int getApproval() {
		return approval;
	}

	public void setApproval(int approval) {
		this.approval = approval;
	}

	public String getImageName() {
		return imageName;
	}

	public void setImageName(String imageName) {
		this.imageName = imageName;
	}

	public List<CrmCustomerDetails> getCustDetails() {
		return custDetails;
	}

	public void setCustDetails(List<CrmCustomerDetails> custDetails) {
		this.custDetails = custDetails;
	}

	public String getCustID() {
		return custID;
	}

	public void setCustID(String custID) {
		this.custID = custID;
	}

	public String getCustName() {
		return custName;
	}

	public void setCustName(String custName) {
		this.custName = custName;
	}

	public String getCustTel1() {
		return custTel1;
	}

	public void setCustTel1(String custTel1) {
		this.custTel1 = custTel1;
	}

	public String getCustTel2() {
		return custTel2;
	}

	public void setCustTel2(String custTel2) {
		this.custTel2 = custTel2;
	}

	public String getCustFax() {
		return custFax;
	}

	public void setCustFax(String custFax) {
		this.custFax = custFax;
	}

	public String getCustEmail() {
		return custEmail;
	}

	public void setCustEmail(String custEmail) {
		this.custEmail = custEmail;
	}

	public String getCustWebsite() {
		return custWebsite;
	}

	public void setCustWebsite(String custWebsite) {
		this.custWebsite = custWebsite;
	}

	public String getCustAddress() {
		return custAddress;
	}

	public void setCustAddress(String custAddress) {
		this.custAddress = custAddress;
	}

	public String getFacebook() {
		return facebook;
	}

	public void setFacebook(String facebook) {
		this.facebook = facebook;
	}

	public String getLine() {
		return line;
	}

	public void setLine(String line) {
		this.line = line;
	}

	public String getViber() {
		return viber;
	}

	public void setViber(String viber) {
		this.viber = viber;
	}

	public String getWhatApp() {
		return whatApp;
	}

	public void setWhatApp(String whatApp) {
		this.whatApp = whatApp;
	}

	public CrmIndustry getIndustID() {
		return industID;
	}

	public void setIndustID(CrmIndustry industID) {
		this.industID = industID;
	}

	public CrmAccountType getAccountTypeID() {
		return accountTypeID;
	}

	public void setAccountTypeID(CrmAccountType accountTypeID) {
		this.accountTypeID = accountTypeID;
	}

	public PriceCode getPriceCode() {
		return priceCode;
	}

	public void setPriceCode(PriceCode priceCode) {
		this.priceCode = priceCode;
	}

	public CustomerGroup getCustGroup() {
		return custGroup;
	}

	public void setCustGroup(CustomerGroup custGroup) {
		this.custGroup = custGroup;
	}

	public List<CrmCase> getCases() {
		return cases;
	}

	public void setCases(List<CrmCase> cases) {
		this.cases = cases;
	}

	public List<CrmContact> getContacts() {
		return contacts;
	}

	public void setContacts(List<CrmContact> contacts) {
		this.contacts = contacts;
	}

	public List<CrmOpportunity> getOpportunities() {
		return opportunities;
	}

	public void setOpportunities(List<CrmOpportunity> opportunities) {
		this.opportunities = opportunities;
	}

}
