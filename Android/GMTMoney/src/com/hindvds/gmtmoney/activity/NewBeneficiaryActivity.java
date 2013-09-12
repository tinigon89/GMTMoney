package com.hindvds.gmtmoney.activity;

import java.util.ArrayList;

import com.hindvds.gmtmoney.service.BeneficiaryService;
import com.hindvds.gmtmoney.R;

import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.AdapterView;
import android.widget.AdapterView.OnItemClickListener;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.DatePicker;
import android.widget.EditText;

public class NewBeneficiaryActivity extends BaseActivity {
	private EditText new_beneficiary_personal_firstname,
			new_beneficiary_personal_surname,
			new_beneficiary_personal_companyname,
			new_beneficiary_personal_birthday, new_beneficiary_personal_idno,
			new_beneficiary_personal_idexpiry,
			new_beneficiary_business_street, new_beneficiary_business_suburb,
			new_beneficiary_business_postcode,
			new_beneficiary_contact_primary, new_beneficiary_contact_second,
			new_beneficiary_contact_email, new_beneficiary_business_state,
			new_beneficiary_business_city;

	private AutoCompleteTextView new_beneficiary_personal_identification,
			new_beneficiary_business_country,
			new_beneficiary_contact_primary_select,
			new_beneficiary_contact_second_select;

	private DatePicker new_beneficiary_personal_birthday_picker;

	private int year;
	private int month;
	private int day;

