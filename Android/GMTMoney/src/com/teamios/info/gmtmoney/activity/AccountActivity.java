package com.teamios.info.gmtmoney.activity;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;

import com.teamios.info.gmtmoney.R;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.database.Cursor;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.graphics.drawable.BitmapDrawable;
import android.net.Uri;
import android.os.Bundle;
import android.os.Environment;
import android.provider.MediaStore.Images;
import android.provider.MediaStore.Images.ImageColumns;
import android.text.Html;
import android.view.View;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;

public class AccountActivity extends BaseActivity {
	
	protected static final int CAMERA_REQUEST = 0;
	protected static final int GALLERY_PICTURE = 1;
	private Intent pictureActionIntent = null;
	Bitmap bitmap;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.account_screen);
		
		initNavButton();
		Button account_btn_home = (Button) findViewById(R.id.account_btn_home);
		account_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_dailyrates = (Button) findViewById(R.id.account_btn_dailyrates);
		account_btn_dailyrates.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(),DailyRatesActivity.class);
				startActivity(i);
				finish();
			}
		});
		
		Button account_btn_rate_alerts = (Button) findViewById(R.id.account_btn_rate_alerts);
		account_btn_rate_alerts.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), RateAlertsActivity.class);
				startActivity(i);
				finish();
			}
		});
		
		Button account_btn_sendmoney = (Button) findViewById(R.id.account_btn_sendmoney);
		account_btn_sendmoney.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_transaction = (Button) findViewById(R.id.account_btn_transaction);
		account_btn_transaction.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), NewsActivity.class);
				i.putExtra("name", "transaction_history");
				startActivity(i);
			}
		});
		
		Button account_btn_find_trans = (Button) findViewById(R.id.account_btn_find_trans);
		account_btn_find_trans.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		Button account_btn_track = (Button) findViewById(R.id.account_btn_track);
		account_btn_track.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), WebViewScreenActivity.class);
				i.putExtra("name", "account_track");
				startActivity(i);
			}
		});
		
		Button account_btn_add_your_file = (Button) findViewById(R.id.account_btn_add_your_file);
		account_btn_add_your_file.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				startDialog();
			}
		});
		
		TextView account_bar1_title_right = (TextView) findViewById(R.id.account_bar1_title_right);
		account_bar1_title_right.setText("Hi, " + getSharedPreferences("username"));
	}
	
	private void startDialog() {
	    AlertDialog.Builder myAlertDialog = new AlertDialog.Builder(this);
	    myAlertDialog.setTitle("Upload Pictures Option");
	    myAlertDialog.setMessage("How do you want to set your picture?");

	    myAlertDialog.setPositiveButton("Photo Library",
	            new DialogInterface.OnClickListener() {
	                public void onClick(DialogInterface arg0, int arg1) {
	                    pictureActionIntent = new Intent(
	                            Intent.ACTION_GET_CONTENT, null);
	                    pictureActionIntent.setType("image/*");
	                    pictureActionIntent.putExtra("return-data", true);
	                    startActivityForResult(pictureActionIntent,
	                            GALLERY_PICTURE);
	                }
	            });

	    myAlertDialog.setNegativeButton("Camera",
	            new DialogInterface.OnClickListener() {
	                public void onClick(DialogInterface arg0, int arg1) {
	                    pictureActionIntent = new Intent(
	                            android.provider.MediaStore.ACTION_IMAGE_CAPTURE);
	                    startActivityForResult(pictureActionIntent,
	                            CAMERA_REQUEST);

	                }
	            });
	    
	    myAlertDialog.setCancelable(true);
	    myAlertDialog.show();
	}

	protected void onActivityResult(int requestCode, int resultCode, Intent data) {

	    super.onActivityResult(requestCode, resultCode, data);
	    if (requestCode == GALLERY_PICTURE) {
	        if (resultCode == RESULT_OK) {
	            if (data != null) {
	                // our BitmapDrawable for the thumbnail
	                BitmapDrawable bmpDrawable = null;
	                // try to retrieve the image using the data from the intent
	                Cursor cursor = getContentResolver().query(data.getData(),
	                        null, null, null, null);
	                if (cursor != null) {

	                    cursor.moveToFirst();

	                    int idx = cursor.getColumnIndex(ImageColumns.DATA);
	                    String fileSrc = cursor.getString(idx);
	                    bitmap = BitmapFactory.decodeFile(fileSrc); // load
	                                                                        // preview
	                                                                        // image
	                    bitmap = Bitmap.createScaledBitmap(bitmap,
	                            100, 100, false);
	                    // bmpDrawable = new BitmapDrawable(bitmapPreview);
	                    //img_logo.setImageBitmap(bitmap);
	                    sendMail(bitmap);
	                } else {

	                    bmpDrawable = new BitmapDrawable(getResources(), data
	                            .getData().getPath());
	                    //img_logo.setImageDrawable(bmpDrawable);
	                }

	            } else {
	                Toast.makeText(getApplicationContext(), "Cancelled",
	                        Toast.LENGTH_SHORT).show();
	            }
	        } else if (resultCode == RESULT_CANCELED) {
	            Toast.makeText(getApplicationContext(), "Cancelled",
	                    Toast.LENGTH_SHORT).show();
	        }
	    } else if (requestCode == CAMERA_REQUEST) {
	        if (resultCode == RESULT_OK) {
	            if (data.hasExtra("data")) {

	                // retrieve the bitmap from the intent
	                bitmap = (Bitmap) data.getExtras().get("data");

	                bitmap = Bitmap.createScaledBitmap(bitmap, 100,
	                        100, false);
	                // update the image view with the bitmap
	                //img_logo.setImageBitmap(bitmap);
	                sendMail(bitmap);
	            } else if (data.getExtras() == null) {

	                Toast.makeText(getApplicationContext(),
	                        "No extras to retrieve!", Toast.LENGTH_SHORT)
	                        .show();

	                BitmapDrawable thumbnail = new BitmapDrawable(
	                        getResources(), data.getData().getPath());

	                // update the image view with the newly created drawable
	                //img_logo.setImageDrawable(thumbnail);

	            }

	        } else if (resultCode == RESULT_CANCELED) {
	            Toast.makeText(getApplicationContext(), "Cancelled",
	                    Toast.LENGTH_SHORT).show();
	        }
	    }

	}
	
	private void sendMail(Bitmap bmp){
		File png = new File(new File(Environment.getExternalStorageDirectory(), "Pictures"), "photo");
	    FileOutputStream out = null;
	    try {
	        out = new FileOutputStream(png);
	        bitmap.compress(Bitmap.CompressFormat.PNG, 100, out);
	        out.flush();
	    } catch (Exception e) {
	        e.printStackTrace();
	    } finally {
	        try {
	            if (out != null) out.close();
	        }
	         catch (IOException ignore) {}
	        }
	        final Intent emailIntent = new Intent(android.content.Intent.ACTION_SEND);
	        emailIntent.putExtra(Intent.EXTRA_EMAIL, new String[]{"admin@gmtmoney.com.au","gmtmoneyt@gmail.com"});
	        emailIntent.putExtra(Intent.EXTRA_STREAM, Uri.fromFile(png));
	        emailIntent.setType("image/png");
	        startActivity(Intent.createChooser(emailIntent, "Email to Friend"));
	        finish();
	    }
}
