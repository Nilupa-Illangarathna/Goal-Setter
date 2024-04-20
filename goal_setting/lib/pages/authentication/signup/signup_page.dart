// Import statements
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../../../global/global_settings.dart';
import '../../../global/regex.dart';
import '../../../utils/error_handling.dart';
import '../../../utils/theme.dart';
import '../../../utils/user_credentials.dart';

// SignUpPage class
class SignUpPage extends StatefulWidget {
  @override
  _SignUpPageState createState() => _SignUpPageState();
}

// _SignUpPageState class
class _SignUpPageState extends State<SignUpPage> {
  // Text editing controllers
  final TextEditingController nameController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  // Error messages
  Map<String, String> errorMessages = {};

// Function to handle signup
  Future<void> handleSignup() async {
    // Extract data from text controllers
    String name = nameController.text;
    int? age = int.tryParse(ageController.text);
    String username = usernameController.text;
    String email = emailController.text;
    String mobile = mobileController.text;
    String password = passwordController.text;

    // Validate input fields
    if (!_validateInputFields()) {
      return;
    }

    // TODO: API call to signup
    try {
      var response = await http.post(
        Uri.parse('${globalData.baseUrlRoute}/signup'),
        body: jsonEncode({
          'name': name,
          'age': age,
          'username': username,
          'email': email,
          'mobile': mobile,
          'password': password,
        }),
        headers: {'Content-Type': 'application/json'},
      );

      // Check response status code
      if (response.statusCode == 200) {
        var userData = jsonDecode(response.body)['user'];
        print('Signup successful. User data: $userData');

        // Save credentials on local storage
        await userCredentials.saveCredentials(username, password);
        await globalData.updateData(); // Await the updateData call

        // Print updated data
        globalData.printData();

        // Navigate to home page
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        setState(() {
          // Show error message
          errorMessages['general'] = 'Signup failed. Please try again.';
        });
      }
    } catch (e) {
      print('Error occurred: $e');
      setState(() {
        // Show error message
        errorMessages['general'] = 'An error occurred. Please try again later.';
      });
    }
  }


  // Function to validate input fields
  bool _validateInputFields() {
    bool isValid = true;
    errorMessages.clear();

    // Name validation
    if (nameController.text.isEmpty) {
      errorMessages['name'] = ErrorHandling.signupErrors['name']['required']!;
      isValid = false;
    }

    // Age validation
    if (ageController.text.isEmpty) {
      errorMessages['age'] = ErrorHandling.signupErrors['age']['required']!;
      isValid = false;
    } else {
      int? age = int.tryParse(ageController.text);
      if (age == null) {
        errorMessages['age'] = ErrorHandling.signupErrors['age']['invalid']!;
        isValid = false;
      }
    }

    // Username validation
    if (usernameController.text.isEmpty) {
      errorMessages['username'] =
          ErrorHandling.signupErrors['username']['required']!;
      isValid = false;
    }

    // Email validation
    if (emailController.text.isEmpty) {
      errorMessages['email'] = ErrorHandling.signupErrors['email']['required']!;
      isValid = false;
    } else if (!Regex.emailRegExp.hasMatch(emailController.text)) {
      errorMessages['email'] = ErrorHandling.signupErrors['email']['invalid']!;
      isValid = false;
    }

    // Mobile validation
    if (mobileController.text.isEmpty) {
      errorMessages['mobile'] = ErrorHandling.signupErrors['mobile']['required']!;
      isValid = false;
    } else if (!Regex.mobileRegExp.hasMatch(mobileController.text)) {
      errorMessages['mobile'] = ErrorHandling.signupErrors['mobile']['invalid']!;
      isValid = false;
    }

    // Password validation
    if (passwordController.text.isEmpty) {
      errorMessages['password'] =
          ErrorHandling.signupErrors['password']['required']!;
      isValid = false;
    } else if (!Regex.passwordRegExp.hasMatch(passwordController.text)) {
      errorMessages['password'] =
          ErrorHandling.signupErrors['password']['invalid']!;
      isValid = false;
    }

    setState(() {});
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Text(
                  'SignUp',
                  style: TextStyle(
                    fontSize: 36.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo,
                  ),
                ),
              ),
              SizedBox(height: 8.0),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    TextFormField(
                      controller: nameController,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        errorText: errorMessages['name'],
                      ),
                      style: TextStyle(color: AppTheme.themeData.primaryColor),
                    ),
                    SizedBox(height: 20.0),
                    // Age
                    TextFormField(
                      controller: ageController,
                      decoration: InputDecoration(
                        labelText: 'Age',
                        errorText: errorMessages['age'],
                      ),
                      keyboardType: TextInputType.number,
                      style: TextStyle(color: AppTheme.themeData.primaryColor),
                    ),
                    SizedBox(height: 20.0),
                    // Username
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                        labelText: 'Username',
                        errorText: errorMessages['username'],
                      ),
                      style: TextStyle(color: AppTheme.themeData.primaryColor),
                    ),
                    SizedBox(height: 20.0),
                    // Email
                    TextFormField(
                      controller: emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        errorText: errorMessages['email'],
                      ),
                      keyboardType: TextInputType.emailAddress,
                      style: TextStyle(color: AppTheme.themeData.primaryColor),
                    ),
                    SizedBox(height: 20.0),
                    // Mobile
                    TextFormField(
                      controller: mobileController,
                      decoration: InputDecoration(
                        labelText: 'Mobile Number',
                        errorText: errorMessages['mobile'],
                      ),
                      keyboardType: TextInputType.phone,
                      style: TextStyle(color: AppTheme.themeData.primaryColor),
                    ),
                    SizedBox(height: 20.0),
                    // Password
                    TextFormField(
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        errorText: errorMessages['password'],
                      ),
                      obscureText: true,
                      style: TextStyle(color: AppTheme.themeData.primaryColor),
                    ),
                    SizedBox(height: 20.0),
                    // Error messages
                    if (errorMessages.containsKey('general'))
                      Container(
                        constraints: BoxConstraints(
                            minHeight: 20.0), // Adjust the minHeight as needed
                        child: Text(
                          errorMessages['general']!,
                          style: TextStyle(
                            color: Colors.red,
                          ),
                        ),
                      ),

                    SizedBox(height: 36.0),
                    // Signup button
                    Center(
                      child: ElevatedButton(
                        onPressed: handleSignup,
                        child: Text('Signup'),
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
                    ),
                    SizedBox(height: 20.0),
                    // Already have an account
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: Theme.of(context).textTheme.button!.copyWith(
                                color: Theme.of(context).primaryColor,
                                fontWeight: FontWeight.normal,
                              ),
                        ),
                        TextButton(
                          onPressed: () {
                            // Navigate to login page
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Login',
                            style: TextStyle(
                                color: AppTheme.themeData.primaryColor),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
