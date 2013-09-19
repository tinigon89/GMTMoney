package com.hindvds.gmtmoney.activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.hindvds.gmtmoney.service.BeneficiaryService;
import com.hindvds.gmtmoney.service.RemittanceService;
import com.hindvds.gmtmoney.R;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class Step3Activity extends BaseActivity {

	private EditText step3_search_text;
	private AutoCompleteTextView step3_by_select;
	private Button step3_search_btn;
	private boolean isSelectItem = false;

	private ListView lv = null;
	private SimpleAdapter adapter = null;
	private List<HashMap<String, String>> fillMaps;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.remittance_step3);

		checkSessionExpired();
		lv = (ListView) findViewById(R.id.step3_listview1);
		fillMaps = new ArrayList<HashMap<String, String>>();

		String[] from = null;
		int[] to = null;
		from = new String[] { "step2_item_title", "step2_item_right",
				"step2_item_info" };
		to = new int[] { R.id.step2_item_title, R.id.step2_item_right,
				R.id.step2_item_info };
		adapter = new SimpleAdapter(this, fillMaps,
				R.layout.listview_item_step2, from, to);
		lv.setAdapter(adapter);
		lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {
				TextView idSender = (TextView) arg1.findViewById(R.id.step2_item_right);
				saveSharedPreferences("beneId", idSender.getText().toString());
				ImageView step3_item_img = (ImageView) arg1
						.findViewById(R.id.step2_item_img);
				step3_item_img.setVisibility(View.VISIBLE);
				isSelectItem = true;
				saveSharedPreferences("step3_position", String.valueOf(position));
			}
		});

		initNavButton();
		Button step3_btn_home = (Button) findViewById(R.id.step3_btn_home);
		step3_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		Button step3_btn_new = (Button) findViewById(R.id.step3_btn_new);
		step3_btn_new.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), NewBeneficiaryActivity.class);
				startActivity(i);
			}
		});

		step3_search_text = (EditText) findViewById(R.id.step3_search_text);
		step3_by_select = (AutoCompleteTextView) findViewById(R.id.step3_by_select);
		String[] searchBy = { "First Name", "Sur Name", "Company Name", "Phone" };
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
				if (step3_by_select.getText().toString().equals("First Name")) {
					step3_by_select.setTag("0");
				} else if (step3_by_select.getText().toString()
						.equals("Sur Name")) {
					step3_by_select.setTag("1");
				} else if (step3_by_select.getText().toString()
						.equals("Company Name")) {
					step3_by_select.setTag("2");
				} else if (step3_by_select.getText().toString().equals("Phone")) {
					step3_by_select.setTag("3");
				}
			}
		});

		step3_search_btn = (Button) findViewById(R.id.step3_search_btn);
		step3_search_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
				imm.hideSoftInputFromWindow(step3_search_text.getWindowToken(),
						0);
				new searchProcessAsyncTask().execute(
						getSharedPreferences("RegisterID"),
						(String) step3_by_select.getTag(), step3_search_text
								.getText().toString());
			}
		});

		Button step3_next_btn = (Button) findViewById(R.id.step3_next_btn);
		step3_next_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if(isSelectItem){
					if(isSessionExpired){
						showDialogGoHome("Your session has expired!");
						return;
					}
					new submitAsyncTask().execute(
							getSharedPreferences("RegisterID"),
							getSharedPreferences("remid"),
							getSharedPreferences("beneId"),
							getSharedPreferences("PayMethod"),
							getSharedPreferences("online"));
				} else {
					showDialog("Please select a beneficiary.");
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
				BeneficiaryService beneficiaryService = new BeneficiaryService();
				listBeneficiaryInfo = null;
				listBeneficiaryInfo = beneficiaryService.searchBeneficiary(aurl[0], aurl[1],
						aurl[2]);
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
			fillMaps.clear();
			adapter.notifyDataSetChanged();
			try {
				if (listBeneficiaryInfo != null || listBeneficiaryInfo.size() > 0) {
					for (int i = 0; i < listBeneficiaryInfo.size(); i++) {
						HashMap<String, String> map = new HashMap<String, String>();
						map.put("step2_item_title", listBeneficiaryInfo.get(i)
								.getFirstN()
								+ " "
								+ listBeneficiaryInfo.get(i).getSurN());
						map.put("step2_item_right", listBeneficiaryInfo.get(i)
								.getBeneficiaryID());
						map.put("step2_item_info", listBeneficiaryInfo.get(i)
								.getAddL1()
								+ "\n"
								+ listBeneficiaryInfo.get(i).getCityy()
								+ ", "
								+ listBeneficiaryInfo.get(i).getStates()
								+ ", "
								+ listBeneficiaryInfo.get(i).getPostCode());
						fillMaps.add(map);
						adapter.notifyDataSetChanged();
					}
				} else {
					// showDialog("No Result");
				}
			} catch (Exception e) {
				e.printStackTrace();
				// showDialog("No Result");
			}
		}
	}

	private class submitAsyncTask extends AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				RemittanceService remittanceService = new RemittanceService();
				remittanceService.submitStep3(aurl[0], aurl[1], aurl[2],
						aurl[3], aurl[4]);
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
				if(getSharedPreferences("PayMethod").equals("1")){
					Intent i = new Intent(getBaseContext(), Step4Activity.class);
					startActivity(i);
				} else {
					Intent i = new Intent(getBaseContext(), Step3ContActivity.class);
					startActivity(i);
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
