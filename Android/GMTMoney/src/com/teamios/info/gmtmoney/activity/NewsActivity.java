package com.teamios.info.gmtmoney.activity;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.NewsFeedParser;
import com.teamios.info.gmtmoney.service.TransactionHistoryService;
import com.teamios.info.gmtmoney.service.info.RSSFeed;
import com.teamios.info.gmtmoney.service.info.TransactionHistoryInfo;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.Button;
import android.widget.ListView;
import android.widget.SimpleAdapter;
import android.widget.TextView;

public class NewsActivity extends BaseActivity {
	private ListView lv = null;
	private SimpleAdapter adapter = null;
	private List<HashMap<String, String>> fillMaps;
	private NewsFeedParser mNewsFeeder;
	private List<RSSFeed> mRssFeedList;
	private List<TransactionHistoryInfo> listItems;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.news);

		String name = getIntent().getExtras().getString("name");
		lv = (ListView) findViewById(R.id.news_rates_listview1);
		fillMaps = new ArrayList<HashMap<String, String>>();

		String[] from = null;
		int[] to = null;

		final Button news_rates_btn_home = (Button) findViewById(R.id.news_rates_btn_home);
		news_rates_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		TextView news_rates_title = (TextView) findViewById(R.id.news_rates_title);

		if (name.equals("news")) {
			HashMap<String, String> map1 = new HashMap<String, String>();
			map1.put("daily_rates_item_info", "Top News");
			fillMaps.add(map1);

			HashMap<String, String> map2 = new HashMap<String, String>();
			map2.put("daily_rates_item_info", "Business");
			fillMaps.add(map2);

			HashMap<String, String> map3 = new HashMap<String, String>();
			map3.put("daily_rates_item_info", "Science");
			fillMaps.add(map3);

			HashMap<String, String> map4 = new HashMap<String, String>();
			map4.put("daily_rates_item_info", "World");
			fillMaps.add(map4);

			HashMap<String, String> map5 = new HashMap<String, String>();
			map5.put("daily_rates_item_info", "Skynews");
			fillMaps.add(map5);

			HashMap<String, String> map6 = new HashMap<String, String>();
			map6.put("daily_rates_item_info", "US News");
			fillMaps.add(map6);

			HashMap<String, String> map7 = new HashMap<String, String>();
			map7.put("daily_rates_item_info", "Google News");
			fillMaps.add(map7);

			HashMap<String, String> map8 = new HashMap<String, String>();
			map8.put("daily_rates_item_info", "Bollywood News");
			fillMaps.add(map8);

			HashMap<String, String> map9 = new HashMap<String, String>();
			map9.put("daily_rates_item_info", "Under Bollywood");
			fillMaps.add(map9);

			from = new String[] { "daily_rates_item_info" };
			to = new int[] { R.id.daily_rates_item_info };
			adapter = new SimpleAdapter(this, fillMaps,
					R.layout.listview_item_new1, from, to);
			lv.setAdapter(adapter);
			lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
				@Override
				public void onItemClick(AdapterView<?> arg0, View arg1,
						int position, long arg3) {
					TextView title = (TextView) arg1
							.findViewById(R.id.daily_rates_item_info);
					Intent i = new Intent(getBaseContext(), NewsActivity.class);
					i.putExtra("name", "news_feed");
					if (position == 0) {
						i.putExtra("url",
								"http://in.mobile.reuters.com/reuters/rss/TOPIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 1) {
						i.putExtra("url",
								"http://in.mobile.reuters.com/reuters/rss/BUSIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 2) {
						i.putExtra("url",
								"http://in.mobile.reuters.com/reuters/rss/SCIIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 3) {
						i.putExtra("url",
								"http://in.mobile.reuters.com/reuters/rss/WORIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 4) {
						i.putExtra("url",
								"http://www.skynews.com.au/rss/feeds/skynews_business.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 5) {
						i.putExtra("url",
								"http://mobile.reuters.com/reuters/rss/USN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 6) {
						i.putExtra("url",
								"http://mobile.reuters.com/reuters/rss/USN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 7) {
						i.putExtra("url",
								"http://entertainment.oneindia.in/rss/entertainment-bollywood-fb.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 8) {
						i.putExtra("url",
								"http://www.nowrunning.com/cgi-bin/rss/video.xml");
						i.putExtra("title", title.getText().toString());
					}
					startActivity(i);
				}
			});
		}

		if (name.equals("news_feed")) {
			String url = getIntent().getExtras().getString("url");
			String title = getIntent().getExtras().getString("title");
			news_rates_title.setText(title);
			news_rates_btn_home.setBackgroundResource(R.drawable.btn_nav_back);
			from = new String[] { "rss_title_view", "rss_content_view",
					"rss_link" };
			to = new int[] { R.id.rss_title_view, R.id.rss_content_view,
					R.id.rss_link };
			adapter = new SimpleAdapter(this, fillMaps,
					R.layout.listview_item_new2, from, to);
			lv.setAdapter(adapter);
			lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
				@Override
				public void onItemClick(AdapterView<?> arg0, View arg1,
						int position, long arg3) {
					TextView title = (TextView) arg1
							.findViewById(R.id.rss_title_view);
					TextView link = (TextView) arg1.findViewById(R.id.rss_link);
					Intent i = new Intent(getBaseContext(),
							WebViewScreenActivity.class);
					i.putExtra("name", "news");
					i.putExtra("url", link.getText().toString());
					i.putExtra("title", title.getText().toString());
					startActivity(i);
				}
			});

			new GetRssNewsAsyncTask().execute(url);
		}

		if (name.equals("transaction_history")) {
			news_rates_title.setText("Transaction History");
			news_rates_btn_home.setBackgroundResource(R.drawable.btn_nav_back);
			from = new String[] { "transaction_item_left1", "transaction_item_right2", "transaction_item_right3", "daily_rates_value1","daily_rates_value2","daily_rates_value3" ,"transaction_item_right4","transaction_item_right5"};
			to = new int[] { R.id.transaction_item_left1, R.id.transaction_item_right2, R.id.transaction_item_right3 , R.id.daily_rates_value1, R.id.daily_rates_value2, R.id.daily_rates_value3 , R.id.transaction_item_right4, R.id.transaction_item_right5};
			adapter = new SimpleAdapter(this, fillMaps,
					R.layout.listview_item_transaction, from, to);
			lv.setAdapter(adapter);

			new GetTransactionHistoryAsyncTask().execute(getSharedPreferences("RegisterID"));
		}
		
		if (name.equals("find_remittance")) {
			news_rates_title.setText("Transaction List");
			news_rates_btn_home.setBackgroundResource(R.drawable.btn_nav_back);
			from = new String[] { "transaction_item_left1", "transaction_item_right2", "transaction_item_right3", "daily_rates_value1","daily_rates_value2","daily_rates_value3" ,"transaction_item_right4","transaction_item_right5"};
			to = new int[] { R.id.transaction_item_left1, R.id.transaction_item_right2, R.id.transaction_item_right3 , R.id.daily_rates_value1, R.id.daily_rates_value2, R.id.daily_rates_value3 , R.id.transaction_item_right4, R.id.transaction_item_right5};
			adapter = new SimpleAdapter(this, fillMaps, R.layout.listview_item_transaction2, from, to);
			lv.setAdapter(adapter);

			for (int i = 0; i < listResultSearchRemittance.size(); i++) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("transaction_item_left1", "OTT" + listResultSearchRemittance.get(i).getRemitId());
				map.put("transaction_item_right2", listResultSearchRemittance.get(i).getFName1() + " " + listResultSearchRemittance.get(i).getSurName1());
				map.put("transaction_item_right3", listResultSearchRemittance.get(i).getFirstN() + " " + listResultSearchRemittance.get(i).getSurN());
				map.put("daily_rates_value1", listResultSearchRemittance.get(i).getPayAmt() + "000 AUD");
				map.put("daily_rates_value2", listResultSearchRemittance.get(i).getExRate());
				map.put("daily_rates_value3", listResultSearchRemittance.get(i).getForAmt() + "000 " + getCurrSymByCurrMainID(listResultSearchRemittance.get(i).getCurrSym()));
				map.put("transaction_item_right4", listResultSearchRemittance.get(i).getBankName());
				map.put("transaction_item_right5", listResultSearchRemittance.get(i).getACNo());
				fillMaps.add(map);
				adapter.notifyDataSetChanged();
			}
		}
		
		if (name.equals("alerts")) {
			news_rates_title.setText("Alerts");
			news_rates_btn_home.setBackgroundResource(R.drawable.btn_nav_back);
			from = new String[] { "alert_info_currency", "alert_info_email", "alert_info_rate", "alert_info_date","alert_info_type"};
			to = new int[] { R.id.alert_info_currency, R.id.alert_info_email, R.id.alert_info_rate , R.id.alert_info_date, R.id.alert_info_type};
			adapter = new SimpleAdapter(this, fillMaps, R.layout.listview_item_alert, from, to);
			lv.setAdapter(adapter);

			for (int i = 0; i < alertInfo.size(); i++) {
				HashMap<String, String> map = new HashMap<String, String>();
				map.put("alert_info_currency", "AUD/" + getCurrSymByCurrMainID(alertInfo.get(i).getCurrency_id()));
				map.put("alert_info_email", alertInfo.get(i).getEmail());
				map.put("alert_info_rate", alertInfo.get(i).getRate_alert());
				map.put("alert_info_date", alertInfo.get(i).getDate_added());
				map.put("alert_info_type", getTypeAlerts(alertInfo.get(i).getDevice_token()));
				fillMaps.add(map);
				adapter.notifyDataSetChanged();
			}
		}

		initNavButton();
	}
	
	private String getCurrSymByCurrMainID(String currMainID){
		String val = "";
		for (int i = 0; i < listDailyRates.size(); i++) {
			if(listDailyRates.get(i).getCurrID().equals(currMainID)){
				val = listDailyRates.get(i).getCurrSym();
			}
		}
		return val;
	}
	
	private String getTypeAlerts(String token){
		String val = "";
		if(token.equals("")) {
			val = "Email";
		} else {
			val = "Email & Push";
		}
		return val;
	}
	
	private class GetRssNewsAsyncTask extends
			AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			mNewsFeeder = new NewsFeedParser(aurl[0]);
			mRssFeedList = mNewsFeeder.parse();
			publishProgress(1);
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {
			if (progress[0] == 1) {
				for (int i = 0; i < mRssFeedList.size(); i++) {
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("rss_title_view", mRssFeedList.get(i).getTitle());
					map.put("rss_content_view", mRssFeedList.get(i)
							.getDescription());
					map.put("rss_link", mRssFeedList.get(i).getLink());
					fillMaps.add(map);
					adapter.notifyDataSetChanged();
				}
			}
		}

		@Override
		protected void onPostExecute(String unused) {
			closeProcessLoading();
		}
	}

	private class GetTransactionHistoryAsyncTask extends
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
				listItems = null;
				listItems = transactionHistoryService.getTransactionHistory(aurl[0]);
				publishProgress(1);
			} catch (Exception e) {
				e.printStackTrace();
			}
			return null;
		}

		protected void onProgressUpdate(Integer... progress) {
			if (progress[0] == 1) {
				for (int i = 0; i < listItems.size(); i++) {
					HashMap<String, String> map = new HashMap<String, String>();
					map.put("transaction_item_left1", "OTT" + listItems.get(i).getRemitId());
					map.put("transaction_item_right2", listItems.get(i).getFName1() + " " + listItems.get(i).getSurName1());
					map.put("transaction_item_right3", listItems.get(i).getFirstN() + " " + listItems.get(i).getSurN());
					map.put("daily_rates_value1", listItems.get(i).getPayAmt() + "000 AUD");
					map.put("daily_rates_value2", listItems.get(i).getExRate());
					map.put("daily_rates_value3", listItems.get(i).getForAmt() + " " + listItems.get(i).getCurrSym());
					map.put("transaction_item_right4", listItems.get(i).getBankName());
					map.put("transaction_item_right5", listItems.get(i).getACNo());
					fillMaps.add(map);
					adapter.notifyDataSetChanged();
				}
			}
		}

		@Override
		protected void onPostExecute(String unused) {
			closeProcessLoading();
		}
	}
}
