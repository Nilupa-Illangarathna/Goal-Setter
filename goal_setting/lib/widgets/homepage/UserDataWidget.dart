import 'package:flutter/material.dart';

import '../../data_classes/sub classes/user_profile_data.dart';
import '../../utils/theme.dart';

class UserDataWidget extends StatelessWidget {
  final UserData userData;

  const UserDataWidget({Key? key, required this.userData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'User Data:',
          style: AppTheme.headerTextStyle.copyWith(
            fontSize: 18.0, // Adjust font size
          ),
        ),
        SizedBox(height: 8), // Add vertical spacing
        Text(
          'Name: ${userData.name}',
          style: TextStyle(fontSize: 16), // Use a slightly smaller font size
        ),
        Text(
          'Age: ${userData.age}',
          style: TextStyle(fontSize: 16), // Use a slightly smaller font size
        ),
        Text(
          'Username: ${userData.username}',
          style: TextStyle(fontSize: 16), // Use a slightly smaller font size
        ),
        Text(
          'Email: ${userData.email}',
          style: TextStyle(fontSize: 16), // Use a slightly smaller font size
        ),
        Text(
          'Mobile: ${userData.mobile}',
          style: TextStyle(fontSize: 16), // Use a slightly smaller font size
        ),
      ],
    );
  }
}