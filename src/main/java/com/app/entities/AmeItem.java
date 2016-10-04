package com.app.entities;


public class AmeItem{
	private String itemId;
	private String itemName;
	private AmeUom itemUom;

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

	public AmeUom getItemUom() {
		return itemUom;
	}

	public void setItemUom(AmeUom itemUom) {
		this.itemUom = itemUom;
	}
}
