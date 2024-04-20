
//
// class UserDataPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('User Data Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Create a UserData object
//             UserData user = UserData(
//               name: 'John Doe',
//               age: 30,
//               username: 'johndoe123',
//               email: 'john.doe@example.com',
//               mobile: '1234567890',
//               password: 'password123',
//             );
//
//             // Print user data
//             user.printData();
//
//             // Serialize user data to JSON
//             Map<String, dynamic> jsonUser = user.toJson();
//             print('Serialized User Data: $jsonUser');
//
//             // Deserialize user data from JSON
//             UserData deserializedUser = UserData.fromJson(jsonUser);
//             print('Deserialized User Data:');
//             deserializedUser.printData();
//           },
//           child: Text('Print User Data'),
//         ),
//       ),
//     );
//   }
// }






//
// class TaskDummy extends StatelessWidget {
//   void _printDummyTask() {
//     // Create dummy achievements
//     List<Achievement> achievements = [
//       Achievement(id: '1', name: 'Achievement 1', description: 'Description 1', dateEarned: DateTime.now()),
//       Achievement(id: '2', name: 'Achievement 2', description: 'Description 2', dateEarned: DateTime.now()),
//     ];
//
//     // Create dummy report
//     Report report = Report(
//       id: '1',
//       userId: 'user1',
//       dateRangeStart: DateTime.now().subtract(Duration(days: 7)),
//       dateRangeEnd: DateTime.now(),
//       statistics: {'stat1': 10, 'stat2': 20},
//     );
//
//     // Create dummy progress
//     Progress progress = Progress(
//       id: '1',
//       goalId: 'goal1',
//       taskId: 'task1',
//       date: DateTime.now(),
//       value: 50,
//     );
//
//     // Create dummy task
//     Task dummyTask = Task(
//       id: '1',
//       name: 'Dummy Task',
//       startDate: DateTime.now().subtract(Duration(days: 3)),
//       targetDate: DateTime.now().add(Duration(days: 7)),
//       completed: false,
//       achievements: achievements,
//       report: report,
//       progress: progress,
//     );
//
//     // Print dummy task data
//     dummyTask.printData();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Dummy Task Printer'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: _printDummyTask,
//           child: Text('Print Dummy Task'),
//         ),
//       ),
//     );
//   }
// }
//










//
// class GoalPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Goal Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Create a dummy Goal object with associated Task, Achievement, Report, and Progress objects
//             Goal dummyGoal = Goal(
//               id: '1',
//               name: 'Dummy Goal',
//               startDate: DateTime.now(),
//               targetDate: DateTime.now().add(Duration(days: 30)),
//               description: 'This is a dummy goal.',
//               tasks: [
//                 Task(
//                   id: '1',
//                   name: 'Dummy Task 1',
//                   startDate: DateTime.now(),
//                   targetDate: DateTime.now().add(Duration(days: 15)),
//                   completed: false,
//                   achievements: [
//                     Achievement(
//                       id: '1',
//                       name: 'Achievement 1',
//                       description: 'This is an achievement for Dummy Task 1',
//                       dateEarned: DateTime.now(),
//                     ),
//                   ],
//                   report: Report(
//                     id: '1',
//                     userId: 'user1',
//                     dateRangeStart: DateTime.now().subtract(Duration(days: 7)),
//                     dateRangeEnd: DateTime.now(),
//                     statistics: {
//                       'taskCompletionRate': 0.5,
//                     },
//                   ),
//                   progress: Progress(
//                     id: '1',
//                     goalId: '1',
//                     taskId: '1',
//                     date: DateTime.now(),
//                     value: 0.3,
//                   ),
//                 ),
//                 Task(
//                   id: '2',
//                   name: 'Dummy Task 2',
//                   startDate: DateTime.now(),
//                   targetDate: DateTime.now().add(Duration(days: 25)),
//                   completed: false,
//                   achievements: [],
//                   report: Report(
//                     id: '2',
//                     userId: 'user1',
//                     dateRangeStart: DateTime.now().subtract(Duration(days: 14)),
//                     dateRangeEnd: DateTime.now(),
//                     statistics: {
//                       'taskCompletionRate': 0.2,
//                     },
//                   ),
//                   progress: Progress(
//                     id: '2',
//                     goalId: '1',
//                     taskId: '2',
//                     date: DateTime.now(),
//                     value: 0.1,
//                   ),
//                 ),
//               ],
//             );
//
//             // Print the dummy Goal object
//             dummyGoal.printData();
//           },
//           child: Text('Print Dummy Goal'),
//         ),
//       ),
//     );
//   }
// }












