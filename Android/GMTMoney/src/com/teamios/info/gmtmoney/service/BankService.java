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

import android.util.Log;

import com.teamios.info.gmtmoney.common.Constant;
import com.teamios.info.gmtmoney.service.info.BankInfo;
import com.teamios.info.gmtmoney.service.info.BeneficiaryInfo;
import com.teamios.info.gmtmoney.service.info.CountryList;
import com.teamios.info.gmtmoney.service.info.DailyRates;
import com.teamios.info.gmtmoney.service.info.SenderInfo;
import com.teamios.info.gmtmoney.service.info.TransactionHistoryInfo;

public class BankService {

	public List<BankInfo> searchBank(String bankID) throws IllegalStateException, ClientProtocolException,
			IOException, JSONException {
		String json = getStringJson(String.format(
				Constant.kServer_Get_BankInfo, bankID),
				null);
		return parseJson(json);
	}

	private List<BankInfo> parseJson(String json)
			throws IllegalStateException, ClientProtocolException, IOException,
			JSONException {
		List<BankInfo> listItems = new ArrayList<BankInfo>();
		json = json.replace("[{", "{\"data\":[{");
		json = json.replace("}]", "}]}");
		JSONObject jsonRoot = new JSONObject(json);
		JSONArray array = jsonRoot.getJSONArray("data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonUnit = array.getJSONObject(i);
			BankInfo item = new BankInfo();
			item.setBankACID(String.valueOf(jsonUnit.get("BankACID")));
			item.setBeneficiaryID(String.valueOf(jsonUnit.get("BeneficiaryID")));
			item.setAcHolderName(String.valueOf(jsonUnit.get("AcHolderName")));
			item.setACNo(String.valueOf(jsonUnit.get("ACNo")));
			item.setBankName(String.valueOf(jsonUnit.get("BankName")));
			item.setBankCode(String.valueOf(jsonUnit.get("BankCode")));
			item.setSwiftCode(String.valueOf(jsonUnit.get("SwiftCode")));
			item.setRouteNo(String.valueOf(jsonUnit.get("RouteNo")));
			item.setBranch1(String.valueOf(jsonUnit.get("Branch1")));
			item.setBranch2(String.valueOf(jsonUnit.get("Branch2")));
			item.setCity(String.valueOf(jsonUnit.get("City")));
			item.setState(String.valueOf(jsonUnit.get("State")));
			item.setPostCode(String.valueOf(jsonUnit.get("PostCode")));
			item.setCountryID(String.valueOf(jsonUnit.get("CountryID")));
			item.setBState(String.valueOf(jsonUnit.get("BState")));
			item.setBankCodeDesc(String.valueOf(jsonUnit.get("BankCodeDesc")));
			item.setSwiftCodeDesc(String.valueOf(jsonUnit.get("SwiftCodeDesc")));
			item.setRoutenoDesc(String.valueOf(jsonUnit.get("RoutenoDesc")));
			listItems.add(item);
		}
		return listItems;
	}

	public String newBank(String RegID, String ACHolderName, String ACNo,
			String BankName, String BankCode, String SwiftCode, String RoutNo,
			String Add1, String Add2, String City, String State,
			String PostCode, String Country, String BeneID) throws IllegalStateException,
			ClientProtocolException, IOException {
		ACHolderName = URLEncoder.encode(ACHolderName, "utf-8");
		Add1 = URLEncoder.encode(Add1, "utf-8");
		Add2 = URLEncoder.encode(Add2, "utf-8");
		City = URLEncoder.encode(City, "utf-8");
		BankName = URLEncoder.encode(BankName, "utf-8");
		State = URLEncoder.encode(State, "utf-8");
		String url = String.format(Constant.kServer_Create_NewBank, RegID,
				ACHolderName, ACNo, BankName, BankCode, SwiftCode,
				RoutNo, Add1, Add2, City, State,
				PostCode, Country, BeneID);
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
