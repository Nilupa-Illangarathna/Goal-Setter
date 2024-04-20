import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:goal_setting/pages/app_drawer.dart';
import 'package:goal_setting/pages/authentication/login/login_page.dart';
import 'package:goal_setting/pages/authentication/signup/signup_page.dart';
import 'package:goal_setting/pages/homepage/home_page.dart';
import 'package:goal_setting/pages/homepage/pages/set_new_goals.dart';
import 'package:goal_setting/pages/homepage/pages/user_home_page.dart';
import 'data_classes/global_data_class.dart';
import 'dummy_user_page.dart';
import 'global/global_settings.dart';
import 'pages/splash/splash_screen.dart';
import 'package:provider/provider.dart';
import 'utils/theme.dart';
import 'utils/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

String? _fcmToken; // Variable to store FCM token

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  print("Handling a background message: ${message.messageId}");
}


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // Register background message handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  // Get FCM token
  _fcmToken = await FirebaseMessaging.instance.getToken();

  globalData.FirebaseServiceToken = _fcmToken!;
  print("FCM Token: $_fcmToken");

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // System UI Configuration
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.bottom,
    ]);
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Colors.transparent,
      ),
    );
    WidgetsFlutterBinding.ensureInitialized();
    SystemChrome.setEnabledSystemUIMode(
      SystemUiMode.immersiveSticky,
    );

    return MaterialApp(
      theme: AppTheme.themeData,
      // home: UserHomePage(), // Set SplashScreen as the initial route
      // home: SetGoalPage(),
      // initialRoute:'/home',
      initialRoute:'/splash',
      routes: {
        '/splash': (context) => SplashScreen(),

        '/login': (context) => LoginPage(),
        '/signup': (context) => SignUpPage(),
        '/home': (context) => HomePage(),

        '/page1': (context) => Page2(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
        '/page4': (context) => Page4(),

        '/AppDrawerpage1': (context) => AppDrawerPage2(),
        '/AppDrawerpage2': (context) => AppDrawerPage2(),
        '/AppDrawerpage3': (context) => AppDrawerPage3(),
        '/AppDrawerpage4': (context) => AppDrawerPage4(),
      },
      debugShowCheckedModeBanner: false,
    );
  }
}