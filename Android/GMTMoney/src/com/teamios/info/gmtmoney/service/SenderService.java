package com.teamios.info.gmtmoney.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;


import com.teamios.info.gmtmoney.common.Constant;
import com.teamios.info.gmtmoney.service.info.SenderInfo;

public class SenderService {

	public List<SenderInfo> searchSender(String RegisterID, String index,
			String data) throws IllegalStateException, ClientProtocolException,
			IOException, JSONException {
		data = URLEncoder.encode(data, "utf-8");
		String json = getStringJson(String.format(
				Constant.kServer_Get_Search_Sender, RegisterID, index, data),
				null);
		return parseJson(json);
	}

	private List<SenderInfo> parseJson(String json)
			throws IllegalStateException, ClientProtocolException, IOException,
			JSONException {
		List<SenderInfo> listItems = new ArrayList<SenderInfo>();
		json = json.replace("[{", "{\"data\":[{");
		json = json.replace("}]", "}]}");
		JSONObject jsonRoot = new JSONObject(json);
		JSONArray array = jsonRoot.getJSONArray("data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonUnit = array.getJSONObject(i);
			SenderInfo item = new SenderInfo();
			item.setSendersID(String.valueOf(jsonUnit.get("SendersID")));
			item.setRegisterID(String.valueOf(jsonUnit.get("RegisterID")));
			item.setFName(String.valueOf(jsonUnit.get("FName")));
			item.setSurName(String.valueOf(jsonUnit.get("SurName")));
			item.setBisName(String.valueOf(jsonUnit.get("BisName")));
			item.setDBirth(String.valueOf(jsonUnit.get("DBirth")));
			item.setNationID(String.valueOf(jsonUnit.get("NationID")));
			item.setIdentyID(String.valueOf(jsonUnit.get("IdentyID")));
			item.setIdCode(String.valueOf(jsonUnit.get("IdCode")));
			item.setPContact(String.valueOf(jsonUnit.get("PContact")));
			item.setSContact(String.valueOf(jsonUnit.get("SContact")));
			item.setEmail(String.valueOf(jsonUnit.get("Email")));
			item.setIDExpiry(String.valueOf(jsonUnit.get("IDExpiry")));
			item.setIDIssuer(String.valueOf(jsonUnit.get("IDIssuer")));
			item.setRStreet(String.valueOf(jsonUnit.get("RStreet")));
			item.setRSub(String.valueOf(jsonUnit.get("RSub")));
			item.setRState(String.valueOf(jsonUnit.get("RState")));
			item.setRPost(String.valueOf(jsonUnit.get("RPost")));
			item.setRCountryID(String.valueOf(jsonUnit.get("RCountryID")));
			listItems.add(item);
		}
		return listItems;
	}

	public String newSender(String RegID, String Email, 
			String FName, String SurName, String BisName, String DBirth,
			String NationID, String IdentyID, String IdCode, String IDExpiry,
			String IDIssuer, String Occup, String RStreet, String RSub,
			String RState, String RPost, String RCountryID, String PStatus,
			String PStreet, String PSub, String PState, String PPost,
			String PCountryID, String PContact, String SContact,
			 String PCDet, String SCDet)
			throws IllegalStateException, ClientProtocolException, IOException {
		BisName = URLEncoder.encode(BisName, "utf-8");
		RStreet = URLEncoder.encode(RStreet, "utf-8");
		RSub = URLEncoder.encode(RSub, "utf-8");
		PStreet = URLEncoder.encode(PStreet, "utf-8");
		PSub = URLEncoder.encode(PSub, "utf-8");
		String url = String.format(Constant.kServer_Create_NewSender,RegID, Email,
				FName, SurName, BisName, DBirth, NationID, IdentyID,
				IdCode, IDExpiry, IDIssuer, Occup, RStreet, RSub, RState,
				RPost, RCountryID, PStatus, PStreet, PSub, PState, PPost,
				PCountryID, PContact, SContact, PCDet, SCDet);
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

	private String getStringJson(String url,
			ArrayList<BasicNameValuePair> postDatas)
			throws IllegalStateException, ClientProtocolException, IOException {
		HttpService httpService = new HttpService();
		return httpService.getDataAsString(url, postDatas);
	}
}
