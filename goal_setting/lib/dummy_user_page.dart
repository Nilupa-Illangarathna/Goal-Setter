import 'dart:convert';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:goal_setting/utils/theme.dart';
import 'package:goal_setting/widgets/homepage/AchivementWidget.dart';
import 'package:goal_setting/widgets/homepage/ProgressWidget.dart';
import 'package:goal_setting/widgets/homepage/QuateWidget.dart';
import 'package:goal_setting/widgets/homepage/ReportWidget.dart';
import 'package:goal_setting/widgets/homepage/TaskWidget.dart';
import 'package:intl/intl.dart';

import 'data_classes/global_data_class.dart';
import 'data_classes/sub classes/achievement_class.dart';
import 'data_classes/sub classes/goal_class.dart';
import 'data_classes/sub classes/progress_class.dart';
import 'data_classes/sub classes/quote_class.dart';
import 'data_classes/sub classes/report_class.dart';
import 'data_classes/sub classes/task_class.dart';
import 'data_classes/sub classes/user_profile_data.dart';
import 'data_state/dataState.dart';


import 'package:http/http.dart' as http;
import 'dart:convert';

import 'global/global_settings.dart';

class RandomDataGenerator {
  static String generateRandomString(int length) {
    const chars = 'abcdefghijklmnopqrstuvwxyz0123456789';
    final random = Random();
    return String.fromCharCodes(Iterable.generate(
      length, (_) => chars.codeUnitAt(random.nextInt(chars.length)),
    ));
  }


  static List<List<DateTime>> breakDateRange(DateTime startDate, DateTime endDate, int maxTasks) {
    final List<List<DateTime>> subIntervals = [];

    final Duration interval = endDate.difference(startDate);
    final Duration subIntervalDuration = Duration(days: interval.inDays ~/ maxTasks);

    DateTime subIntervalStart = startDate;
    DateTime subIntervalEnd;

    for (int i = 0; i < maxTasks; i++) {
      subIntervalEnd = subIntervalStart.add(subIntervalDuration);
      subIntervals.add([subIntervalStart, subIntervalEnd]);
      subIntervalStart = subIntervalEnd.add(Duration(days: 1)); // Move start to next day for the next subinterval
    }

    // Adjust the last subinterval end to match the end date
    subIntervals[maxTasks - 1][1] = endDate;

    return subIntervals;
  }


  static dynamic pickRandomItem(List<dynamic> items) {
    final random = Random();
    return items[random.nextInt(items.length)];
  }

  //TODO Date generator
  static List<DateTime> generateRandomDate(int daysToAdd) {
    final random = Random();
    final now = DateTime.now();
    final randomDay1 = now.add(Duration(days: random.nextInt(365)));
    final randomDay2 = randomDay1.add(Duration(days: daysToAdd));

    final year1 = randomDay1.year;
    final month1 = randomDay1.month.toString().padLeft(2, '0');
    final day1 = randomDay1.day.toString().padLeft(2, '0');

    final year2 = randomDay2.year;
    final month2 = randomDay2.month.toString().padLeft(2, '0');
    final day2 = randomDay2.day.toString().padLeft(2, '0');

    final DateTime date1 = DateTime.parse('$year1-$month1-$day1');
    final DateTime date2 = DateTime.parse('$year2-$month2-$day2');

    return [date1, date2];
  }











  //TODO UserData
  static UserData generateRandomUserData() {
    final names = ['John', 'Nick', 'Nathan', 'Emily', 'Sophia', 'Oliver', 'Emma', 'Ava'];
    final usernames = ['john_doe', 'nick_23', 'nathan97', 'emily.smith', 'sophia_12', 'oliver99'];
    final emails = ['john@example.com', 'nick@example.com', 'nathan@example.com', 'emily@example.com'];
    final mobiles = ['0774567890', '0716543210', '0815555555', '0607777777'];
    final passwords = ['password123', 'securepass', 'mypassword', 'letmein'];
    final FirebaseServiceTokens = ['0774567890', '0716543210', '0815555555', '0607777777'];

    return UserData(
      name: pickRandomItem(names),
      age: Random().nextInt(50) + 18,
      username: pickRandomItem(usernames),
      email: pickRandomItem(emails),
      mobile: pickRandomItem(mobiles),
      password: pickRandomItem(passwords),
      FirebaseServiceToken: pickRandomItem(FirebaseServiceTokens),
      notificationsOn: false,
      notificationTime: timeOfDayToString(TimeOfDay.now()),
    );
  }

