import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data_classes/sub classes/goal_class.dart';
import '../../../data_state/dataState.dart';
import '../../../widgets/homepage/TaskWidget.dart';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data_classes/sub classes/goal_class.dart';
import '../../../widgets/homepage/TaskWidget.dart';

class TilePage extends StatelessWidget {
  final Goal goal;
  final Function(String) updateGoalsAfterDeletion;

  const TilePage({Key? key, required this.goal, required this.updateGoalsAfterDeletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: Text('Goal Details'),
      // ),
      body: Stack(
        children: [
          SizedBox(
            height:230,
            child: Container(
              height:250,
              width:MediaQuery.of(context).size.width,
              child: Positioned.fill(
                child: Opacity(
                  opacity: 0.6,
                  child: Container(

                    child: Image.network(
                      goal.goalImageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Stack(
                    children:[

                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              IconButton(
                                icon: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.white.withOpacity(0.2),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Icon(
                                    Icons.close,
                                    color: Colors.grey,
                                  ),
                                ),
                                onPressed: () {
                                  Navigator.of(context).pop();
                                },
                              ),
                              IconButton(
                                icon: Container(
                                  height: 48,
                                  width: 48,
                                  decoration: BoxDecoration(
                                    color: Colors.red.withOpacity(0.5),
                                    borderRadius: BorderRadius.circular(15.0),
                                  ),
                                  child: Icon(
                                    Icons.delete,
                                    color: Colors.black.withOpacity(0.4),
                                  ),
                                ),
                                onPressed: () {
                                  // global_user_data_OBJ.deleteGoalById(goalId: goal.id);
                                  updateGoalsAfterDeletion(goal.id);
                                  Navigator.of(context).pop();
                                },
                              ),
                            ],
                          ),
                          Text(
                            'Goal Details',
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                          ),
                          SizedBox(height: 8),
                          Text('Name: ${goal.name}', style: TextStyle(fontSize: 16)),
                          Text('Start Date: ${DateFormat('yyyy-MM-dd').format(goal.startDate)}', style: TextStyle(fontSize: 16)),
                          Text('Target Date: ${DateFormat('yyyy-MM-dd').format(goal.targetDate)}', style: TextStyle(fontSize: 16)),
                          Text('Description: ${goal.description}', style: TextStyle(fontSize: 16)),
                          SizedBox(height: 16),
                        ],
                      ),
                    ]
                ),


                SizedBox(height: 16),
                Expanded(
                  child: ListView.builder(
                    itemCount: goal.tasks.length,
                    itemBuilder: (context, index) {
                      final task = goal.tasks[index];
                      return TaskWidget(task:task);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

