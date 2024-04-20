import 'package:flutter/material.dart';
import './task_class.dart'; // Import the Task class

// Goal Class
class Goal {
  String id; // Unique identifier for each goal
  String name;
  DateTime startDate;
  DateTime targetDate;
  String description;
  String ImageURL;
  List<Task> tasks;

  // Constructor
  Goal({
    required this.id,
    required this.name,
    required this.startDate,
    required this.targetDate,
    required this.ImageURL,
    required this.description,
    required this.tasks,
  });

  // Getter and Setter for ID, Name, Start Date, Target Date, Description, Tasks
  String get goalId => id;
  set goalId(String value) => id = value;

  String get goalName => name;
  set goalName(String value) => name = value;

  DateTime get goalStartDate => startDate;
  set goalStartDate(DateTime value) => startDate = value;

  DateTime get goalTargetDate => targetDate;
  set goalTargetDate(DateTime value) => targetDate = value;

  String get goalDescription => description;
  set goalDescription(String value) => description = value;

  String get goalImageURL => ImageURL;
  set goalImageURL(String value) => ImageURL = value;

  List<Task> get goalTasks => tasks;
  set goalTasks(List<Task> value) => tasks = value;

  // Print Method
  void printData() {
    print('Goal Data:');
    print('ID: $id');
    print('Name: $name');
    print('Start Date: $startDate');
    print('Target Date: $targetDate');
    print('ImageURL: $ImageURL');
    print('Description: $description');
    print('Tasks:');
    for (var task in tasks) {
      task.printData();
    }
  }

  // Convert Goal object to JSON
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> taskListJson = tasks.map((task) => task.toJson()).toList();

    return {
      'id': id,
      'name': name,
      'startDate': startDate.toIso8601String(),
      'targetDate': targetDate.toIso8601String(),
      'ImageURL': ImageURL,
      'description': description,
      'tasks': taskListJson,
    };
  }

  // Create Goal object from JSON
  factory Goal.fromJson(Map<String, dynamic> json) {
    List<dynamic> taskListJson = json['tasks'];
    List<Task> taskList = taskListJson.map((taskJson) => Task.fromJson(taskJson)).toList();

    return Goal(
      id: json['id'],
      name: json['name'],
      startDate: DateTime.parse(json['startDate']),
      targetDate: DateTime.parse(json['targetDate']),
      ImageURL: json['ImageURL'],
      description: json['description'],
      tasks: taskList,
    );
  }
}
