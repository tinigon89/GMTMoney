package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;

public class AccountActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.account_screen);
		
		initNavButton();
		Button account_btn_home = (Button) findViewById(R.id.account_btn_home);
		account_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_dailyrates = (Button) findViewById(R.id.account_btn_dailyrates);
		account_btn_dailyrates.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_rate_alerts = (Button) findViewById(R.id.account_btn_rate_alerts);
		account_btn_rate_alerts.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_sendmoney = (Button) findViewById(R.id.account_btn_sendmoney);
		account_btn_sendmoney.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_transaction = (Button) findViewById(R.id.account_btn_transaction);
		account_btn_transaction.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_find_trans = (Button) findViewById(R.id.account_btn_find_trans);
		account_btn_find_trans.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_track = (Button) findViewById(R.id.account_btn_track);
		account_btn_track.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_add_your_file = (Button) findViewById(R.id.account_btn_add_your_file);
		account_btn_add_your_file.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		TextView account_bar1_title_right = (TextView) findViewById(R.id.account_bar1_title_right);
		account_bar1_title_right.setText("Hi, " + getSharedPreferences("username"));
	}
}
