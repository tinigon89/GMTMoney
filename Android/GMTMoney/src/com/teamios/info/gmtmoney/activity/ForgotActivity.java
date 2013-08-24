package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.LoginService;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;

public class ForgotActivity extends BaseActivity {
	private String value;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.forgot);

		final EditText forgot_email = (EditText) findViewById(R.id.forgot_email);

		Button forgot_btn_submit = (Button) findViewById(R.id.forgot_btn_submit);
		forgot_btn_submit.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if (forgot_email.getText().toString().equals("") || !checkEmail(forgot_email.getText().toString())) {
					showDialog("Email invalided.");
				} else {
					new ForgotAsyncTask().execute(forgot_email.getText().toString());
				}
			}
		});
		initNavButton();
		Button webview_btn_home = (Button) findViewById(R.id.forgot_btn_home);
		webview_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

	}

	private class ForgotAsyncTask extends
			AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				LoginService loginService = new LoginService();
				value = loginService.forgot(aurl[0]);
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
			if(!value.equals("Email Not Found")){
				Intent i = new Intent(getBaseContext(), HomeActivity.class);
				startActivity(i);
				finish();
			} else {
				showDialog(value);
			}
		}
	}
}
