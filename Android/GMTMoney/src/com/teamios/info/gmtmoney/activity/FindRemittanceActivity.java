package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.TransactionHistoryService;

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

public class FindRemittanceActivity extends BaseActivity {

	private EditText find_search_text;
	private AutoCompleteTextView find_by_select;
	private Button find_search_btn;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.find_remittance);

		initNavButton();
		Button find_btn_home = (Button) findViewById(R.id.find_btn_home);
		find_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		find_search_btn = (Button) findViewById(R.id.find_search_btn);
		find_search_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				new searchProcessAsyncTask().execute(
						getSharedPreferences("RegisterID"),
						(String) find_by_select.getTag(), find_search_text
								.getText().toString());
			}
		});

		find_search_text = (EditText) findViewById(R.id.find_search_text);
		find_by_select = (AutoCompleteTextView) findViewById(R.id.find_by_select);
		String[] searchBy = { "OTT", "First Name", "Last Name",
				"Business Name", "Phone Number" };
		find_by_select.setFocusable(false);
		find_by_select.setFocusableInTouchMode(false);
		find_by_select.setText("OTT");
		find_by_select.setTag("0");
		find_by_select.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, searchBy));
		Button find_by_select_btn = (Button) findViewById(R.id.find_by_select_btn);
		find_by_select_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				find_by_select.showDropDown();
			}
		});
		find_by_select.addTextChangedListener(new TextWatcher() {

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
				if (find_by_select.getText().toString().equals("OTT")) {
					find_by_select.setTag("0");
				} else if (find_by_select.getText().toString()
						.equals("First Name")) {
					find_by_select.setTag("1");
				} else if (find_by_select.getText().toString()
						.equals("Last Name")) {
					find_by_select.setTag("2");
				} else if (find_by_select.getText().toString()
						.equals("Business Name")) {
					find_by_select.setTag("3");
				} else if (find_by_select.getText().toString()
						.equals("Phone Number")) {
					find_by_select.setTag("4");
				}
			}
		});
	}

	private class searchProcessAsyncTask extends
			AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				TransactionHistoryService transactionHistoryService = new TransactionHistoryService();
				listResultSearchRemittance = null;
				listResultSearchRemittance = transactionHistoryService
						.searchRemittance(aurl[0], aurl[1], aurl[2]);
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
			try {
				if (listResultSearchRemittance != null
						|| listResultSearchRemittance.size() > 0) {
					Intent i = new Intent(getBaseContext(), NewsActivity.class);
					i.putExtra("name", "find_remittance");
					startActivity(i);
				} else {
					showDialog("No Sullt");
				}
			} catch (Exception e) {
				e.printStackTrace();
				showDialog("No Sullt");
			}
		}
	}
}
