package com.teamios.info.gmtmoney.activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.SenderService;
import com.teamios.info.gmtmoney.service.info.SenderInfo;

import android.content.Intent;
import android.graphics.Color;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.AbsListView;
import android.widget.AbsListView.OnScrollListener;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SimpleAdapter;

public class Step2Activity extends BaseActivity {

	private EditText step2_search_text;
	private AutoCompleteTextView step2_by_select;
	private Button step2_search_btn;
	private boolean isSelectItem = false;

	private ListView lv = null;
	private SimpleAdapter adapter = null;
	private List<HashMap<String, String>> fillMaps;
	private List<SenderInfo> listSenderInfo = null;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.remittance_step2);

		lv = (ListView) findViewById(R.id.step2_listview1);
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
				ImageView step2_item_img = (ImageView) arg1.findViewById(R.id.step2_item_img);
				step2_item_img.setVisibility(View.VISIBLE);
			}
		});

		initNavButton();
		Button step2_btn_home = (Button) findViewById(R.id.step2_btn_home);
		step2_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button step2_btn_new = (Button) findViewById(R.id.step2_btn_new);
		step2_btn_new.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), NewSenderActivity.class);
				startActivity(i);
			}
		});

		step2_search_text = (EditText) findViewById(R.id.step2_search_text);
		step2_by_select = (AutoCompleteTextView) findViewById(R.id.step2_by_select);
		String[] searchBy = { "First Name", "Sur Name", "Company Name", "Phone" };
		step2_by_select.setFocusable(false);
		step2_by_select.setFocusableInTouchMode(false);
		step2_by_select.setText("First Name");
		step2_by_select.setTag("0");
		step2_by_select.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, searchBy));
		Button step2_by_select_btn = (Button) findViewById(R.id.step2_by_select_btn);
		step2_by_select_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				step2_by_select.showDropDown();
			}
		});
		step2_by_select.addTextChangedListener(new TextWatcher() {

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
				if (step2_by_select.getText().toString().equals("First Name")) {
					step2_by_select.setTag("0");
				} else if (step2_by_select.getText().toString()
						.equals("Sur Name")) {
					step2_by_select.setTag("1");
				} else if (step2_by_select.getText().toString()
						.equals("Company Name")) {
					step2_by_select.setTag("2");
				} else if (step2_by_select.getText().toString().equals("Phone")) {
					step2_by_select.setTag("3");
				}
			}
		});

		step2_search_btn = (Button) findViewById(R.id.step2_search_btn);
		step2_search_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
				imm.hideSoftInputFromWindow(step2_search_text.getWindowToken(),
						0);
				new searchProcessAsyncTask().execute(
						getSharedPreferences("RegisterID"),
						(String) step2_by_select.getTag(), step2_search_text
								.getText().toString());
			}
		});
		
		Button step2_next_btn = (Button) findViewById(R.id.step2_next_btn);
		step2_next_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), Step3Activity.class);
				startActivity(i);
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
				SenderService senderService = new SenderService();
				listSenderInfo = null;
				listSenderInfo = senderService.searchSender(aurl[0], aurl[1],
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
				if (listSenderInfo != null || listSenderInfo.size() > 0) {
					for (int i = 0; i < listSenderInfo.size(); i++) {
						HashMap<String, String> map = new HashMap<String, String>();
						map.put("step2_item_title", listSenderInfo.get(i)
								.getFName()
								+ " "
								+ listSenderInfo.get(i).getSurName());
						map.put("step2_item_right", listSenderInfo.get(i)
								.getSendersID());
						map.put("step2_item_info", listSenderInfo.get(i)
								.getRStreet()
								+ "\n"
								+ listSenderInfo.get(i).getRSub()
								+ ", "
								+ listSenderInfo.get(i).getRState()
								+ ", "
								+ listSenderInfo.get(i).getRPost());
						fillMaps.add(map);
						adapter.notifyDataSetChanged();
					}
				} else {
					// showDialog("No Sullt");
				}
			} catch (Exception e) {
				e.printStackTrace();
				// showDialog("No Sullt");
			}
		}
	}
}
