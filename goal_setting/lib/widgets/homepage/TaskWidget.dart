import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data_classes/sub classes/task_class.dart';
import '../../data_state/dataState.dart';
import 'AchivementWidget.dart';
import 'ProgressWidget.dart';
import 'ReportWidget.dart';

class TaskWidget extends StatefulWidget {
  final Task task;

  const TaskWidget({Key? key, required this.task}) : super(key: key);

  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  late bool todayComplete;

  @override
  void initState() {
    super.initState();
    // Initialize todayComplete based on the current date-related statistical value
    todayComplete = _getTodayCompletionStatus();

    // Calculate the true percentage
    int trueCount = 0;
    int falseCount = 0;
    widget.task.report.statistics.values.forEach((value) {
      if (value) {
        trueCount++;
      } else {
        falseCount++;
      }
    });

    // Calculate the true percentage
    int truePercentage = (trueCount / (trueCount + falseCount -1) * 100).round();
    print('True Percentage: $truePercentage');

    // Update the progress value with the true percentage
    if (widget.task.progress != null) {
      setState(() {
        widget.task.progress.progressValue = truePercentage;
      });
    }

    sendGlobalData(globalData: global_user_data_OBJ);
  }

  @override
  Widget build(BuildContext context) {
    // Check if the current date is in the statistics list
    bool isDateInStatistics = _isDateInStatistics(DateTime.now());

    // If the current date is not in the statistics list, don't create the button at all
    if (!isDateInStatistics) {
      return _buildTaskWidget();
    }

    // Otherwise, create the button based on the completion status
    return _buildTaskWidgetWithButton();
  }

  // Check if the current date is in the statistics list
  bool _isDateInStatistics(DateTime date) {
    String formattedDate = DateFormat('yyyy-MM-dd').format(date);
    return widget.task.report.statistics.containsKey(formattedDate);
  }

  // Get the completion status for the current date
  bool _getTodayCompletionStatus() {
    bool isCompleted = false;
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    if (widget.task.report.statistics.containsKey(formattedDate)) {
      isCompleted = widget.task.report.statistics[formattedDate]!;
    }
    return isCompleted;
  }

  // Update the completion status and refresh the UI
  void _updateCompletionStatus(bool newValue) {
    setState(() {
      todayComplete = newValue;
    });
  }

  // Toggle the completion status and update the statistics
  void _toggleCompletionStatus() {
    setState(() {
      todayComplete = !todayComplete;
    });

    // Update the completion status for the current date
    String formattedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());
    widget.task.report.statistics[formattedDate] = todayComplete;
    global_user_data_OBJ.updateDatabase();

    sendGlobalData(globalData: global_user_data_OBJ);

    // Calculate the true percentage
    int trueCount = 0;
    int falseCount = 0;
    widget.task.report.statistics.values.forEach((value) {
      if (value) {
        trueCount++;
      } else {
        falseCount++;
      }
    });

    // Calculate the true percentage
    int truePercentage = (trueCount / (trueCount + falseCount -1) * 100).round();
    print('True Percentage: $truePercentage');

    // Update the progress value with the true percentage
    if (widget.task.progress != null) {
      setState(() {
        widget.task.progress.progressValue = truePercentage;
      });
    }
  }



  // Build the task widget without the button
  Widget _buildTaskWidget() {
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
              'Task - ${widget.task.name}:',
              style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize: 19),
            ),
            SizedBox(height: 8),
            Text('Start Date: ${DateFormat('yyyy-MM-dd').format(widget.task.startDate)}', style: TextStyle(color: Colors.black)),
            Text('Target Date: ${DateFormat('yyyy-MM-dd').format(widget.task.targetDate)}', style: TextStyle(color: Colors.black)),
            Text('Completed: ${widget.task.progress.progressValue>50? "Yes":"No"}', style: TextStyle(color: Colors.black),),
            if (widget.task.progress != null) SizedBox(height: 8),
            if (widget.task.progress != null) ProgressWidget(progress: widget.task.progress),
          ],
        ),
      ),
    );
  }


  bool isDateInRange(DateTime currentDate, DateTime startDate, DateTime endDate) =>
      currentDate.isAfter(startDate.subtract(Duration(days: 0))) &&
          currentDate.isBefore(endDate.add(Duration(days: 0)));


  // Build the task widget with the completion button
  Widget _buildTaskWidgetWithButton() {
    return Card(
      color: Colors.blue.withOpacity(0.1),
      elevation: 0.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                if(isDateInRange(DateTime.now(), widget.task.startDate, widget.task.targetDate)) IconButton(
                  icon: Container(
                    height: 48,
                    width: 48,
                    decoration: BoxDecoration(
                      color: todayComplete ? Colors.green.withOpacity(0.2) : Colors.orange.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    child: Icon(
                      todayComplete ? Icons.done : Icons.close,
                      color: todayComplete ? Colors.green : Colors.grey,
                    ),
                  ),
                  onPressed: _toggleCompletionStatus,
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Task - ${widget.task.name}:',
                  style: TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF1A237E), fontSize: 19),
                ),
                SizedBox(height: 8),
                Text('Start Date: ${DateFormat('yyyy-MM-dd').format(widget.task.startDate)}', style: TextStyle(color: Colors.black)),
                Text('Target Date: ${DateFormat('yyyy-MM-dd').format(widget.task.targetDate)}', style: TextStyle(color: Colors.black)),
                Text('Completed: ${widget.task.progress.progressValue>50? "Yes":"No"}', style: TextStyle(color: Colors.black),),
                if (widget.task.progress != null) SizedBox(height: 8),
                if (widget.task.progress != null) ProgressWidget(progress: widget.task.progress),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
