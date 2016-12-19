package com.app.entities;

import java.util.List;

public class HBUItem{
	
	private String itemId;
	private String itemName;
	private List<HBUCompetitor> competitors;
	private MeDataSource meDataSource;

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
	}

	public String getItemName() {
		return itemName;
	}

	public void setItemName(String itemName) {
		this.itemName = itemName;
	}

	public List<HBUCompetitor> getCompetitors() {
		return competitors;
	}

	public void setCompetitors(List<HBUCompetitor> competitors) {
		this.competitors = competitors;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
}
