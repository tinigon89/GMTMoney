package com.hindvds.gmtmoney.service.info;

public class CountryList {
	
	private String CurrID;
	private String CurrSym;
	private String CurText;
	private String CState;
	private String CountryID;
	private String CountryID1;
	private String CountryName;
	private String CFlag;
	private String Country_Code;
	private String curname;
	
	public CountryList() {
		super();
	}

	public CountryList(String currID, String currSym, String curText,
			String cState, String countryID, String countryID1,
			String countryName, String cFlag, String country_Code,
			String curname) {
		super();
		this.CurrID = currID;
		this.CurrSym = currSym;
		this.CurText = curText;
		this.CState = cState;
		this.CountryID = countryID;
		this.CountryID1 = countryID1;
		this.CountryName = countryName;
		this.CFlag = cFlag;
		this.Country_Code = country_Code;
		this.curname = curname;
	}

	public String getCurrID() {
		return CurrID;
	}

	public void setCurrID(String currID) {
		CurrID = currID;
	}

	public String getCurrSym() {
		return CurrSym;
	}

	public void setCurrSym(String currSym) {
		CurrSym = currSym;
	}

	public String getCurText() {
		return CurText;
	}

	public void setCurText(String curText) {
		CurText = curText;
	}

	public String getCState() {
		return CState;
	}

	public void setCState(String cState) {
		CState = cState;
	}

	public String getCountryID() {
		return CountryID;
	}

	public void setCountryID(String countryID) {
		CountryID = countryID;
	}

	public String getCountryID1() {
		return CountryID1;
	}

	public void setCountryID1(String countryID1) {
		CountryID1 = countryID1;
	}

	public String getCountryName() {
		return CountryName;
	}

	public void setCountryName(String countryName) {
		CountryName = countryName;
	}

	public String getCFlag() {
		return CFlag;
	}

	public void setCFlag(String cFlag) {
		CFlag = cFlag;
	}

	public String getCountry_Code() {
		return Country_Code;
	}

	public void setCountry_Code(String country_Code) {
		Country_Code = country_Code;
	}

	public String getCurname() {
		return curname;
	}

	public void setCurname(String curname) {
		this.curname = curname;
	}

}
