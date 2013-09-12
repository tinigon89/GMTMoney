package com.hindvds.gmtmoney.activity;

import java.util.ArrayList;
import java.util.Calendar;


import com.hindvds.gmtmoney.service.SenderService;
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
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;

public class NewSenderActivity extends BaseActivity {
	private EditText new_sender_personal_firstname,
			new_sender_personal_surname, new_sender_personal_businessname,
			new_sender_personal_birthday, new_sender_personal_idno,
			new_sender_personal_idexpiry, new_sender_personal_idissuer,
			new_sender_personal_occupation, new_sender_business_street,
			new_sender_business_suburb, new_sender_business_postcode,
			new_sender_business_street_pre, new_sender_business_suburb_pre,
			new_sender_business_postcode_pre, new_sender_contact_primary,
			new_sender_contact_second, new_sender_contact_email;

	private AutoCompleteTextView new_sender_personal_nationality,
			new_sender_personal_identification, new_sender_business_state,
			new_sender_business_country, new_sender_business_country_pre,
			new_sender_business_state_pre, new_sender_contact_primary_select,
			new_sender_contact_second_select;

	private CheckBox new_sender_business_checkbox_same;

	private DatePicker new_sender_personal_birthday_picker;
	private Button new_sender_personal_birthday_btn,new_sender_personal_idexpiry_btn;
	
	private int year;
	private int month;
	private int day;
	
