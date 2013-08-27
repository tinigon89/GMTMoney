package com.teamios.info.gmtmoney.service;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.List;
import org.apache.http.NameValuePair;
import org.apache.http.client.ClientProtocolException;
import org.apache.http.client.ResponseHandler;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.HttpGet;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.conn.ClientConnectionManager;
import org.apache.http.conn.scheme.PlainSocketFactory;
import org.apache.http.conn.scheme.Scheme;
import org.apache.http.conn.scheme.SchemeRegistry;
import org.apache.http.conn.ssl.SSLSocketFactory;
import org.apache.http.entity.mime.MultipartEntity;
import org.apache.http.entity.mime.content.FileBody;
import org.apache.http.entity.mime.content.StringBody;
import org.apache.http.impl.client.BasicResponseHandler;
import org.apache.http.impl.client.DefaultHttpClient;
import org.apache.http.impl.conn.tsccm.ThreadSafeClientConnManager;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.params.BasicHttpParams;
import org.apache.http.params.HttpConnectionParams;
import org.apache.http.params.HttpParams;
import org.apache.http.protocol.HTTP;

import com.teamios.info.gmtmoney.common.Constant;

import android.content.Context;
import android.net.ConnectivityManager;
import android.net.NetworkInfo;
import android.util.Log;

/**
 * Project Name: Pinten
 * @author VietLu
 *
 * HttpService
 * Create: 2012/01/19
 */
public class HttpService {
	private DefaultHttpClient httpClient = null;
	private HttpParams httpParameters = null;

	/**
	 * HttpService object
	 * 
	 * @param host
	 *            is hot connect to service
	 * @param port
	 *            is port connect to service
	 */
	public HttpService(String host, int port) {
		this.httpParameters = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(this.httpParameters, Constant.CONST_TIME_OUT);
		HttpConnectionParams.setSoTimeout(this.httpParameters, Constant.CONST_TIME_OUT);
		
		//registers schemes for both http and https
        SchemeRegistry registry = new SchemeRegistry();
        registry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        final SSLSocketFactory sslSocketFactory = SSLSocketFactory.getSocketFactory();
        sslSocketFactory.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
        registry.register(new Scheme("https", sslSocketFactory, 443));
//        ThreadSafeClientConnManager manager = new ThreadSafeClientConnManager(httpParameters, registry);
        ClientConnectionManager manager = new ThreadSafeClientConnManager(httpParameters, registry);
        this.httpClient = new DefaultHttpClient(manager, httpParameters);
//		this.httpClient = new DefaultHttpClient();
//		this.httpClient.setParams(httpParameters);
	}

	/**
	 * HttpService with properties default
	 */
	public HttpService() {
		this.httpParameters = new BasicHttpParams();
		HttpConnectionParams.setConnectionTimeout(this.httpParameters, Constant.CONST_TIME_OUT);
		HttpConnectionParams.setSoTimeout(this.httpParameters, Constant.CONST_TIME_OUT);
		//registers schemes for both http and https
        SchemeRegistry registry = new SchemeRegistry();
        registry.register(new Scheme("http", PlainSocketFactory.getSocketFactory(), 80));
        final SSLSocketFactory sslSocketFactory = SSLSocketFactory.getSocketFactory();
        sslSocketFactory.setHostnameVerifier(SSLSocketFactory.ALLOW_ALL_HOSTNAME_VERIFIER);
        registry.register(new Scheme("https", sslSocketFactory, 443));
        ThreadSafeClientConnManager manager = new ThreadSafeClientConnManager(httpParameters, registry);
        this.httpClient = new DefaultHttpClient(manager, httpParameters);
//		this.httpClient = new DefaultHttpClient();
//		this.httpClient.setParams(httpParameters);
	}

