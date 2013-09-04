package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class SmsActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sms);
		
		initNavButton();
		Button sms_btn_home = (Button) findViewById(R.id.sms_btn_home);
		sms_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button sms_btn_send = (Button) findViewById(R.id.sms_btn_send);
		sms_btn_send.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button sms_number_to_btn = (Button) findViewById(R.id.sms_number_to_btn);
		sms_number_to_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
	}
}
