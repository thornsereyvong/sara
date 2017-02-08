package com.app.entities;

import java.time.LocalDateTime;

public class CrmLeadProject{

	private int id;
	private String name;
	private String accountManager;
	private String companyName;
	private String typeBiz;
	private String sizeBiz;
	private String address;
	private String perInCharge;
	private String mobile;
	private String email;
	private String url;
	private String owner;
	private String consultant;
	private String construction;
	private String mainConstructor;
	private String subConstructor;
	private String remark;
	private LocalDateTime startDate;
	private LocalDateTime endDate;
	private MeDataSource dataSource;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAccountManager() {
		return accountManager;
	}

	public void setAccountManager(String accountManager) {
		this.accountManager = accountManager;
	}

	public String getCompanyName() {
		return companyName;
	}

	public void setCompanyName(String companyName) {
		this.companyName = companyName;
	}

	public String getTypeBiz() {
		return typeBiz;
	}

	public void setTypeBiz(String typeBiz) {
		this.typeBiz = typeBiz;
	}

	public String getSizeBiz() {
		return sizeBiz;
	}

	public void setSizeBiz(String sizeBiz) {
		this.sizeBiz = sizeBiz;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getPerInCharge() {
		return perInCharge;
	}

	public void setPerInCharge(String perInCharge) {
		this.perInCharge = perInCharge;
	}

	public String getMobile() {
		return mobile;
	}

	public void setMobile(String mobile) {
		this.mobile = mobile;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getOwner() {
		return owner;
	}

	public void setOwner(String owner) {
		this.owner = owner;
	}

	public String getConsultant() {
		return consultant;
	}

	public void setConsultant(String consultant) {
		this.consultant = consultant;
	}

	public String getConstruction() {
		return construction;
	}

	public void setConstruction(String construction) {
		this.construction = construction;
	}

	public String getMainConstructor() {
		return mainConstructor;
	}

	public void setMainConstructor(String mainConstructor) {
		this.mainConstructor = mainConstructor;
	}

	public String getSubConstructor() {
		return subConstructor;
	}

	public void setSubConstructor(String subConstructor) {
		this.subConstructor = subConstructor;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public LocalDateTime getStartDate() {
		return startDate;
	}

	public void setStartDate(LocalDateTime startDate) {
		this.startDate = startDate;
	}

	public LocalDateTime getEndDate() {
		return endDate;
	}

	public void setEndDate(LocalDateTime endDate) {
		this.endDate = endDate;
	}

	public MeDataSource getDataSource() {
		return dataSource;
	}

	public void setDataSource(MeDataSource dataSource) {
		this.dataSource = dataSource;
	}
	
}
