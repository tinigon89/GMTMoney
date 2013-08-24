package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.os.Bundle;
import android.util.Log;
import android.view.View;
import android.webkit.WebView;
import android.webkit.WebViewClient;
import android.widget.Button;
import android.widget.TextView;

public class WebViewScreenActivity extends BaseActivity {

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.webviewscreen);
		
		String name = getIntent().getExtras().getString("name");
		String website = null;
		TextView webview_bar1_title = (TextView) findViewById(R.id.webview_bar1_title);
		WebView webview = (WebView) findViewById(R.id.webview_webview);
		webview.getSettings().setJavaScriptEnabled(true);
		Button webview_btn_home = (Button) findViewById(R.id.webview_btn_home);
		webview_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		if (name.equals("home_btn_cash")) {
			website = "https://instantcashworldwide.ae/InstantcashworldwideOffload/agentsearch_en.aspx";
			webview_bar1_title.setText("Cash Locations");
		} else if (name.equals("home_btn_ifsc")) {
			website = "http://bankifsccode.com/";
			webview_bar1_title.setText("IFSC Locator");
		} else if (name.equals("news")) {
			String url = getIntent().getExtras().getString("url");
			Log.d("rss url", url);
			String title = getIntent().getExtras().getString("title");
			website = url;
			webview_bar1_title.setText(title);
			webview.getSettings().setBuiltInZoomControls(true);
			webview.getSettings().setSupportZoom(true);
			webview.setWebViewClient(new WebViewClient());
			webview_btn_home.setBackgroundResource(R.drawable.btn_nav_back);
		} 
		webview.loadUrl(website);
		
		initNavButton();
		
	}
}
