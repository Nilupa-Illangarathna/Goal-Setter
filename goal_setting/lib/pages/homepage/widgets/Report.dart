import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../../data_classes/sub classes/task_class.dart';
import '../../../widgets/homepage/AchivementWidget.dart';
import '../../../widgets/homepage/ReportWidget.dart';


class ReportDoc extends StatelessWidget {
  final Task task;
  final String imageUrl;

  const ReportDoc({Key? key, required this.task, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.blue.withOpacity(0.1),
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Task - ${task.name}:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize:19),
            ),
            SizedBox(height: 8),
            Text('Start Date: ${DateFormat('yyyy-MM-dd').format(task.startDate)}', style: TextStyle(color: Colors.black),),
            Text('Target Date: ${DateFormat('yyyy-MM-dd').format(task.targetDate)}', style: TextStyle(color: Colors.black),),
            Text('Completed: ${task.progress.progressValue>50? "Yes":"No"}', style: TextStyle(color: Colors.black),),
            SizedBox(height: 16),
            task.progress.progressValue >= 60? Text(
              'Achievements:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ): SizedBox(height:0,width:0),
            task.progress.progressValue >= 60? SizedBox(height: 8): SizedBox(height:0,width:0),
            task.progress.progressValue >= 60? AchievementWidget(achievement: task.achievements[0], task: task, imageUrl:imageUrl): SizedBox(height:0,width:0),

            SizedBox(height: 16),
            Text(
              'Report:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo),
            ),
            SizedBox(height: 8),
            ReportWidget(report: task.report, task: task),

          ],
        ),
      ),
    );
  }
}
