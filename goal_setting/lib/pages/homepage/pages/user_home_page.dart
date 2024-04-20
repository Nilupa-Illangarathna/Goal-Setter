import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goal_setting/data_classes/global_data_class.dart';
import 'package:goal_setting/data_instance_creation.dart';

import '../../../data_state/dataState.dart';
import '../../../data_classes/sub classes/goal_class.dart';
import '../../../data_classes/sub classes/quote_class.dart';
import '../../../data_classes/sub classes/user_profile_data.dart';
import '../../../dummy_user_page.dart';
import '../../../utils/theme.dart';
import '../../../widgets/homepage/QuateWidget.dart';
import '../../../widgets/homepage/UserDataWidget.dart';
import '../widgets/Goal Page.dart';



class UserHomePage extends StatefulWidget {
  @override
  _UserHomePageState createState() => _UserHomePageState();
}

class _UserHomePageState extends State<UserHomePage> {
  late UserData userData;
  late List<Goal> goals7Days;
  late List<Goal> goals21Days;
  late List<Goal> customGoals;


  @override
  void initState() {
    super.initState();
    userData = global_user_data_OBJ.userData;
    goals7Days = global_user_data_OBJ.goals7Days;
    goals21Days = global_user_data_OBJ.goals21Days;
    customGoals = global_user_data_OBJ.customGoals;
    final random = Random();
  }

  void updateGoalsAfterDeletion(String goalId) {
    setState(() {
      // TODO: Find and remove the goal with the provided goalId from the lists
      global_user_data_OBJ.deleteGoalById(goalId: goalId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding:EdgeInsets.only(left:100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/background.png', // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Stack(
                  children: [

                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 18),
                        Text(
                          'Goal Setting App',
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E), // Adjusted color to a darker shade
                          ),
                        ),

                        SizedBox(height: 24),
                        // Text(
                        //   'User Details',
                        //   style: AppTheme.headerTextStyle,
                        // ),
                        // SizedBox(height: 16),
                        UserDataWidget(userData: userData),
                        SizedBox(height: 16),
                        QuoteWidget(quote: quote1),
                        SizedBox(height: 16),
                        _buildSection('Goals of 7 days', goals7Days),
                        SizedBox(height: 16),
                        _buildSection('Goals of 21 days', goals21Days),
                        SizedBox(height: 16),
                        _buildSection('Custom Goals', customGoals),
                        SizedBox(height: 16),
                        QuoteWidget(quote: quote2),
                        SizedBox(height: 0),



                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSection(String label, List<Goal> goals) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$label',
          style: AppTheme.headerTextStyle,
        ),
        SizedBox(height: 8),
        if (goals.isNotEmpty) // Render the ListView only if goals is not empty
          Container(
            height: 200,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: goals.length,
              itemBuilder: (context, index) {
                final goal = goals[index];
                return Padding(
                  padding: EdgeInsets.only(right: 16), // Add right padding to create the gap between items
                  child: SizedBox(
                    width: null, // Allow the width to be determined by the child's content
                    child: GoalTile(goal: goal, updateGoalsAfterDeletion: updateGoalsAfterDeletion, ),
                  ),
                );
              },
            ),
          )
        else // Render an empty SizedBox with the desired height if goals is empty
          GestureDetector(
            onTap: null, // Disable onTap functionality
            child: Container(
              height: 60,
              width:200,
              // width: MediaQuery.of(context).size.width, // Match the width of the screen
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.grey[300], // Adjust color to represent disabled state
              ),
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add Goals ',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.grey[600], // Adjust color to represent disabled state
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios, // Use the arrow forward icon
                      size: 16, // Adjust size as needed
                      color: Colors.grey[600], // Adjust color to represent disabled state
                    ),
                    Icon(
                      Icons.arrow_forward_ios, // Use the arrow forward icon
                      size: 16, // Adjust size as needed
                      color: Colors.grey[600], // Adjust color to represent disabled state
                    ),
                    Icon(
                      Icons.arrow_forward_ios, // Use the arrow forward icon
                      size: 16, // Adjust size as needed
                      color: Colors.grey[600], // Adjust color to represent disabled state
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
