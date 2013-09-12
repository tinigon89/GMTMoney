package com.hindvds.gmtmoney.service;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.hindvds.gmtmoney.common.Constant;
import com.hindvds.gmtmoney.service.info.CountryList;

public class CountryListService {
	
	public List<CountryList> getCountryListInfo() throws IllegalStateException, ClientProtocolException, IOException,JSONException {
		String json = getStringJson(Constant.kServer_Get_CountryList, null);
		return parseJson(json);
	}
	
	private List<CountryList> parseJson(String json) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		List<CountryList> listItems = new ArrayList<CountryList>();
		json = json.replace("[{", "{\"data\":[{");
		json = json.replace("}]", "}]}");
		JSONObject jsonRoot = new JSONObject(json);
		JSONArray array = jsonRoot.getJSONArray("data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonUnit = array.getJSONObject(i);
			CountryList item = new CountryList();
			item.setCurrID(String.valueOf(jsonUnit.get("CurrID")));
			item.setCurrSym(String.valueOf(jsonUnit.get("CurrSym")));
			item.setCurText(String.valueOf(jsonUnit.get("CurText")));
			item.setCState(String.valueOf(jsonUnit.get("CState")));
			item.setCountryID(String.valueOf(jsonUnit.get("CountryID")));
			item.setCountryID1(String.valueOf(jsonUnit.get("CountryID1")));
			item.setCountryName(String.valueOf(jsonUnit.get("CountryName")));
			item.setCFlag(String.valueOf(jsonUnit.get("CFlag")));
			item.setCountry_Code(String.valueOf(jsonUnit.get("Country_Code")));
			item.setCurname(String.valueOf(jsonUnit.get("curname")));
			listItems.add(item);
		}
		return listItems;
	}
	
	private String getStringJson(String url, ArrayList<BasicNameValuePair> postDatas) throws IllegalStateException, ClientProtocolException, IOException {
		HttpService httpService = new HttpService();
		return httpService.getDataAsString(url, postDatas);
	}
}
