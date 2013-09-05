package com.teamios.info.gmtmoney.activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

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
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class Step3Activity extends BaseActivity {

	private EditText step3_search_text;
	private AutoCompleteTextView step3_by_select;
	private Button step3_search_btn;
	
	private ListView lv = null;
	private SimpleAdapter adapter = null;
	private List<HashMap<String, String>> fillMaps;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.remittance_step3);
		
		lv = (ListView) findViewById(R.id.step3_listview1);
		fillMaps = new ArrayList<HashMap<String, String>>();

		String[] from = null;
		int[] to = null;
		from = new String[] { "step2_item_title", "step2_item_right", "step2_item_info"};
		to = new int[] { R.id.step2_item_title, R.id.step2_item_right, R.id.step2_item_info };
		adapter = new SimpleAdapter(this, fillMaps, R.layout.listview_item_step2, from, to);
		lv.setAdapter(adapter);

		initNavButton();
		Button step3_btn_home = (Button) findViewById(R.id.step3_btn_home);
		step3_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		step3_search_btn = (Button) findViewById(R.id.step3_search_btn);
		step3_search_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				new searchProcessAsyncTask().execute(
						getSharedPreferences("RegisterID"),
						(String) step3_by_select.getTag(), step3_search_text
								.getText().toString());
			}
		});

		step3_search_text = (EditText) findViewById(R.id.step3_search_text);
		step3_by_select = (AutoCompleteTextView) findViewById(R.id.step3_by_select);
		String[] searchBy = { "First Name", "Sur Name",
				"Company Name", "Phone" };
		step3_by_select.setFocusable(false);
		step3_by_select.setFocusableInTouchMode(false);
		step3_by_select.setText("First Name");
		step3_by_select.setTag("0");
		step3_by_select.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, searchBy));
		Button step3_by_select_btn = (Button) findViewById(R.id.step3_by_select_btn);
		step3_by_select_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				step3_by_select.showDropDown();
			}
		});
		step3_by_select.addTextChangedListener(new TextWatcher() {

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
				if (step3_by_select.getText().toString()
						.equals("First Name")) {
					step3_by_select.setTag("0");
				} else if (step3_by_select.getText().toString()
						.equals("Sur Name")) {
					step3_by_select.setTag("1");
				} else if (step3_by_select.getText().toString()
						.equals("Company Name")) {
					step3_by_select.setTag("2");
				} else if (step3_by_select.getText().toString()
						.equals("Phone")) {
					step3_by_select.setTag("3");
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
					i.putExtra("name", "step3_remittance");
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
