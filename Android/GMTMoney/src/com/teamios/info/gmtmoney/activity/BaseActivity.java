package com.teamios.info.gmtmoney.activity;

import java.io.IOException;
import java.util.List;

import org.apache.http.client.ClientProtocolException;
import org.json.JSONException;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.DailyRatesService;
import com.teamios.info.gmtmoney.service.info.DailyRates;

import android.app.Activity;
import android.app.Dialog;
import android.app.ProgressDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class BaseActivity extends Activity{
	
	protected ProgressDialog progressDialog;
	protected Dialog dialog;
	protected static List<DailyRates> listDailyRates = null;
	
//	public void openProcessLoading(final Boolean isCloseScreen) {
//		try {
//			if (dialog == null) {
//				dialog = new Dialog(this, R.style.Theme_MyDialogTran);
//		        dialog.setContentView(R.layout.progress_dialog);
//		        dialog.setCancelable(isCloseScreen);
//			}
//	        dialog.show();
//		} catch (Exception e) {
//			Log.e("Close dialog process", this.toString());
//		}
//	}
//	
//	public void closeProcessLoading() {
//		new Thread() {
//			@Override
//			public void run() {
//				super.run();
//				if (dialog != null) {
//					dialog.dismiss();
//				}
//			}
//		}.start();
//	}
	
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


