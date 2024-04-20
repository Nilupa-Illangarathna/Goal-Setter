import 'package:flutter/material.dart';
import 'package:goal_setting/data_classes/sub%20classes/user_profile_data.dart';
import '../data_state/dataState.dart';
import 'sub classes/goal_class.dart';
import 'sub classes/quote_class.dart';

// Global Data Class
class GlobalDataInstance {
  UserData userData;
  List<Goal> goals7Days;
  List<Goal> goals21Days;
  List<Goal> customGoals;
  List<Quote> quotes;

  // Constructor
  GlobalDataInstance({
    required this.userData,
    required this.goals7Days,
    required this.goals21Days,
    required this.customGoals,
    required this.quotes,
  });

  // Setters and Getters
  UserData get getUserData => userData;
  set setUserData(UserData value) => userData = value;

  List<Goal> get getGoals7Days => goals7Days;
  set setGoals7Days(List<Goal> value) => goals7Days = value;

  List<Goal> get getGoals21Days => goals21Days;
  set setGoals21Days(List<Goal> value) => goals21Days = value;

  List<Goal> get getCustomGoals => customGoals;
  set setCustomGoals(List<Goal> value) => customGoals = value;

  List<Quote> get getQuotes => quotes;
  set setQuotes(List<Quote> value) => quotes = value;

  // Print Method
  void printData() {
    print('Global Data:');
    userData.printData();
    print('Goals of 7 Days:');
    for (var goal in goals7Days) {
      goal.printData();
    }
    print('Goals of 21 Days:');
    for (var goal in goals21Days) {
      goal.printData();
    }
    print('Custom Goals:');
    for (var goal in customGoals) {
      goal.printData();
    }
    print('Quotes:');
    for (var quote in quotes) {
      quote.printData();
    }
  }

  // Convert GlobalData object to JSON
  Map<String, dynamic> toJson() {
    List<Map<String, dynamic>> goals7DaysJson = goals7Days.map((goal) => goal.toJson()).toList();
    List<Map<String, dynamic>> goals21DaysJson = goals21Days.map((goal) => goal.toJson()).toList();
    List<Map<String, dynamic>> customGoalsJson = customGoals.map((goal) => goal.toJson()).toList();
    List<Map<String, dynamic>> quotesJson = quotes.map((quote) => quote.toJson()).toList();

    return {
      'userData': userData.toJson(),
      'goals7Days': goals7DaysJson,
      'goals21Days': goals21DaysJson,
      'customGoals': customGoalsJson,
      'quotes': quotesJson,
    };
  }

  // Create GlobalData object from JSON
  factory GlobalDataInstance.fromJson(Map<String, dynamic> json) {
    List<dynamic> goals7DaysJson = json['goals7Days'];
    List<dynamic> goals21DaysJson = json['goals21Days'];
    List<dynamic> customGoalsJson = json['customGoals'];
    List<dynamic> quotesJson = json['quotes'];

    List<Goal> goals7DaysList = goals7DaysJson.map((goalJson) => Goal.fromJson(goalJson)).toList();
    List<Goal> goals21DaysList = goals21DaysJson.map((goalJson) => Goal.fromJson(goalJson)).toList();
    List<Goal> customGoalsList = customGoalsJson.map((goalJson) => Goal.fromJson(goalJson)).toList();
    List<Quote> quotesList = quotesJson.map((quoteJson) => Quote.fromJson(quoteJson)).toList();

    return GlobalDataInstance(
      userData: UserData.fromJson(json['userData']),
      goals7Days: goals7DaysList,
      goals21Days: goals21DaysList,
      customGoals: customGoalsList,
      quotes: quotesList,
    );
  }

  // TODO: Method to add a goal and append it to the correct array based on its duration
  // FIXME: API call should be done
  void addGoalAndAppendArray({required Goal newGoal}) {
    if (newGoal.targetDate.difference(newGoal.startDate).inDays == 7) {
      goals7Days.add(newGoal);
    } else if (newGoal.targetDate.difference(newGoal.startDate).inDays == 21) {
      goals21Days.add(newGoal);
    } else {
      customGoals.add(newGoal);
    }

    // Update database
    updateDatabase();
  }


  // Function to delete a goal based on its ID from any of the arrays
  void deleteGoalById({required String goalId}) {
    // Remove goal from goals7Days if found
    goals7Days.removeWhere((goal) => goal.id == goalId);

    // Remove goal from goals21Days if found
    goals21Days.removeWhere((goal) => goal.id == goalId);

    // Remove goal from customGoals if found
    customGoals.removeWhere((goal) => goal.id == goalId);

    // Update database
    updateDatabase();
  }

  //TODO : We can make this automated isnide this class itelf
  void updateDatabase(){
    sendGlobalData(globalData:global_user_data_OBJ); //TODO
  }
}
