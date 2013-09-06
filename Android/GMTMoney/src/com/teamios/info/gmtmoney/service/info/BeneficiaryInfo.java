package com.teamios.info.gmtmoney.service.info;

public class BeneficiaryInfo {
	
	private String BeneficiaryID;
	private String RegisterID;
	private String FirstN;
	private String SurN;
	private String CompN;
	private String IDType;
	private String IDNo;
	private String PCont;
	private String SCont;
	private String Emails1;
	private String AddL1;
	private String AddL2;
	private String Cityy;
	private String States;
	private String PostCode;
	private String CountryID;
	private String BState;
	private String BAssID;
	private String BAddress;
	
	public BeneficiaryInfo() {
		super();
	}

	public BeneficiaryInfo(String beneficiaryID, String registerID,
			String firstN, String surN, String compN, String iDType,
			String iDNo, String pCont, String sCont, String emails1,
			String addL1, String addL2, String cityy, String states,
			String postCode, String countryID, String bState, String bAssID,
			String bAddress) {
		super();
		BeneficiaryID = beneficiaryID;
		RegisterID = registerID;
		FirstN = firstN;
		SurN = surN;
		CompN = compN;
		IDType = iDType;
		IDNo = iDNo;
		PCont = pCont;
		SCont = sCont;
		Emails1 = emails1;
		AddL1 = addL1;
		AddL2 = addL2;
		Cityy = cityy;
		States = states;
		PostCode = postCode;
		CountryID = countryID;
		BState = bState;
		BAssID = bAssID;
		BAddress = bAddress;
	}

	public String getBeneficiaryID() {
		return BeneficiaryID;
	}

	public void setBeneficiaryID(String beneficiaryID) {
		BeneficiaryID = beneficiaryID;
	}

	public String getRegisterID() {
		return RegisterID;
	}

	public void setRegisterID(String registerID) {
		RegisterID = registerID;
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

	public String getCompN() {
		return CompN;
	}

	public void setCompN(String compN) {
		CompN = compN;
	}

	public String getIDType() {
		return IDType;
	}

	public void setIDType(String iDType) {
		IDType = iDType;
	}

	public String getIDNo() {
		return IDNo;
	}

	public void setIDNo(String iDNo) {
		IDNo = iDNo;
	}

	public String getPCont() {
		return PCont;
	}

	public void setPCont(String pCont) {
		PCont = pCont;
	}

	public String getSCont() {
		return SCont;
	}

	public void setSCont(String sCont) {
		SCont = sCont;
	}

	public String getEmails1() {
		return Emails1;
	}

	public void setEmails1(String emails1) {
		Emails1 = emails1;
	}

	public String getAddL1() {
		return AddL1;
	}

	public void setAddL1(String addL1) {
		AddL1 = addL1;
	}

	public String getAddL2() {
		return AddL2;
	}

	public void setAddL2(String addL2) {
		AddL2 = addL2;
	}

	public String getCityy() {
		return Cityy;
	}

	public void setCityy(String cityy) {
		Cityy = cityy;
	}

	public String getStates() {
		return States;
	}

	public void setStates(String states) {
		States = states;
	}

	public String getPostCode() {
		return PostCode;
	}

	public void setPostCode(String postCode) {
		PostCode = postCode;
	}

	public String getCountryID() {
		return CountryID;
	}

	public void setCountryID(String countryID) {
		CountryID = countryID;
	}

	public String getBState() {
		return BState;
	}

	public void setBState(String bState) {
		BState = bState;
	}

	public String getBAssID() {
		return BAssID;
	}

	public void setBAssID(String bAssID) {
		BAssID = bAssID;
	}

	public String getBAddress() {
		return BAddress;
	}

	public void setBAddress(String bAddress) {
		BAddress = bAddress;
	}
	
}
