package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.content.Intent;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class SuccessActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.success);
		
		saveSharedPreferences("FinishTransaction", "true");
		Button success_btn_home = (Button) findViewById(R.id.success_btn_home);
		success_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				showDialogGoHome("You have finished a transaction, share us on facebook to get 10 SMS for free.");
			}
		});

	}
}
