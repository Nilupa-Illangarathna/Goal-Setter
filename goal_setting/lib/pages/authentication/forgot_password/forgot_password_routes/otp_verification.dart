import 'dart:convert';
import 'package:flutter/material.dart';
import '../../../../global/api_caller.dart';
import '../../../../global/global_settings.dart';
import '../../../../utils/theme.dart';
import '../../../../widgets/login/otp_input_with_countdown.dart';

class ForgotPasswordOTPPage extends StatefulWidget {
  final Function(int) onNextStep;
  final String method; // 'email' or 'mobile'
  final String contact; // Email address or mobile number
  final Function sendOTP; // Function to send OTP

  const ForgotPasswordOTPPage({required this.onNextStep, required this.method, required this.contact, required this.sendOTP});

  @override
  _ForgotPasswordOTPPageState createState() => _ForgotPasswordOTPPageState();
}

class _ForgotPasswordOTPPageState extends State<ForgotPasswordOTPPage> {
  late String enteredOTP;

  Future<void> verifyOTP() async {
    final Map<String, dynamic> body = {
      'method': widget.method,
      'contact': widget.contact,
      'otp': enteredOTP,
    };

    final apiCaller = ApiCaller(baseUrl: globalData.baseUrlRoute);
    final response = await apiCaller.callApi('verify_otp', body);

    if (response != null && response['success']) {
      widget.onNextStep(3); // Move to the next step if OTP verification is successful
    } else {
      // Handle unsuccessful OTP verification
      print('OTP verification failed');
      // Optionally, show an error message to the user
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Enter the OTP',
            style: TextStyle(
              fontSize: AppTheme.forgotPasswordPageHeaderFontSize,
              fontWeight: AppTheme.forgotPasswordPageHeaderFontWeight,
              color: AppTheme.forgotPasswordPageHeaderColor,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 20.0),
          child: Text(
            'Enter the OTP we sent you via ${widget.method} to ${widget.contact}',
            style: TextStyle(
              fontSize: AppTheme.forgotPasswordPageSubheaderFontSize,
              color: AppTheme.forgotPasswordPageSubheaderColor,
            ),
          ),
        ),
        Container(
          height: 130,
          child: OtpInputWithCountdown(
            onTimerFinished: () {
              // Handle timer finished event
            },
            onResendPressed: (otp) {
              // Handle resend OTP button pressed event
              widget.sendOTP();
            },
            onOTPChanged: (otp) {
              enteredOTP = otp;
            },
          ),
        ),
        Center(
          child: ElevatedButton(
            onPressed: verifyOTP,
            child: Text('Verify'),
          ),
        ),
      ],
    );
  }
}