  //TODO Progress
  static Progress generateRandomProgress(String goalId, String taskId, DateTime endDate) {
    final progressValues = ["0", "10", "30", "50", "70", "90", "100"];

    return Progress(
      goalID: goalId,
      taskId: taskId,
      date: endDate,
      value: pickRandomItem(progressValues),
    );
  }

  //TODO Report
  static Report generateRandomReport(String goalId, String taskId, DateTime startDate, DateTime endDate) {
    final statistics = <String, int>{};
    final duration = endDate.difference(startDate).inDays;

    // Generate statistics for each day within the date range
    for (int i = 0; i <= duration; i++) {
      if(Random().nextInt(3)==1){
        continue;
      }
      final currentDate = startDate.add(Duration(days: i));
      statistics[currentDate.toString()] = Random().nextInt(10);
    }

    return Report(
      goalID: goalId,
      taskId: taskId,
      dateRangeStart: startDate,
      dateRangeEnd: endDate,
      statistics: statistics,
    );
  }

  //TODO Achievement
  static Achievement generateRandomAchievement(String goalId, String taskId, DateTime completeDate) {
    final descriptions = [
      "Completed a challenging task",
      "Reached a significant milestone",
      "Overcame a difficult obstacle",
      "Demonstrated exceptional skill",
      "Achieved outstanding results",
      "Received recognition for hard work",
      "Made a significant contribution",
      "Exceeded expectations",
      "Showed exceptional dedication",
      "Earned respect from peers",
    ];

    final AchievementNames = [
      "Complete project Achievement",
      "Write report Achievement",
      "Attend meeting Achievement",
      "Prepare presentation Achievement",
      "Review documents Achievement",
      "Analyze data Achievement",
      "Conduct research Achievement",
      "Develop prototype Achievement",
      "Test application Achievement",
      "Implement feature Achievement",
    ];

    return Achievement(
      goalID: goalId,
      taskId: taskId,
      name: pickRandomItem(AchievementNames),
      description: pickRandomItem(descriptions),
      dateEarned: completeDate,
    );
  }

  //TODO Task
  static Task generateRandomTask(String goalId, DateTime startDate, DateTime endDate) {

    final taskId = goalId + generateRandomString(6);

    final taskNames = [
      "Complete project",
      "Write report",
      "Attend meeting",
      "Prepare presentation",
      "Review documents",
      "Analyze data",
      "Conduct research",
      "Develop prototype",
      "Test application",
      "Implement feature",
    ];


    return Task(
      goalID: goalId,
      taskID: taskId,
      name: pickRandomItem(taskNames),
      startDate: startDate,
      targetDate: endDate,
      completed: Random().nextBool(),
      achievements: List.generate(Random().nextInt(2) + 1, (_) => generateRandomAchievement(goalId,taskId, endDate)),
      report: generateRandomReport(goalId,taskId, startDate, endDate),
      progress: generateRandomProgress(goalId, taskId, endDate),
    );
  }












  //TODO Goal
  static Goal generateRandomGoal(List<int> GoalType) {
    final goalId = generateRandomString(6);

    final goalNames = [
      "Achieve fitness goals",
      "Complete project tasks",
      "Learn new skills",
      "Improve productivity",
      "Enhance communication skills",
      "Explore new opportunities",
      "Develop personal projects",
      "Expand professional network",
      "Boost career prospects",
      "Achieve work-life balance",
    ];

    final goalDescriptions = [
      "Increase strength and endurance through regular exercise routines",
      "Accomplish project milestones according to set deadlines",
      "Acquire proficiency in programming languages and tools",
      "Implement time management techniques for better efficiency",
      "Participate in public speaking events and workshops",
      "Seek out novel experiences and challenges",
      "Work on passion projects during free time",
      "Attend industry events and connect with professionals",
      "Pursue career advancement opportunities",
      "Establish boundaries between work and personal life for improved well-being",
    ];

    final imageUrls = [
      "https://www.monash.edu/__data/assets/image/0009/2836899/complexideas.jpg",
      "https://www.dummies.com/wp-content/uploads/goals-list-adobestock_244632453.jpg",
      "https://www.cfp.net/-/media/images/cfp-board/photos/full-width/individuals/1144287280.jpg?cx=0&cy=0&cw=750&ch=550&hash=DAF2E9DA34856A90B08DFD63C88C6A1E"
    ];

    final maxTasks = Random().nextInt(4) + 3; // Random number of tasks (1 to 4)

    int daysToAdd = GoalType[0]==7 ? 7 : GoalType[0] == 21 ? 21 : GoalType[0];

    final startDate = generateRandomDate(daysToAdd);

    // Break the time gap between startTime and endTime into maxTasks number of subintervals
    final subIntervals = breakDateRange(startDate[0], startDate[1], maxTasks);

    DateTime startTime = startDate[0];
    DateTime endTime = startDate[1];

    return Goal(
      id: goalId,
      name: pickRandomItem(goalNames),
      startDate: startTime,
      targetDate: endTime,
      ImageURL: pickRandomItem(imageUrls),
      description: pickRandomItem(goalDescriptions),
      tasks: List.generate(
        maxTasks,
            (index) => generateRandomTask(goalId, subIntervals[index][0], subIntervals[index][1]),
      ),
    );
  }




