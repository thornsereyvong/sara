package com.app.entities;

import java.util.List;

public class HBUItemCompetitor{

	private int id;
	private String itemId;
	private List<HBUCompetitor> competitors;
	private MeDataSource meDataSource;

	public String getItemId() {
		return itemId;
	}

	public void setItemId(String itemId) {
		this.itemId = itemId;
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

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

}
