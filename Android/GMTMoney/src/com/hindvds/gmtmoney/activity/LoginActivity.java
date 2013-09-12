package com.hindvds.gmtmoney.activity;

import com.hindvds.gmtmoney.service.LoginService;
import com.hindvds.gmtmoney.R;

import android.content.Context;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class LoginActivity extends BaseActivity {
	private boolean isLogin;
	private Context context;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);
		context = this;

		final EditText login_userid = (EditText) findViewById(R.id.login_userid);
		final EditText login_password = (EditText) findViewById(R.id.login_password);

		Button login_btn_login = (Button) findViewById(R.id.login_btn_login);
		login_btn_login.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if (login_userid.getText().toString().equals("")) {
					showDialog("Please enter your userid.");
				} else if (login_password.getText().toString().equals("")) {
					showDialog("Please enter your password.");
				} else {
					new LoginAsyncTask().execute(login_userid.getText().toString(),login_password.getText().toString());
				}
			}
		});
		initNavButton();
		Button webview_btn_home = (Button) findViewById(R.id.login_btn_home);
		webview_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		TextView login_forgot1 = (TextView) findViewById(R.id.login_forgot1);
		TextView login_forgot2 = (TextView) findViewById(R.id.login_forgot2);
		login_forgot1.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), ForgotActivity.class);
				startActivity(i);
			}
		});
		login_forgot2.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), ForgotActivity.class);
				startActivity(i);
			}
		});
		
		TextView login_register = (TextView) findViewById(R.id.login_register);
		login_register.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), RegisterActivity.class);
				startActivity(i);
			}
		});
	}

	private class LoginAsyncTask extends
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
				isLogin = loginService.login(aurl[0],aurl[1],context);
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
			if(isLogin){
				saveSharedPreferences("isLogin", "true");
				Intent i = new Intent(getBaseContext(), AccountActivity.class);
				startActivity(i);
				finish();
			} else {
				showDialog("UserID or Password not correct.");
			}
		}
	}
}