  //TODO Quote
  static Quote generateRandomQuote() {
    final List<List<String>> quotesList = [
      ["The only way to do great work is to love what you do.", "Steve Jobs"],
      ["Success is not final, failure is not fatal: It is the courage to continue that counts.", "Winston Churchill"],
      ["Believe you can and you're halfway there.", "Theodore Roosevelt"],
      ["The future belongs to those who believe in the beauty of their dreams.", "Eleanor Roosevelt"],
      ["It does not matter how slowly you go as long as you do not stop.", "Confucius"],
      ["You are never too old to set another goal or to dream a new dream.", "C.S. Lewis"],
      ["Success is not the key to happiness. Happiness is the key to success. If you love what you are doing, you will be successful.", "Albert Schweitzer"],
      ["The only limit to our realization of tomorrow will be our doubts of today.", "Franklin D. Roosevelt"],
      ["The best way to predict the future is to create it.", "Abraham Lincoln"],
      ["The only source of knowledge is experience.", "Albert Einstein"],
      // Add more quotes as needed
    ];

    final random = Random();
    final List<String> selectedQuote =  quotesList[random.nextInt(quotesList.length)];

    return Quote(
      id: generateRandomString(6),
      text: selectedQuote[0],
      author: selectedQuote[1], // Since the author is not specified in the list
    );
  }

  static GlobalDataInstance generateRandomGlobalData(int numberOfRandomGeneratod, int NumberOfQuotes,  UserData userDataOBJ) {
    return GlobalDataInstance(
      userData: userDataOBJ,
      goals7Days: List.generate(Random().nextInt(numberOfRandomGeneratod + 1), (_) => generateRandomGoal([7])),
      goals21Days: List.generate(Random().nextInt(numberOfRandomGeneratod + 1), (_) => generateRandomGoal([21])),
      customGoals: List.generate(Random().nextInt(numberOfRandomGeneratod + 1), (_) => generateRandomGoal([Random().nextInt(365)])),
      quotes: List.generate(Random().nextInt(NumberOfQuotes) + 1, (_) => generateRandomQuote()),
    );
  }
}


late Quote quote1;
late Quote quote2;

Future<List<List<String>>> fetchQuotes() async {
  final response = await http.get(Uri.parse('${globalData.baseUrlRoute}/quotes'));

  if (response.statusCode == 200) {
    // If the server returns a 200 OK response, parse the JSON
    List<dynamic> decodedData = jsonDecode(response.body);
    List<List<String>> quotesList = [];

    decodedData.forEach((quote) {
      if (quote is List<dynamic> && quote.length >= 2) {
        quotesList.add([quote[0].toString(), quote[1].toString()]);
      }
    });

    int randomNumber1 = Random().nextInt(quotesList.length);
    int randomNumber2 = Random().nextInt(quotesList.length);
    while(randomNumber1==randomNumber2 && quotesList.length>1) {
      randomNumber2 = Random().nextInt(quotesList.length);
    }
    quote1 =   Quote(id:"1", text: quotesList[randomNumber1][0], author: quotesList[randomNumber1][1]);
    quote2 =   Quote(id:"1", text: quotesList[randomNumber2][0], author: quotesList[randomNumber2][1]);

    // Print the quotesList to the CLI
    print('Quotes List:');
    quotesList.forEach((quote) {
      print('${quote[0]} - ${quote[1]}');
    });

    return quotesList;
  } else {
    // If the server returns an error response, throw an exception
    throw Exception('Failed to load quotes');
  }
}
