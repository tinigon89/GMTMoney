package com.hindvds.gmtmoney.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.message.BasicNameValuePair;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.hindvds.gmtmoney.common.Constant;
import com.hindvds.gmtmoney.service.info.BeneficiaryInfo;

public class BeneficiaryService {

	public List<BeneficiaryInfo> searchBeneficiary(String RegisterID, String index,
			String data) throws IllegalStateException, ClientProtocolException,
			IOException, JSONException {
		data = URLEncoder.encode(data, "utf-8");
		String json = getStringJson(String.format(
				Constant.kServer_Get_Search_Bene, RegisterID, index, data),
				null);
		return parseJson(json);
	}

	private List<BeneficiaryInfo> parseJson(String json)
			throws IllegalStateException, ClientProtocolException, IOException,
			JSONException {
		List<BeneficiaryInfo> listItems = new ArrayList<BeneficiaryInfo>();
		json = json.replace("[{", "{\"data\":[{");
		json = json.replace("}]", "}]}");
		JSONObject jsonRoot = new JSONObject(json);
		JSONArray array = jsonRoot.getJSONArray("data");
		for (int i = 0; i < array.length(); i++) {
			JSONObject jsonUnit = array.getJSONObject(i);
			BeneficiaryInfo item = new BeneficiaryInfo();
			item.setBeneficiaryID(String.valueOf(jsonUnit.get("BeneficiaryID")));
			item.setRegisterID(String.valueOf(jsonUnit.get("RegisterID")));
			item.setFirstN(String.valueOf(jsonUnit.get("FirstN")));
			item.setSurN(String.valueOf(jsonUnit.get("SurN")));
			item.setIDType(String.valueOf(jsonUnit.get("IDType")));
			item.setIDNo(String.valueOf(jsonUnit.get("IDNo")));
			item.setPCont(String.valueOf(jsonUnit.get("PCont")));
			item.setSCont(String.valueOf(jsonUnit.get("SCont")));
			item.setEmails1(String.valueOf(jsonUnit.get("Emails1")));
			item.setAddL1(String.valueOf(jsonUnit.get("AddL1")));
			item.setAddL2(String.valueOf(jsonUnit.get("AddL2")));
			item.setCityy(String.valueOf(jsonUnit.get("Cityy")));
			item.setStates(String.valueOf(jsonUnit.get("States")));
			item.setPostCode(String.valueOf(jsonUnit.get("PostCode")));
			item.setCountryID(String.valueOf(jsonUnit.get("CountryID")));
			item.setBState(String.valueOf(jsonUnit.get("BState")));
			item.setBAssID(String.valueOf(jsonUnit.get("BAssID")));
			item.setBAddress(String.valueOf(jsonUnit.get("BAddress")));
			listItems.add(item);
		}
		return listItems;
	}

	public String newBeneficiary(String RegID, String Email, String FName,
			String SurName, String BisName, String IDType, String IdCode,
			String Add1, String Add2, String City, String RState,
			String RPost, String RCountryID, String PContact, String SContact,
			String PCDet, String SCDet) throws IllegalStateException,
			ClientProtocolException, IOException {
		BisName = URLEncoder.encode(BisName, "utf-8");
		Add1 = URLEncoder.encode(Add1, "utf-8");
		Add2 = URLEncoder.encode(Add2, "utf-8");
		City = URLEncoder.encode(City, "utf-8");
		RState = URLEncoder.encode(RState, "utf-8");
		String url = String.format(Constant.kServer_Create_NewBeneficiary, RegID,
				Email, FName, SurName, BisName, IDType,
				IdCode, Add1, Add2, City, RState,
				RPost, RCountryID, PContact, SContact, PCDet, SCDet);
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
