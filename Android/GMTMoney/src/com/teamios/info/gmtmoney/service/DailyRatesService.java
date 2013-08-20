package com.teamios.info.gmtmoney.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;
import com.teamios.info.gmtmoney.common.Constant;
import com.teamios.info.gmtmoney.service.info.DailyRates;

public class DailyRatesService {
	
	public List<DailyRates> getDailyRatesInfo() throws IllegalStateException, ClientProtocolException, IOException,JSONException {
		String json = getStringJson(Constant.kServer_Get_DailyRates, null);
		return parseJson(json);
	}
	
	private List<DailyRates> parseJson(String json) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		List<DailyRates> listItems = new ArrayList<DailyRates>();
		json = json.replace("[{", "{\"data\":[{");
		json = json.replace("}]", "}]}");
		JSONObject jsonRoot = new JSONObject(json);
		JSONArray array = jsonRoot.getJSONArray("data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonUnit = array.getJSONObject(i);
			DailyRates item = new DailyRates();
			item.setEXID(String.valueOf(jsonUnit.get("EXID")));
			item.setExDate(String.valueOf(jsonUnit.get("ExDate")));
			item.setCurrID(String.valueOf(jsonUnit.get("CurrID")));
			item.setERate(String.valueOf(jsonUnit.get("ERate")));
			item.setERateS(String.valueOf(jsonUnit.get("ERateS")));
			item.setPType(String.valueOf(jsonUnit.get("PType")));
			item.setCountryID(String.valueOf(jsonUnit.get("CountryID")));
			item.setLComm(String.valueOf(jsonUnit.get("LComm")));
			item.setSComm(String.valueOf(jsonUnit.get("SComm")));
			item.setShowH(String.valueOf(jsonUnit.get("ShowH")));
			item.setxValue(String.valueOf(jsonUnit.get("xValue")));
			item.setyValue(String.valueOf(jsonUnit.get("yValue")));
			item.setxTop(String.valueOf(jsonUnit.get("xTop")));
			item.setyTop(String.valueOf(jsonUnit.get("yTop")));
			item.setLess5(String.valueOf(jsonUnit.get("Less5")));
			item.setGreat5(String.valueOf(jsonUnit.get("Great5")));
			item.setOnlineRt(String.valueOf(jsonUnit.get("OnlineRt")));
			item.setAcMargin(String.valueOf(jsonUnit.get("AcMargin")));
			item.setCaMargin(String.valueOf(jsonUnit.get("CaMargin")));
			item.setOAct(String.valueOf(jsonUnit.get("OAct")));
			item.setCurrID1(String.valueOf(jsonUnit.get("CurrID1")));
			item.setCurrSym(String.valueOf(jsonUnit.get("CurrSym")));
			item.setCurText(String.valueOf(jsonUnit.get("CurText")));
			item.setCState(String.valueOf(jsonUnit.get("CState")));
			item.setCountryID1(String.valueOf(jsonUnit.get("CountryID1")));
			listItems.add(item);
		}
		return listItems;
	}
	
	private String getStringJson(String url, ArrayList<BasicNameValuePair> postDatas) throws IllegalStateException, ClientProtocolException, IOException {
		HttpService httpService = new HttpService();
		return httpService.getDataAsString(url, postDatas);
	}
}
