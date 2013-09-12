package com.hindvds.gmtmoney.service;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import org.apache.http.HttpResponse;
import org.apache.http.NameValuePair;
import org.apache.http.auth.AuthScope;
import org.apache.http.auth.UsernamePasswordCredentials;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;
import org.json.JSONException;

import android.util.Log;

import com.hindvds.gmtmoney.common.Constant;

public class SendSMSService {

	public void sendSMS(String to, String body) throws IllegalStateException,
			ClientProtocolException, IOException, JSONException {
		to = URLEncoder.encode(to, "utf-8");
		body = URLEncoder.encode(body, "utf-8");
		Log.d("sms value",Constant.kServer_Sms + " | " + to + " | " + body);
		String result = postData(Constant.kServer_Sms, to, body);
		Log.d("send sms refult", result);
	}

	public String postData(String URL, String to, String body) throws ClientProtocolException, IOException {
		AuthScope authScope = new AuthScope(AuthScope.ANY_HOST, AuthScope.ANY_PORT);
		UsernamePasswordCredentials	credential = new UsernamePasswordCredentials(Constant.kServer_Sms_kTwilioSID, Constant.kServer_Sms_token);

		HttpParams httpParameters = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(httpParameters, Constant.CONST_TIME_OUT);
		HttpConnectionParams.setSoTimeout(httpParameters, Constant.CONST_TIME_OUT);
		
		SchemeRegistry registry = new SchemeRegistry();
        registry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        final SSLSocketFactory sslSocketFactory = SSLSocketFactory.getSocketFactory();
        sslSocketFactory.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
        registry.register(new Scheme("https", sslSocketFactory, 443));
        ClientConnectionManager manager = new ThreadSafeClientConnManager(httpParameters, registry);
        DefaultHttpClient httpclient = new DefaultHttpClient(manager, httpParameters);
        httpclient.setParams(httpParameters);
		httpclient.getCredentialsProvider().setCredentials(authScope, credential);
        HttpPost httppost = new HttpPost(URL);
		ResponseHandler<String> resonseHandler = new BasicResponseHandler();
		

		try {
			// Add your data
			List<NameValuePair> nameValuePairs = new ArrayList<NameValuePair>(2);
			nameValuePairs.add(new BasicNameValuePair("From", Constant.kServer_Sms_kFromNumber));
			nameValuePairs.add(new BasicNameValuePair("To", to));
			nameValuePairs.add(new BasicNameValuePair("Body", body));
			httppost.setEntity(new UrlEncodedFormEntity(nameValuePairs, HTTP.UTF_8));

			// Execute HTTP Post Request
			HttpResponse response = httpclient.execute(httppost);

		} catch (ClientProtocolException e) {
			// TODO Auto-generated catch block
		} catch (IOException e) {
			// TODO Auto-generated catch block
		}
		
		return httpclient.execute(httppost, resonseHandler);
	}
}
