import 'package:flutter/material.dart';

class AppTheme {
  static const Color primaryColor = Color(0xFF8843E8);
  static const Color primaryColorLight = Color(0xFFB0A3E5);
  static const Color textColor = Color(0xFF333333);
  static const Color subtextColor = Color(0xFF888888);
  static const Color backgroundColor = Colors.white;
  static const Color errorColor = Colors.redAccent;
  static const secondryColor = Color(0xff34C559);
  static const colorGray = Color(0xff8F959E);
  static const lightGray = Color(0xffF5F5F5);
  static const textColor1 = Color(0xff1D1E20);
  static const mainColor = Color(0xff9775FA);

  static ThemeData get theme {
    return ThemeData(
      primaryColor: primaryColor,
      scaffoldBackgroundColor: backgroundColor,
      fontFamily:
          'Poppins', 
      appBarTheme: const AppBarTheme(
        backgroundColor: backgroundColor,
        elevation: 0,
        iconTheme: IconThemeData(color: textColor),
      ),

      textTheme: const TextTheme(
        displayLarge: TextStyle(
          fontSize: 28.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        displayMedium: TextStyle(
          fontSize: 24.0,
          fontWeight: FontWeight.bold,
          color: textColor,
        ),
        titleMedium: TextStyle(fontSize: 16.0, color: subtextColor),
        bodyLarge: TextStyle(fontSize: 14.0, color: textColor),
      ),

      inputDecorationTheme: InputDecorationTheme(
        labelStyle: const TextStyle(color: subtextColor),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black12),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),

      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          foregroundColor: Colors.white,
          backgroundColor: primaryColor,
          minimumSize: const Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
