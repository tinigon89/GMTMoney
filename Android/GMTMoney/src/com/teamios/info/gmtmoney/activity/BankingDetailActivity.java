package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class BankingDetailActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.bank_detail);
		
		Button btn_bank_detail = (Button) findViewById(R.id.btn_bank_detail);
		btn_bank_detail.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button btn_contact_us = (Button) findViewById(R.id.btn_contact_us);
		btn_contact_us.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button btn_refer_friends = (Button) findViewById(R.id.btn_refer_friends);
		btn_refer_friends.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button btn_more = (Button) findViewById(R.id.btn_more);
		btn_more.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

	}
}
