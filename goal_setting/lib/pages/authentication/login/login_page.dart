// Import statements
import 'package:flutter/material.dart';
import '../../../data_state/dataState.dart';
import '../../../data_classes/sub classes/user_profile_data.dart';
import '../../../global/api_caller.dart';
import '../../../global/global_settings.dart';
import '../../../utils/error_handling.dart';
import '../../../utils/user_credentials.dart';
import '../forgot_password/forgot_password_page.dart';

// LoginPage class
class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

// _LoginPageState class
class _LoginPageState extends State<LoginPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  Map<String, String> errorMessages = {}; // Error messages

  // Function to handle login
  Future<void> handleLogin() async {
    String username = usernameController.text;
    String password = passwordController.text;

    // Validate input fields
    if (!_validateInputFields()) {
      return;
    }

    // Create a map containing the user's credentials
    Map<String, dynamic> body = {
      'username': username,
      'password': password,
    };

    try {
      // Make the API call using the ApiCaller object
      Map<String, dynamic>? response = await apiCaller.callApi('login', body);

      if (response != null && response['success']) {
        // Login successful
        print('Login successful. User data: ${response['user']}');



        // Save credentials in SharedPreferences
        await userCredentials.saveCredentials(username, password);

        // Update GlobalData with the latest credentials
        await globalData.updateData();

        // // Print updated credentials
        // globalData.printData();

        UserData userData = UserData(
          name: response['user']['name'],
          age: response['user']['age'] as int,
          username: response['user']['username'],
          email: response['user']['email'],
          mobile: response['user']['mobile'],
          password: response['user']['password'],
          FirebaseServiceToken: globalData.FirebaseServiceToken,
          notificationsOn: false,
          notificationTime: timeOfDayToString(TimeOfDay.now()),
        );

        // userData.printData();
        userDataOBJ = userData;

        global_user_data_OBJ = (await getGlobalData(userDataOBJ: userDataOBJ))!; //get ddata from the database

        // Navigate to home page
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Login failed
        setState(() {
          errorMessages['general'] =
              ErrorHandling.loginErrors['general']['invalidCredentials']!;
        });
      }
    } catch (e) {
      // Handle errors
      print('Error occurred: $e');
      setState(() {
        errorMessages['general'] =
            ErrorHandling.loginErrors['general']['serverError']!;
      });
    }
  }

  // Function to validate input fields
  bool _validateInputFields() {
    bool isValid = true;
    errorMessages.clear();

    // Username validation
    if (usernameController.text.isEmpty) {
      errorMessages['username'] =
          ErrorHandling.loginErrors['username']['required']!;
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      errorMessages['password'] =
          ErrorHandling.loginErrors['password']['required']!;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  // Function to handle "Forgot Password" button tap
  void handleForgotPassword() {
    if (globalData.forgotPass) {
      // Show the Forgot Password model bottom sheet
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return ForgotPasswordModelBottomSheet();
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            left: 100,
            right: 0,
            bottom: 0,
            child: Opacity(
              opacity: 0.7, // Set the opacity value as desired
              child: Image.asset(
                'assets/images/background.png', // Replace 'your_image.png' with your image asset path
                fit: BoxFit.fill, // Adjust the fit as needed
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
                SizedBox(height: 24.0),
                TextField(
                  controller: usernameController,
                  decoration: InputDecoration(
                    labelText: 'Username',
                    errorText: errorMessages['username'],
                  ),
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                SizedBox(height: 20.0),
                TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Password',
                    errorText: errorMessages['password'],
                  ),
                  obscureText: true,
                  style: TextStyle(color: Theme.of(context).primaryColor),
                ),
                if (errorMessages
                    .containsKey('general')) // Show general error message
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      errorMessages['general']!,
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: handleLogin,
                  child: Text('Login'),
                ),
                SizedBox(height: 16),
                if (globalData
                    .forgotPass) // Show "Forgot Password" button conditionally
                  TextButton(
                    onPressed: handleForgotPassword,
                    child: Text(
                      'Forgot Password',
                      // style: AppTheme.forgotPasswordTextStyle, // Apply custom text style
                    ),
                  ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'New user? ',
                      style: Theme.of(context).textTheme.button!.copyWith(
                            color: Theme.of(context).primaryColor,
                            fontWeight: FontWeight.normal,
                          ),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pushNamed(context, '/signup');
                      },
                      child: Text(
                        'Sign Up',
                        style: Theme.of(context).textTheme.button!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
