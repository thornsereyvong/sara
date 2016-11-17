package com.app.entities;




public class CrmAccountType {

	private int accountID;
	
	private String accountName;
	
	private String accountDes;
	
	private MeDataSource meDataSource;
	
	public final MeDataSource getMeDataSource() {
		return meDataSource;
	}

	public final void setMeDataSource(MeDataSource meDataSource) {
		this.meDataSource = meDataSource;
	}
	
	public int getAccountID() {
		return accountID;
	}

	public void setAccountID(int accountID) {
		this.accountID = accountID;
	}

	public String getAccountName() {
		return accountName;
	}

	public void setAccountName(String accountName) {
		this.accountName = accountName;
	}

	public String getAccountDes() {
		return accountDes;
	}

	public void setAccountDes(String accountDes) {
		this.accountDes = accountDes;
	}
}
