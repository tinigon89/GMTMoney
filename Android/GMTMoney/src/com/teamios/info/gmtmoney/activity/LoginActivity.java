package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.os.Bundle;
import android.view.View;
import android.widget.Button;

public class LoginActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.login);
		
		initNavButton();
		Button webview_btn_home = (Button) findViewById(R.id.login_btn_home);
		webview_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
	}
}
