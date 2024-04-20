import 'package:flutter/material.dart';

// Report Class
class Report {
  String goalID; // Unique identifier for each achievement
  String taskId; // Unique identifier for each achievement
  DateTime dateRangeStart;
  DateTime dateRangeEnd;
  Map<String, dynamic> statistics; // Report statistics (e.g., task completion rates, progress summaries, etc.)

  // Constructor
  Report({
    required this.goalID,
    required this.taskId,
    required this.dateRangeStart,
    required this.dateRangeEnd,
    required this.statistics,
  });

  // Getter and Setter for ID
  String get achievementgoalID => goalID;
  set achievementgoalID(String value) => goalID = value;

  String get achievementtaskId => taskId;
  set achievementtaskId(String value) => taskId = value;

  // Getter and Setter for Date Range Start
  DateTime get reportDateRangeStart => dateRangeStart;
  set reportDateRangeStart(DateTime value) => dateRangeStart = value;

  // Getter and Setter for Date Range End
  DateTime get reportDateRangeEnd => dateRangeEnd;
  set reportDateRangeEnd(DateTime value) => dateRangeEnd = value;

  // Convert Report object to JSON
  Map<String, dynamic> toJson() {
    return {
      'goalID': goalID,
      'taskId': taskId,
      'dateRangeStart': dateRangeStart.toIso8601String(),
      'dateRangeEnd': dateRangeEnd.toIso8601String(),
      'statistics': statistics,
    };
  }

  // Create Report object from JSON
  factory Report.fromJson(Map<String, dynamic> json) {
    return Report(
      goalID: json['goalID'],
      taskId: json['taskId'],
      dateRangeStart: DateTime.parse(json['dateRangeStart']),
      dateRangeEnd: DateTime.parse(json['dateRangeEnd']),
      statistics: json['statistics'],
    );
  }

  // Print Method
  void printData() {
    print('Report Data:');
    print('goalID: $goalID');
    print('taskId: $taskId');
    print('Date Range Start: $dateRangeStart');
    print('Date Range End: $dateRangeEnd');
    print('Statistics:');
    statistics.forEach((key, value) {
      print('$key: $value');
    });
  }
}