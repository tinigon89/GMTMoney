package com.hindvds.gmtmoney.service;

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

import com.hindvds.gmtmoney.common.Constant;
import com.hindvds.gmtmoney.service.info.UserLoginInfo;

public class LoginService {
	public boolean login(String user, String pass, Context context)
			throws IllegalStateException, ClientProtocolException, IOException {
		boolean isLogin;
		user = URLEncoder.encode(user, "utf-8");
		pass = URLEncoder.encode(pass, "utf-8");
		UserLoginInfo userInfo = new UserLoginInfo();
		String json = getJson(String.format(Constant.kServer_Get_Login, user,
				pass));
		try {
			json = json.replace("[{", "{\"data\":[{");
			json = json.replace("}]", "}]}");
			JSONObject jsonRoot = new JSONObject(json);
			JSONArray array = jsonRoot.getJSONArray("data");
			JSONObject jsonLogin = array.getJSONObject(0);
			userInfo.setUserName(jsonLogin.getString("UserName").toString());
			userInfo.setUPassword(jsonLogin.getString("UPassword").toString());
			userInfo.setRegisterID(jsonLogin.getString("RegisterID").toString());
			isLogin = true;

			SharedPreferences sharedPreferences = PreferenceManager
					.getDefaultSharedPreferences(context);
			SharedPreferences.Editor editer = sharedPreferences.edit();
			editer.putString("username", jsonLogin.getString("UserName")
					.toString());
			editer.putString("RegisterID", jsonLogin.getString("RegisterID")
					.toString());
			editer.putString("UType", jsonLogin.getString("UType")
					.toString());
			editer.putString("UIDExpiry", jsonLogin.getString("IDExpiry")
					.toString());
			editer.commit();
		} catch (JSONException e) {
			isLogin = false;
		}

		return isLogin;
	}

	public String forgot(String email) throws IllegalStateException,
			ClientProtocolException, IOException {
		email = URLEncoder.encode(email, "utf-8");
		String json = getJson(String.format(Constant.kServer_Get_Forgot, email));
		return json;
	}

	public String register(String Email, String UserName, String Password,
			String FName, String SurName, String BisName, String DBirth,
			String NationID, String IdentyID, String IdCode, String IDExpiry,
			String IDIssuer, String Occup, String RStreet, String RSub,
			String RState, String RPost, String RCountryID, String PStatus,
			String PStreet, String PSub, String PState, String PPost,
			String PCountryID, String PContact, String SContact,
			String SourceD, String PCDet, String SCDet)
			throws IllegalStateException, ClientProtocolException, IOException {
		Email = URLEncoder.encode(Email, "utf-8");
		Password = URLEncoder.encode(Password, "utf-8");
		FName = URLEncoder.encode(FName, "utf-8");
		SurName = URLEncoder.encode(SurName, "utf-8");
		BisName = URLEncoder.encode(BisName, "utf-8");
		Occup = URLEncoder.encode(Occup, "utf-8");
		RStreet = URLEncoder.encode(RStreet, "utf-8");
		RSub = URLEncoder.encode(RSub, "utf-8");
		PStreet = URLEncoder.encode(PStreet, "utf-8");
		PSub = URLEncoder.encode(PSub, "utf-8");
		String url = String.format(Constant.kServer_Register, Email, UserName,
				Password, FName, SurName, BisName, DBirth, NationID, IdentyID,
				IdCode, IDExpiry, IDIssuer, Occup, RStreet, RSub, RState,
				RPost, RCountryID, PStatus, PStreet, PSub, PState, PPost,
				PCountryID, PContact, SContact, SourceD, PCDet, SCDet);
		String json = getJson(url);
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
