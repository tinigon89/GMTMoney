package com.hindvds.gmtmoney.activity;
import com.facebook.Request;
import com.facebook.Response;
import com.facebook.Session;
import com.facebook.android.DialogError;
import com.facebook.android.Facebook;
import com.facebook.android.Facebook.DialogListener;
import com.facebook.android.FacebookError;
import com.facebook.model.GraphUser;
import com.hindvds.gmtmoney.R;
import android.os.Bundle;
import android.os.Handler;
import android.view.View;
import android.widget.Button;
import android.widget.Toast;

@SuppressWarnings("deprecation")
public class FacebookActivity extends BaseActivity {
	private static final String[] FACEBOOK_PERMISSION = { 
		"user_photos",
		"publish_checkins",
		"publish_actions",
		"publish_stream",
		"email",
		"user_groups",
		"read_stream",
		"user_about_me",
		"offline_access"};
	private Handler mRunOnUi = new Handler();
	private static int RESULT_LOAD_IMAGE = 1;
	String picpath="";
	Session session;
	private String APP_ID;
	Facebook fb;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.facebook);
		
		APP_ID = getString(R.string.app_id);
		fb = new Facebook(APP_ID);	
		
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
//				if(getSharedPreferences("remaing_sms").equals("")){
//					saveSharedPreferences("remaing_sms","0");
//				}
//				saveSharedPreferences("remaing_sms",String.valueOf(Integer.parseInt(getSharedPreferences("remaing_sms")) + 10));
//				finish();
				logintoFB();
			}
		});
	}
	
	private void logintoFB() {
		fb.authorize(FacebookActivity.this,FACEBOOK_PERMISSION, new DialogListener() {
			@Override
			public void onCancel() {
				Toast.makeText(FacebookActivity.this, "onCancel", Toast.LENGTH_SHORT).show();
			}

			@Override
			public void onFacebookError(FacebookError e) {
				// TODO Auto-generated method stub
				Toast.makeText(FacebookActivity.this, "onFacebookError", Toast.LENGTH_SHORT).show();
			}

			@Override
			public void onError(DialogError e) {
				// TODO Auto-generated method stub
				Toast.makeText(FacebookActivity.this, "onError", Toast.LENGTH_SHORT).show();
			}

			@Override
			public void onComplete(Bundle values) {
				// TODO Auto-generated method stub
				session = fb.getSession();
				changeStatuaLogin();
			}
		});
		
	}
	
	private void changeStatuaLogin() {
		if(fb.isSessionValid()){
			Request.executeMeRequestAsync(session, new Request.GraphUserCallback() {
				
				@Override
				public void onCompleted(GraphUser user, Response response) {
					if (user != null){
						//tvName.setText("Wellcome " + user.getName());
					}
					Toast.makeText(FacebookActivity.this, "Login Complete", Toast.LENGTH_SHORT).show();
				}
			});
			
			
		}else{
//			ckbLogin.setChecked(false);
//			btnpost.setVisibility(View.INVISIBLE);
//			btnpop.setVisibility(View.INVISIBLE);
//			txtstt.setVisibility(View.INVISIBLE);
//			img.setVisibility(View.INVISIBLE);
//			ckbLogin.setVisibility(View.VISIBLE);
		}
		
	}
}
