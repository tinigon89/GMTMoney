package com.teamios.info.gmtmoney.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;

import org.apache.http.client.ClientProtocolException;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.util.Log;

import com.teamios.info.gmtmoney.common.Constant;
import com.teamios.info.gmtmoney.service.info.UserLoginInfo;

public class RemittanceService {
	public String submitStep1(String regid, String curr, String purpose,
			String paycurr, String PayMethod, String PayAmount,
			String Commision, String TranAmount, String ExRate, String FAmount,
			String Comments, String online) throws IllegalStateException,
			ClientProtocolException, IOException {
		purpose = URLEncoder.encode(purpose, "utf-8");
		Comments = URLEncoder.encode(Comments, "utf-8");
		String url = String.format(Constant.kServer_Step1, regid, curr,
				purpose, paycurr, PayMethod, PayAmount, Commision, TranAmount, ExRate,
				FAmount, Comments, online);
		String json = getJson(url);
		Log.d("submit result", json);
		return json;
	}
	
	public String submitStep2(String regid, String remid, String senderid,
			String PayMethod, String online) throws IllegalStateException,
			ClientProtocolException, IOException {
		String url = String.format(Constant.kServer_Step2, regid, remid,
				senderid, PayMethod, online);
		String json = getJson(url);
		Log.d("submit result", json);
		return json;
	}
	
	public String submitStep3(String regid, String remid, String beneId,
			String PayMethod, String online) throws IllegalStateException,
			ClientProtocolException, IOException {
		String url = String.format(Constant.kServer_Step3, regid, remid,
				beneId, PayMethod, online);
		String json = getJson(url);
		Log.d("submit result", json);
		return json;
	}
	
	public String submitStep4(String regid, String remid, String senderid, String PayMethod, String beneId,
			String bnkID, String online) throws IllegalStateException,
			ClientProtocolException, IOException {
		String url = String.format(Constant.kServer_Step4, regid, remid,
				senderid, PayMethod, beneId, bnkID, online);
		String json = getJson(url);
		Log.d("submit result", json);
		return json;
	}

	private String getJson(String url) throws IllegalStateException,
			ClientProtocolException, IOException {
		HttpService httpService = new HttpService();
		ArrayList<BasicNameValuePair> listParam = new ArrayList<BasicNameValuePair>(
				1);
		return httpService.getDataAsString(url, listParam);
	}
}
