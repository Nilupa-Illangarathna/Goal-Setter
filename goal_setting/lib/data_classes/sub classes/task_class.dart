import 'package:flutter/material.dart';
import '../../data_state/dataState.dart';
import './achievement_class.dart';
import './progress_class.dart';
import './report_class.dart';

// Task Class
class Task {
  String goalID; // Unique identifier for each goal
  String taskID; // Unique identifier for each task
  String name;
  DateTime startDate;
  DateTime targetDate;
  bool completed;
  List<Achievement> achievements;
  Report report;
  Progress progress;

  // Constructor
  Task({
    required this.goalID,
    required this.taskID,
    required this.name,
    required this.startDate,
    required this.targetDate,
    required this.completed,
    required this.achievements,
    required this.report,
    required this.progress,
  });

  // Getters and Setters
  String get goalId => goalID;
  set goalId(String value) => goalID = value;


  String get taskId => taskID;
  set taskId(String value) => taskID = value;

  String get taskName => name;
  set taskName(String value) => name = value;

  DateTime get taskStartDate => startDate;
  set taskStartDate(DateTime value) => startDate = value;

  DateTime get taskTargetDate => targetDate;
  set taskTargetDate(DateTime value) => targetDate = value;

  bool get isTaskCompleted => completed;
  set isTaskCompleted(bool value) => completed = value;

  // Print Method
  void printData() {
    print('Task Data:');
    print('GoalID: $goalID');
    print('TaskID: $taskID');
    print('Name: $name');
    print('Start Date: $startDate');
    print('Target Date: $targetDate');
    print('Completed: $completed');
    print('Achievements:');
    for (var achievement in achievements) {
      achievement.printData();
    }
    print('Report:');
    report.printData();
    print('Progress:');
    progress.printData();
  }

  // Convert Task object to JSON
  Map<String, dynamic> toJson() {
    return {
      'goalID': goalID,
      'taskID': taskID,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'targetDate': targetDate.toIso8601String(),
      'completed': completed,
      'achievements': achievements.map((achievement) => achievement.toJson()).toList(),
      'report': report.toJson(),
      'progress': progress.toJson(),
    };
  }

  // Create Task object from JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    List<dynamic> achievementsJson = json['achievements'];
    List<Achievement> achievementList = achievementsJson.map((achievementJson) => Achievement.fromJson(achievementJson)).toList();

    return Task(
      goalID: json['goalID'],
      taskID: json['taskID'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      targetDate: DateTime.parse(json['targetDate']),
      completed: json['completed'],
      achievements: achievementList,
      report: Report.fromJson(json['report']),
      progress: Progress.fromJson(json['progress']),
    );
  }

  //TODO Add this method to the Task class
  int updateStatistics(DateTime date) {
    // Format the date to match the format used in the statistics map
    String formattedDate = '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';

    // Update the statistics map
    if (report.statistics.containsKey(formattedDate)) {
      report.statistics[formattedDate] = true;
    } else {
      // If the date key doesn't exist, you can choose to handle it here
      // For example, you could throw an exception or simply ignore it
      // For now, let's print a message indicating that the date key doesn't exist
      print('Date key $formattedDate not found in statistics map.');
    }

    // Calculate the percentage of true values in the statistics map
    double trueCount = report.statistics.values.where((value) => value == true).length.toDouble();
    double totalCount = report.statistics.length.toDouble();
    double percentage = trueCount / totalCount * 100;

    // Round up the percentage value
    int roundedPercentage = percentage.ceil();

    // Ensure the rounded percentage value is within the inclusive 0 to 100 range
    roundedPercentage = roundedPercentage.clamp(0, 100);

    global_user_data_OBJ.updateDatabase();
    // Return the rounded percentage value
    return roundedPercentage;
  }


}
