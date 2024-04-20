import 'dart:async';
import 'package:flutter/material.dart';
import '../../global/global_settings.dart';
import '../../utils/theme.dart';

class OtpInputWithCountdown extends StatefulWidget {
  final void Function() onTimerFinished;
  final void Function(String otp) onResendPressed;
  final void Function(String otp) onOTPChanged;

  OtpInputWithCountdown({
    required this.onTimerFinished,
    required this.onResendPressed,
    required this.onOTPChanged,
  });

  @override
  State<OtpInputWithCountdown> createState() => _OtpInputWithCountdownState();
}

class _OtpInputWithCountdownState extends State<OtpInputWithCountdown> {
  late bool countdown;
  late int digitCount;
  late int countdownTime;
  late bool isNumeric;

  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    countdown = globalData.otpCountdownTime > 0;
    digitCount = globalData.otpDigitCount;
    countdownTime = globalData.otpCountdownTime;
    isNumeric = globalData.isNumaricOTP;
    controllers = List.generate(digitCount, (index) => TextEditingController());
  }

  @override
  void dispose() {
    controllers.forEach((controller) => controller.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final showOtpFields = digitCount > 0;

    return Container(
      height: countdown ? AppTheme.otpInputHeight + AppTheme.otpCountdownHeight : AppTheme.otpInputHeight,
      child: Column(
        children: [
          Visibility(
            visible: showOtpFields,
            child: Container(
              height: AppTheme.otpInputHeight,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  digitCount,
                      (index) => Container(
                    height: AppTheme.otpInputHeight,
                    width: (MediaQuery.of(context).size.width - digitCount * AppTheme.otpInputSpacing) * AppTheme.otpInputWidthFactor,
                    child: TextField(
                      controller: controllers[index],
                      onChanged: (value) {
                        if (value.isNotEmpty && index < digitCount - 1) {
                          FocusScope.of(context).nextFocus();
                        }
                        widget.onOTPChanged(_getOtp());
                      },
                      keyboardType: isNumeric ? TextInputType.number : null,
                      maxLength: 1,
                      textAlign: TextAlign.center,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.otpInputBorderRadius),
                        ),
                        counterText: '',
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          if (showOtpFields) SizedBox(height: AppTheme.otpInputSpacing),
          if (showOtpFields)
            countdown
                ? CountdownTimer(
              timeInSeconds: countdownTime,
              onTimerFinished: () {
                setState(() {
                  countdown = false;
                  widget.onTimerFinished();
                });
              },
            )
                : ElevatedButton(
              onPressed: () => widget.onResendPressed(_getOtp()),
              child: Text('Resend OTP'),
            ),
        ],
      ),
    );
  }

  String _getOtp() {
    return controllers.map((controller) => controller.text).join();
  }
}

class CountdownTimer extends StatefulWidget {
  final int timeInSeconds;
  final void Function() onTimerFinished;

  CountdownTimer({
    required this.timeInSeconds,
    required this.onTimerFinished,
  });

  @override
  _CountdownTimerState createState() => _CountdownTimerState();
}

class _CountdownTimerState extends State<CountdownTimer> {
  late int _seconds;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.timeInSeconds;
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (_seconds > 0) {
        setState(() {
          _seconds--;
        });
      } else {
        _timer.cancel();
        widget.onTimerFinished();
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Text(
      'Resend OTP in ${_formatTime(_seconds)}',
      textAlign: TextAlign.center,
      style: TextStyle(
        fontSize: AppTheme.otpCountdownFontSize,
        fontWeight: AppTheme.otpCountdownFontWeight,
      ),
    );
  }

  String _formatTime(int seconds) {
    final minutes = (seconds / 60).floor();
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }
}
