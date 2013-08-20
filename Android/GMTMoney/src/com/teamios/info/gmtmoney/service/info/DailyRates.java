package com.teamios.info.gmtmoney.service.info;

public class DailyRates {
	
	private String EXID;
	private String ExDate;
	private String CurrID;
	private String ERate;
	private String ERateS;
	private String PType;
	private String CountryID;
	private String LComm;
	private String SComm;
	private String ShowH;
	private String xValue;
	private String yValue;
	private String xTop;
	private String yTop;
	private String Less5;
	private String Great5;
	private String OnlineRt;
	private String AcMargin;
	private String CaMargin;
	private String OAct;
	private String CurrID1;
	private String CurrSym;
	private String CurText;
	private String CState;
	private String CountryID1;
	
	public DailyRates() {
		super();
	}
	
	public DailyRates(String eXID, String exDate, String currID, String eRate,
			String eRateS, String pType, String countryID, String lComm,
			String sComm, String showH, String xValue, String yValue,
			String xTop, String yTop, String less5, String great5,
			String onlineRt, String acMargin, String caMargin, String oAct,
			String currID1, String currSym, String curText, String cState,
			String countryID1) {
		super();
		this.EXID = eXID;
		this.ExDate = exDate;
		this.CurrID = currID;
		this.ERate = eRate;
		this.ERateS = eRateS;
		this.PType = pType;
		this.CountryID = countryID;
		this.LComm = lComm;
		this.SComm = sComm;
		this.ShowH = showH;
		this.xValue = xValue;
		this.yValue = yValue;
		this.xTop = xTop;
		this.yTop = yTop;
		this.Less5 = less5;
		this.Great5 = great5;
		this.OnlineRt = onlineRt;
		this.AcMargin = acMargin;
		this.CaMargin = caMargin;
		this.OAct = oAct;
		this.CurrID1 = currID1;
		this.CurrSym = currSym;
		this.CurText = curText;
		this.CState = cState;
		this.CountryID1 = countryID1;
	}

	public String getEXID() {
		return EXID;
	}

	public void setEXID(String eXID) {
		EXID = eXID;
	}

	public String getExDate() {
		return ExDate;
	}

	public void setExDate(String exDate) {
		ExDate = exDate;
	}

	public String getCurrID() {
		return CurrID;
	}

	public void setCurrID(String currID) {
		CurrID = currID;
	}

	public String getERate() {
		return ERate;
	}

	public void setERate(String eRate) {
		ERate = eRate;
	}

	public String getERateS() {
		return ERateS;
	}

	public void setERateS(String eRateS) {
		ERateS = eRateS;
	}

	public String getPType() {
		return PType;
	}

	public void setPType(String pType) {
		PType = pType;
	}

	public String getCountryID() {
		return CountryID;
	}

	public void setCountryID(String countryID) {
		CountryID = countryID;
	}

	public String getLComm() {
		return LComm;
	}

	public void setLComm(String lComm) {
		LComm = lComm;
	}

	public String getSComm() {
		return SComm;
	}

	public void setSComm(String sComm) {
		SComm = sComm;
	}

	public String getShowH() {
		return ShowH;
	}

	public void setShowH(String showH) {
		ShowH = showH;
	}

	public String getxValue() {
		return xValue;
	}

	public void setxValue(String xValue) {
		this.xValue = xValue;
	}

	public String getyValue() {
		return yValue;
	}

	public void setyValue(String yValue) {
		this.yValue = yValue;
	}

	public String getxTop() {
		return xTop;
	}

	public void setxTop(String xTop) {
		this.xTop = xTop;
	}

	public String getyTop() {
		return yTop;
	}

	public void setyTop(String yTop) {
		this.yTop = yTop;
	}

	public String getLess5() {
		return Less5;
	}

	public void setLess5(String less5) {
		Less5 = less5;
	}

	public String getGreat5() {
		return Great5;
	}

	public void setGreat5(String great5) {
		Great5 = great5;
	}

	public String getOnlineRt() {
		return OnlineRt;
	}

	public void setOnlineRt(String onlineRt) {
		OnlineRt = onlineRt;
	}

	public String getAcMargin() {
		return AcMargin;
	}

	public void setAcMargin(String acMargin) {
		AcMargin = acMargin;
	}

	public String getCaMargin() {
		return CaMargin;
	}

	public void setCaMargin(String caMargin) {
		CaMargin = caMargin;
	}

	public String getOAct() {
		return OAct;
	}

	public void setOAct(String oAct) {
		OAct = oAct;
	}

	public String getCurrID1() {
		return CurrID1;
	}

	public void setCurrID1(String currID1) {
		CurrID1 = currID1;
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

	public String getCountryID1() {
		return CountryID1;
	}

	public void setCountryID1(String countryID1) {
		CountryID1 = countryID1;
	}
}