// class AchievementPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Achievement Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Create an Achievement object
//             Achievement achievement = Achievement(
//               id: '1',
//               name: 'High Score',
//               description: 'Achieved the highest score in the game',
//               dateEarned: DateTime.now(),
//             );
//
//             // Print achievement data
//             achievement.printData();
//
//             // Serialize achievement data to JSON
//             Map<String, dynamic> jsonAchievement = achievement.toJson();
//             print('Serialized Achievement Data: $jsonAchievement');
//
//             // Deserialize achievement data from JSON
//             Achievement deserializedAchievement = Achievement.fromJson(jsonAchievement);
//             print('Deserialized Achievement Data:');
//             deserializedAchievement.printData();
//           },
//           child: Text('Print Achievement Data'),
//         ),
//       ),
//     );
//   }
// }












// class ProgressPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Progress Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Create a Progress object
//             Progress progress = Progress(
//               id: '1',
//               goalId: 'goal1',
//               taskId: 'task1',
//               date: DateTime.now(),
//               value: 50,
//             );
//
//             // Print progress data
//             progress.printData();
//
//             // Serialize progress data to JSON
//             Map<String, dynamic> jsonProgress = progress.toJson();
//             print('Serialized Progress Data: $jsonProgress');
//
//             // Deserialize progress data from JSON
//             Progress deserializedProgress = Progress.fromJson(jsonProgress);
//             print('Deserialized Progress Data:');
//             deserializedProgress.printData();
//           },
//           child: Text('Print Progress Data'),
//         ),
//       ),
//     );
//   }
// }









// class QuotePage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Quote Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Create a Quote object
//             Quote quote = Quote(
//               id: '1',
//               text: 'Example quote text',
//               author: 'John Doe',
//               date: DateTime.now(),
//             );
//
//             // Print quote data
//             quote.printData();
//
//             // Serialize quote data to JSON
//             Map<String, dynamic> jsonQuote = quote.toJson();
//             print('Serialized Quote Data: $jsonQuote');
//
//             // Deserialize quote data from JSON
//             Quote deserializedQuote = Quote.fromJson(jsonQuote);
//             print('Deserialized Quote Data:');
//             deserializedQuote.printData();
//           },
//           child: Text('Print Quote Data'),
//         ),
//       ),
//     );
//   }
// }










// class ReportPage extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Report Page'),
//       ),
//       body: Center(
//         child: ElevatedButton(
//           onPressed: () {
//             // Create a Report object
//             Report report = Report(
//               id: '1',
//               userId: 'user123',
//               dateRangeStart: DateTime.now(),
//               dateRangeEnd: DateTime.now().add(Duration(days: 7)),
//               statistics: {
//                 'taskCompletionRate': 0.75,
//                 'progressSummary': 'Good progress',
//               },
//             );
//
//             // Print report data
//             report.printData();
//
//             // Serialize report data to JSON
//             Map<String, dynamic> jsonReport = report.toJson();
//             print('Serialized Report Data: $jsonReport');
//
//             // Deserialize report data from JSON
//             Report deserializedReport = Report.fromJson(jsonReport);
//             print('Deserialized Report Data:');
//             deserializedReport.printData();
//           },
//           child: Text('Print Report Data'),
//         ),
//       ),
//     );
//   }
// }