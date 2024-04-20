import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data_classes/sub classes/goal_class.dart';
import 'ReportPage.dart';
import 'Tasks Page.dart';


class ReportTile extends StatelessWidget {
  final Goal goal;

  const ReportTile({Key? key, required this.goal}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formattedStartDate = DateFormat('yyyy-MM-dd').format(goal.startDate);
    final formattedTargetDate = DateFormat('yyyy-MM-dd').format(goal.targetDate);

    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (context) => ReportContentPage(goal: goal)));
      },
      child: Container(
        margin: EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          children: [
            // Image
            Positioned.fill(
              child: Opacity(
                opacity:0.5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.network(
                    goal.goalImageURL,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            // Gradient overlay
            Positioned.fill(
              child: Opacity(
                opacity:0.6,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    gradient: LinearGradient(
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                      colors: [Colors.black.withOpacity(0.8), Colors.black.withOpacity(0.6)],
                    ),
                  ),
                ),
              ),
            ),
            // Content
            Padding(
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    goal.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 12),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Start Date: $formattedStartDate',
                        style: TextStyle(color: Colors.white),
                      ),
                      Text(
                        'Target Date: $formattedTargetDate',
                        style: TextStyle(color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 12),
                  Text(
                    'Tasks Count: ${goal.tasks.length}',
                    style: TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
