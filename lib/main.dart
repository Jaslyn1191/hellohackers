import 'package:flutter/material.dart';
import 'profile_page.dart';
import 'payment_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'OTC Medicine App',
      theme: ThemeData(
        // Darker blue as primary color
        primarySwatch: Colors.blue,
        primaryColor: const Color(0xFF1976D2), // Darker blue
        scaffoldBackgroundColor: Colors.white,
        
        // Color scheme
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.blue,
        ).copyWith(
          primary: const Color(0xFF1976D2), // Darker blue
          secondary: Colors.green,
          surface: Colors.white,
        ),
        
        // App Bar Theme
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF1976D2), // Darker blue app bar
          foregroundColor: Colors.white, // White text/icons for contrast
          elevation: 4,
          centerTitle: true,
        ),
        
        // Button Themes
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.green,
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
          ),
        ),
        
        // Text Button Theme
        textButtonTheme: TextButtonThemeData(
          style: TextButton.styleFrom(
            foregroundColor: const Color(0xFF1976D2), // Darker blue for text buttons
          ),
        ),
        
        // Input Decoration Theme - DARKER BORDERS
        inputDecorationTheme: InputDecorationTheme(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black54, width: 1.5), // Darker border
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.black45, width: 1.5), // Darker enabled border
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.green, width: 2.5), // Green when focused
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Colors.red, width: 1.5),
          ),
          labelStyle: const TextStyle(color: Color(0xFF1976D2)), // Darker blue labels
          prefixIconColor: const Color(0xFF1976D2), // Darker blue icons
          suffixIconColor: const Color(0xFF1976D2), // Darker blue suffix icons
          hintStyle: TextStyle(color: Colors.grey[600]),
        ),
        
        // Card Theme
        cardTheme: const CardThemeData(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(15)),
          ),
          color: Colors.white,
        ),
        
        useMaterial3: true,
      ),
      home: const PaymentPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}