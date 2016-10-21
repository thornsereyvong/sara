package com.app.entities;

public class CrmShipAddress{
	private String moduleId;
	private String docId;
	private String shipId;
	private String shipName;
	private short inactive;

	public String getModuleId() {
		return moduleId;
	}

	public void setModuleId(String moduleId) {
		this.moduleId = moduleId;
	}

	public String getShipId() {
		return shipId;
	}

	public void setShipId(String shipId) {
		this.shipId = shipId;
	}

	public String getShipName() {
		return shipName;
	}

	public void setShipName(String shipName) {
		this.shipName = shipName;
	}

	public short getInactive() {
		return inactive;
	}

	public void setInactive(short inactive) {
		this.inactive = inactive;
	}

	public String getDocId() {
		return docId;
	}

	public void setDocId(String docId) {
		this.docId = docId;
	}
}
