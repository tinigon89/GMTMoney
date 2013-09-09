package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.SendSMSService;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;

public class SmsActivity extends BaseActivity {

	private AutoCompleteTextView sms_codearea;
	private TextView sms_count, sms_count_text;
	private EditText sms_content, sms_number_to;
	private int countText = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.sms);

		sms_count_text = (TextView) findViewById(R.id.sms_count_text);
		sms_content = (EditText) findViewById(R.id.sms_content);
		sms_number_to = (EditText) findViewById(R.id.sms_number_to);
		sms_codearea = (AutoCompleteTextView) findViewById(R.id.sms_codearea);
		String[] listcodearea = { "+91", "+61", "+65", "+1", "+92", "+44",
				"+60", "+66", "+64" };
		sms_codearea.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, listcodearea));
		Button sms_codearea_btn = (Button) findViewById(R.id.sms_codearea_btn);
		sms_codearea_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				sms_codearea.showDropDown();
			}
		});

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
				if (getSharedPreferences("remaing_sms").equals("")
						|| getSharedPreferences("remaing_sms").equals("0")) {
					showDialog("Finish a transaction and share on facebook to get 10 SMS for free.");
				} else {
					if (sms_number_to.getText().toString().equals("")) {
						showDialog("Please enter phone number!");
					} else if (sms_content.getText().toString().equals("")) {
						showDialog("Please enter your message!");
					} else {
						saveSharedPreferences(
								"remaing_sms",
								String.valueOf(Integer
										.parseInt(getSharedPreferences("remaing_sms")) - 1));
						sms_count.setText(getSharedPreferences("remaing_sms"));
						new sendSMSAsyncTask().execute(sms_number_to.getText()
								.toString(), sms_content.getText().toString());
					}
				}
			}
		});

		sms_content.addTextChangedListener(new TextWatcher() {

			@Override
			public void beforeTextChanged(CharSequence arg0, int arg1,
					int arg2, int arg3) {
				// TODO Auto-generated method stub
			}

			@Override
			public void onTextChanged(CharSequence arg0, int arg1, int arg2,
					int arg3) {
				// TODO Auto-generated method stub
			}

			@Override
			public void afterTextChanged(Editable arg0) {
				// TODO Auto-generated method stub
				countText = sms_content.getText().length();
				sms_count_text.setText(String.valueOf(countText));
			}
		});

		sms_count = (TextView) findViewById(R.id.sms_count);
		if (getSharedPreferences("remaing_sms").equals("")) {
			sms_count.setText("0");
		} else {
			sms_count.setText(getSharedPreferences("remaing_sms"));
		}
	}

	private class sendSMSAsyncTask extends AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				SendSMSService sendSMSService = new SendSMSService();
				sendSMSService.sendSMS(aurl[0], aurl[1]);
				publishProgress(1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {
			if (progress[0] == 1) {

			}
		}

		@Override
		protected void onPostExecute(String unused) {
			closeProcessLoading();
			showDialogFinish("Your message has been sent!");
		}
	}
	
	public void showDialogFinish(String msg) {
		AlertDialog.Builder builder1 = new AlertDialog.Builder(
				SmsActivity.this);
		builder1.setMessage(msg)
				.setPositiveButton("OK", new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
					}
				}).show();
	}
}
