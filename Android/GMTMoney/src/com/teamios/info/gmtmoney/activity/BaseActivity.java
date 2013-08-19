package com.teamios.info.gmtmoney.activity;

import com.teamios.info.gmtmoney.R;

import android.app.Activity;
import android.app.Dialog;
import android.util.Log;

public class BaseActivity extends Activity{
	
	protected Dialog dialog;
	
	public void openProcessLoading(final Boolean isCloseScreen) {
		try {
			if (dialog == null) {
				dialog = new Dialog(this, R.style.Theme_MyDialogTran);
		        dialog.setContentView(R.layout.progress_dialog);
		        dialog.setCancelable(isCloseScreen);
			}
	        dialog.show();
		} catch (Exception e) {
			Log.e("Close dialog process", this.toString());
		}
	}
	
	public void closeProcessLoading() {
		new Thread() {
			@Override
			public void run() {
				super.run();
				if (dialog != null) {
					dialog.dismiss();
				}
			}
		}.start();
	}
}


