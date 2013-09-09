package com.teamios.info.gmtmoney.service.info;

public class TransactionHistoryInfo {
	
	private String RemitId;
	private String FName1;
	private String SurName1;
	private String FirstN;
	private String SurN;
	private String PayAmt;
	private String ExRate;
	private String ForAmt;
	private String BankName;
	private String ACNo;
	private String CurrSym;
	private String RDate;
	
	public TransactionHistoryInfo() {
		super();
	}

	public TransactionHistoryInfo(String remitId, String fName1,
			String surName1, String firstN, String surN, String payAmt,
			String exRate, String forAmt, String bankName, String aCNo,
			String currSym, String rDate) {
		super();
		RemitId = remitId;
		FName1 = fName1;
		SurName1 = surName1;
		FirstN = firstN;
		SurN = surN;
		PayAmt = payAmt;
		ExRate = exRate;
		ForAmt = forAmt;
		BankName = bankName;
		ACNo = aCNo;
		CurrSym = currSym;
		RDate = rDate;
	}

	public String getRemitId() {
		return RemitId;
	}

	public void setRemitId(String remitId) {
		RemitId = remitId;
	}

	public String getFName1() {
		return FName1;
	}

	public void setFName1(String fName1) {
		FName1 = fName1;
	}

	public String getSurName1() {
		return SurName1;
	}

	public void setSurName1(String surName1) {
		SurName1 = surName1;
	}

	public String getFirstN() {
		return FirstN;
	}

	public void setFirstN(String firstN) {
		FirstN = firstN;
	}

	public String getSurN() {
		return SurN;
	}

	public void setSurN(String surN) {
		SurN = surN;
	}

	public String getPayAmt() {
		return PayAmt;
	}

	public void setPayAmt(String payAmt) {
		PayAmt = payAmt;
	}

	public String getExRate() {
		return ExRate;
	}

	public void setExRate(String exRate) {
		ExRate = exRate;
	}

	public String getForAmt() {
		return ForAmt;
	}

	public void setForAmt(String forAmt) {
		ForAmt = forAmt;
	}

	public String getBankName() {
		return BankName;
	}

	public void setBankName(String bankName) {
		BankName = bankName;
	}

	public String getACNo() {
		return ACNo;
	}

	public void setACNo(String aCNo) {
		ACNo = aCNo;
	}

	public String getCurrSym() {
		return CurrSym;
	}

	public void setCurrSym(String currSym) {
		CurrSym = currSym;
	}

	public String getRDate() {
		return RDate;
	}

	public void setRDate(String rDate) {
		RDate = rDate;
	}
	
}
