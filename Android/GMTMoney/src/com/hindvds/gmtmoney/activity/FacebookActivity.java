package com.hindvds.gmtmoney.activity;

import java.io.ByteArrayOutputStream;

import com.hindvds.gmtmoney.R;
import com.facebook.HttpMethod;
import com.facebook.LoggingBehavior;
import com.facebook.Request;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.SessionState;
import com.facebook.Settings;

import android.app.ProgressDialog;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

@SuppressWarnings("deprecation")
public class FacebookActivity extends BaseActivity {
	private static final String[] FACEBOOK_PERMISSION = { "user_photos",
			"publish_checkins", "publish_actions", "publish_stream", "email",
			"user_groups", "read_stream", "user_about_me", "offline_access" };
	String picpath = "";
	private Session.StatusCallback statusCallback = new SessionStatusCallback();
	private ProgressDialog mProgress;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.facebook);
		mProgress = new ProgressDialog(this);
		Settings.addLoggingBehavior(LoggingBehavior.INCLUDE_ACCESS_TOKENS);

		Session session = Session.getActiveSession();
		if (session == null) {
			if (savedInstanceState != null) {
				session = Session.restoreSession(this, null, statusCallback,
						savedInstanceState);
			}
			if (session == null) {
				session = new Session(this);
			}
			Session.setActiveSession(session);
			if (session.getState().equals(SessionState.CREATED_TOKEN_LOADED)) {
				session.openForRead(new Session.OpenRequest(this)
						.setCallback(statusCallback));
			}
		}

		initNavButton();
		Button facebook_btn_home = (Button) findViewById(R.id.facebook_btn_home);
		facebook_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		Button facebook_btn = (Button) findViewById(R.id.facebook_btn);
		facebook_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Session ss = Session.getActiveSession();
				if (ss.isOpened()) {
					postImage();
				} else {
					onLogin();
				}
			}
		});
	}
	
	@Override
	protected void onSaveInstanceState(Bundle outState) {
		super.onSaveInstanceState(outState);
		Session ss = Session.getActiveSession();
		Session.saveSession(ss, outState);
	}

	@Override
	protected void onStart() {
		super.onStart();
		Session.getActiveSession().addCallback(statusCallback);
	}

	@Override
	protected void onStop() {
		super.onStop();
		Session.getActiveSession().removeCallback(statusCallback);
	}

	private void postImage() {
		Session session = Session.getActiveSession();
		if (session != null) {
			mProgress.setMessage("Posting ...");
			mProgress.show();

			Bundle postParams = new Bundle();

			byte[] data = null;
			Bitmap bi = BitmapFactory.decodeResource(getResources(), R.drawable.banner);
			ByteArrayOutputStream baos = new ByteArrayOutputStream();
			bi.compress(Bitmap.CompressFormat.PNG, 100, baos);
			data = baos.toByteArray();
			postParams.putByteArray("picture", data);
			postParams.putString("caption", "GMT Money Transfer and Exchange");

			Request.Callback callback = new Request.Callback() {
				public void onCompleted(Response response) {
					mProgress.cancel();
//					Toast.makeText(FacebookActivity.this, "Success!",
//							Toast.LENGTH_SHORT).show();
				}
			};

			Request.executeRestRequestAsync(session, "photos.upload",
					postParams, HttpMethod.POST);
			mProgress.cancel();
//			Toast.makeText(FacebookActivity.this, "Success!", Toast.LENGTH_LONG)
//					.show();
			if(getSharedPreferences("remaing_sms").equals("")){
				saveSharedPreferences("remaing_sms","0");
			}
			saveSharedPreferences("remaing_sms",String.valueOf(Integer.parseInt(getSharedPreferences("remaing_sms")) + 10));
			finish();
		}
	}

	private void onLogin() {
		Session session = Session.getActiveSession();
		if (!session.isOpened() && !session.isClosed()) {
			session.openForRead(new Session.OpenRequest(this)
					.setCallback(statusCallback));
		} else {
			Session.openActiveSession(this, true, statusCallback);
			try {
				Session.NewPermissionsRequest newPermissionsRequest = new Session.NewPermissionsRequest(
						this, FACEBOOK_PERMISSION);
				session.requestNewPublishPermissions(newPermissionsRequest);
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}

	}

	// SessionStatusCallback class
	public class SessionStatusCallback implements Session.StatusCallback {

		@Override
		public void call(Session session, SessionState state,
				Exception exception) {
			postImage();
		}

	}
}
