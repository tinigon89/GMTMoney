package com.teamios.info.gmtmoney.activity;

import java.util.ArrayList;

import com.teamios.info.gmtmoney.R;

import android.content.Intent;
import android.os.Bundle;
import android.text.Editable;
import android.text.TextWatcher;
import android.view.View;
import android.widget.ArrayAdapter;
import android.widget.AutoCompleteTextView;
import android.widget.Button;
import android.widget.EditText;

public class CalculatorActivity extends BaseActivity {
	private AutoCompleteTextView to;

	@Override
	protected void onCreate(Bundle savedInstanceState) {
		super.onCreate(savedInstanceState);
		setContentView(R.layout.calculator);
		
		initNavButton();
		Button webview_btn_home = (Button) findViewById(R.id.calculator_btn_home);
		webview_btn_home.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				finish();
			}
		});
		
		EditText from = (EditText) findViewById(R.id.calculator_from);
		final EditText calculator_amount = (EditText) findViewById(R.id.calculator_amount);
		final EditText calculator_rate = (EditText) findViewById(R.id.calculator_rate);
		final EditText calculator_total = (EditText) findViewById(R.id.calculator_total);
		from.setFocusable(false);
		from.setFocusableInTouchMode(false);
		calculator_total.setFocusable(false);
		calculator_total.setFocusableInTouchMode(false);
		calculator_rate.setFocusable(false);
		calculator_rate.setFocusableInTouchMode(false);
		calculator_amount.setFocusable(false);
		calculator_amount.setFocusableInTouchMode(false);
		
		to = (AutoCompleteTextView) findViewById(R.id.calculator_to);
		to.setFocusable(false);
		to.setFocusableInTouchMode(false);
		
		ArrayList<String> item = new ArrayList<String>();
		for(int i=0; i< listDailyRates.size(); i++){
			item.add(listDailyRates.get(i).getCurrSym());
		}
		to.setAdapter(new ArrayAdapter<String>(this, android.R.layout.simple_dropdown_item_1line, item));
		to.addTextChangedListener(new TextWatcher() {

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
				calculator_amount.setFocusable(true);
				calculator_amount.setFocusableInTouchMode(true);
				calculator_rate.setText(getRates());
				if(calculator_amount.getText().toString().equals("")){
					calculator_total.setText("0.0000");
				} else {
					calculator_total.setText(String.valueOf(Float.parseFloat(calculator_amount.getText().toString()) * Float.parseFloat(calculator_rate.getText().toString())));
				}
			}
		});
		
		calculator_amount.addTextChangedListener(new TextWatcher() {

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
				if(calculator_amount.getText().toString().equals("")){
					calculator_total.setText("0.0000");
				} else {
					calculator_total.setText(String.valueOf(Float.parseFloat(calculator_amount.getText().toString()) * Float.parseFloat(calculator_rate.getText().toString())));
				}
			}
		});
		
		Button calculator_to_btn = (Button) findViewById(R.id.calculator_to_btn);
		calculator_to_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				to.showDropDown();
			}
		});
		
		Button calculator_send_money_btn = (Button) findViewById(R.id.calculator_send_money_btn);
		calculator_send_money_btn.setOnClickListener(new View.OnClickListener() {
			public void onClick(View view) {
				if(getSharedPreferences("isLogin").equals("true")){
					Intent i = new Intent(getBaseContext(), AccountActivity.class);
					startActivity(i);
				} else {
					Intent i = new Intent(getBaseContext(), LoginActivity.class);
					startActivity(i);
				}
				finish();
			}
		});
	}
	
	private String getRates(){
		String val = "";
		for(int i=0; i< listDailyRates.size(); i++){
			if(to.getText().toString().equals(listDailyRates.get(i).getCurrSym())){
				val = listDailyRates.get(i).getERate();
			}
		}
		return val;
	}
}
