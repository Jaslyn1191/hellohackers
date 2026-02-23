package com.example.mediai;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Button;
import android.widget.EditText;
import android.widget.TextView;
import android.widget.Toast;
import androidx.activity.compose.ComponentActivityKt;
import com.example.mediai.ui.ChatScreenKt;
import com.example.mediai.ui.theme.ThemeKt;

import java.util.Set;

import java.util.HashSet;

public class UserLogin extends AppCompatActivity {

    private Button loginButton, signupButton;
    private TextView forgotPassword, pharmacistLogin;
    private EditText userEmail, userPassword;

    protected void onCreate(Bundle savedInstance) {
        super.onCreate(savedInstance);
        setContentView(R.layout.user_login_page);


        loginButton = findViewById(R.id.user_login);
        signupButton = findViewById(R.id.user_signup);
        forgotPassword = findViewById(R.id.forgot_password);
        pharmacistLogin = findViewById(R.id.pharmacist_login);
        userEmail = findViewById(R.id.userEmail);
        userPassword = findViewById(R.id.userPassword);



        loginButton.setOnClickListener(b -> {
            String email = userEmail.getText().toString();
            String password = userPassword.getText().toString();

            //check empty fields
            if (email.isEmpty()) {
                userEmail.setError("Email required");
                return;
            }

            if (password.isEmpty()) {
                userPassword.setError("Password required");
                return;
            }


        });


        signupButton.setOnClickListener(b -> {
            Intent intent = new Intent(UserLogin.this, UserSignUp.class);
            startActivity(intent);
        });

    }

    private boolean isPasswordEmpty() {
        String password = userPassword.getText().toString();
        return password.isEmpty();
    }

    @Override
    protected void onResume() {
        super.onResume();
    }

    //add functions for the buttons
    private void generateQuote() {

        QuoteAPI.fetchRandomQuote(new QuoteAPI.QuoteCallBack() {
            @Override
            public void onSuccess(Quote quote) { //Quote object hv 2 attributes
                currentQuote = quote;
                quoteText.setText(quote.quoteTitle);
                quoteAuthor.setText("- " + quote.quoteAuthor);
            }

            @Override
            public void onFailed(String error) {
                quoteText.setText("Error: " + error);
                quoteAuthor.setError(" ");
            }
        });
    }

    private void SaveToList(){
        if (currentQuote == null) return;

        //shared pref: local storage for android, small data
        //savedQuotes: name of the storage file
        SharedPreferences sharedPreferences = getSharedPreferences("savedQuotes" , MODE_PRIVATE);

        //if ntg then hashset created by default
        //updated is to prevent direct change in original hashset, so create a copy
        Set<String> savedQuotes = sharedPreferences.getStringSet("quotes" , new HashSet<>());
        Set<String> updated = new HashSet<>(savedQuotes);
        String formatted = currentQuote.quoteTitle + " - " + currentQuote.quoteAuthor;
        updated.add(formatted);

        //update/add the new quote to the sharedPref
        //.apply() saves asynchronously, faster
        sharedPreferences.edit().putStringSet("quotes" , updated).apply();

        //Toast = small popup msg
        Toast.makeText(this , "Quote saved!" , Toast.LENGTH_SHORT).show();

    }

}
