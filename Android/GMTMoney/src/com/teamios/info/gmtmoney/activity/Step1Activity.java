package com.teamios.info.gmtmoney.activity;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.RemittanceService;

import android.content.Intent;
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

public class Step1Activity extends BaseActivity {
	private EditText step1_purpose, step1_payment_amount, step1_less_com,
			step1_transfer_amount, step1_rate_exchange, step1_foreign_amount,
			step1_extra_comment;
	private TextView step1_foreign_amount1;
	private AutoCompleteTextView step1_by_select;
	private boolean isLeftBtn = false;
	private int online = 0;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.remittance_step1);

		initNavButton();
		Button step1_btn_home = (Button) findViewById(R.id.step1_btn_home);
		step1_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		step1_by_select = (AutoCompleteTextView) findViewById(R.id.step1_by_select);
		step1_purpose = (EditText) findViewById(R.id.step1_purpose);
		step1_payment_amount = (EditText) findViewById(R.id.step1_payment_amount);
		step1_less_com = (EditText) findViewById(R.id.step1_less_com);
		step1_transfer_amount = (EditText) findViewById(R.id.step1_transfer_amount);
		step1_rate_exchange = (EditText) findViewById(R.id.step1_rate_exchange);
		step1_foreign_amount = (EditText) findViewById(R.id.step1_foreign_amount);
		step1_foreign_amount1 = (TextView) findViewById(R.id.step1_foreign_amount1);
		step1_extra_comment = (EditText) findViewById(R.id.step1_extra_comment);
		step1_less_com.setFocusable(false);
		step1_less_com.setFocusableInTouchMode(false);
		step1_transfer_amount.setFocusable(false);
		step1_transfer_amount.setFocusableInTouchMode(false);
		step1_rate_exchange.setFocusable(false);
		step1_rate_exchange.setFocusableInTouchMode(false);
		step1_foreign_amount.setFocusable(false);
		step1_foreign_amount.setFocusableInTouchMode(false);
		step1_by_select.setFocusable(false);
		step1_by_select.setFocusableInTouchMode(false);
		step1_by_select.setText(listDailyRates.get(0).getCurrSym() + " - "
				+ listDailyRates.get(0).getCurText());
		step1_less_com.setText(listDailyRates.get(0).getSComm());
		step1_rate_exchange.setText(listDailyRates.get(0).getERateS());

		isLeftBtn = true;
		final Button step1_case_btn = (Button) findViewById(R.id.step1_case_btn);
		final Button step1_account_btn = (Button) findViewById(R.id.step1_account_btn);
		step1_case_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				isLeftBtn = true;
				step1_less_com.setText(getSComm());
				step1_rate_exchange.setText(getRates());
				step1_case_btn.setBackgroundResource(R.drawable.step1_case_on);
				step1_account_btn
						.setBackgroundResource(R.drawable.step1_account);
				processCal();
			}
		});
		step1_account_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				isLeftBtn = false;
				step1_less_com.setText(getLComm());
				step1_rate_exchange.setText(getRate());
				step1_case_btn.setBackgroundResource(R.drawable.step1_case);
				step1_account_btn
						.setBackgroundResource(R.drawable.step1_account_on);
				processCal();
			}
		});

		ArrayList<String> listDailyRatesItem = new ArrayList<String>();
		if (listDailyRates != null) {
			for (int i = 0; i < RegisterActivity.listDailyRates.size(); i++) {
				listDailyRatesItem.add(listDailyRates.get(i).getCurrSym()
						+ " - " + listDailyRates.get(i).getCurText());
			}
		}
		step1_by_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						listDailyRatesItem));
		Button step1_by_select_btn = (Button) findViewById(R.id.step1_by_select_btn);
		step1_by_select_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				step1_by_select.showDropDown();
			}
		});

		step1_by_select.addTextChangedListener(new TextWatcher() {

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
				String temp = step1_by_select.getText().toString();
				String[] temps = temp.split("\\s+");
				step1_foreign_amount1.setText(temps[0]);
				if (isLeftBtn) {
					step1_less_com.setText(getSComm());
					step1_rate_exchange.setText(getRates());
				} else {
					step1_less_com.setText(getLComm());
					step1_rate_exchange.setText(getRate());
				}
			}
		});

		step1_payment_amount.addTextChangedListener(new TextWatcher() {

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
				processCal();
			}
		});

		Button step1_next_btn = (Button) findViewById(R.id.step1_next_btn);
		step1_next_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if (step1_purpose.getText().toString().equals("")) {
					showDialog("Please enter your purpose of this transaction!");
				} else if (Float.parseFloat(step1_payment_amount.getText()
						.toString()) < Float.parseFloat(step1_less_com
						.getText().toString())) {
					showDialog("Your payment not valid!");
				} else {
					String PayMethod = "";
					if (isLeftBtn) {
						PayMethod = "1";
					} else {
						PayMethod = "2";
					}
					if (getSharedPreferences("UType").equals("0")) {
						online = 1;
						try {
							if(!checkIDExpiry(getSharedPreferences("UIDExpiry"))){
								showDialog("Your ID has expired please update your new ID!");
								return;
							}
						} catch (ParseException e) {
							// TODO Auto-generated catch block
							e.printStackTrace();
						}
					}
					new submitAsyncTask().execute(
							getSharedPreferences("RegisterID"), 
							getCurrID(),
							step1_purpose.getText().toString(), 
							"2", 
							PayMethod,
							step1_payment_amount.getText().toString(),
							step1_less_com.getText().toString(),
							step1_transfer_amount.getText().toString(),
							step1_rate_exchange.getText().toString(),
							step1_foreign_amount.getText().toString(),
							step1_extra_comment.getText().toString(),
							String.valueOf(online));
					saveSharedPreferences("step4_transfer_payment", step1_payment_amount.getText().toString());
					saveSharedPreferences("step4_transfer_commission", step1_less_com.getText().toString());
					saveSharedPreferences("step4_transfer_transfer", step1_transfer_amount.getText().toString());
					saveSharedPreferences("step4_transfer_exchange", step1_rate_exchange.getText().toString());
					saveSharedPreferences("step4_transfer_foreign", step1_foreign_amount.getText().toString());
					saveSharedPreferences("step4_transfer_comments", step1_extra_comment.getText().toString());
				}
			}
		});

	}

	private void processCal() {
		if (step1_payment_amount.getText().toString().equals("0")) {
			step1_payment_amount.setText("");
			step1_transfer_amount.setText("");
			step1_foreign_amount.setText("");

		} else if (!step1_payment_amount.getText().toString().equals("")) {
			step1_transfer_amount.setText(String.valueOf(Float
					.parseFloat(step1_payment_amount.getText().toString())
					- Float.parseFloat(step1_less_com.getText().toString())));
			step1_foreign_amount
					.setText(String.valueOf(Float
							.parseFloat(step1_transfer_amount.getText()
									.toString())
							* Float.parseFloat(step1_rate_exchange.getText()
									.toString())));
		} else {
			step1_transfer_amount.setText("");
			step1_foreign_amount.setText("");
		}
	}

	private String getRates() {
		String val = "";
		for (int i = 0; i < listDailyRates.size(); i++) {
			if ((step1_foreign_amount1.getText().toString()).trim().equals(
					(listDailyRates.get(i).getCurrSym()).trim())) {
				val = listDailyRates.get(i).getERateS();
			}
		}
		return val;
	}

	private String getRate() {
		String val = "";
		for (int i = 0; i < listDailyRates.size(); i++) {
			if ((step1_foreign_amount1.getText().toString()).trim().equals(
					(listDailyRates.get(i).getCurrSym()).trim())) {
				val = listDailyRates.get(i).getERate();
			}
		}
		return val;
	}

	private String getSComm() {
		String val = "";
		for (int i = 0; i < listDailyRates.size(); i++) {
			if ((step1_foreign_amount1.getText().toString()).trim().equals(
					(listDailyRates.get(i).getCurrSym()).trim())) {
				val = listDailyRates.get(i).getSComm();
			}
		}
		return val;
	}

	private String getLComm() {
		String val = "";
		for (int i = 0; i < listDailyRates.size(); i++) {
			if ((step1_foreign_amount1.getText().toString()).trim().equals(
					(listDailyRates.get(i).getCurrSym()).trim())) {
				val = listDailyRates.get(i).getLComm();
			}
		}
		return val;
	}

	private String getCurrID() {
		String val = "";
		for (int i = 0; i < listDailyRates.size(); i++) {
			if ((step1_foreign_amount1.getText().toString()).trim().equals(
					(listDailyRates.get(i).getCurrSym()).trim())) {
				val = listDailyRates.get(i).getCurrID();
			}
		}
		return val;
	}
	
	public boolean checkIDExpiry(String mdate) throws ParseException {
		SimpleDateFormat formatter = new SimpleDateFormat("dd-MM-yyyy");
		Date date = formatter.parse(mdate);
		long milliSeconds = date.getTime();
	    if(milliSeconds >= System.currentTimeMillis()){
	    	return true;
	    }
	    return false;
	}

	private class submitAsyncTask extends AsyncTask<String, Integer, String> {
		
		private String result;
		private String tab;

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				RemittanceService remittanceService = new RemittanceService();
				result = remittanceService.submitStep1(aurl[0], aurl[1],
						aurl[2], aurl[3], aurl[4], aurl[5], aurl[6], aurl[7],
						aurl[8], aurl[9], aurl[10], aurl[11]);
				saveSharedPreferences("remid", result);
				tab = aurl[4];
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
			if (getSharedPreferences("UType").equals("0")) {
				if(tab.equals("1")){
					//showDialog("Cash->step3->step4");
					saveSharedPreferences("PayMethod", "1");
				} else if(tab.equals("2")){
					//showDialog("Account->Step3->Step3continue->step4");
					saveSharedPreferences("PayMethod", "2");
				}
				saveSharedPreferences("online", "1");
				Intent i = new Intent(getBaseContext(), Step3Activity.class);
				startActivity(i);
			} else {
				if(tab.equals("1")){
					//showDialog("Cash->step2->step3->step4");
					saveSharedPreferences("PayMethod", "1");
				} else if(tab.equals("2")){
					saveSharedPreferences("PayMethod", "2");
					//showDialog("Account->step2->Step3->Step3continue->step4");
				}
				saveSharedPreferences("online", "0");
				Intent i = new Intent(getBaseContext(), Step2Activity.class);
				startActivity(i);
			}
		}
	}
}
