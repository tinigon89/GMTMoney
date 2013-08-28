package com.teamios.info.gmtmoney.service.info;

public class AlertInfo {
	
	private String email;
	private String device_token;
	private String currency_id;
	private String rate_alert;
	private String date_added;
	
	public AlertInfo() {
		super();
	}

	public AlertInfo(String email, String device_token, String currency_id,
			String rate_alert, String date_added) {
		super();
		this.email = email;
		this.device_token = device_token;
		this.currency_id = currency_id;
		this.rate_alert = rate_alert;
		this.date_added = date_added;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getDevice_token() {
		return device_token;
	}

	public void setDevice_token(String device_token) {
		this.device_token = device_token;
	}

	public String getCurrency_id() {
		return currency_id;
	}

	public void setCurrency_id(String currency_id) {
		this.currency_id = currency_id;
	}

	public String getRate_alert() {
		return rate_alert;
	}

	public void setRate_alert(String rate_alert) {
		this.rate_alert = rate_alert;
	}

	public String getDate_added() {
		return date_added;
	}

	public void setDate_added(String date_added) {
		this.date_added = date_added;
	}

}
