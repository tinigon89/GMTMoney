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
import com.teamios.info.gmtmoney.service.info.CountryList;
import com.teamios.info.gmtmoney.service.info.DailyRates;
import com.teamios.info.gmtmoney.service.info.TransactionHistoryInfo;

public class TransactionHistoryService {
	
	public List<TransactionHistoryInfo> getTransactionHistory(String RegisterID) throws IllegalStateException, ClientProtocolException, IOException,JSONException {
		String json = getStringJson(String.format(Constant.kServer_Get_Trans_History, RegisterID), null);
		return parseJson(json);
	}
	
	private List<TransactionHistoryInfo> parseJson(String json) throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		List<TransactionHistoryInfo> listItems = new ArrayList<TransactionHistoryInfo>();
		json = json.replace("[{", "{\"data\":[{");
		json = json.replace("}]", "}]}");
		JSONObject jsonRoot = new JSONObject(json);
		JSONArray array = jsonRoot.getJSONArray("data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonUnit = array.getJSONObject(i);
			TransactionHistoryInfo item = new TransactionHistoryInfo();
			item.setRemitId(String.valueOf(jsonUnit.get("RemitId")));
			item.setFName1(String.valueOf(jsonUnit.get("FName1")));
			item.setSurName1(String.valueOf(jsonUnit.get("SurName1")));
			item.setFirstN(String.valueOf(jsonUnit.get("FirstN")));
			item.setSurN(String.valueOf(jsonUnit.get("SurN")));
			item.setPayAmt(String.valueOf(jsonUnit.get("PayAmt")));
			item.setExRate(String.valueOf(jsonUnit.get("ExRate")));
			item.setForAmt(String.valueOf(jsonUnit.get("ForAmt")));
			item.setBankName(String.valueOf(jsonUnit.get("BankName")));
			item.setACNo(String.valueOf(jsonUnit.get("ACNo")));
			item.setCurrSym(String.valueOf(jsonUnit.get("CurrSym")));
			listItems.add(item);
		}
		return listItems;
	}
	
	private String getStringJson(String url, ArrayList<BasicNameValuePair> postDatas) throws IllegalStateException, ClientProtocolException, IOException {
		HttpService httpService = new HttpService();
		return httpService.getDataAsString(url, postDatas);
	}
}
