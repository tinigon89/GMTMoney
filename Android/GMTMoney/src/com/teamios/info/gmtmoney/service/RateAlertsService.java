package com.teamios.info.gmtmoney.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.Map;

import org.apache.http.client.ClientProtocolException;
import org.json.JSONException;

import android.content.Context;
import android.util.Log;

import com.teamios.info.gmtmoney.common.Constant;

public class RateAlertsService {
	
	public boolean checkAlertInfo(Context context, String device_id, String currency_id) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		Map<String, String> paramMapChild = new HashMap<String, String>();
		paramMapChild.put("device_id", device_id);
		paramMapChild.put("currency_id", currency_id);
		
		String data = convertJsonCheckAlert(paramMapChild);
		Log.d("json", data);
		data = URLEncoder.encode(data, "utf-8");
		String result = getStringJson(String.format(Constant.kServer_Check_Alert, data));
		Log.d("checkAlertInfo result", result);
		boolean val = false;
		if(result.indexOf("true") != -1){
			val = true;
		}
		return val;
	}
	
	public boolean getAlertInfo(Context context, String device_id) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		Map<String, String> paramMapChild = new HashMap<String, String>();
		paramMapChild.put("device_id", device_id);
		
		String data = convertJsonGetAlert(paramMapChild);
		Log.d("json", data);
		data = URLEncoder.encode(data, "utf-8");
		String result = getStringJson(String.format(Constant.kServer_Get_Alert, data));
		Log.d("getAlertInfo result", result);
		boolean val = false;
		if(result.indexOf("true") != -1){
			val = true;
		}
		return val;
	}
	
	public boolean deleteAlertInfo(Context context, String device_id) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		Map<String, String> paramMapChild = new HashMap<String, String>();
		paramMapChild.put("device_id", device_id);
		
		String data = convertJsonDeleteAlert(paramMapChild);
		Log.d("json", data);
		data = URLEncoder.encode(data, "utf-8");
		String result = getStringJson(String.format(Constant.kServer_Delete_Alert, data));
		Log.d("getAlertInfo result", result);
		boolean val = false;
		if(result.indexOf("true") != -1){
			val = true;
		}
		return val;
	}
	
	public boolean registerAler(Context context, String device_id, String email, String device_token, String device_type, String currency_id, String rate_alert) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		Map<String, String> paramMapChild = new HashMap<String, String>();
		paramMapChild.put("device_id", device_id);
		paramMapChild.put("email", email);
		paramMapChild.put("device_token", device_token);
		paramMapChild.put("device_type", device_type);
		paramMapChild.put("currency_id", currency_id);
		paramMapChild.put("rate_alert", rate_alert);
		
		String data = convertJsonRegist(paramMapChild);
		Log.d("json", data);
		data = URLEncoder.encode(data, "utf-8");
		String result = getStringJson(String.format(Constant.kServer_Register_Alert, data));
		Log.d("registerAlert result", result);
		
		return true;
	}
	
	private String getStringJson(String url) throws IllegalStateException, ClientProtocolException, IOException {
		HttpService httpService = new HttpService();
		return httpService.getDataAsString(url, null);
	}
	
	private static String convertJsonRegist(Map<String, String> params) {
		String content = "{\"device_id\":\"" + params.get("device_id")
				+ "\",\"email\":\"" + params.get("email")
				+ "\",\"device_token\":\"" + params.get("device_token")
				+ "\",\"device_type\":\"" + params.get("device_type")
				+ "\",\"currency_id\":\"" + params.get("currency_id")
				+ "\",\"rate_alert\":\"" + params.get("rate_alert") + "\"}";
		return content;
	}
	
	private static String convertJsonCheckAlert(Map<String, String> params) {
		String content = "{\"device_id\":\"" + params.get("device_id")
				+ "\",\"currency_id\":\"" + params.get("currency_id") + "\"}";
		return content;
	}
	
	private static String convertJsonGetAlert(Map<String, String> params) {
		String content = "{\"device_id\":\"" + params.get("device_id") + "\"}";
 		return content;
	}
	
	private static String convertJsonDeleteAlert(Map<String, String> params) {
		String content = "{\"device_id\":\"" + params.get("device_id") + "\"}";
 		return content;
	}
}
