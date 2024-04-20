import 'package:flutter/material.dart';

// Progress Class
class Progress {
  String goalID; // Unique identifier for each achievement
  String taskId; // Unique identifier for each achievement
  DateTime date;
  int value; // Progress value (e.g., percentage completed, numeric value, etc.)

  // Constructor
  Progress({
    required this.goalID,
    required this.taskId,
    required this.date,
    required this.value,
  });

  String get progressgoalID => goalID;
  set progressgoalID(String value) => goalID = value;

  String get progresstaskId => taskId;
  set progresstaskId(String value) => taskId = value;

  // Getter and Setter for Task ID
  String get progressTaskId => taskId;
  set progressTaskId(String value) => taskId = value;

  // Getter and Setter for Date
  DateTime get progressDate => date;
  set progressDate(DateTime value) => date = value;

  // Getter and Setter for Value
  dynamic get progressValue => value;
  set progressValue(dynamic value) => this.value = value;

  // Convert Progress object to JSON
  Map<String, dynamic> toJson() {
    return {
      'goalID': goalID,
      'taskId': taskId,
      'date': date.toIso8601String(),
      'value': value,
    };
  }

  // Create Progress object from JSON
  factory Progress.fromJson(Map<String, dynamic> json) {
    return Progress(
      goalID: json['goalID'],
      taskId: json['taskId'],
      date: DateTime.parse(json['date']),
      value: json['value'],
    );
  }

  // Print Method
  void printData() {
    print('Progress Data:');
    print('goalID: $goalID');
    print('taskId: $taskId');
    print('Date: $date');
    print('Value: $value');
  }
}
