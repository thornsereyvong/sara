package com.app.entities;

import java.time.LocalDateTime;
import java.util.List;

public class HBUCompetitor{

	private String comId;
	private String comName;
	private String comAddress;
	private String comCreateBy;
	private LocalDateTime comModifiedDate;
	private String comModifiedBy;
	private MeDataSource meDataSource;
	private List<HBUItem> items;
	
	public String getComId() {
		return comId;
	}

	public void setComId(String comId) {
		this.comId = comId;
	}

	public String getComName() {
		return comName;
	}

	public void setComName(String comName) {
		this.comName = comName;
	}

	public String getComAddress() {
		return comAddress;
	}

	public void setComAddress(String comAddress) {
		this.comAddress = comAddress;
	}
	
	public String getComCreateBy() {
		return comCreateBy;
	}

	public void setComCreateBy(String comCreateBy) {
		this.comCreateBy = comCreateBy;
	}

	public LocalDateTime getComModifiedDate() {
		return comModifiedDate;
	}

	public void setComModifiedDate(LocalDateTime comModifiedDate) {
		this.comModifiedDate = comModifiedDate;
	}

	public String getComModifiedBy() {
		return comModifiedBy;
	}

	public void setComModifiedBy(String comModifiedBy) {
		this.comModifiedBy = comModifiedBy;
	}

	public MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}

	public List<HBUItem> getItems() {
		return items;
	}

	public void setItems(List<HBUItem> items) {
		this.items = items;
	}
}
