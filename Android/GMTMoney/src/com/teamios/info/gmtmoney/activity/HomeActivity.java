package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.webkit.WebView;
import android.widget.Button;

public class HomeActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home);

		initNavButton();
		Button home_btn_daily = (Button) findViewById(R.id.home_btn_daily);
		home_btn_daily.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), DailyRatesActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_cash = (Button) findViewById(R.id.home_btn_cash);
		home_btn_cash.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), WebViewScreenActivity.class);
				i.putExtra("name", "home_btn_cash");
				startActivity(i);
			}
		});
		
		Button home_btn_ifsc = (Button) findViewById(R.id.home_btn_ifsc);
		home_btn_ifsc.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), WebViewScreenActivity.class);
				i.putExtra("name", "home_btn_ifsc");
				startActivity(i);
			}
		});
		
		Button home_btn_login = (Button) findViewById(R.id.home_btn_login);
		home_btn_login.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), LoginActivity.class);
				startActivity(i);
			}
		});
		
		Button home_btn_cal = (Button) findViewById(R.id.home_btn_cal);
		home_btn_cal.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), CalculatorActivity.class);
				startActivity(i);
			}
		});
		
		new LoadDataBackgroundDailyAsyncTask().execute("");
		
	}
	
	private class LoadDataBackgroundDailyAsyncTask extends AsyncTask<String, Integer, String> {

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
				publishProgress(1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {
			if(progress[0] == 1) {
				
			}
		}

		@Override
		protected void onPostExecute(String unused) {
			closeProcessLoading();
		}
	}
}
