package com.teamios.info.gmtmoney.activity;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.teamios.info.gmtmoney.R;
import com.teamios.info.gmtmoney.service.NewsFeedParser;
import com.teamios.info.gmtmoney.service.info.RSSFeed;

import android.R.drawable;
import android.R.raw;
import android.content.Intent;
import android.graphics.drawable.Drawable;
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

		if(name.equals("news")){
			HashMap<String, String> map1 = new HashMap<String, String>();
			map1.put("daily_rates_item_info","Top News");
			fillMaps.add(map1);
			
			HashMap<String, String> map2 = new HashMap<String, String>();
			map2.put("daily_rates_item_info","Business");
			fillMaps.add(map2);
			
			HashMap<String, String> map3 = new HashMap<String, String>();
			map3.put("daily_rates_item_info","Science");
			fillMaps.add(map3);
			
			HashMap<String, String> map4 = new HashMap<String, String>();
			map4.put("daily_rates_item_info","World");
			fillMaps.add(map4);
			
			HashMap<String, String> map5 = new HashMap<String, String>();
			map5.put("daily_rates_item_info","Skynews");
			fillMaps.add(map5);
			
			HashMap<String, String> map6 = new HashMap<String, String>();
			map6.put("daily_rates_item_info","US News");
			fillMaps.add(map6);
			
			HashMap<String, String> map7 = new HashMap<String, String>();
			map7.put("daily_rates_item_info","Google News");
			fillMaps.add(map7);
			
			HashMap<String, String> map8 = new HashMap<String, String>();
			map8.put("daily_rates_item_info","Bollywood News");
			fillMaps.add(map8);
			
			HashMap<String, String> map9 = new HashMap<String, String>();
			map9.put("daily_rates_item_info","Under Bollywood");
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
					TextView title = (TextView) arg1.findViewById(R.id.daily_rates_item_info);
					Intent i = new Intent(getBaseContext(), NewsActivity.class);
					i.putExtra("name", "news_feed");
					if (position == 0) {
						i.putExtra("url", "http://in.mobile.reuters.com/reuters/rss/TOPIN.xml");
						i.putExtra("title", title.getText().toString());
					} 
					if (position == 1) {
						i.putExtra("url", "http://in.mobile.reuters.com/reuters/rss/BUSIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 2) {
						i.putExtra("url", "http://in.mobile.reuters.com/reuters/rss/SCIIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 3) {
						i.putExtra("url", "http://in.mobile.reuters.com/reuters/rss/WORIN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 4) {
						i.putExtra("url", "http://www.skynews.com.au/rss/feeds/skynews_business.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 5) {
						i.putExtra("url", "http://mobile.reuters.com/reuters/rss/USN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 6) {
						i.putExtra("url", "http://mobile.reuters.com/reuters/rss/USN.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 7) {
						i.putExtra("url", "http://entertainment.oneindia.in/rss/entertainment-bollywood-fb.xml");
						i.putExtra("title", title.getText().toString());
					}
					if (position == 8) {
						i.putExtra("url", "http://www.nowrunning.com/cgi-bin/rss/video.xml");
						i.putExtra("title", title.getText().toString());
					}
					startActivity(i);
				}
			});
		}
		
		if(name.equals("news_feed")){
			String url = getIntent().getExtras().getString("url");
			String title = getIntent().getExtras().getString("title");
			news_rates_title.setText(title);
			news_rates_btn_home.setBackgroundResource(R.drawable.btn_nav_back);
			from = new String[] { "rss_title_view", "rss_content_view", "rss_link" };
			to = new int[] { R.id.rss_title_view, R.id.rss_content_view, R.id.rss_link };
			adapter = new SimpleAdapter(this, fillMaps, R.layout.listview_item_new2, from, to);
			lv.setAdapter(adapter);
			lv.setOnItemClickListener(new AdapterView.OnItemClickListener() {
				@Override
				public void onItemClick(AdapterView<?> arg0, View arg1,
						int position, long arg3) {
					TextView title = (TextView) arg1.findViewById(R.id.rss_title_view);
					TextView link = (TextView) arg1.findViewById(R.id.rss_link);
					Intent i = new Intent(getBaseContext(), WebViewScreenActivity.class);
					i.putExtra("name", "news");
					i.putExtra("url", link.getText().toString());
					i.putExtra("title", title.getText().toString());
					startActivity(i);
				}
			});
			
			new GetRssNewsAsyncTask().execute(url);
		}
		
		initNavButton();
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
					map.put("rss_content_view", mRssFeedList.get(i).getDescription());
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
}
