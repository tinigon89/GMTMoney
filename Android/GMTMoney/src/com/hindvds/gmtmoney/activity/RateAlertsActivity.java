package com.hindvds.gmtmoney.activity;

import static com.hindvds.gmtmoney.common.CommonUtilities.DISPLAY_MESSAGE_ACTION;
import static com.hindvds.gmtmoney.common.CommonUtilities.SENDER_ID;

import java.util.ArrayList;
import java.util.UUID;
import java.util.regex.Pattern;

import com.google.android.gcm.GCMRegistrar;
import com.hindvds.gmtmoney.service.RateAlertsService;
import com.hindvds.gmtmoney.R;

import android.content.BroadcastReceiver;
import android.content.Context;
import android.content.Intent;
import android.content.IntentFilter;
import android.content.SharedPreferences;
import android.content.SharedPreferences.Editor;
import android.os.AsyncTask;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.util.Log;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.Toast;

public class RateAlertsActivity extends BaseActivity {
	AsyncTask<Void, Void, Void> mRegisterTask;
	private String currencyId;
	private String tokenString;
	private static String uniqueID = null;
	private static final String PREF_UNIQUE_ID = "PREF_UNIQUE_ID";
	public final Pattern EMAIL_ADDRESS_PATTERN = Pattern
			.compile("[a-zA-Z0-9\\+\\.\\_\\%\\-\\+]{1,256}" + "\\@"
					+ "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,64}" + "(" + "\\."
					+ "[a-zA-Z0-9][a-zA-Z0-9\\-]{0,25}" + ")+");

