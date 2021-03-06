package com.hindvds.gmtmoney.activity;

import com.hindvds.gmtmoney.R;

import android.app.Activity;
import android.app.AlertDialog;
import android.content.ActivityNotFoundException;
import android.content.DialogInterface;
import android.content.Intent;
import android.net.Uri;
import android.os.Bundle;
import android.text.Html;
import android.util.Log;
import android.view.View;
import android.widget.RelativeLayout;
import android.widget.TextView;

public class ContactUsActivity extends Activity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.contact_us);
		
		RelativeLayout more_view_outside = (RelativeLayout) findViewById(R.id.view_outside);
		more_view_outside.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		TextView contact_tel1 = (TextView) findViewById(R.id.contact_tel1);
		contact_tel1.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				callNumber("1300783036");
			}
		});
		
		TextView contact_tel2 = (TextView) findViewById(R.id.contact_tel2);
		contact_tel2.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				callNumber("+61286773534");
			}
		});
		
		TextView contact_tel3 = (TextView) findViewById(R.id.contact_tel3);
		contact_tel3.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				callNumber("0466392621");
			}
		});
		
		TextView contact_email = (TextView) findViewById(R.id.contact_email);
		contact_email.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);
				emailIntent.setType("message/rfc822");
				emailIntent.putExtra(Intent.EXTRA_EMAIL, new String[]{"info@gmtmoney.com.au"});
				emailIntent.putExtra(android.content.Intent.EXTRA_TEXT, Html.fromHtml("<br><br><br><b>Sent from my " + android.os.Build.MODEL + "</b>"));
				startActivity(Intent.createChooser(emailIntent, "Email to Friend"));
				finish();
			}
		});

	}
	
	private void callNumber(String num){
		final String number = num;
		AlertDialog.Builder builder1 = new AlertDialog.Builder(ContactUsActivity.this);
		builder1.setMessage("Do you want to call this number:" + number+"?")
				.setPositiveButton("YES",
						new DialogInterface.OnClickListener() {
							public void onClick(
									DialogInterface dialog,
									int which) {
								try {
									Intent callIntent = new Intent(Intent.ACTION_CALL);
									callIntent.setData(Uri.parse("tel:" + number));
									startActivity(callIntent);
								} catch (ActivityNotFoundException activityException) {
									Log.e("Calling a Phone Number", "Call failed",
											activityException);
								}
								finish();
							}
						})
						.setNegativeButton("NO", new DialogInterface.OnClickListener() {
							public void onClick(
									DialogInterface dialog,
									int which) {
							}
						}).show();
		
	}
}
