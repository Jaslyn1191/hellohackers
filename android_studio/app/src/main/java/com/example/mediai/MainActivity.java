package com.example.mediai;

import androidx.appcompat.app.AppCompatActivity;

import android.content.Intent;
import android.content.SharedPreferences;
import android.os.Bundle;
import android.widget.Button;
import android.widget.TextView;
import android.widget.Toast;
import androidx.activity.compose.ComponentActivityKt;
import com.example.mediai.ui.ChatScreenKt;
import com.example.mediai.ui.theme.ThemeKt;

import java.util.Set;

import java.util.HashSet;
/**
 * Represents the main class for running the app.
 */


public class MainActivity extends AppCompatActivity {

        @Override
        protected void onCreate(Bundle savedInstanceState) {
            super.onCreate(savedInstanceState);
//            ComponentActivityKt.setContent(this, null, (composer, i) -> {
//                ThemeKt.MediAITheme(false, true, (composer1, i1) -> {
//                    ChatScreenKt.ChatScreen(null, composer1, 0, 1);
//                    return null;
//                }, composer, 0x30);
//                return null;
            });
            }

}
