package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.app.Activity;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.RelativeLayout;

public class MoreActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.more);
		
		RelativeLayout more_view_outside = (RelativeLayout) findViewById(R.id.view_outside);
		more_view_outside.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		ImageView more_line1_btn_help = (ImageView) findViewById(R.id.more_line1_btn_help);
		more_line1_btn_help.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent intent = new Intent(android.content.Intent.ACTION_VIEW,Uri.parse("http://www.gmtmoney.com.au/faq.php"));
				startActivity(intent);
				finish();
			}
		});
		
		ImageView more_line2_btn_visit = (ImageView) findViewById(R.id.more_line2_btn_visit);
		more_line2_btn_visit.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent intent = new Intent(android.content.Intent.ACTION_VIEW,Uri.parse("http://www.gmtmoney.com.au/"));
				startActivity(intent);
				finish();
			}
		});
		
		ImageView more_line3_btn_new = (ImageView) findViewById(R.id.more_line3_btn_new);
		more_line3_btn_new.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent intent = new Intent(android.content.Intent.ACTION_VIEW,Uri.parse("http://www.gmtmoney.com.au/"));
				startActivity(intent);
				finish();
			}
		});
	}
}