	/**
	 * Get xml as string from service
	 * 
	 * @param file
	 *            is short url
	 * @param postDatas
	 *            is a list parameter
	 * @return a string xml
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public String getDataAsString(String url, ArrayList<BasicNameValuePair> postDatas)
			throws ClientProtocolException, IOException {
		HttpPost httpPost = new HttpPost(url);
		ResponseHandler<String> resonseHandler = new BasicResponseHandler();
		if (postDatas != null) {
			List<NameValuePair> data = new ArrayList<NameValuePair>();
			for (BasicNameValuePair post : postDatas) {
				data.add(post);
			}
			httpPost.setEntity(new UrlEncodedFormEntity(data, HTTP.UTF_8));
		}
		Log.i("HttpService", url);
		return httpClient.execute(httpPost, resonseHandler);
	}
	
	public InputStream postDataFile(String url, ArrayList<BasicNameValuePair> postDatas) throws IllegalStateException, ClientProtocolException, IOException {
		HttpPost httpPost = new HttpPost(url);
		if (postDatas != null) {
			MultipartEntity entity = new MultipartEntity();
			for (BasicNameValuePair post : postDatas) {
				String splitName[] = post.getValue().split("\\."); 
				if (splitName.length >= 2) {
					entity.addPart(post.getName(), new FileBody(new File(post.getValue())));
				} else {
					entity.addPart(post.getName(), new StringBody(post.getValue()));
				}
			}
			httpPost.setEntity(entity);
		}
		Log.i("HttpService", url);
		return httpClient.execute(httpPost).getEntity().getContent();
	}

	/**
	 * Get xml as InputStream from service
	 * 
	 * @param file
	 *            is short url
	 * @param postDatas
	 *            is a list parameter
	 * @return a InputStream
	 * @throws IllegalStateException
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public InputStream getDataAsInputStream(String url, ArrayList<BasicNameValuePair> postDatas)
			throws IllegalStateException, ClientProtocolException, IOException {
		HttpPost httpPost = new HttpPost(url);
		if (postDatas != null) {
			List<NameValuePair> data = new ArrayList<NameValuePair>();
			for (BasicNameValuePair post : postDatas) {
				data.add(post);
			}
			httpPost.setEntity(new UrlEncodedFormEntity(data, HTTP.UTF_8));
		}
		Log.i("HttpService", url);
		return httpClient.execute(httpPost).getEntity().getContent();
	}

	/**
	 * Get xml as InputStream from service
	 * 
	 * @param file
	 *            is short url
	 * @return a InputStream
	 * @throws IllegalStateException
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public InputStream getDataAsInputStream(String url) throws IllegalStateException,
			ClientProtocolException, IOException {
		HttpGet httpGet = new HttpGet(url);
		Log.i("HttpService", url);
		return httpClient.execute(httpGet).getEntity().getContent();
	}

	/**
	 * Get xml as InputStream from service
	 * 
	 * @param file
	 *            is short url
	 * @return a InputStream
	 * @throws IllegalStateException
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public InputStream getDataAsInputStreamCgi(String url,
			ArrayList<BasicNameValuePair> postDatas) throws IllegalStateException,
			ClientProtocolException, IOException {
		String param = "";
		if (postDatas != null) {
			for (BasicNameValuePair post : postDatas) {
				param += post.getName();
				param += "=";
				param += post.getValue();
				param += "&";
			}
		}
		if (param.length() > 0) {
			param = param.substring(0, param.length() - 1);
			url += "?" + param;
		}
		Log.i("HttpService", url);
		HttpGet httpGet = new HttpGet(url);
		return httpClient.execute(httpGet).getEntity().getContent();
	}
	
	/**
	 * Get xml as InputStream from service
	 * 
	 * @param file
	 *            is short url
	 * @return a InputStream
	 * @throws IllegalStateException
	 * @throws ClientProtocolException
	 * @throws IOException
	 */
	public String getDataAsStringCgi(String url,
			ArrayList<BasicNameValuePair> postDatas) throws IllegalStateException,
			ClientProtocolException, IOException {
		ResponseHandler<String> resonseHandler = new BasicResponseHandler();
		String param = "";
		if (postDatas != null) {
			for (BasicNameValuePair post : postDatas) {
				param += post.getName();
				param += "=";
				param += post.getValue();
				param += "&";
			}
		}
		if (param.length() > 0) {
			param = param.substring(0, param.length() - 1);
			url += "?" + param;
		}
		Log.i("HttpService", url);
		HttpGet httpGet = new HttpGet(url);
		return httpClient.execute(httpGet, resonseHandler);
	}
	
	/**
	 * Check connect network
	 * 
	 * @return Boolean.
	 */
	public Boolean isConnectNetwork(Context context) {
		Boolean isConnect = false;
		ConnectivityManager conMan = (ConnectivityManager) context
				.getSystemService(Context.CONNECTIVITY_SERVICE);
		NetworkInfo netInfo = conMan.getActiveNetworkInfo();
		if (netInfo != null && netInfo.isConnectedOrConnecting()) {
			Log.e("Connect type", netInfo.getTypeName());
			isConnect = true;
		} else {
			isConnect = false;
		}
		return isConnect;
	}
}
