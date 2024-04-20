// Import necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../data_state/dataState.dart';
import '../../../data_classes/sub classes/achievement_class.dart';
import '../../../data_classes/sub classes/goal_class.dart';
import '../../../data_classes/sub classes/progress_class.dart';
import '../../../data_classes/sub classes/report_class.dart';
import '../../../data_classes/sub classes/task_class.dart';
import '../widgets/Add_Goals_page.dart';

// Define the SetGoalPage StatefulWidget
class ToSetGoalPage extends StatefulWidget {
  @override
  _ToSetGoalPageState createState() => _ToSetGoalPageState();
}

// Define the _SetGoalPageState State class
class _ToSetGoalPageState extends State<ToSetGoalPage> {
  // Define variables to store goal-related data
  String name = '';
  DateTime? startDate;
  DateTime? targetDate;
  String description = '';
  String imageURL = '';
  String goalID = Uuid().v4(); // Generate a UUID for the goal ID
  int remainingDays = 0;

  // Define a list to store tasks
  List<Task> tasks = [];

  // Define a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Define a GlobalKey for the task form
  final _taskFormKey = GlobalKey<FormState>();

  // Controller for the task name input field
  final _taskNamesController = TextEditingController();

  // Controller for the task days input field
  final _taskDaysController = TextEditingController();

  // Controller for the task descriptiuon input field
  final _taskDescriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold body
      body: Stack(
        children: [
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.only(right: 100, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/set_goals_background2.png',
                    // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: MediaQuery
                .of(context)
                .size
                .height,
            width: MediaQuery
                .of(context)
                .size
                .width,
            padding: EdgeInsets.only(left: 100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/set_goals_background.png',
                    // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    'Add Goals',
                    style: TextStyle(
                      fontSize: 36.0,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A237E),
                    ),
                  ),
                ),

                Column(
                  children: [
                    Center(
                      child: SizedBox(
                        width: 200,
                        child: ElevatedButton(
                          onPressed: () {
                            // Show task input form
                            Navigator.push(context, MaterialPageRoute(
                                builder: (context) => SetGoalPage()));
                          },
                          child: Text('Add Goals'),
                        ),
                      ),
                    ),
                    SizedBox(height: 24,),
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