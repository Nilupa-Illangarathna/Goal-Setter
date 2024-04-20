import 'package:flutter/material.dart';
import 'forgot_password_page.dart';
import 'forgot_password_routes/PasswordResetCompletePage.dart';
import 'forgot_password_routes/otp_verification.dart';
import 'forgot_password_routes/reset_password.dart';
import 'forgot_password_routes/send_otp.dart';

class ForgotPasswordModelBottomSheet extends StatefulWidget {
  @override
  _ForgotPasswordModelBottomSheetState createState() => _ForgotPasswordModelBottomSheetState();
}

class _ForgotPasswordModelBottomSheetState extends State<ForgotPasswordModelBottomSheet> {
  late int step;
  late String method; // Variable to store method
  late String contact; // Variable to store contact
  late Function _sendOTP; // Variable to store the _sendOTP function


  @override
  void initState() {
    super.initState();
    step = 1;
  }

  void moveToNextStep(int nextStep) {
    setState(() {
      step = nextStep;
    });
  }

  void saveMethodAndContact(String selectedMethod, String enteredContact, Function sendOTP) {
    setState(() {
      method = selectedMethod;
      contact = enteredContact;
      _sendOTP = sendOTP; // Save the _sendOTP function
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget currentPage;
    switch (step) {
      case 1:
        currentPage = ForgotPasswordPage(
          onNextStep: moveToNextStep,
          onSaveMethodAndContact: saveMethodAndContact, // Pass the callback function
        );
        break;
      case 2:
        currentPage = ForgotPasswordOTPPage(
          onNextStep: moveToNextStep,
          method: method, // Pass method to OTP page
          contact: contact, // Pass contact to OTP page
          sendOTP: _sendOTP, // Pass the _sendOTP function
        );
        break;
      case 3:
        currentPage = ResetPasswordPage(
          onNextStep: moveToNextStep,
          method: method, // Pass method to OTP page
          contact: contact, // Pass contact to OTP page
        );
        break;
      case 4:
        currentPage = PasswordResetCompletePage(
          onClose: () {
            Navigator.pop(context);
          },
        );
        break;
      default:
        currentPage = Container();
    }

    return Material(
      child: Container(
        padding: EdgeInsets.all(20.0),
        child: currentPage,
      ),
    );
  }
}
