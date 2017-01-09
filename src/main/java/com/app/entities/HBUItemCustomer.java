package com.app.entities;

import java.util.List;
public class HBUItemCustomer{

	private int id;
	private String itemId;
	private List<HBUCustomer> customers;
	private MeDataSource meDataSource;

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public List<HBUCustomer> getCustomers() {
		return customers;
	}

	public void setCustomers(List<HBUCustomer> customers) {
		this.customers = customers;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
}
