package com.hindvds.gmtmoney.activity;

import java.util.ArrayList;
import java.util.Calendar;


import com.hindvds.gmtmoney.service.LoginService;
import com.hindvds.gmtmoney.R;

import android.app.AlertDialog;
import android.app.DatePickerDialog;
import android.app.Dialog;
import android.content.DialogInterface;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.view.inputmethod.InputMethodManager;
import android.widget.AdapterView;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.DatePicker;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.AdapterView.OnItemClickListener;

public class RegisterActivity extends BaseActivity {
	private EditText register_login_username, register_login_password,
			register_login_repassword, register_personal_firstname,
			register_personal_surname, register_personal_businessname,
			register_personal_birthday, register_personal_idno,
			register_personal_idexpiry, register_personal_idissuer,
			register_personal_occupation, register_business_street,
			register_business_suburb, register_business_postcode,
			register_business_street_pre, register_business_suburb_pre,
			register_business_postcode_pre, register_contact_primary,
			register_contact_second, register_contact_email;

	private AutoCompleteTextView register_personal_nationality,
			register_personal_identification, register_business_state,
			register_business_country, register_business_country_pre,
			register_business_state_pre, register_contact_primary_select,
			register_contact_second_select, register_source;

	private CheckBox register_business_checkbox_same, register_accept;

	private DatePicker register_personal_birthday_picker;
	private Button register_personal_birthday_btn,register_personal_idexpiry_btn;
	
	private TextView register_term_and_condition;
	
	private int year;
	private int month;
	private int day;
	
