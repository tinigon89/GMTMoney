package com.hindvds.gmtmoney.activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.hindvds.gmtmoney.service.BankService;
import com.hindvds.gmtmoney.R;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ImageView;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class Step3ContActivity extends BaseActivity {

	private boolean isSelectItem = false;

	private ListView lv = null;
	private SimpleAdapter adapter = null;
	private List<HashMap<String, String>> fillMaps;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.remittance_step3_cont);

		lv = (ListView) findViewById(R.id.step3_cont_listview1);
		fillMaps = new ArrayList<HashMap<String, String>>();

		String[] from = null;
		int[] to = null;
		from = new String[] { "step2_item_title", "step2_item_right",
				"step2_item_info", "step2_item_bankid" };
		to = new int[] { R.id.step2_item_title, R.id.step2_item_right,
				R.id.step2_item_info, R.id.step2_item_bankid };
		adapter = new SimpleAdapter(this, fillMaps,
				R.layout.listview_item_step4, from, to);
		lv.setAdapter(adapter);
		lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1,
					int position, long arg3) {
				TextView idSender = (TextView) arg1.findViewById(R.id.step2_item_bankid);
				saveSharedPreferences("bankId", idSender.getText().toString());
				ImageView step3_cont_item_img = (ImageView) arg1
						.findViewById(R.id.step2_item_img);
				step3_cont_item_img.setVisibility(View.VISIBLE);
				isSelectItem = true;
				saveSharedPreferences("step3cont_position", String.valueOf(position));
			}
		});

		initNavButton();
		Button step3_cont_btn_home = (Button) findViewById(R.id.step3_cont_btn_home);
		step3_cont_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		Button step3_cont_btn_new = (Button) findViewById(R.id.step3_cont_btn_new);
		step3_cont_btn_new.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), NewBankActivity.class);
				startActivity(i);
				finish();
			}
		});

		Button step3_cont_next_btn = (Button) findViewById(R.id.step3_cont_next_btn);
		step3_cont_next_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if(isSelectItem){
					if(isSessionExpired){
						showDialogGoHome("Your session has expired!");
						return;
					}
					Intent i = new Intent(getBaseContext(), Step4Activity.class);
					startActivity(i);
				} else {
					showDialog("Please select a bank account.");
				}
			}
		});
		
		new searchProcessAsyncTask().execute(getSharedPreferences("beneId"));
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
				BankService bankService = new BankService();
				listBankInfo = null;
				listBankInfo = bankService.searchBank(aurl[0]);
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
				if (listBankInfo != null || listBankInfo.size() > 0) {
					for (int i = 0; i < listBankInfo.size(); i++) {
						HashMap<String, String> map = new HashMap<String, String>();
						map.put("step2_item_title", listBankInfo.get(i)
								.getBankName());
						map.put("step2_item_right", listBankInfo.get(i)
								.getACNo());
						map.put("step2_item_info", listBankInfo.get(i)
								.getAcHolderName());
						map.put("step2_item_bankid", listBankInfo.get(i)
								.getBankACID());
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
}