	private int idPos;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.new_sender);

		initNavButton();
		Button new_sender_btn_home = (Button) findViewById(R.id.new_sender_btn_home);
		new_sender_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		initFields();

		Button new_sender_btn_next = (Button) findViewById(R.id.new_sender_btn_next);
		new_sender_btn_next.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				checkValidateFields();
			}
		});

		setUpAutocompleteData();
		setDatePicker();
	}

	private void initFields() {
		new_sender_personal_firstname = (EditText) findViewById(R.id.new_sender_personal_firstname);
		new_sender_personal_surname = (EditText) findViewById(R.id.new_sender_personal_surname);
		new_sender_personal_businessname = (EditText) findViewById(R.id.new_sender_personal_businessname);
		new_sender_personal_birthday = (EditText) findViewById(R.id.new_sender_personal_birthday);
		new_sender_personal_idno = (EditText) findViewById(R.id.new_sender_personal_idno);
		new_sender_personal_idexpiry = (EditText) findViewById(R.id.new_sender_personal_idexpiry);
		new_sender_personal_idissuer = (EditText) findViewById(R.id.new_sender_personal_idissuer);
		new_sender_personal_occupation = (EditText) findViewById(R.id.new_sender_personal_occupation);
		new_sender_business_street = (EditText) findViewById(R.id.new_sender_business_street);
		new_sender_business_suburb = (EditText) findViewById(R.id.new_sender_business_suburb);
		new_sender_business_postcode = (EditText) findViewById(R.id.new_sender_business_postcode);
		new_sender_business_street_pre = (EditText) findViewById(R.id.new_sender_business_street_pre);
		new_sender_business_suburb_pre = (EditText) findViewById(R.id.new_sender_business_suburb_pre);
		new_sender_business_postcode_pre = (EditText) findViewById(R.id.new_sender_business_postcode_pre);
		new_sender_contact_primary = (EditText) findViewById(R.id.new_sender_contact_primary);
		new_sender_contact_second = (EditText) findViewById(R.id.new_sender_contact_second);
		new_sender_contact_email = (EditText) findViewById(R.id.new_sender_contact_email);

		new_sender_personal_nationality = (AutoCompleteTextView) findViewById(R.id.new_sender_personal_nationality);
		new_sender_personal_identification = (AutoCompleteTextView) findViewById(R.id.new_sender_personal_identification);
		new_sender_business_state = (AutoCompleteTextView) findViewById(R.id.new_sender_business_state);
		new_sender_business_country = (AutoCompleteTextView) findViewById(R.id.new_sender_business_country);
		new_sender_business_country_pre = (AutoCompleteTextView) findViewById(R.id.new_sender_business_country_pre);
		new_sender_business_state_pre = (AutoCompleteTextView) findViewById(R.id.new_sender_business_state_pre);
		new_sender_contact_primary_select = (AutoCompleteTextView) findViewById(R.id.new_sender_contact_primary_select);
		new_sender_contact_second_select = (AutoCompleteTextView) findViewById(R.id.new_sender_contact_second_select);

		new_sender_business_checkbox_same = (CheckBox) findViewById(R.id.new_sender_business_checkbox_same);
		new_sender_personal_birthday_btn = (Button) findViewById(R.id.new_sender_personal_birthday_btn);
		new_sender_personal_idexpiry_btn = (Button) findViewById(R.id.new_sender_personal_idexpiry_btn);
	}

	private void setDatePicker() {
		new_sender_personal_birthday.setFocusable(false);
		new_sender_personal_birthday.setFocusableInTouchMode(false);
		
		new_sender_personal_idexpiry.setFocusable(false);
		new_sender_personal_idexpiry.setFocusableInTouchMode(false);

		new_sender_personal_birthday_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						showDialog(999);
					}
				});
		
		new_sender_personal_idexpiry_btn
		.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				showDialog(1000);
			}
		});

		setCurrentDateOnView();
	}

	private void setUpAutocompleteData() {
		ArrayList<String> countryListItem = new ArrayList<String>();
		if (countryList != null) {
			for (int i = 0; i < NewSenderActivity.countryList.size(); i++) {
				countryListItem.add(countryList.get(i).getCountryName());
			}
		}
		new_sender_personal_nationality.setFocusable(false);
		new_sender_personal_nationality.setFocusableInTouchMode(false);
		new_sender_personal_nationality.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button new_sender_personal_nationality_btn = (Button) findViewById(R.id.new_sender_personal_nationality_btn);
		new_sender_personal_nationality_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_personal_nationality.showDropDown();
					}
				});

		new_sender_business_country.setFocusable(false);
		new_sender_business_country.setFocusableInTouchMode(false);
		new_sender_business_country.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button new_sender_business_country_btn = (Button) findViewById(R.id.new_sender_business_country_btn);
		new_sender_business_country_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_business_country.showDropDown();
					}
				});

		new_sender_business_country_pre.setFocusable(false);
		new_sender_business_country_pre.setFocusableInTouchMode(false);
		new_sender_business_country_pre.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button new_sender_business_country_pre_btn = (Button) findViewById(R.id.new_sender_business_country_pre_btn);
		new_sender_business_country_pre_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_business_country_pre.showDropDown();
					}
				});

		String[] indentifyList = { "Alien registration number","Bank account","Benefits card/ID","Birth certificate","Business registration/licence","Credit/debit card","Customer account/ID","Driver's licence","Employee ID","Employer number","Identity card/number","Membership ID","Passport","Photo ID","Security ID","Social security ID","Student ID","Tax number/ID" };
		new_sender_personal_identification.setFocusable(false);
		new_sender_personal_identification.setFocusableInTouchMode(false);
		new_sender_personal_identification.setAdapter(new ArrayAdapter<String>(
				this, android.R.layout.simple_dropdown_item_1line,
				indentifyList));
		new_sender_personal_identification.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPos = arg2;
			}
	    });
		Button new_sender_personal_identification_btn = (Button) findViewById(R.id.new_sender_personal_identification_btn);
		new_sender_personal_identification_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_personal_identification.showDropDown();
					}
				});

		String[] stateList = { "NSW", "ACT", "VIC", "QLD", "SA", "WA", "NT",
				"TAS", "OTHER", "N/A" };
		new_sender_business_state.setFocusable(false);
		new_sender_business_state.setFocusableInTouchMode(false);
		new_sender_business_state.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, stateList));
		Button new_sender_business_state_btn = (Button) findViewById(R.id.new_sender_business_state_btn);
		new_sender_business_state_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_business_state.showDropDown();
					}
				});

		new_sender_business_state_pre.setFocusable(false);
		new_sender_business_state_pre.setFocusableInTouchMode(false);
		new_sender_business_state_pre.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, stateList));
		Button new_sender_business_state_pre_btn = (Button) findViewById(R.id.new_sender_business_state_pre_btn);
		new_sender_business_state_pre_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_business_state_pre.showDropDown();
					}
				});

		String[] contactList = { "HOME PHONE", "WORK PHONE", "MOBILE", "FAX" };
		new_sender_contact_primary_select.setFocusable(false);
		new_sender_contact_primary_select.setFocusableInTouchMode(false);
		new_sender_contact_primary_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						contactList));
		Button new_sender_contact_primary_select_btn = (Button) findViewById(R.id.new_sender_contact_primary_select_btn);
		new_sender_contact_primary_select_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_contact_primary_select.showDropDown();
					}
				});

		new_sender_contact_second_select.setFocusable(false);
		new_sender_contact_second_select.setFocusableInTouchMode(false);
		new_sender_contact_second_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						contactList));
		Button new_sender_contact_second_select_btn = (Button) findViewById(R.id.new_sender_contact_second_select_btn);
		new_sender_contact_second_select_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						new_sender_contact_second_select.showDropDown();
					}
				});
	}

	private void checkValidateFields() {
		String PCDet = "";
		String SCDet = "";
		if(new_sender_contact_primary_select.getText().toString().equals("HOME PHONE")){
			PCDet = "0";
		} else if(new_sender_contact_primary_select.getText().toString().equals("WORK PHONE")){
			PCDet = "1";
		} else if(new_sender_contact_primary_select.getText().toString().equals("MOBILE")){
			PCDet = "2";
		} else if(new_sender_contact_primary_select.getText().toString().equals("FAX")){
			PCDet = "3";
		}
		if(new_sender_contact_second_select.getText().toString().equals("HOME PHONE")){
			SCDet = "0";
		} else if(new_sender_contact_second_select.getText().toString().equals("WORK PHONE")){
			SCDet = "1";
		} else if(new_sender_contact_second_select.getText().toString().equals("MOBILE")){
			SCDet = "2";
		} else if(new_sender_contact_second_select.getText().toString().equals("FAX")){
			SCDet = "3";
		}
		if (new_sender_personal_firstname.getText().toString().equals("")) {
			showDialog("Please enter your first name!");
		} else if (new_sender_personal_surname.getText().toString().equals("")) {
			showDialog("Please enter your last name!");
		} else if (new_sender_personal_birthday.getText().toString().equals("")) {
			showDialog("Please select date of birth!");
		} else if (new_sender_personal_identification.getText().toString()
				.equals("")) {
			showDialog("Please select identification!");
		} else if (new_sender_personal_idno.getText().toString().equals("")) {
			showDialog("Please enter your identification number!");
		} else if (new_sender_personal_idexpiry.getText().toString().equals("")) {
			showDialog("Please select id expiry!");
		} else if (new_sender_personal_idissuer.getText().toString().equals("")) {
			showDialog("Please enter ID issuer!");
		} else if (new_sender_personal_occupation.getText().toString().equals("")) {
			showDialog("Please enter your occupation!");
		} else if (new_sender_business_street.getText().toString().equals("")) {
			showDialog("Please enter street address!");
		} else if (new_sender_business_suburb.getText().toString().equals("")) {
			showDialog("Please enter subburb!");
		} else if (new_sender_business_state.getText().toString().equals("")) {
			showDialog("Please select state!");
		} else if (new_sender_business_postcode.getText().toString().equals("")) {
			showDialog("Please enter postcode!");
		} else if (new_sender_business_country.getText().toString().equals("")) {
			showDialog("Please select country!");
		} else if (!new_sender_business_checkbox_same.isChecked()) {
			if (new_sender_business_street_pre.getText().toString().equals("")) {
				showDialog("Please enter street address in previous address!");
			} else if (new_sender_business_suburb_pre.getText().toString()
					.equals("")) {
				showDialog("Please enter subburb in previous address!");
			} else if (new_sender_business_state_pre.getText().toString()
					.equals("")) {
				showDialog("Please select state in previous address!");
			} else if (new_sender_business_postcode_pre.getText().toString()
					.equals("")) {
				showDialog("Please enter postcode in previous address!");
			} else if (new_sender_business_country_pre.getText().toString()
					.equals("")) {
				showDialog("Please select country in previous address!");
			} else if (new_sender_contact_primary_select.getText().toString()
					.equals("")) {
				showDialog("Please select primary contact type!");
			} else if (new_sender_contact_primary.getText().toString().equals("")) {
				showDialog("Please enter primary contact info!");
			} else if (new_sender_contact_email.getText().toString().equals("")) {
				showDialog("Please enter email!");
			} else {
				processRegister(new_sender_contact_email.getText().toString(),
						new_sender_personal_firstname.getText().toString(),
						new_sender_personal_surname.getText().toString(),
						new_sender_personal_businessname.getText().toString(),
						new_sender_personal_birthday.getText().toString(),
						getCountryID(new_sender_personal_nationality.getText().toString()),
						String.valueOf(idPos),
						new_sender_personal_idno.getText().toString(),
						new_sender_personal_idexpiry.getText().toString(),
						new_sender_personal_idissuer.getText().toString(),
						new_sender_personal_occupation.getText().toString(),
						new_sender_business_street.getText().toString(),
						new_sender_business_suburb.getText().toString(),
						new_sender_business_state.getText().toString(),
						new_sender_business_postcode.getText().toString(),
						getCountryID(new_sender_business_country.getText().toString()), 
						"1",
						new_sender_business_street_pre.getText().toString(),
						new_sender_business_suburb_pre.getText().toString(),
						new_sender_business_state_pre.getText().toString(),
						new_sender_business_postcode_pre.getText().toString(),
						getCountryID(new_sender_business_country_pre.getText().toString()),
						new_sender_contact_primary.getText().toString(),
						new_sender_contact_second.getText().toString(),
						PCDet,
						SCDet);
			}
		} else if (new_sender_contact_primary_select.getText().toString()
				.equals("")) {
			showDialog("Please select primary contact type!");
		} else if (new_sender_contact_primary.getText().toString().equals("")) {
			showDialog("Please enter primary contact info!");
		} else if (new_sender_contact_email.getText().toString().equals("")) {
			showDialog("Please enter email!");
		} else {
			processRegister(new_sender_contact_email.getText().toString(),
					new_sender_personal_firstname.getText().toString(),
					new_sender_personal_surname.getText().toString(),
					new_sender_personal_businessname.getText().toString(),
					(new_sender_personal_birthday.getText().toString()).trim(),
					getCountryID(new_sender_personal_nationality.getText().toString()),
					String.valueOf(idPos),
					new_sender_personal_idno.getText().toString(),
					(new_sender_personal_idexpiry.getText().toString()).trim(),
					new_sender_personal_idissuer.getText().toString(),
					new_sender_personal_occupation.getText().toString(),
					new_sender_business_street.getText().toString(),
					new_sender_business_suburb.getText().toString(),
					new_sender_business_state.getText().toString(),
					new_sender_business_postcode.getText().toString(),
					getCountryID(new_sender_business_country.getText().toString()), 
					"1",
					new_sender_business_street.getText().toString(),
					new_sender_business_suburb.getText().toString(),
					new_sender_business_state.getText().toString(),
					new_sender_business_postcode.getText().toString(),
					getCountryID(new_sender_business_country.getText().toString()),
					new_sender_contact_primary.getText().toString(),
					new_sender_contact_second.getText().toString(),
					PCDet,
					SCDet);
		}
	}

	private void processRegister(String Email, String FName, String SurName, String BisName,
			String DBirth, String NationID, String IdentyID, String IdCode,
			String IDExpiry, String IDIssuer, String Occup, String RStreet,
			String RSub, String RState, String RPost, String RCountryID,
			String PStatus, String PStreet, String PSub, String PState,
			String PPost, String PCountryID, String PContact, String SContact, String PCDet, String SCDet) {

		new RegisterAsyncTask().execute(Email, FName,
				SurName, BisName, DBirth, NationID, IdentyID, IdCode, IDExpiry,
				IDIssuer, Occup, RStreet, RSub, RState, RPost, RCountryID,
				PStatus, PStreet, PSub, PState, PPost, PCountryID, PContact,
				SContact, PCDet, SCDet);
	}

	private void showDialogSuccess(String msg) {
		AlertDialog.Builder builder1 = new AlertDialog.Builder(
				NewSenderActivity.this);
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

	private void setCurrentDateOnView() {

		new_sender_personal_birthday_picker = (DatePicker) findViewById(R.id.new_sender_personal_birthday_picker);

		final Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
		month = c.get(Calendar.MONTH);
		day = c.get(Calendar.DAY_OF_MONTH);

		// set current date into datepicker
		new_sender_personal_birthday_picker.init(year, month, day, null);
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
				SenderService senderService = new SenderService();
				value = senderService.newSender(getSharedPreferences("RegisterID") ,aurl[0], aurl[1], aurl[2],
						aurl[3], aurl[4], aurl[5], aurl[6], aurl[7], aurl[8],
						aurl[9], aurl[10], aurl[11], aurl[12], aurl[13],
						aurl[14], aurl[15], aurl[16], aurl[17], aurl[18],
						aurl[19], aurl[20], aurl[21], aurl[22], aurl[23],
						aurl[24], aurl[25]);
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
			new_sender_personal_birthday.setText(new StringBuilder().append(year)
					.append("/").append(month + 1).append("/").append(day)
					.append(" "));

			// set selected date into datepicker also
			new_sender_personal_birthday_picker.init(year, month, day, null);

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
			new_sender_personal_idexpiry.setText(new StringBuilder().append(year)
					.append("/").append(month + 1).append("/").append(day)
					.append(" "));

			// set selected date into datepicker also
			new_sender_personal_birthday_picker.init(year, month, day, null);

		}
	};
}
