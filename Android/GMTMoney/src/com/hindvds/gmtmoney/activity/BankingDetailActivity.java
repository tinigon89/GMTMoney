package com.hindvds.gmtmoney.activity;

import com.hindvds.gmtmoney.R;

import android.app.Activity;
import android.os.Bundle;
import android.view.View;
import android.widget.RelativeLayout;

public class BankingDetailActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.bank_detail);
		
		RelativeLayout more_view_outside = (RelativeLayout) findViewById(R.id.view_outside);
		more_view_outside.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

	}
}
