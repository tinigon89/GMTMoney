package com.teamios.info.gmtmoney.activity;

import java.io.IOException;
import java.util.List;
import java.util.regex.Pattern;

import org.apache.http.client.ClientProtocolException;
import org.json.JSONException;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.CountryListService;
import com.teamios.info.gmtmoney.service.DailyRatesService;
import com.teamios.info.gmtmoney.service.info.AlertInfo;
import com.teamios.info.gmtmoney.service.info.BankInfo;
import com.teamios.info.gmtmoney.service.info.CountryList;
import com.teamios.info.gmtmoney.service.info.DailyRates;
import com.teamios.info.gmtmoney.service.info.TransactionHistoryInfo;
import com.teamios.info.gmtmoney.service.info.UserLoginInfo;

import android.app.Activity;
import android.app.AlertDialog;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class BaseActivity extends Activity{
	
	protected ProgressDialog progressDialog;
	protected Dialog dialog;
	protected static List<DailyRates> listDailyRates = null;
	protected static List<CountryList> countryList = null;
	protected static List<AlertInfo> alertInfo = null;
	protected static List<TransactionHistoryInfo> listResultSearchRemittance = null;
	protected static List<BankInfo> listBankInfo = null;
	public final Pattern EMAIL_ADDRESS_PATTERN = Pattern
			.compile("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@"
					+ "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" + "\\."
					+ "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+");
	
	public boolean checkEmail(String email) {
		return EMAIL_ADDRESS_PATTERN.matcher(email).matches();
	}
	
	public void openProcessLoading(final Boolean isCloseScreen) {
		try {
			if (progressDialog == null) {
				progressDialog = ProgressDialog.show(BaseActivity.this, "", "Loading...", true, true,
						new DialogInterface.OnCancelListener() {

							@Override
							public void onCancel(DialogInterface dialog) {
								if (isCloseScreen) {
									finish();
								}
							}
						});
			} else {
				progressDialog.show();
			}
			progressDialog.setCanceledOnTouchOutside(false);
		} catch (Exception e) {
			Log.e("Close dialog process", this.toString());
		}
	}
	
	public void closeProcessLoading() {
		new Thread() {
			@Override
			public void run() {
				super.run();
				if (progressDialog != null) {
					progressDialog.dismiss();
				}
			}
		}.start();
	}
	
	protected List<DailyRates> getListDailyRatesInfo()
			throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		DailyRatesService server = new DailyRatesService();
		return server.getDailyRatesInfo();
	}
	
	protected List<CountryList> getCountryList()
			throws IllegalStateException, ClientProtocolException, IOException, JSONException {
		CountryListService server = new CountryListService();
		return server.getCountryListInfo();
	}
	
	protected void saveSharedPreferences(String key, String value) {
		SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
		SharedPreferences.Editor editer = sharedPreferences.edit();
		editer.putString(key, value);
		editer.commit();
	}
	
	protected String getSharedPreferences(String key) {
		String suid = null;
		SharedPreferences sharedPreferences = PreferenceManager.getDefaultSharedPreferences(this);
		suid = sharedPreferences.getString(key, "");
		return suid;
	}
	
	public void showDialog(String msg) {
		AlertDialog.Builder builder1 = new AlertDialog.Builder( BaseActivity.this);
		builder1.setMessage(msg)
				.setPositiveButton("OK",
						new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
							}
						}).show();
	}
	
	public void initNavButton(){
		Button home_btn_bank_detail = (Button) findViewById(R.id.home_btn_bank_detail);
		home_btn_bank_detail.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), BankingDetailActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_contact_us = (Button) findViewById(R.id.home_btn_contact_us);
		home_btn_contact_us.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), ContactUsActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_more = (Button) findViewById(R.id.home_btn_more);
		home_btn_more.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), MoreActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_refer_friends = (Button) findViewById(R.id.home_btn_refer_friends);
		home_btn_refer_friends.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);
				emailIntent.setType("message/rfc822");
				emailIntent.putExtra(Intent.EXTRA_SUBJECT, "GMT MONEY");
				emailIntent.putExtra(android.content.Intent.EXTRA_TEXT, Html.fromHtml("<br><br><br><b>Sent from my " + android.os.Build.MODEL + "</b>"));
				startActivity(Intent.createChooser(emailIntent, "Email to Friend"));
			}
		});
	}
}


