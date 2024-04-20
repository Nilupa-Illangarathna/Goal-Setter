import 'package:flutter/material.dart';

import '../utils/user_credentials.dart';

class GlobalData {
  //Base URL
  String baseUrlRoute = 'http://10.0.2.2:3500';
  //Encrypt enable
  bool encryptEnable=true;

  //AppName
  String AppName = "GoalSettingApp";
  //User Credentials
  String _username = "";
  String _password = ""; //TODO
  //Splash
  int splashTime = 4; //should be 4
  //Forgot password
  bool forgotPass = true;
    bool forgotPassEmail = true; // Add email attribute
    bool forgotPassMobile = true; // Add mobile attribute

  //Global cli print enable
  bool print_enabled = true;

  //OTP related
  int otpDigitCount = 4; // Number of OTP digits
  int otpCountdownTime = 15; // Countdown time for OTP
  bool isNumaricOTP=true; // KeyBoard type for OTP


  //Homepage realated
  //App drawer
  bool enableDrawer = false;
  int homePageViewTransTime = 200; //Between two pages

  // Firebase notifications
  String FirebaseServiceToken='';

  // Constructor
  GlobalData() {
    _loadUserCredentials(); // Load user credentials on object creation
  }

  // Load user credentials from SharedPreferences
  _loadUserCredentials() async {
    Map<String, String> credentials = await userCredentials.getCredentials();
    _username = credentials['username'] ?? '';
    _password = credentials['password'] ?? '';
  }

  // Getters for username and password
  String get username => _username;
  String get password => _password;

  //methods
  updateData() async {
    await _loadUserCredentials();
  }

  void printData() {
    print('GlobalData:');
    print('  AppName: $AppName');
    print('  Username: $_username');
    print('  Password: $_password');
    print('  SplashTime: $splashTime');
    print('  ForgotPass: $forgotPass');
    print('  ForgotPassEmail: $forgotPassEmail');
    print('  ForgotPassMobile: $forgotPassMobile');
    print('  PrintEnabled: $print_enabled');
    print('  BaseUrlRoute: $baseUrlRoute');
    print('  OTPDigitCount: $otpDigitCount');
    print('  OTPCountdownTime: $otpCountdownTime');
    print('  IsNumericOTP: $isNumaricOTP');
  }
}

GlobalData globalData = GlobalData();