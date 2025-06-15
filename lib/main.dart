
import 'package:abans_city_clean_supervisor/screens/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(AbansApp());
}

class AbansApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Abans Environmental Services',
      theme: ThemeData(
        primarySwatch: MaterialColor(0xFF6A1B9A, {
          50: Color(0xFFE8E2F3),
          100: Color(0xFFC5B8E1),
          200: Color(0xFF9E89CE),
          300: Color(0xFF7759BB),
          400: Color(0xFF5A36AC),
          500: Color(0xFF6A1B9A),
          600: Color(0xFF5E1892),
          700: Color(0xFF511488),
          800: Color(0xFF45117E),
          900: Color(0xFF320B6C),
        }),
        scaffoldBackgroundColor: Color(0xFFFFF8E1),
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFF6A1B9A),
          foregroundColor: Colors.white,
          elevation: 0,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF6A1B9A),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF6A1B9A)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Color(0xFF6A1B9A), width: 2),
          ),
        ),
      ),
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}