	private int idPosidentification;
	private int idPosstate;
	private int idPosstate_pre;
	private int idPoscontact_primary;
	private int idPoscontact_second;
	private int idPossource;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.register);

		initNavButton();
		Button register_btn_home = (Button) findViewById(R.id.register_btn_home);
		register_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});

		initFields();

		Button register_btn_submit = (Button) findViewById(R.id.register_btn_submit);
		register_btn_submit.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				checkValidateFields();
			}
		});

		setUpAutocompleteData();
		setDatePicker();
	}

	private void initFields() {
		register_login_username = (EditText) findViewById(R.id.register_login_username);
		register_login_password = (EditText) findViewById(R.id.register_login_password);
		register_login_repassword = (EditText) findViewById(R.id.register_login_repassword);
		register_personal_firstname = (EditText) findViewById(R.id.register_personal_firstname);
		register_personal_surname = (EditText) findViewById(R.id.register_personal_surname);
		register_personal_businessname = (EditText) findViewById(R.id.register_personal_businessname);
		register_personal_birthday = (EditText) findViewById(R.id.register_personal_birthday);
		register_personal_idno = (EditText) findViewById(R.id.register_personal_idno);
		register_personal_idexpiry = (EditText) findViewById(R.id.register_personal_idexpiry);
		register_personal_idissuer = (EditText) findViewById(R.id.register_personal_idissuer);
		register_personal_occupation = (EditText) findViewById(R.id.register_personal_occupation);
		register_business_street = (EditText) findViewById(R.id.register_business_street);
		register_business_suburb = (EditText) findViewById(R.id.register_business_suburb);
		register_business_postcode = (EditText) findViewById(R.id.register_business_postcode);
		register_business_street_pre = (EditText) findViewById(R.id.register_business_street_pre);
		register_business_suburb_pre = (EditText) findViewById(R.id.register_business_suburb_pre);
		register_business_postcode_pre = (EditText) findViewById(R.id.register_business_postcode_pre);
		register_contact_primary = (EditText) findViewById(R.id.register_contact_primary);
		register_contact_second = (EditText) findViewById(R.id.register_contact_second);
		register_contact_email = (EditText) findViewById(R.id.register_contact_email);

		register_personal_nationality = (AutoCompleteTextView) findViewById(R.id.register_personal_nationality);
		register_personal_identification = (AutoCompleteTextView) findViewById(R.id.register_personal_identification);
		register_business_state = (AutoCompleteTextView) findViewById(R.id.register_business_state);
		register_business_country = (AutoCompleteTextView) findViewById(R.id.register_business_country);
		register_business_country_pre = (AutoCompleteTextView) findViewById(R.id.register_business_country_pre);
		register_business_state_pre = (AutoCompleteTextView) findViewById(R.id.register_business_state_pre);
		register_contact_primary_select = (AutoCompleteTextView) findViewById(R.id.register_contact_primary_select);
		register_contact_second_select = (AutoCompleteTextView) findViewById(R.id.register_contact_second_select);
		register_source = (AutoCompleteTextView) findViewById(R.id.register_source);

		register_business_checkbox_same = (CheckBox) findViewById(R.id.register_business_checkbox_same);
		register_accept = (CheckBox) findViewById(R.id.register_accept);
		register_accept.setText("I certify that I have read and agree to all the above terms and conditions and confirm to receive all account related communications by phone, fax or email.");

		register_personal_birthday_btn = (Button) findViewById(R.id.register_personal_birthday_btn);
		register_personal_idexpiry_btn = (Button) findViewById(R.id.register_personal_idexpiry_btn);
		
		register_term_and_condition = (TextView) findViewById(R.id.register_term_and_condition);
		register_term_and_condition.setText(R.string.hello_world);
	}

	private void setDatePicker() {
		register_personal_birthday.setFocusable(false);
		register_personal_birthday.setFocusableInTouchMode(false);
		
		register_personal_idexpiry.setFocusable(false);
		register_personal_idexpiry.setFocusableInTouchMode(false);

		register_personal_birthday_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						showDialog(999);
					}
				});
		
		register_personal_idexpiry_btn
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
			for (int i = 0; i < RegisterActivity.countryList.size(); i++) {
				countryListItem.add(countryList.get(i).getCountryName());
			}
		}
		register_personal_nationality.setFocusable(false);
		register_personal_nationality.setFocusableInTouchMode(false);
		register_personal_nationality.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button register_personal_nationality_btn = (Button) findViewById(R.id.register_personal_nationality_btn);
		register_personal_nationality_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_personal_nationality.showDropDown();
					}
				});

		register_business_country.setFocusable(false);
		register_business_country.setFocusableInTouchMode(false);
		register_business_country.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button register_business_country_btn = (Button) findViewById(R.id.register_business_country_btn);
		register_business_country_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_business_country.showDropDown();
					}
				});

		register_business_country_pre.setFocusable(false);
		register_business_country_pre.setFocusableInTouchMode(false);
		register_business_country_pre.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, countryListItem));
		Button register_business_country_pre_btn = (Button) findViewById(R.id.register_business_country_pre_btn);
		register_business_country_pre_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_business_country_pre.showDropDown();
					}
				});

		String[] indentifyList = { "Drivers licence", "Passport", "Photo ID" };
		register_personal_identification.setFocusable(false);
		register_personal_identification.setFocusableInTouchMode(false);
		register_personal_identification.setAdapter(new ArrayAdapter<String>(
				this, android.R.layout.simple_dropdown_item_1line,
				indentifyList));
		Button register_personal_identification_btn = (Button) findViewById(R.id.register_personal_identification_btn);
		register_personal_identification_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_personal_identification.showDropDown();
					}
				});
		register_personal_identification.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPosidentification = arg2;
			}
	    });

		String[] stateList = { "NSW", "ACT", "VIC", "QLD", "SA", "WA", "NT",
				"TAS", "OTHER", "N/A" };
		register_business_state.setFocusable(false);
		register_business_state.setFocusableInTouchMode(false);
		register_business_state.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, stateList));
		Button register_business_state_btn = (Button) findViewById(R.id.register_business_state_btn);
		register_business_state_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_business_state.showDropDown();
					}
				});
		register_business_state.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPosstate = arg2;
			}
	    });

		register_business_state_pre.setFocusable(false);
		register_business_state_pre.setFocusableInTouchMode(false);
		register_business_state_pre.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, stateList));
		Button register_business_state_pre_btn = (Button) findViewById(R.id.register_business_state_pre_btn);
		register_business_state_pre_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_business_state_pre.showDropDown();
					}
				});
		register_business_state_pre.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPosstate_pre = arg2;
			}
	    });

		String[] contactList = { "HOME PHONE", "WORK PHONE", "MOBILE", "FAX" };
		register_contact_primary_select.setFocusable(false);
		register_contact_primary_select.setFocusableInTouchMode(false);
		register_contact_primary_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						contactList));
		Button register_contact_primary_select_btn = (Button) findViewById(R.id.register_contact_primary_select_btn);
		register_contact_primary_select_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_contact_primary_select.showDropDown();
					}
				});
		register_contact_primary_select.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPoscontact_primary = arg2;
			}
	    });

		register_contact_second_select.setFocusable(false);
		register_contact_second_select.setFocusableInTouchMode(false);
		register_contact_second_select
				.setAdapter(new ArrayAdapter<String>(this,
						android.R.layout.simple_dropdown_item_1line,
						contactList));
		Button register_contact_second_select_btn = (Button) findViewById(R.id.register_contact_second_select_btn);
		register_contact_second_select_btn
				.setOnClickListener(new View.OnClickListener() {
					public void onClick(View view) {
						register_contact_second_select.showDropDown();
					}
				});
		register_contact_second_select.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPoscontact_second = arg2;
			}
	    });

		String[] sourceList = { "Website", "Newspaper/Magazine", "Poster",
				"Printed/Web Article", "Direct Post", "Pamphlet",
				"Internet search engineer", "Email", "Seminar",
				"Tradeshow/Function", "Word of Mouth", "Others" };
		register_source.setFocusable(false);
		register_source.setFocusableInTouchMode(false);
		register_source.setAdapter(new ArrayAdapter<String>(this,
				android.R.layout.simple_dropdown_item_1line, sourceList));
		Button register_source_btn = (Button) findViewById(R.id.register_source_btn);
		register_source_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				register_source.showDropDown();
			}
		});
		register_source.setOnItemClickListener(new OnItemClickListener() {

			@Override
			public void onItemClick(AdapterView<?> arg0, View arg1, int arg2,
					long arg3) {
				// TODO Auto-generated method stub
				idPossource = arg2;
			}
	    });
	}

	private void checkValidateFields() {
		if (register_login_username.getText().toString().equals("")) {
			showDialog("Please enter your userid.");
		} else if (register_login_password.getText().toString().equals("")) {
			showDialog("Please enter your password.");
		} else if (!register_login_password.getText().toString()
				.equals(register_login_repassword.getText().toString())
				|| register_login_repassword.getText().toString().equals("")) {
			showDialog("Confirm password not match!");
		} else if (register_personal_firstname.getText().toString().equals("")) {
			showDialog("Please enter your first name!");
		} else if (register_personal_surname.getText().toString().equals("")) {
			showDialog("Please enter your last name!");
		} else if (register_personal_birthday.getText().toString().equals("")) {
			showDialog("Please select date of birth!");
		} else if (register_personal_identification.getText().toString()
				.equals("")) {
			showDialog("Please select identification!");
		} else if (register_personal_idno.getText().toString().equals("")) {
			showDialog("Please enter your identification number!");
		} else if (register_personal_idexpiry.getText().toString().equals("")) {
			showDialog("Please select id expiry!");
		} else if (register_personal_idissuer.getText().toString().equals("")) {
			showDialog("Please enter ID issuer!");
		} else if (register_personal_occupation.getText().toString().equals("")) {
			showDialog("Please enter your occupation!");
		} else if (register_business_street.getText().toString().equals("")) {
			showDialog("Please enter street address!");
		} else if (register_business_suburb.getText().toString().equals("")) {
			showDialog("Please enter subburb!");
		} else if (register_business_state.getText().toString().equals("")) {
			showDialog("Please select state!");
		} else if (register_business_postcode.getText().toString().equals("")) {
			showDialog("Please enter postcode!");
		} else if (register_business_country.getText().toString().equals("")) {
			showDialog("Please select country!");
		} else if (!register_business_checkbox_same.isChecked()) {
			if (register_business_street_pre.getText().toString().equals("")) {
				showDialog("Please enter street address in previous address!");
			} else if (register_business_suburb_pre.getText().toString()
					.equals("")) {
				showDialog("Please enter subburb in previous address!");
			} else if (register_business_state_pre.getText().toString()
					.equals("")) {
				showDialog("Please select state in previous address!");
			} else if (register_business_postcode_pre.getText().toString()
					.equals("")) {
				showDialog("Please enter postcode in previous address!");
			} else if (register_business_country_pre.getText().toString()
					.equals("")) {
				showDialog("Please select country in previous address!");
			} else if (register_contact_primary_select.getText().toString()
					.equals("")) {
				showDialog("Please select primary contact type!");
			} else if (register_contact_primary.getText().toString().equals("")) {
				showDialog("Please enter primary contact info!");
			} else if (register_contact_email.getText().toString().equals("")) {
				showDialog("Please enter email!");
			} else if (!register_accept.isChecked()) {
				showDialog("Please must accept our terms and conditions!");
			} else {
				InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
				imm.hideSoftInputFromWindow(register_contact_email.getWindowToken(),
						0);
				processRegister(register_contact_email.getText().toString(),
						register_login_username.getText().toString(),
						register_login_password.getText().toString(),
						register_personal_firstname.getText().toString(),
						register_personal_surname.getText().toString(),
						register_personal_businessname.getText().toString(),
						(register_personal_birthday.getText().toString()).trim(),
						getCountryID(register_personal_nationality.getText().toString()),
						String.valueOf(idPosidentification),
						register_personal_idno.getText().toString(),
						(register_personal_idexpiry.getText().toString()).trim(),
						register_personal_idissuer.getText().toString(),
						register_personal_occupation.getText().toString(),
						register_business_street.getText().toString(),
						register_business_suburb.getText().toString(),
						String.valueOf(idPosstate),
						register_business_postcode.getText().toString(),
						getCountryID(register_business_country.getText().toString()), "1",
						register_business_street_pre.getText().toString(),
						register_business_suburb_pre.getText().toString(),
						String.valueOf(idPosstate_pre),
						register_business_postcode_pre.getText().toString(),
						getCountryID(register_business_country_pre.getText().toString()),
						register_contact_primary.getText().toString(),
						register_contact_second.getText().toString(),
						String.valueOf(idPossource),
						String.valueOf(idPoscontact_primary),
						String.valueOf(idPoscontact_second));
			}
		} else if (register_contact_primary_select.getText().toString()
				.equals("")) {
			showDialog("Please select primary contact type!");
		} else if (register_contact_primary.getText().toString().equals("")) {
			showDialog("Please enter primary contact info!");
		} else if (register_contact_email.getText().toString().equals("")) {
			showDialog("Please enter email!");
		} else if (!register_accept.isChecked()) {
			showDialog("Please must accept our terms and conditions!");
		} else {
			InputMethodManager imm = (InputMethodManager) getSystemService(INPUT_METHOD_SERVICE);
			imm.hideSoftInputFromWindow(register_contact_email.getWindowToken(),
					0);
			processRegister(register_contact_email.getText().toString(),
					register_login_username.getText().toString(),
					register_login_password.getText().toString(),
					register_personal_firstname.getText().toString(),
					register_personal_surname.getText().toString(),
					register_personal_businessname.getText().toString(),
					(register_personal_birthday.getText().toString()).trim(),
					getCountryID(register_personal_nationality.getText().toString()),
					String.valueOf(idPosidentification),
					register_personal_idno.getText().toString(),
					(register_personal_idexpiry.getText().toString()).trim(),
					register_personal_idissuer.getText().toString(),
					register_personal_occupation.getText().toString(),
					register_business_street.getText().toString(),
					register_business_suburb.getText().toString(),
					String.valueOf(idPosstate),
					register_business_postcode.getText().toString(),
					getCountryID(register_business_country.getText().toString()), "1",
					register_business_street.getText().toString(),
					register_business_suburb.getText().toString(),
					String.valueOf(idPosstate),
					register_business_postcode.getText().toString(),
					getCountryID(register_business_country.getText().toString()),
					register_contact_primary.getText().toString(),
					register_contact_second.getText().toString(),
					String.valueOf(idPossource),
					String.valueOf(idPoscontact_primary),
					String.valueOf(idPoscontact_second));
		}
	}

	private void processRegister(String Email, String UserName,
			String Password, String FName, String SurName, String BisName,
			String DBirth, String NationID, String IdentyID, String IdCode,
			String IDExpiry, String IDIssuer, String Occup, String RStreet,
			String RSub, String RState, String RPost, String RCountryID,
			String PStatus, String PStreet, String PSub, String PState,
			String PPost, String PCountryID, String PContact, String SContact,
			String SourceD, String PCDet, String SCDet) {

		new RegisterAsyncTask().execute(Email, UserName, Password, FName,
				SurName, BisName, DBirth, NationID, IdentyID, IdCode, IDExpiry,
				IDIssuer, Occup, RStreet, RSub, RState, RPost, RCountryID,
				PStatus, PStreet, PSub, PState, PPost, PCountryID, PContact,
				SContact, SourceD, PCDet, SCDet);
	}

	private void showDialogSuccess(String msg) {
		AlertDialog.Builder builder1 = new AlertDialog.Builder(
				RegisterActivity.this);
		builder1.setMessage(msg)
				.setPositiveButton("OK", new DialogInterface.OnClickListener() {
					public void onClick(DialogInterface dialog, int which) {
						finish();
					}
				}).show();
	}

	private void setCurrentDateOnView() {

		register_personal_birthday_picker = (DatePicker) findViewById(R.id.register_personal_birthday_picker);

		final Calendar c = Calendar.getInstance();
		year = c.get(Calendar.YEAR);
		month = c.get(Calendar.MONTH);
		day = c.get(Calendar.DAY_OF_MONTH);

		// set current date into datepicker
		register_personal_birthday_picker.init(year, month, day, null);
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
				LoginService loginService = new LoginService();
				value = loginService.register(aurl[0], aurl[1], aurl[2],
						aurl[3], aurl[4], aurl[5], aurl[6], aurl[7], aurl[8],
						aurl[9], aurl[10], aurl[11], aurl[12], aurl[13],
						aurl[14], aurl[15], aurl[16], aurl[17], aurl[18],
						aurl[19], aurl[20], aurl[21], aurl[22], aurl[23],
						aurl[24], aurl[25], aurl[26], aurl[27], aurl[28]);
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
				showDialogSuccess("Successful! Please check your email for more info to verify your account!");
			} else {
				showDialog(value);
			}
		}
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
			register_personal_birthday.setText(new StringBuilder().append(year)
					.append("/").append(month + 1).append("/").append(day)
					.append(" "));

			// set selected date into datepicker also
			register_personal_birthday_picker.init(year, month, day, null);

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
			register_personal_idexpiry.setText(new StringBuilder().append(year)
					.append("/").append(month + 1).append("/").append(day)
					.append(" "));

			// set selected date into datepicker also
			register_personal_birthday_picker.init(year, month, day, null);

		}
	};
}
