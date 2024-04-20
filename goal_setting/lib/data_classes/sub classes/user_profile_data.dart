import 'dart:convert';

import 'package:flutter/material.dart';

// UserData Class
class UserData {
  String name;
  int age;
  String username;
  String email;
  String mobile;
  String password;
  String FirebaseServiceToken;
  bool notificationsOn;
  String notificationTime;


  // Constructor
  UserData({
    required this.name,
    required this.age,
    required this.username,
    required this.email,
    required this.mobile,
    required this.password,
    required this.FirebaseServiceToken,
    required this.notificationsOn,
    required this.notificationTime,
  });

  // Getters and Setters

  // Name
  String get getName => name;
  set setName(String value) => name = value;

  // Age
  int get getAge => age;
  set setAge(int value) => age = value;

  // Username
  String get getUsername => username;
  set setUsername(String value) => username = value;

  // Email
  String get getEmail => email;
  set setEmail(String value) => email = value;

  // Mobile
  String get getMobile => mobile;
  set setMobile(String value) => mobile = value;

  // Password
  String get getPassword => password;
  set setPassword(String value) => password = value;

  // FirebaseServiceToken
  String get getFirebaseServiceToken => FirebaseServiceToken;
  set setFirebaseServiceToken(String value) => FirebaseServiceToken = value;

  // notificationsOn
  bool get getnotificationsOn => notificationsOn;
  set setnotificationsOn(bool value) => notificationsOn = value;

  // notificationTime
  String get getnotificationTime => notificationTime;
  set setnotificationTime(String value) => notificationTime = value;



  static Map<String, dynamic> timeOfDayToJson(TimeOfDay timeOfDay) {
    return {
      'hour': timeOfDay.hour,
      'minute': timeOfDay.minute,
    };
  }


  // Serialization Method
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'age': age,
      'username': username,
      'email': email,
      'mobile': mobile,
      'password': password,
      'FirebaseServiceToken': FirebaseServiceToken,
      'notificationsOn': notificationsOn,
      'notificationTime': notificationTime,
    };
  }



  // Deserialization Method
  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      name: json['name'],
      age: json['age'],
      username: json['username'],
      email: json['email'],
      mobile: json['mobile'],
      password: json['password'],
      FirebaseServiceToken: json['FirebaseServiceToken'],
      notificationsOn: json['notificationsOn'],
      notificationTime: json['notificationTime'],
    );
  }



  // Print Method
  void printData() {
    print('User Data:');
    print('Name: $name');
    print('Age: $age');
    print('Username: $username');
    print('Email: $email');
    print('Mobile: $mobile');
    print('FirebaseServiceToken: $FirebaseServiceToken');
    print('notificationsOn: $notificationsOn');
    print('notificationTime: $notificationTime');
    // Avoid printing password for security reasons
  }
}
