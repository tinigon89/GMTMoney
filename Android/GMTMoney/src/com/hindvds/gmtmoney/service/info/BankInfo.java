package com.hindvds.gmtmoney.service.info;

public class BankInfo {
	
	private String BankACID;
	private String BeneficiaryID;
	private String AcHolderName;
	private String ACNo;
	private String BankName;
	private String BankCode;
	private String SwiftCode;
	private String RouteNo;
	private String Branch1;
	private String Branch2;
	private String City;
	private String State;
	private String PostCode;
	private String CountryID;
	private String BState;
	private String BankCodeDesc;
	private String SwiftCodeDesc;
	private String RoutenoDesc;
	
	public BankInfo() {
		super();
	}

	public BankInfo(String bankACID, String beneficiaryID, String acHolderName,
			String aCNo, String bankName, String bankCode, String swiftCode,
			String routeNo, String branch1, String branch2, String city,
			String state, String postCode, String countryID, String bState,
			String bankCodeDesc, String swiftCodeDesc, String routenoDesc) {
		super();
		BankACID = bankACID;
		BeneficiaryID = beneficiaryID;
		AcHolderName = acHolderName;
		ACNo = aCNo;
		BankName = bankName;
		BankCode = bankCode;
		SwiftCode = swiftCode;
		RouteNo = routeNo;
		Branch1 = branch1;
		Branch2 = branch2;
		City = city;
		State = state;
		PostCode = postCode;
		CountryID = countryID;
		BState = bState;
		BankCodeDesc = bankCodeDesc;
		SwiftCodeDesc = swiftCodeDesc;
		RoutenoDesc = routenoDesc;
	}

	public String getBankACID() {
		return BankACID;
	}

	public void setBankACID(String bankACID) {
		BankACID = bankACID;
	}

	public String getBeneficiaryID() {
		return BeneficiaryID;
	}

	public void setBeneficiaryID(String beneficiaryID) {
		BeneficiaryID = beneficiaryID;
	}

	public String getAcHolderName() {
		return AcHolderName;
	}

	public void setAcHolderName(String acHolderName) {
		AcHolderName = acHolderName;
	}

	public String getACNo() {
		return ACNo;
	}

	public void setACNo(String aCNo) {
		ACNo = aCNo;
	}

	public String getBankName() {
		return BankName;
	}

	public void setBankName(String bankName) {
		BankName = bankName;
	}

	public String getBankCode() {
		return BankCode;
	}

	public void setBankCode(String bankCode) {
		BankCode = bankCode;
	}

	public String getSwiftCode() {
		return SwiftCode;
	}

	public void setSwiftCode(String swiftCode) {
		SwiftCode = swiftCode;
	}

	public String getRouteNo() {
		return RouteNo;
	}

	public void setRouteNo(String routeNo) {
		RouteNo = routeNo;
	}

	public String getBranch1() {
		return Branch1;
	}

	public void setBranch1(String branch1) {
		Branch1 = branch1;
	}

	public String getBranch2() {
		return Branch2;
	}

	public void setBranch2(String branch2) {
		Branch2 = branch2;
	}

	public String getCity() {
		return City;
	}

	public void setCity(String city) {
		City = city;
	}

	public String getState() {
		return State;
	}

	public void setState(String state) {
		State = state;
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

	public String getBankCodeDesc() {
		return BankCodeDesc;
	}

	public void setBankCodeDesc(String bankCodeDesc) {
		BankCodeDesc = bankCodeDesc;
	}

	public String getSwiftCodeDesc() {
		return SwiftCodeDesc;
	}

	public void setSwiftCodeDesc(String swiftCodeDesc) {
		SwiftCodeDesc = swiftCodeDesc;
	}

	public String getRoutenoDesc() {
		return RoutenoDesc;
	}

	public void setRoutenoDesc(String routenoDesc) {
		RoutenoDesc = routenoDesc;
	}
	
}
