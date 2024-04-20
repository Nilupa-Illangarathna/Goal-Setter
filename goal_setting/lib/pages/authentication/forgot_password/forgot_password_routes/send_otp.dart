import 'package:flutter/material.dart';
import '../../../../global/api_caller.dart';
import '../../../../global/global_settings.dart';
import '../../../../utils/theme.dart';
import '../../../../global/regex.dart';
import '../../../../utils/error_handling.dart';

class ForgotPasswordPage extends StatefulWidget {
  final Function(int) onNextStep;
  final Function(String, String, Function) onSaveMethodAndContact; // Updated callback to include the _sendOTP function

  const ForgotPasswordPage({required this.onNextStep, required this.onSaveMethodAndContact});


  @override
  _ForgotPasswordPageState createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  late bool isEmailSelected;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  String emailError = '';
  String mobileError = '';

  @override
  void initState() {
    super.initState();
    isEmailSelected =
        globalData.forgotPassEmail; // Set default based on global data
  }

  void _submitData() {
    setState(() {
      emailError = '';
      mobileError = '';

      // Validate email or mobile based on selection
      if (isEmailSelected) {
        if (emailController.text.isEmpty) {
          emailError = ErrorHandling.sentOtp['otpsend']['email'];
        } else if (!Regex.emailRegExp.hasMatch(emailController.text)) {
          emailError = ErrorHandling.sentOtp['otpsend']['email'];
        }
      } else {
        if (mobileController.text.isEmpty) {
          mobileError = ErrorHandling.sentOtp['otpsend']['mobile'];
        } else if (!Regex.mobileRegExp.hasMatch(mobileController.text)) {
          mobileError = ErrorHandling.sentOtp['otpsend']['mobile'];
        }
      }

      // Move to the next step if there are no errors
      if (isEmailSelected && emailError.isEmpty ||
          !isEmailSelected && mobileError.isEmpty) {
        _sendOTP();
      }
    });
  }

  void _sendOTP() async {
    String method = isEmailSelected ? 'email' : 'mobile';
    String contact = isEmailSelected ? emailController.text : mobileController.text;

    // Save method and contact using callback function
    widget.onSaveMethodAndContact(method, contact, _sendOTP);

    // Call the API to send OTP with additional parameters
    final response = await apiCaller.callApi('send_otp', {
      'method': method,
      'contact': contact,
      'isNumericOTP': globalData.isNumaricOTP,
      'otpDigitCount': globalData.otpDigitCount,
      'otpCountdownTime': globalData.otpCountdownTime,
    });

    if (response != null && response['success'] == true) {
      // OTP sent successfully
      print('OTP sent successfully.');
      // Move to the next step (OTP input view)
      widget.onNextStep(2);
    } else {
      // Failed to send OTP
      print('Failed to send OTP. Please try again.');
      // Handle the failure scenario (show error message, retry option, etc.)
    }
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Forgot Password',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            InkWell(
              onTap: () {
                setState(() {
                  isEmailSelected = true;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: AppTheme.calculateInkWellHorizontalPadding(
                        globalData.forgotPassEmail &&
                            globalData.forgotPassMobile)),
                decoration: BoxDecoration(
                  color: isEmailSelected ? Colors.indigo : Colors.grey.shade300,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    bottomLeft: Radius.circular(10),
                    topRight: Radius.circular(globalData.forgotPassEmail &&
                            globalData.forgotPassMobile
                        ? 0
                        : 10),
                    bottomRight: Radius.circular(globalData.forgotPassEmail &&
                            globalData.forgotPassMobile
                        ? 0
                        : 10),
                  ),
                ),
                child: Text(
                  'Email',
                  style: TextStyle(
                    color: isEmailSelected ? Colors.white : Colors.black,
                  ),
                ),
              ),
            ),
            InkWell(
              onTap: () {
                setState(() {
                  isEmailSelected = false;
                });
              },
              child: Container(
                padding: EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: AppTheme.calculateInkWellHorizontalPadding(
                        globalData.forgotPassEmail &&
                            globalData.forgotPassMobile)),
                decoration: BoxDecoration(
                  color: isEmailSelected ? Colors.grey.shade300 : Colors.indigo,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(globalData.forgotPassEmail &&
                            globalData.forgotPassMobile
                        ? 0
                        : 10),
                    bottomLeft: Radius.circular(globalData.forgotPassEmail &&
                            globalData.forgotPassMobile
                        ? 0
                        : 10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Text(
                  'Mobile',
                  style: TextStyle(
                    color: isEmailSelected ? Colors.black : Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 20.0),
        if (isEmailSelected)
          Container(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    errorText: emailError.isNotEmpty ? emailError : null,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        if (!isEmailSelected)
          Container(
            height: 100,
            child: Column(
              children: [
                TextField(
                  controller: mobileController,
                  decoration: InputDecoration(
                    labelText: 'Mobile',
                    errorText: mobileError.isNotEmpty ? mobileError : null,
                  ),
                ),
                SizedBox(height: 10),
              ],
            ),
          ),
        ElevatedButton(
          onPressed: _submitData,
          child: Text('Submit'),
        ),
        SizedBox(height: 10.0),
      ],
    );
  }
}
