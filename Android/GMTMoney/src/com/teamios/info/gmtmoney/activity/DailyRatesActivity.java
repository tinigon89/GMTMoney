package com.teamios.info.gmtmoney.activity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import com.teamios.info.gmtmoney.R;

import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class DailyRatesActivity extends BaseActivity {
	private ListView lv = null;
	private SimpleAdapter adapter = null;
	private List<HashMap<String, String>> fillMaps;
	private EditText daily_rates_editText1;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.daily_rates);

		lv = (ListView) findViewById(R.id.daily_rates_listview1);
		fillMaps = new ArrayList<HashMap<String, String>>();

		String[] from = null;
		int[] to = null;

		if(getSharedPreferences("isLogin").equals("false")){
			from = new String[] { "daily_rates_item_img", "daily_rates_item_title",
					"daily_rates_item_info", "daily_rates_item_right" };
			to = new int[] { R.id.daily_rates_item_img,
					R.id.daily_rates_item_title, R.id.daily_rates_item_info,
					R.id.daily_rates_item_right };

			adapter = new SimpleAdapter(this, fillMaps,
					R.layout.listview_item_daily_rates, from, to);
		} else if(getSharedPreferences("isLogin").equals("true")){
			from = new String[] { "daily_rates_item_img", "daily_rates_item_title",
					"daily_rates_item_info", "daily_rates_value1", "daily_rates_value2" };
			to = new int[] { R.id.daily_rates_item_img,
					R.id.daily_rates_item_title, R.id.daily_rates_item_info,R.id.daily_rates_value1 ,R.id.daily_rates_value2 };

			adapter = new SimpleAdapter(this, fillMaps,
					R.layout.listview_item_daily_rates2, from, to);
		} else {
			from = new String[] { "daily_rates_item_img", "daily_rates_item_title",
					"daily_rates_item_info", "daily_rates_item_right" };
			to = new int[] { R.id.daily_rates_item_img,
					R.id.daily_rates_item_title, R.id.daily_rates_item_info,
					R.id.daily_rates_item_right };

			adapter = new SimpleAdapter(this, fillMaps,
					R.layout.listview_item_daily_rates, from, to);
		}
		
		lv.setAdapter(adapter);
		
		new RefreshDailyRatesAsyncTask().execute("");

		initNavButton();
		Button daily_rates_btn_home = (Button) findViewById(R.id.daily_rates_btn_home);
		daily_rates_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		Button daily_rates_btn_refesh = (Button) findViewById(R.id.daily_rates_btn_refesh);
		daily_rates_btn_refesh.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				new RefreshDailyRatesAsyncTask().execute("");
			}
		});

		daily_rates_editText1 = (EditText) findViewById(R.id.daily_rates_editText1);
		daily_rates_editText1.addTextChangedListener(new TextWatcher() {

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
				String text = daily_rates_editText1.getText().toString()
						.toLowerCase(Locale.getDefault());
				adapter.getFilter().filter(text);
			}
		});

		DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
		Date date = new Date();
		final TextView daily_rates_lastupdate = (TextView) findViewById(R.id.daily_rates_lastupdate);
		daily_rates_lastupdate.setText("Last update: "
				+ dateFormat.format(date));

		Button daily_rates_search_clear = (Button) findViewById(R.id.daily_rates_search_clear);
		daily_rates_search_clear.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				daily_rates_editText1.setText("");
				InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
				imm.hideSoftInputFromWindow(daily_rates_editText1.getWindowToken(), 0);
			}
		});
	}

	private class RefreshDailyRatesAsyncTask extends
			AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				listDailyRates = null;
				listDailyRates = getListDailyRatesInfo();
				publishProgress(1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {
			if (progress[0] == 1) {
				fillMaps.clear();
				adapter.notifyDataSetChanged();
				lv.setAdapter(adapter);
				for (int i = 0; i < listDailyRates.size(); i++) {
					if (!listDailyRates.get(i).getCurrSym().equals("AUD")) {
						HashMap<String, String> map = new HashMap<String, String>();
						String flag = listDailyRates.get(i).getCurrSym();
						flag = flag.substring(0, 2);
						flag = flag.toLowerCase();
						if(getSharedPreferences("isLogin").equals("false")){
							map.put("daily_rates_item_img",
									"android.resource://com.teamios.info.gmtmoney/"
											+ getResources().getIdentifier(
													"drawable/" + flag, null,
													getPackageName()));
							map.put("daily_rates_item_title", listDailyRates.get(i)
									.getCurrSym());
							map.put("daily_rates_item_info", listDailyRates.get(i)
									.getCurText());
							map.put("daily_rates_item_right", listDailyRates.get(i)
									.getERate());
						} else if(getSharedPreferences("isLogin").equals("true")){
							map.put("daily_rates_item_img",
									"android.resource://com.teamios.info.gmtmoney/"
											+ getResources().getIdentifier(
													"drawable/" + flag, null,
													getPackageName()));
							map.put("daily_rates_item_title", listDailyRates.get(i)
									.getCurrSym());
							map.put("daily_rates_item_info", listDailyRates.get(i)
									.getCurText());
							map.put("daily_rates_value1", listDailyRates.get(i)
									.getERate());
							map.put("daily_rates_value2", listDailyRates.get(i)
									.getERateS());
						} else {
							map.put("daily_rates_item_img",
									"android.resource://com.teamios.info.gmtmoney/"
											+ getResources().getIdentifier(
													"drawable/" + flag, null,
													getPackageName()));
							map.put("daily_rates_item_title", listDailyRates.get(i)
									.getCurrSym());
							map.put("daily_rates_item_info", listDailyRates.get(i)
									.getCurText());
							map.put("daily_rates_item_right", listDailyRates.get(i)
									.getERate());
						}
						fillMaps.add(map);
						adapter.notifyDataSetChanged();
					}
				}
				DateFormat dateFormat = new SimpleDateFormat("MM/dd/yyyy HH:mm");
				Date date = new Date();
				TextView daily_rates_lastupdate = (TextView) findViewById(R.id.daily_rates_lastupdate);
				daily_rates_lastupdate.setText("Last update: "
						+ dateFormat.format(date));
			}
		}

		@Override
		protected void onPostExecute(String unused) {
			closeProcessLoading();
		}
	}
}
