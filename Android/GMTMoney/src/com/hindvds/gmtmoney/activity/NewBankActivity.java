package com.hindvds.gmtmoney.activity;

import java.util.ArrayList;

import com.hindvds.gmtmoney.service.BankService;
import com.hindvds.gmtmoney.R;

import android.app.AlertDialog;
import android.content.DialogInterface;
import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;

public class NewBankActivity extends BaseActivity {
	private EditText new_bank_holdername, new_bank_accountnumber,
			new_bank_bankname, new_bank_bankcode, new_bank_swiftcode,
			new_bank_rountingnumber, new_bank_address1, new_bank_address2,
			new_bank_city, new_bank_state, new_bank_postcode;
	private AutoCompleteTextView new_bank_country;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.new_bank);

		initNavButton();
		Button new_bank_btn_home = (Button) findViewById(R.id.new_bank_btn_home);
		new_bank_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				Intent i = new Intent(getBaseContext(), Step3ContActivity.class);
				startActivity(i);
				finish();
			}
		});

		initFields();

		Button new_bank_btn_next = (Button) findViewById(R.id.new_bank_btn_next);
		new_bank_btn_next.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				checkValidateFields();
			}
		});

		setUpAutocompleteData();
	}

	private void initFields() {
		new_bank_holdername = (EditText) findViewById(R.id.new_bank_holdername);
		new_bank_accountnumber = (EditText) findViewById(R.id.new_bank_accountnumber);
		new_bank_bankname = (EditText) findViewById(R.id.new_bank_bankname);
		new_bank_bankcode = (EditText) findViewById(R.id.new_bank_bankcode);
		new_bank_swiftcode = (EditText) findViewById(R.id.new_bank_swiftcode);
		new_bank_rountingnumber = (EditText) findViewById(R.id.new_bank_rountingnumber);
		new_bank_address1 = (EditText) findViewById(R.id.new_bank_address1);
		new_bank_address2 = (EditText) findViewById(R.id.new_bank_address2);
		new_bank_city = (EditText) findViewById(R.id.new_bank_city);
		new_bank_state = (EditText) findViewById(R.id.new_bank_state);
		new_bank_postcode = (EditText) findViewById(R.id.new_bank_postcode);
		new_bank_country = (AutoCompleteTextView) findViewById(R.id.new_bank_country);
	}

	private void setUpAutocompleteData() {
		ArrayList<String> countryListItem = new ArrayList<String>();
		if (countryList != null) {
			for (int i = 0; i < NewBankActivity.countryList.size(); i++) {
				countryListItem.add(countryList.get(i).getCountryName());
			}
		}
		new_bank_country.setFocusable(false);
		new_bank_country.setFocusableInTouchMode(false);
		new_bank_country.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button new_bank_country_btn = (Button) findViewById(R.id.new_bank_country_btn);
		new_bank_country_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				new_bank_country.showDropDown();
			}
		});
	}

	private void checkValidateFields() {
		if (new_bank_holdername.getText().toString().equals("")) {
			showDialog("Please enter account holder name!");
		} else if (new_bank_accountnumber.getText().toString().equals("")) {
			showDialog("Please enter account number!");
		} else if (new_bank_accountnumber.getText().toString().equals("")) {
			showDialog("Please enter bank name!");
		} else {
			new_bank_holdername = (EditText) findViewById(R.id.new_bank_holdername);
			new_bank_accountnumber = (EditText) findViewById(R.id.new_bank_accountnumber);
			new_bank_bankname = (EditText) findViewById(R.id.new_bank_bankname);
			new_bank_bankcode = (EditText) findViewById(R.id.new_bank_bankcode);
			new_bank_swiftcode = (EditText) findViewById(R.id.new_bank_swiftcode);
			new_bank_rountingnumber = (EditText) findViewById(R.id.new_bank_rountingnumber);
			new_bank_address1 = (EditText) findViewById(R.id.new_bank_address1);
			new_bank_address2 = (EditText) findViewById(R.id.new_bank_address2);
			new_bank_city = (EditText) findViewById(R.id.new_bank_city);
			new_bank_state = (EditText) findViewById(R.id.new_bank_state);
			new_bank_postcode = (EditText) findViewById(R.id.new_bank_postcode);
			new_bank_country = (AutoCompleteTextView) findViewById(R.id.new_bank_country);
			processRegister(new_bank_holdername.getText().toString(),
					new_bank_accountnumber.getText().toString(),
					new_bank_bankname.getText().toString(),
					new_bank_bankcode.getText().toString(),
					new_bank_swiftcode.getText().toString(),
					new_bank_rountingnumber.getText().toString(),
					new_bank_address1.getText().toString(),
					new_bank_address2.getText().toString(),
					new_bank_city.getText().toString(),
					new_bank_state.getText().toString(),
					new_bank_postcode.getText().toString(),
					getCountryID(new_bank_country.getText() .toString()));
		}
	}

	private void processRegister(String ACHolderName, String ACNo,
			String BankName, String BankCode, String SwiftCode, String RoutNo,
			String Add1, String Add2, String City, String State,
			String PostCode, String Country) {

		new RegisterAsyncTask().execute(ACHolderName, ACNo, BankName, BankCode, SwiftCode,
				RoutNo, Add1, Add2, City, State,
				PostCode, Country);
	}

	private void showDialogSuccess(String msg) {
		AlertDialog.Builder builder1 = new AlertDialog.Builder(
				NewBankActivity.this);
		builder1.setMessage(msg)
				.setPositiveButton("OK", new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						finish();
					}
				}).show();
	}

	private String getCountryID(String text) {
		String val = "";
		for (int i = 0; i < countryList.size(); i++) {
			if ((text).trim().equals(
					(countryList.get(i).getCountryName()).trim())) {
				val = countryList.get(i).getCountryID();
			}
		}
		return val;
	}

	private class RegisterAsyncTask extends AsyncTask<String, Integer, String> {
		private String value = "";

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				BankService bankService = new BankService();
				value = bankService.newBank(
						getSharedPreferences("RegisterID"), aurl[0], aurl[1],
						aurl[2], aurl[3], aurl[4], aurl[5], aurl[6], aurl[7],
						aurl[8], aurl[9], aurl[10], aurl[11], getSharedPreferences("beneId"));
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
			if ((value).trim().equals("OK")) {
				showDialogSuccess("Successful!");
				Intent i = new Intent(getBaseContext(), Step3ContActivity.class);
				startActivity(i);
				finish();
			} else {
				showDialog(value);
			}
		}
	}
}
