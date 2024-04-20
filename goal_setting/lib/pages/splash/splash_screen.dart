import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:lottie/lottie.dart';

import '../../dummy_user_page.dart';
import '../../global/global_settings.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();

    // TODO: Firebase :
    // Configure foreground notification presentation options
    FirebaseMessaging.instance.setForegroundNotificationPresentationOptions(
      alert: true,
      badge: true,
      sound: true,
    );

    // Handle initial message when the app is opened from terminated state
    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      if (message != null) {
        Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
      }
    });

    // Listen for incoming messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.title ?? ''),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(notification.body ?? '')],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
      if (notification != null && android != null) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(
            title: Text(notification.title ?? ''),
            content: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [Text(notification.body ?? '')],
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context, 'OK'),
                child: Text('OK'),
              ),
            ],
          ),
        );
      }
    });

    // Handle when a message is opened from the notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      Navigator.pushNamed(context, '/message', arguments: MessageArguments(message, true));
    });
    //TODO: Firebase :

    _controller = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 1500),
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _controller,
      curve: Curves.easeInOut,
    ));
    _controller.repeat(reverse: true);
    Timer(
      Duration(seconds: globalData.splashTime), // Adjust the duration of the splash screen as needed
          () => Navigator.pushReplacementNamed(context, '/login'),
    );


    fetchQuotes();

  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Get screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Lottie animation
            Material(
              elevation:1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5000.0),
              ),
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 0.0),
                width: screenWidth * 0.9, // Adjust width as needed
                child: Image.asset(
                  'assets/images/splash.png', // Replace 'your_image.png' with your image asset path
                  fit: BoxFit.fill, // Adjust the fit as needed
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Text(
              'GOAL SETTER',
              style: TextStyle(
                fontSize: 48.0,
                fontWeight: FontWeight.bold,
                color: Colors.indigo,
              ),
            ),
            SizedBox(height: 60.0),
          ],
        ),
      ),
    );
  }
}


class MessageArguments {
  final RemoteMessage message;
  final bool opened;

  MessageArguments(this.message, this.opened);
}