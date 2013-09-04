package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;

public class HomeActivity extends BaseActivity {
	
	private Button home_btn_login,home_btn_logout;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home);

		initNavButton();
		Button home_btn_daily = (Button) findViewById(R.id.home_btn_daily);
		home_btn_daily.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						DailyRatesActivity.class);
				startActivity(i);
			}
		});

		Button home_btn_cash = (Button) findViewById(R.id.home_btn_cash);
		home_btn_cash.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						WebViewScreenActivity.class);
				i.putExtra("name", "home_btn_cash");
				startActivity(i);
			}
		});

		Button home_btn_ifsc = (Button) findViewById(R.id.home_btn_ifsc);
		home_btn_ifsc.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						WebViewScreenActivity.class);
				i.putExtra("name", "home_btn_ifsc");
				startActivity(i);
			}
		});
		
		Button home_btn_news = (Button) findViewById(R.id.home_btn_news);
		home_btn_news.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						NewsActivity.class);
				i.putExtra("name", "news");
				startActivity(i);
			}
		});
		
		Button home_btn_rate_alert = (Button) findViewById(R.id.home_btn_rate_alert);
		home_btn_rate_alert.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						RateAlertsActivity.class);
				startActivity(i);
			}
		});

		home_btn_login = (Button) findViewById(R.id.home_btn_login);
		home_btn_login.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), LoginActivity.class);
				startActivity(i);
			}
		});

		home_btn_logout = (Button) findViewById(R.id.home_btn_logout);
		home_btn_logout.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				AlertDialog.Builder builder1 = new AlertDialog.Builder(HomeActivity.this);
				builder1.setMessage("Do you want to logout?")
						.setPositiveButton("Yes",
								new DialogInterface.OnClickListener() {
									public void onClick(DialogInterface dialog,
											int which) {
										saveSharedPreferences("isLogin", "false");
										home_btn_login.setVisibility(View.VISIBLE);
										home_btn_logout.setVisibility(View.GONE);
									}
								})
						.setNegativeButton("No", new DialogInterface.OnClickListener() {
							public void onClick(DialogInterface dialog,
									int which) {
							}
						}).show();
			}
		});

		Button home_btn_cal = (Button) findViewById(R.id.home_btn_cal);
		home_btn_cal.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						CalculatorActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_facebook = (Button) findViewById(R.id.home_btn_facebook);
		home_btn_facebook.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						FacebookActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_sms = (Button) findViewById(R.id.home_btn_sms);
		home_btn_sms.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),
						SmsActivity.class);
				startActivity(i);
			}
		});

		Button home_btn_account = (Button) findViewById(R.id.home_btn_account);
		home_btn_account.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if (getSharedPreferences("isLogin").equals("true")) {
					Intent i = new Intent(getBaseContext(),
							AccountActivity.class);
					startActivity(i);
				} else {
					Intent i = new Intent(getBaseContext(), LoginActivity.class);
					startActivity(i);
				}
			}
		});
		
		new LoadDataBackgroundDailyAsyncTask().execute("");

	}
	
	@Override
	protected void onResume() {
		// TODO Auto-generated method stub
		super.onResume();
		if(getSharedPreferences("isLogin").equals("false")){
			home_btn_login.setVisibility(View.VISIBLE);
			home_btn_logout.setVisibility(View.GONE);
		} else if(getSharedPreferences("isLogin").equals("true")){
			home_btn_login.setVisibility(View.GONE);
			home_btn_logout.setVisibility(View.VISIBLE);
		} else {
			home_btn_login.setVisibility(View.VISIBLE);
			home_btn_logout.setVisibility(View.GONE);
		}
	}

	private class LoadDataBackgroundDailyAsyncTask extends
			AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				listDailyRates = null;
				listDailyRates = getListDailyRatesInfo();
				countryList = null;
				countryList = getCountryList();
				publishProgress(1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {
			if (progress[0] == 1) {

			}
		}

		@Override
		protected void onPostExecute(String unused) {
			closeProcessLoading();
		}
	}
}