	private EditText rate_alert_email, rate_alert_pair_from, rate_alerts_rate;
	private AutoCompleteTextView rate_alert_pair_with;
	private CheckBox rate_alert_checkbox_notification;
	private Button rate_alert_pair_with_btn;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.rate_alert);

		rate_alert_email = (EditText) findViewById(R.id.rate_alert_email);
		rate_alert_pair_from = (EditText) findViewById(R.id.rate_alert_pair_from);
		rate_alerts_rate = (EditText) findViewById(R.id.rate_alerts_rate);
		rate_alert_pair_with = (AutoCompleteTextView) findViewById(R.id.rate_alert_pair_with);
		rate_alert_checkbox_notification = (CheckBox) findViewById(R.id.rate_alert_checkbox_notification);
		rate_alert_pair_with_btn = (Button) findViewById(R.id.rate_alert_pair_with_btn);
		rate_alert_pair_from.setFocusable(false);
		rate_alert_pair_from.setFocusableInTouchMode(false);
		rate_alert_pair_with.setFocusable(false);
		rate_alert_pair_with.setFocusableInTouchMode(false);

		initCurrencyWith();

		initNavButton();
		Button rate_alerts_btn_home = (Button) findViewById(R.id.rate_alerts_btn_home);
		rate_alerts_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		Button rate_alert_me = (Button) findViewById(R.id.rate_alert_me);
		rate_alert_me.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				validateFields();
			}
		});

		Button rate_alert_me_notify = (Button) findViewById(R.id.rate_alert_me_notify);
		rate_alert_me_notify.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				new getAlertsListAsyncTask().execute("");
			}
		});

		if (getSharedPreferences("device_id").equals("")) {
			saveSharedPreferences("device_id", deviceId(this));
		}

		registPushNotification();

	}

	private void initCurrencyWith() {
		ArrayList<String> item = new ArrayList<String>();
		for (int i = 0; i < listDailyRates.size(); i++) {
			item.add(listDailyRates.get(i).getCurrSym());
		}
		rate_alert_pair_with.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, item));
		rate_alert_pair_with_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				rate_alert_pair_with.showDropDown();
			}
		});

		rate_alert_pair_with.addTextChangedListener(new TextWatcher() {

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
				for (int i = 0; i < listDailyRates.size(); i++) {
					if (listDailyRates.get(i).getCurrSym()
							.equals(rate_alert_pair_with.getText().toString())) {
						currencyId = listDailyRates.get(i).getCurrID();
					}
				}
			}
		});
	}

	private void validateFields() {
		if (!checkEmail(rate_alert_email.getText().toString())) {
			showDialog("Email invalid");
		} else if (rate_alert_pair_with.getText().toString().equals("")) {
			showDialog("Please select currency!");
		} else if (rate_alerts_rate.getText().toString().equals("")) {
			showDialog("Please enter rate alert!");
		} else {
			// showDialog("Successful!");
			if (!rate_alert_checkbox_notification.isChecked()) {
				tokenString = "";
			} else {
				tokenString = getSharedPreferences("tokenString");
			}
			new RateAlertAsyncTask().execute(rate_alert_email.getText()
					.toString(), currencyId, tokenString, rate_alerts_rate
					.getText().toString());
		}
	}

	public synchronized static String deviceId(Context context) {
		if (uniqueID == null) {
			SharedPreferences sharedPrefs = context.getSharedPreferences(
					PREF_UNIQUE_ID, Context.MODE_PRIVATE);
			uniqueID = sharedPrefs.getString(PREF_UNIQUE_ID, null);
			if (uniqueID == null) {
				uniqueID = UUID.randomUUID().toString();
				Editor editor = sharedPrefs.edit();
				editor.putString(PREF_UNIQUE_ID, uniqueID);
				editor.commit();
			}
		}
		return uniqueID;
	}

	private void registPushNotification() {
		// Make sure the device has the proper dependencies.
		GCMRegistrar.checkDevice(this);
		GCMRegistrar.checkManifest(this);

		registerReceiver(mHandleMessageReceiver, new IntentFilter(
				DISPLAY_MESSAGE_ACTION));
		// Get GCM registration id
		final String regId = GCMRegistrar.getRegistrationId(this);

		if (regId.equals("")) {
			// Registration is not present, register now with GCM
			GCMRegistrar.register(this, SENDER_ID);
		} else {
			// Device is already registered on GCM
			if (GCMRegistrar.isRegisteredOnServer(this)) {
				// Skips registration.
				Toast.makeText(getApplicationContext(),
						"Already registered with GCM", Toast.LENGTH_LONG)
						.show();
			} else {
				// Try to register again, but not in the UI thread.
				// It's also necessary to cancel the thread onDestroy(),
				// hence the use of AsyncTask instead of a raw thread.
				mRegisterTask = new AsyncTask<Void, Void, Void>() {

					@Override
					protected Void doInBackground(Void... params) {
						// Register on our server
						// On server creates a new user
						saveSharedPreferences("tokenString", regId);
						Log.d("regisToken", tokenString);
						return null;
					}

					@Override
					protected void onPostExecute(Void result) {
						mRegisterTask = null;
					}

				};
				mRegisterTask.execute(null, null, null);
			}
		}
	}

	/**
	 * Receiving push messages
	 * */
	private final BroadcastReceiver mHandleMessageReceiver = new BroadcastReceiver() {
		@Override
		public void onReceive(Context context, Intent intent) {
			// Waking up mobile if it is sleeping
			WakeLocker.acquire(getApplicationContext());

			/**
			 * Take appropriate action on this message depending upon your app
			 * requirement For now i am just displaying it on the screen
			 * */
			// Releasing wake lock
			WakeLocker.release();
		}
	};

	@Override
	protected void onDestroy() {
		if (mRegisterTask != null) {
			mRegisterTask.cancel(true);
		}
		try {
			unregisterReceiver(mHandleMessageReceiver);
			GCMRegistrar.onDestroy(this);
		} catch (Exception e) {
			Log.e("UnRegister Receiver Error", "> " + e.getMessage());
		}
		super.onDestroy();
	}

	private class RateAlertAsyncTask extends AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				RateAlertsService rateAlertsService = new RateAlertsService();
				rateAlertsService.registerAler(getBaseContext(),
						getSharedPreferences("device_id"), aurl[0], aurl[2],
						"0", aurl[1], aurl[3]);
				// rateAlertsService.checkAlertInfo(getBaseContext(),getSharedPreferences("device_id"),currencyId);
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
			finish();
		}
	}

	private class getAlertsListAsyncTask extends
			AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				RateAlertsService rateAlertsService = new RateAlertsService();
				alertInfo = null;
				alertInfo = rateAlertsService.getAlertInfo(getBaseContext(), getSharedPreferences("device_id"));
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
			if (alertInfo != null || alertInfo.size() > 0) {
				Intent i = new Intent(getBaseContext(), NewsActivity.class);
				i.putExtra("name", "alerts");
				startActivity(i);
			} else {
				showDialog("No Result");
			}
		}
	}
}
