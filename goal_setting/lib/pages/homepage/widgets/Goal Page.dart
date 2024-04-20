import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data_classes/sub classes/goal_class.dart';
import 'Tasks Page.dart';


class GoalTile extends StatelessWidget {
  final Goal goal;
  final Function(String) updateGoalsAfterDeletion;

  const GoalTile({Key? key, required this.goal, required this.updateGoalsAfterDeletion}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedStartDate = DateFormat('yyyy-MM-dd').format(goal.startDate);
    final formattedTargetDate = DateFormat('yyyy-MM-dd').format(goal.targetDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => TilePage(goal: goal, updateGoalsAfterDeletion: updateGoalsAfterDeletion,)));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(8), // Match the border radius with the container
          child: Stack(
            children: [
              // Background Image
              Positioned.fill(
                child: Opacity(
                  opacity: 0.4,
                  child: Container(
                    height:200,
                    child: Image.network(
                      goal.goalImageURL,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              // Content
              Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Name: ${goal.name}'),
                    Text('Start Date: $formattedStartDate'),
                    Text('Target Date: $formattedTargetDate'),
                    Text('Tasks Count: ${goal.tasks.length}'),
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