package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class FacebookActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.facebook);
		
		initNavButton();
		Button facebook_btn_home = (Button) findViewById(R.id.facebook_btn_home);
		facebook_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button facebook_btn = (Button) findViewById(R.id.facebook_btn);
		facebook_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if(getSharedPreferences("remaing_sms").equals("")){
					saveSharedPreferences("remaing_sms","0");
				}
				saveSharedPreferences("remaing_sms",String.valueOf(Integer.parseInt(getSharedPreferences("remaing_sms")) + 10));
				finish();
			}
		});
	}
}
