import 'package:flutter/material.dart';
import '../transitions/page_transition_rgt_to_lft.dart';

class AppTheme {
  static final ThemeData themeData = ThemeData(
    primaryColor: Colors.indigo,
    scaffoldBackgroundColor: Colors.grey[200],
    appBarTheme: AppBarTheme(
      color: Colors.indigo,
      elevation: 0,
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        elevation: MaterialStateProperty.all<double?>(3),
        backgroundColor: MaterialStateProperty.all<Color>(Colors.white),
        shape: MaterialStateProperty.all<OutlinedBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      ),
    ),
    inputDecorationTheme: inputDecorationTheme, // Reuse the input decoration theme defined below
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: MaterialStateProperty.all<Color>(Colors.indigo),
        textStyle: MaterialStateProperty.all<TextStyle>(
          TextStyle(
            fontWeight: FontWeight.bold,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
    ),
    pageTransitionsTheme: PageTransitionsTheme(
      builders: {
        TargetPlatform.android: CustomPageTransitionsBuilder(
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 600),
        )

        ,
        TargetPlatform.iOS: CustomPageTransitionsBuilder(
          curve: Curves.fastOutSlowIn,
          duration: Duration(milliseconds: 600),
        )

        ,
      },
    ),
  );

  static final InputDecorationTheme inputDecorationTheme = InputDecorationTheme(
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(10.0),
    ),
    filled: true,
    fillColor: Colors.white,
  );

  static final TextStyle forgotPasswordTextStyle = TextStyle(
    fontSize: 16.0,
    color: Colors.indigo,
    fontWeight: FontWeight.bold,
    decoration: TextDecoration.underline,
  );

  // Additional theme data
  static final TextStyle headerTextStyle = TextStyle(
    fontSize: 24.0,
    fontWeight: FontWeight.bold,
    color: Colors.indigo,
  );

  static final TextStyle buttonTextStyle = TextStyle(
    fontSize: 18.0,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  // New theme data for InkWell buttons
  static final double inkWellHorizontalPadding = 80.0; // Default horizontal padding
  static final double inkWellHorizontalPaddingBothOptions = 60.0; // Horizontal padding when both email and mobile options are available

  static double calculateInkWellHorizontalPadding(bool hasBothOptions) {
    return hasBothOptions ? inkWellHorizontalPaddingBothOptions : inkWellHorizontalPadding;
  }

  static final BorderRadius inkWellBorderRadius = BorderRadius.circular(10.0); // Default border radius for InkWell buttons

  // New theme data for OtpInputWithCountdown widget
  static final double otpInputHeight = 48.0; // Height of the OTP input field
  static final double otpInputWidthFactor = 0.25; // Width factor of the OTP input field
  static final double otpInputBorderRadius = 12.0; // Border radius of the OTP input field
  static final double otpInputSpacing = 16.0; // Spacing between OTP input fields
  static final double otpCountdownHeight = 22.0; // Height of the countdown timer
  static final double otpCountdownFontSize = 13.0; // Font size of the countdown timer
  static final FontWeight otpCountdownFontWeight = FontWeight.w400; // Font weight of the countdown timer

  // Additional styles from ForgotPasswordOTPPage
  static final double forgotPasswordPageHeaderFontSize = 20.0;
  static final FontWeight forgotPasswordPageHeaderFontWeight = FontWeight.bold;
  static final Color forgotPasswordPageHeaderColor = Colors.black87;

  static final double forgotPasswordPageSubheaderFontSize = 16.0;
  static final Color forgotPasswordPageSubheaderColor = Colors.black87;

}
