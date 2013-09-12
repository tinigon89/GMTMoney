package com.hindvds.gmtmoney.activity;

import com.hindvds.gmtmoney.service.RemittanceService;
import com.hindvds.gmtmoney.R;

import android.content.Intent;
import android.os.AsyncTask;
import android.os.Bundle;
import android.view.View;
import android.widget.Button;
import android.widget.CheckBox;
import android.widget.EditText;
import android.widget.LinearLayout;

public class Step4Activity extends BaseActivity {

	private EditText step4_sender_fullname, step4_sender_dateofbirth,
			step4_sender_nationally, step4_sender_companyname,
			step4_sender_identification, step4_sender_primarycontact,
			step4_sender_secondarycontact, step4_sender_email,
			step4_sender_residentialaddress, step4_sender_businessaddress,
			step4_sender_postaladdress, step4_beneficiary_fullname,
			step4_beneficiary_companyname, step4_beneficiary_identification,
			step4_beneficiary_primarycontact,
			step4_beneficiary_secondarycontact, step4_beneficiary_email,
			step4_beneficiary_redidentialbusinessaddress, step4_bank_bankname,
			step4_bank_code1, step4_bank_code2, step4_bank_code3,
			step4_bank_address, step4_bank_holdername,
			step4_bank_accountnumber, step4_transfer_payment,
			step4_transfer_commission, step4_transfer_transfer,
			step4_transfer_exchange, step4_transfer_foreign,
			step4_transfer_comments;
	private CheckBox step4_checkbox_agreement;
	private LinearLayout step4_bank_review;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.remittance_step4);

		initNavButton();
		Button step4_btn_home = (Button) findViewById(R.id.step4_btn_home);
		step4_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		initFields();

		Button step4_btn_next = (Button) findViewById(R.id.step4_btn_next);
		step4_btn_next.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if(!step4_checkbox_agreement.isChecked()){
					showDialog("You must agree to continue!");
				} else {
					new submitAsyncTask().execute(
							getSharedPreferences("RegisterID"),
							getSharedPreferences("remid"),
							getSharedPreferences("senderid"),
							getSharedPreferences("PayMethod"),
							getSharedPreferences("beneId"),
							getSharedPreferences("bankId"),
							getSharedPreferences("online"));
				}
			}
		});
	}
	
	private void initFields(){
		step4_sender_fullname = (EditText) findViewById(R.id.step4_sender_fullname);
		step4_sender_dateofbirth = (EditText) findViewById(R.id.step4_sender_dateofbirth);
		step4_sender_nationally = (EditText) findViewById(R.id.step4_sender_nationally);
		step4_sender_companyname = (EditText) findViewById(R.id.step4_sender_companyname);
		step4_sender_identification = (EditText) findViewById(R.id.step4_sender_identification);
		step4_sender_primarycontact = (EditText) findViewById(R.id.step4_sender_primarycontact);
		step4_sender_secondarycontact = (EditText) findViewById(R.id.step4_sender_secondarycontact);
		step4_sender_email = (EditText) findViewById(R.id.step4_sender_email);
		step4_sender_residentialaddress = (EditText) findViewById(R.id.step4_sender_residentialaddress);
		step4_sender_businessaddress = (EditText) findViewById(R.id.step4_sender_businessaddress);
		step4_sender_postaladdress = (EditText) findViewById(R.id.step4_sender_postaladdress);
		step4_beneficiary_fullname = (EditText) findViewById(R.id.step4_beneficiary_fullname);
		step4_beneficiary_companyname = (EditText) findViewById(R.id.step4_beneficiary_companyname);
		step4_beneficiary_identification = (EditText) findViewById(R.id.step4_beneficiary_identification);
		step4_beneficiary_primarycontact = (EditText) findViewById(R.id.step4_beneficiary_primarycontact);
		step4_beneficiary_secondarycontact = (EditText) findViewById(R.id.step4_beneficiary_secondarycontact);
		step4_beneficiary_email = (EditText) findViewById(R.id.step4_beneficiary_email);
		step4_beneficiary_redidentialbusinessaddress = (EditText) findViewById(R.id.step4_beneficiary_redidentialbusinessaddress);
		step4_bank_bankname = (EditText) findViewById(R.id.step4_bank_bankname);
		step4_bank_code1 = (EditText) findViewById(R.id.step4_bank_code1);
		step4_bank_code2 = (EditText) findViewById(R.id.step4_bank_code2);
		step4_bank_code3 = (EditText) findViewById(R.id.step4_bank_code3);
		step4_bank_address = (EditText) findViewById(R.id.step4_bank_address);
		step4_bank_holdername = (EditText) findViewById(R.id.step4_bank_holdername);
		step4_bank_accountnumber = (EditText) findViewById(R.id.step4_bank_accountnumber);
		step4_transfer_payment = (EditText) findViewById(R.id.step4_transfer_payment);
		step4_transfer_commission = (EditText) findViewById(R.id.step4_transfer_commission);
		step4_transfer_transfer = (EditText) findViewById(R.id.step4_transfer_transfer);
		step4_transfer_exchange = (EditText) findViewById(R.id.step4_transfer_exchange);
		step4_transfer_foreign = (EditText) findViewById(R.id.step4_transfer_foreign);
		step4_transfer_comments = (EditText) findViewById(R.id.step4_transfer_comments);
		step4_checkbox_agreement = (CheckBox) findViewById(R.id.step4_checkbox_agreement);
		step4_bank_review = (LinearLayout) findViewById(R.id.step4_bank_review);
		
		int step2 = Integer.parseInt(getSharedPreferences("step2_position"));
		step4_sender_fullname.setText(listSenderInfo.get(step2).getFName() + " " + listSenderInfo.get(step2).getSurName());
		step4_sender_dateofbirth.setText(getDateFromMilli(listSenderInfo.get(step2).getDBirth(), "MM/dd/yyyy"));
		step4_sender_nationally.setText(getNationFromId(listSenderInfo.get(step2).getNationID()));
		step4_sender_companyname.setText(listSenderInfo.get(step2).getBisName());
		step4_sender_identification.setText(listSenderInfo.get(step2).getIdCode());
		step4_sender_primarycontact.setText(listSenderInfo.get(step2).getPContact());
		step4_sender_secondarycontact.setText(listSenderInfo.get(step2).getSContact());
		step4_sender_email.setText(listSenderInfo.get(step2).getEmail());
		step4_sender_residentialaddress.setText(listSenderInfo.get(step2).getRStreet());
		step4_sender_businessaddress.setText(listSenderInfo.get(step2).getBisName());
		step4_sender_postaladdress.setText(listSenderInfo.get(step2).getRSub() + "," + listSenderInfo.get(step2).getRState() + "," + listSenderInfo.get(step2).getRPost());
				
		int step3 = Integer.parseInt(getSharedPreferences("step3_position"));
		step4_beneficiary_fullname.setText(listBeneficiaryInfo.get(step3).getFirstN() + " " + listBeneficiaryInfo.get(step3).getSurN());
		step4_beneficiary_companyname.setText(listBeneficiaryInfo.get(step3).getCompN());
		step4_beneficiary_identification.setText(listBeneficiaryInfo.get(step3).getIDNo());
		step4_beneficiary_primarycontact.setText(listBeneficiaryInfo.get(step3).getPCont());
		step4_beneficiary_secondarycontact.setText(listBeneficiaryInfo.get(step3).getSCont());
		step4_beneficiary_email.setText(listBeneficiaryInfo.get(step3).getEmails1());
		step4_beneficiary_redidentialbusinessaddress.setText(listBeneficiaryInfo.get(step3).getAddL1());
		
		if(getSharedPreferences("PayMethod").equals("2")){
			int step3cont = Integer.parseInt(getSharedPreferences("step3cont_position"));
			step4_bank_bankname.setText(listBankInfo.get(step3cont).getBankName());
			step4_bank_code1.setText(listBankInfo.get(step3cont).getBankCode());
			step4_bank_code2.setText(listBankInfo.get(step3cont).getSwiftCode());
			step4_bank_code3.setText(listBankInfo.get(step3cont).getRouteNo());
			step4_bank_address.setText(listBankInfo.get(step3cont).getBranch1());
			step4_bank_holdername.setText(listBankInfo.get(step3cont).getAcHolderName());
			step4_bank_accountnumber.setText(listBankInfo.get(step3cont).getACNo());
		} else {
			step4_bank_review.setVisibility(View.GONE);
		}
		
		step4_transfer_payment.setText(getSharedPreferences("step4_transfer_payment"));
		step4_transfer_commission.setText(getSharedPreferences("step4_transfer_commission"));
		step4_transfer_transfer.setText(getSharedPreferences("step4_transfer_transfer"));
		step4_transfer_exchange.setText(getSharedPreferences("step4_transfer_exchange"));
		step4_transfer_foreign.setText(getSharedPreferences("step4_transfer_foreign"));
		step4_transfer_comments.setText(getSharedPreferences("step4_transfer_comments"));
	}
	
	private String getNationFromId(String id) {
		String val = "";
		for (int i = 0; i < countryList.size(); i++) {
			if (id.equals(countryList.get(i).getCountryID())) {
				val = countryList.get(i).getCountryName();
			}
		}
		return val;
	}

	private class submitAsyncTask extends AsyncTask<String, Integer, String> {

		@Override
		protected void onPreExecute() {
			super.onPreExecute();
			openProcessLoading(false);
		}

		@Override
		protected String doInBackground(String... aurl) {
			try {
				RemittanceService remittanceService = new RemittanceService();
				remittanceService.submitStep4(aurl[0], aurl[1], aurl[2],
						aurl[3], aurl[4], aurl[5], aurl[6]);
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
			try {
				Intent i = new Intent(getBaseContext(), SuccessActivity.class);
				startActivity(i);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
	}
}
