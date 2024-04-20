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
import '../widgets/TaskReportPage.dart';


class ReportPage extends StatefulWidget {
  @override
  _ReportPageState createState() => _ReportPageState();
}

class _ReportPageState extends State<ReportPage> {
  late UserData userData;
  late List<Goal> goals7Days;
  late List<Goal> goals21Days;
  late List<Goal> customGoals;
  late Quote quote1;
  late Quote quote2;

  @override
  void initState() {
    super.initState();
    userData = global_user_data_OBJ.userData;
    goals7Days = global_user_data_OBJ.goals7Days;
    goals21Days = global_user_data_OBJ.goals21Days;
    customGoals = global_user_data_OBJ.customGoals;
    final random = Random();
    quote1 = global_user_data_OBJ.quotes[0];
    quote2 = global_user_data_OBJ.quotes[1];
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
                          'Reports',
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
                        // UserDataWidget(userData: userData),
                        // SizedBox(height: 16),
                        // QuoteWidget(quote: quote1),
                        SizedBox(height: 16),
                        goals7Days.isNotEmpty? _buildSection('Goals of 7 days', goals7Days): SizedBox(height:0,width:0),
                        SizedBox(height: 16),
                        goals21Days.isNotEmpty? _buildSection('Goals of 21 days', goals21Days): SizedBox(height:0,width:0),
                        SizedBox(height: 16),
                        customGoals.isNotEmpty? _buildSection('Custom Goals', customGoals): SizedBox(height:0,width:0),
                        SizedBox(height: 16),
                        // QuoteWidget(quote: quote2),
                        // SizedBox(height: 0),



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
        SingleChildScrollView(
          child: Column(
            children:[
              if (goals.isNotEmpty) // Render the ListView only if goals is not empty
                Container(
                  height: (160 * goals.length) * 1.0, //150
                  child: ListView.builder(
                    // scrollDirection: Axis.vertical,
                    itemCount: goals.length,
                    itemBuilder: (context, index) {
                      final goal = goals[index];
                      return Padding(
                        padding: EdgeInsets.only(right: 0), // Add right padding to create the gap between items
                        child: SizedBox(
                          width: null, // Allow the width to be determined by the child's content
                          child: ReportTile(goal: goal),
                        ),
                      );
                    },
                  ),
                )
              else // Render an empty SizedBox with the desired height if goals is empty
                SizedBox(height:0,width:0),
            ]
          ),
        ),

      ],
    );
  }
}
