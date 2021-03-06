package com.hindvds.gmtmoney.common;

public class Constant {
	// Time out when connect wrong ip
	public static final int CONST_TIME_OUT = 60000;
	public static final String kServer_Get_DailyRates 				= "http://www.gmtmoney.com.au/dr.aspx";
	public static final String kServer_Get_Login 					= "http://www.gmtmoney.com.au/ilogin.aspx?uname=%s&upass=%s";
	public static final String kServer_Get_Forgot 					= "http://www.gmtmoney.com.au/iforget.aspx?email=%s";
	public static final String kServer_Get_SMS 						= "http://www.gmtmoney.com.au/isms.aspx?msg=%s&to=%s";
	public static final String kServer_Get_Trans_Status 			= "http://www.gmtmoney.com.au/iremitpend.aspx?regID=%s";
	public static final String kServer_Get_Trans_History 			= "http://www.gmtmoney.com.au/iremits.aspx?regID=%s";
	public static final String kServer_Get_CountryList 				= "http://www.gmtmoney.com.au/icurrency.aspx";
	public static final String kServer_Get_Sender 					= "http://www.gmtmoney.com.au/isendersrch.aspx?regid=%s&lst=0&data=%s";
	public static final String kServer_Get_Search_Sender 			= "http://www.gmtmoney.com.au/isendersrch.aspx?regid=%s&lst=%s&data=%s";
	public static final String kServer_Get_Bene 					= "http://www.gmtmoney.com.au/ibenesrch.aspx?regid=%s&lst=-1&data=%s";
	public static final String kServer_Get_Search_Bene 				= "http://www.gmtmoney.com.au/ibenesrch.aspx?regid=%s&lst=%s&data=%s";
	public static final String kServer_Get_Search_Remitance 		= "http://www.gmtmoney.com.au/idupsrch.aspx?regid=%s&lst=%s&data=%s";
	public static final String kServer_Get_BankDetail 				= "http://www.gmtmoney.com.au/ibankdet.aspx?bankID=%s";
	public static final String kServer_Get_BankInfo 				= "http://www.gmtmoney.com.au/ibanksrch.aspx?bankID=%s";
	public static final String kServer_ImageURL 					= "http://www.cgapp.net.au/img/";
	public static final String kServer_Register 					= "http://gmtmoney.com.au/iregister.aspx?Country1=1&Email=%s&UserName=%s&Password=%s&FName=%s&SurName=%s&BisName=%s&DBirth=%s&NationID=%s&IdentyID=%s&IdCode=%s&IDExpiry=%s&IDIssuer=%s&Occup=%s&RStreet=%s&RSub=%s&RState=%s&RPost=%s&RCountryID=%s&PStatus=%s&PStreet=%s&PSub=%s&PState=%s&PPost=%s&PCountryID=%s&PContact=%s&SContact=%s&SourceD=%s&PCDet=%s&SCDet=%s";
	public static final String kServer_Register_Alert 				= "http://www.gmtmoney.com.au/pushapi/apis.php?api=push_info2&data=%s";
	public static final String kServer_Check_Alert 					= "http://www.gmtmoney.com.au/pushapi/apis.php?api=check_info2&data=%s";
	public static final String kServer_Get_Alert 					= "http://www.gmtmoney.com.au/pushapi/apis.php?api=get_alerts2&data=%s";
	public static final String kServer_Delete_Alert 				= "http://www.gmtmoney.com.au/pushapi/apis.php?api=delete_alert2&data=%s";
	public static final String kServer_Step1 						= "http://www.gmtmoney.com.au/istep1.aspx?regid=%s&curr=%s&purpose=%s&paycurr=%s&PayMethod=%s&PayAmount=%s&Commision=%s&TranAmount=%s&ExRate=%s&FAmount=%s&Comments=%s&online=%s";
	public static final String kServer_Create_NewSender 			= "http://gmtmoney.com.au/isendernew.aspx?RegID=%s&Email=%s&FName=%s&SurName=%s&BisName=%s&DBirth=%s&NationID=%s&IdentyID=%s&IdCode=%s&IDExpiry=%s&IDIssuer=%s&Occup=%s&RStreet=%s&RSub=%s&RState=%s&RPost=%s&RCountryID=%s&PStatus=%s&PStreet=%s&PSub=%s&PState=%s&PPost=%s&PCountryID=%s&PContact=%s&SContact=%s&PCDet=%s&SCDet=%s";
	public static final String kServer_Create_NewBeneficiary 		= "http://gmtmoney.com.au/ibeneadd.aspx?RegID=%s&Email=%s&FName=%s&SurName=%s&BisName=%s&IDType=%s&IdCode=%s&Add1=%s&Add2=%s&City=%s&State=%s&Rpost=%s&RCountryID=%s&PCont=%s&SCont=%s&PCDet=%s&SCDet=%s";
	public static final String kServer_Create_NewBank 				= "http://gmtmoney.com.au/ibankadd.aspx?RegID=%s&ACHolderName=%s&ACNo=%s&BankName=%s&BankCode=%s&SwiftCode=%s&RoutNo=%s&Add1=%s&Add2=%s&City=%s&State=%s&PostCode=%s&Country=%s&BeneID=%s";
	public static final String kServer_Step2		 				= "http://www.gmtmoney.com.au/istep2.aspx?regid=%s&remid=%s&sid=%s&paytype=%s&online=%s";
	public static final String kServer_Step3		 				= "http://www.gmtmoney.com.au/istep3.aspx?regid=%s&remid=%s&benID=%s&paytype=%s&online=%s";
	public static final String kServer_Step4		 				= "http://www.gmtmoney.com.au/iconfirmpage.aspx?regid=%s&remid=%s&sid=%s&paytype=%s&benid=%s&bnkID=%s&online=%s";
	public static final String kServer_Sms_kTwilioSID 				= "AC804d07d85308200fed9e8c318ec52213";
	public static final String kServer_Sms_token 					= "d187b5d108907702f01b21c2ad5bffa2";
	public static final String kServer_Sms_kFromNumber 				= "+12016693458";
	public static final String kServer_Sms 							= String.format("https://api.twilio.com/2010-04-01/Accounts/%s/SMS/Messages", kServer_Sms_kTwilioSID);
}
