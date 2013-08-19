package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.Button;

public class HomeActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.home);

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
