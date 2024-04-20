import 'package:flutter/material.dart';
import '../../../../global/api_caller.dart';
import '../../../../global/regex.dart';
import '../../../../utils/error_handling.dart';

class ResetPasswordPage extends StatefulWidget {
  final Function(int) onNextStep;
  final String method;
  final String contact;

  const ResetPasswordPage({required this.onNextStep, required this.method, required this.contact});


  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  String _passwordError = '';
  String _confirmPasswordError = '';

  void _resetPassword() {
    setState(() {
      // Reset errors
      _passwordError = '';
      _confirmPasswordError = '';

      // Validate password
      if (_passwordController.text.isEmpty) {
        _passwordError = ErrorHandling.resetPasswordErrors['password']['required'];
      } else if (!Regex.passwordRegExp.hasMatch(_passwordController.text)) {
        _passwordError = ErrorHandling.resetPasswordErrors['password']['invalid'];
      }

      // Validate confirm password
      if (_confirmPasswordController.text.isEmpty) {
        _confirmPasswordError = ErrorHandling.resetPasswordErrors['confirmPassword']['required'];
      } else if (_confirmPasswordController.text != _passwordController.text) {
        _confirmPasswordError = 'Passwords do not match.';
      }

      // If no errors, proceed to reset password
      if (_passwordError.isEmpty && _confirmPasswordError.isEmpty) {
        // Add your logic here to reset the password
        print('Password reset successful!');
        print('New Password: ${_passwordController.text}'); // Print new password on CLI
        _callResetPasswordApi(_passwordController.text);
        widget.onNextStep(4);
        // TODO: Call API to reset password
      }
    });
  }

  // TODO: API CALL Function to call the reset password API
  void _callResetPasswordApi(String newPassword) {
    final Map<String, dynamic> requestBody = {
      'method': widget.method,
      'contact': widget.contact,
      'password': newPassword,
    };

    apiCaller.callApi('reset_password', requestBody).then((response) {
      if (response != null && response['success']) {
        print('Password reset successful!');
        widget.onNextStep(4); // Move to next step
      } else {
        print('Failed to reset password.');
        // Handle error or display appropriate message to the user
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Material( // Wrap TextFormField with Material widget
          child: TextFormField(
            controller: _passwordController,
            obscureText: !_passwordVisible,
            decoration: InputDecoration(
              labelText: 'New Password',
              suffixIcon: IconButton(
                icon: Icon(_passwordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _passwordVisible = !_passwordVisible;
                  });
                },
              ),
              errorText: _passwordError.isNotEmpty ? _passwordError : null,
            ),
          ),
        ),
        SizedBox(height: 20),
        Material( // Wrap TextFormField with Material widget
          child: TextFormField(
            controller: _confirmPasswordController,
            obscureText: !_confirmPasswordVisible,
            decoration: InputDecoration(
              labelText: 'Confirm Password',
              suffixIcon: IconButton(
                icon: Icon(_confirmPasswordVisible ? Icons.visibility : Icons.visibility_off),
                onPressed: () {
                  setState(() {
                    _confirmPasswordVisible = !_confirmPasswordVisible;
                  });
                },
              ),
              errorText: _confirmPasswordError.isNotEmpty ? _confirmPasswordError : null,
            ),
          ),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: _resetPassword,
          child: Text('Reset Password'),
        ),
      ],
    );









  }
}