	private int idPos;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.new_beneficiary);

		initNavButton();
		Button new_beneficiary_btn_home = (Button) findViewById(R.id.new_beneficiary_btn_home);
		new_beneficiary_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		initFields();

		Button new_beneficiary_btn_next = (Button) findViewById(R.id.new_beneficiary_btn_next);
		new_beneficiary_btn_next.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				checkValidateFields();
			}
		});

		setUpAutocompleteData();
	}

	private void initFields() {
		new_beneficiary_personal_firstname = (EditText) findViewById(R.id.new_beneficiary_personal_firstname);
		new_beneficiary_personal_surname = (EditText) findViewById(R.id.new_beneficiary_personal_surname);
		new_beneficiary_personal_companyname = (EditText) findViewById(R.id.new_beneficiary_personal_companyname);
		new_beneficiary_personal_idno = (EditText) findViewById(R.id.new_beneficiary_personal_idno);
		new_beneficiary_business_street = (EditText) findViewById(R.id.new_beneficiary_business_street);
		new_beneficiary_business_suburb = (EditText) findViewById(R.id.new_beneficiary_business_suburb);
		new_beneficiary_business_postcode = (EditText) findViewById(R.id.new_beneficiary_business_postcode);
		new_beneficiary_contact_primary = (EditText) findViewById(R.id.new_beneficiary_contact_primary);
		new_beneficiary_contact_second = (EditText) findViewById(R.id.new_beneficiary_contact_second);
		new_beneficiary_contact_email = (EditText) findViewById(R.id.new_beneficiary_contact_email);

		new_beneficiary_personal_identification = (AutoCompleteTextView) findViewById(R.id.new_beneficiary_personal_identification);
		new_beneficiary_business_state = (EditText) findViewById(R.id.new_beneficiary_business_state);
		new_beneficiary_business_city = (EditText) findViewById(R.id.new_beneficiary_business_city);
		new_beneficiary_business_country = (AutoCompleteTextView) findViewById(R.id.new_beneficiary_business_country);
		new_beneficiary_contact_primary_select = (AutoCompleteTextView) findViewById(R.id.new_beneficiary_contact_primary_select);
		new_beneficiary_contact_second_select = (AutoCompleteTextView) findViewById(R.id.new_beneficiary_contact_second_select);
	}

	private void setUpAutocompleteData() {
		ArrayList<String> countryListItem = new ArrayList<String>();
		if (countryList != null) {
			for (int i = 0; i < NewBeneficiaryActivity.countryList.size(); i++) {
				countryListItem.add(countryList.get(i).getCountryName());
			}
		}
		new_beneficiary_business_country.setFocusable(false);
		new_beneficiary_business_country.setFocusableInTouchMode(false);
		new_beneficiary_business_country.setAdapter(new ArrayAdapter<String>(
				this, android.R.layout.simple_dropdown_item_1line,
				countryListItem));
		Button new_beneficiary_business_country_btn = (Button) findViewById(R.id.new_beneficiary_business_country_btn);
		new_beneficiary_business_country_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_beneficiary_business_country.showDropDown();
					}
				});

		String[] indentifyList = { "National ID Card", "Driving Licence",
				"Passport" };
		new_beneficiary_personal_identification.setFocusable(false);
		new_beneficiary_personal_identification.setFocusableInTouchMode(false);
		new_beneficiary_personal_identification
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						indentifyList));
		new_beneficiary_personal_identification
				.setOnItemClickListener(new OnItemClickListener() {

					@Override
					public void onItemClick(AdapterView<?> arg0, View arg1,
							int arg2, long arg3) {
						// TODO Auto-generated method stub
						idPos = arg2;
					}
				});
		Button new_beneficiary_personal_identification_btn = (Button) findViewById(R.id.new_beneficiary_personal_identification_btn);
		new_beneficiary_personal_identification_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_beneficiary_personal_identification.showDropDown();
					}
				});

		String[] contactList = { "HOME PHONE", "WORK PHONE", "MOBILE", "FAX" };
		new_beneficiary_contact_primary_select.setFocusable(false);
		new_beneficiary_contact_primary_select.setFocusableInTouchMode(false);
		new_beneficiary_contact_primary_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						contactList));
		Button new_beneficiary_contact_primary_select_btn = (Button) findViewById(R.id.new_beneficiary_contact_primary_select_btn);
		new_beneficiary_contact_primary_select_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_beneficiary_contact_primary_select.showDropDown();
					}
				});

		new_beneficiary_contact_second_select.setFocusable(false);
		new_beneficiary_contact_second_select.setFocusableInTouchMode(false);
		new_beneficiary_contact_second_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						contactList));
		Button new_beneficiary_contact_second_select_btn = (Button) findViewById(R.id.new_beneficiary_contact_second_select_btn);
		new_beneficiary_contact_second_select_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_beneficiary_contact_second_select.showDropDown();
					}
				});
	}

	private void checkValidateFields() {
		String PCDet = "";
		String SCDet = "";
		if (new_beneficiary_contact_primary_select.getText().toString()
				.equals("HOME PHONE")) {
			PCDet = "0";
		} else if (new_beneficiary_contact_primary_select.getText().toString()
				.equals("WORK PHONE")) {
			PCDet = "1";
		} else if (new_beneficiary_contact_primary_select.getText().toString()
				.equals("MOBILE")) {
			PCDet = "2";
		} else if (new_beneficiary_contact_primary_select.getText().toString()
				.equals("FAX")) {
			PCDet = "3";
		}
		if (new_beneficiary_contact_second_select.getText().toString()
				.equals("HOME PHONE")) {
			SCDet = "0";
		} else if (new_beneficiary_contact_second_select.getText().toString()
				.equals("WORK PHONE")) {
			SCDet = "1";
		} else if (new_beneficiary_contact_second_select.getText().toString()
				.equals("MOBILE")) {
			SCDet = "2";
		} else if (new_beneficiary_contact_second_select.getText().toString()
				.equals("FAX")) {
			SCDet = "3";
		}
		if (new_beneficiary_personal_firstname.getText().toString().equals("")) {
			showDialog("Please enter your first name!");
		} else if (new_beneficiary_personal_surname.getText().toString()
				.equals("")) {
			showDialog("Please enter your last name!");
		} else if (new_beneficiary_business_street.getText().toString()
				.equals("")) {
			showDialog("Please enter street address!");
		} else if (new_beneficiary_business_city.getText().toString()
				.equals("")) {
			showDialog("Please enter city!");
		} else if (new_beneficiary_business_state.getText().toString()
				.equals("")) {
			showDialog("Please enter state!");
		} else if (new_beneficiary_business_country.getText().toString()
				.equals("")) {
			showDialog("Please select country!");
		} else if (new_beneficiary_contact_primary_select.getText().toString()
				.equals("")) {
			showDialog("Please select primary contact type!");
		} else if (new_beneficiary_contact_primary.getText().toString()
				.equals("")) {
			showDialog("Please enter primary contact info!");
		} else if (new_beneficiary_contact_email.getText().toString()
				.equals("")) {
			showDialog("Please enter email!");
		} else {
			processRegister(new_beneficiary_contact_email.getText().toString(),
					new_beneficiary_personal_firstname.getText().toString(),
					new_beneficiary_personal_surname.getText().toString(),
					new_beneficiary_personal_companyname.getText().toString(),
					String.valueOf(idPos),
					new_beneficiary_personal_idno.getText().toString(),
					new_beneficiary_business_street.getText().toString(),
					new_beneficiary_business_suburb.getText().toString(),
					new_beneficiary_business_city.getText().toString(),
					new_beneficiary_business_state.getText().toString(),
					new_beneficiary_business_postcode.getText().toString(),
					getCountryID(new_beneficiary_business_country.getText().toString()),
					new_beneficiary_contact_primary.getText().toString(),
					new_beneficiary_contact_second.getText().toString(), 
					PCDet, SCDet);
		}
	}

	private void processRegister(String Email, String FName, String SurName,
			String BisName, String IdentyID, String IdCode, String RStreet,
			String RSub, String City, String RState, String RPost,
			String RCountryID, String PContact, String SContact, String PCDet,
			String SCDet) {

		new RegisterAsyncTask().execute(Email, FName, SurName, BisName,
				IdentyID, IdCode, RStreet, RSub, City, RState, RPost,
				RCountryID, PContact, SContact, PCDet, SCDet);
	}

	private void showDialogSuccess(String msg) {
		AlertDialog.Builder builder1 = new AlertDialog.Builder(
				NewBeneficiaryActivity.this);
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
				BeneficiaryService beneficiaryService = new BeneficiaryService();
				value = beneficiaryService.newBeneficiary(
						getSharedPreferences("RegisterID"), aurl[0], aurl[1],
						aurl[2], aurl[3], aurl[4], aurl[5], aurl[6], aurl[7],
						aurl[8], aurl[9], aurl[10], aurl[11], aurl[12],
						aurl[13], aurl[14], aurl[15]);
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
			if ((value).trim().equals("Ok")) {
				showDialogSuccess("Successful!");
				finish();
			} else {
				showDialog(value);
			}
		}
	}

	@Override
	protected Dialog onCreateDialog(int id) {
		switch (id) {
		case 999:
			// set date picker as current date
			return new DatePickerDialog(this, datePickerListener, year, month,
					day);

		case 1000:
			// set date picker as current date
			return new DatePickerDialog(this, datePickerListener2, year, month,
					day);
		}
		return null;
	}

	private DatePickerDialog.OnDateSetListener datePickerListener = new DatePickerDialog.OnDateSetListener() {

		// when dialog box is closed, below method will be called.
		public void onDateSet(DatePicker view, int selectedYear,
				int selectedMonth, int selectedDay) {
			year = selectedYear;
			month = selectedMonth;
			day = selectedDay;

			// set selected date into textview
			new_beneficiary_personal_birthday.setText(new StringBuilder()
					.append(year).append("/").append(month + 1).append("/")
					.append(day).append(" "));

			// set selected date into datepicker also
			new_beneficiary_personal_birthday_picker.init(year, month, day,
					null);

		}
	};

	private DatePickerDialog.OnDateSetListener datePickerListener2 = new DatePickerDialog.OnDateSetListener() {

		// when dialog box is closed, below method will be called.
		public void onDateSet(DatePicker view, int selectedYear,
				int selectedMonth, int selectedDay) {
			year = selectedYear;
			month = selectedMonth;
			day = selectedDay;

			// set selected date into textview
			new_beneficiary_personal_idexpiry.setText(new StringBuilder()
					.append(year).append("/").append(month + 1).append("/")
					.append(day).append(" "));

			// set selected date into datepicker also
			new_beneficiary_personal_birthday_picker.init(year, month, day,
					null);

		}
	};
}
