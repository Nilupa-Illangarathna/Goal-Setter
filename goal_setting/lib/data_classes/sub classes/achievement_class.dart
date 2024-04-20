import 'package:flutter/material.dart';

// Achievement Class
class Achievement {
  String goalID; // Unique identifier for each achievement
  String taskId; // Unique identifier for each achievement
  String name;
  String description;
  DateTime dateEarned;

  // Constructor
  Achievement({
    required this.goalID,
    required this.taskId,
    required this.name,
    required this.description,
    required this.dateEarned,
  });

  // Getter and Setter for ID
  String get achievementgoalID => goalID;
  set achievementgoalID(String value) => goalID = value;

  String get achievementtaskId => taskId;
  set achievementtaskId(String value) => taskId = value;

  // Getter and Setter for Name
  String get achievementName => name;
  set achievementName(String value) => name = value;

  // Getter and Setter for Description
  String get achievementDescription => description;
  set achievementDescription(String value) => description = value;

  // Getter and Setter for Date Earned
  DateTime get achievementDateEarned => dateEarned;
  set achievementDateEarned(DateTime value) => dateEarned = value;

  // Convert Achievement object to JSON
  Map<String, dynamic> toJson() {
    return {
      'goalID': goalID,
      'taskId': taskId,
      'name': name,
      'description': description,
      'dateEarned': dateEarned.toIso8601String(),
    };
  }

  // Create Achievement object from JSON
  factory Achievement.fromJson(Map<String, dynamic> json) {
    return Achievement(
      goalID: json['goalID'],
      taskId: json['taskId'],
      name: json['name'],
      description: json['description'],
      dateEarned: DateTime.parse(json['dateEarned']),
    );
  }

  // Print Method
  void printData() {
    print('Achievement Data:');
    print('goalID: $goalID');
    print('taskId: $taskId');
    print('Name: $name');
    print('Description: $description');
    print('Date Earned: $dateEarned');
  }
}
