// Import necessary packages
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

import '../../../data_state/dataState.dart';
import '../../../data_classes/sub classes/achievement_class.dart';
import '../../../data_classes/sub classes/goal_class.dart';
import '../../../data_classes/sub classes/progress_class.dart';
import '../../../data_classes/sub classes/report_class.dart';
import '../../../data_classes/sub classes/task_class.dart';
import 'package:http/http.dart' as http;

// Define the SetGoalPage StatefulWidget
class SetGoalPage extends StatefulWidget {
  @override
  _SetGoalPageState createState() => _SetGoalPageState();
}

// Define the _SetGoalPageState State class
class _SetGoalPageState extends State<SetGoalPage> {
  // Define variables to store goal-related data
  String name = '';
  DateTime? startDate;
  DateTime? targetDate;
  DateTime? taskStartDate;
  DateTime? taskTargetDate;
  String description = '';
  String imageURL = '';
  String goalID = Uuid().v4(); // Generate a UUID for the goal ID
  int remainingDays = 0;
  bool exists = false;

  // Define a list to store tasks
  List<Task> tasks = [];

  // Define a GlobalKey for the form
  final _formKey = GlobalKey<FormState>();

  // Define a GlobalKey for the task form
  final _taskFormKey = GlobalKey<FormState>();

  // Controller for the task name input field
  final _taskNamesController = TextEditingController();

  // Controller for the task days input field
  final _taskDaysController = TextEditingController();

  // Controller for the task descriptiuon input field
  final _taskDescriptionController = TextEditingController();


  // Verify image URL existence
  Future<bool> _verifyImageURL(String url) async {
    try {
      final response = await http.head(Uri.parse(url));
      if (response.statusCode == 200) {
        final contentType = response.headers['content-type'];
        if (contentType != null) {
          exists = contentType.startsWith('image/');
          return exists;
        }
      }
      exists = false;
      return false;
    } catch (e) {
      exists = false;
      return false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Scaffold body
      body: Stack(
        children: [

          Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding:EdgeInsets.only(right:100, top:20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/set_goals_background2.png', // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          Container(
            height:MediaQuery.of(context).size.height,
            width:MediaQuery.of(context).size.width,
            padding:EdgeInsets.only(left:100),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Opacity(
                  opacity: 0.6, // Set the opacity value as desired
                  child: Image.asset(
                    'assets/images/set_goals_background.png', // Replace 'your_image.png' with your image asset path
                    fit: BoxFit.fill, // Adjust the fit as needed
                  ),
                ),
              ],
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        child: Text(
                          'Add Goals',
                          style: TextStyle(
                            fontSize: 36.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1A237E),
                          ),
                        ),
                      ),
                      IconButton(
                        icon: Container(
                          height: 48,
                          width: 48,
                          decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.2),
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Icon(
                            Icons.close,
                            color: Colors.grey,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 0.0),
                  child: SingleChildScrollView(
                    // padding: EdgeInsets.symmetric(vertical: 24.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Title
                        SizedBox(height: 24), // Spacer
                        // Goal form
                        Form(
                          key: _formKey,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                // Goal input fields
                                _buildInputField(
                                  labelText: 'Name',
                                  onChanged: (value) => name = value,
                                ),
                                Row(
                                  children: [
                                    SizedBox(height: 10.0),
                                  ],
                                ), // Spacer
                                _buildInputField(
                                  labelText: 'Start Date',
                                  readOnly: true,
                                  onTap: () => _selectDate(context, true),
                                  suffixIcon: Icons.calendar_today,
                                  value: startDate != null ? DateFormat('MMM dd, yyyy').format(startDate!) : null,
                                ),
                                SizedBox(height: 10.0), // Spacer
                                _buildInputField(
                                  labelText: 'Target Date',
                                  readOnly: true,
                                  onTap: () => _selectDate(context, false),
                                  suffixIcon: Icons.calendar_today,
                                  value: targetDate != null ? DateFormat('MMM dd, yyyy').format(targetDate!) : null,
                                ),
                                SizedBox(height: 10.0), // Spacer
                                _buildInputField(
                                  labelText: 'Description',
                                  maxLines: null,
                                  onChanged: (value) => description = value,
                                ),
                                SizedBox(height: 10.0), // Spacer
                                _buildInputField(
                                  labelText: 'Image URL',
                                  onChanged: (value) async {
                                    imageURL = value;
                                    // Verify image URL existence
                                    if (value.isNotEmpty) {
                                      exists = await _verifyImageURL(value);
                                      if (!exists && value.isNotEmpty) {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Image URL does not exist')),
                                        );
                                      }
                                    }
                                  },
                                ),
                                SizedBox(height: 32.0), // Spacer
                                // Add Tasks Button



                                //
                                // // Remaining Time
                                // Center(
                                //   child: Padding(
                                //     padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                //     child: Text(
                                //       'Remaining Time: $remainingDays days',
                                //       style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
                                //     ),
                                //   ),
                                // ),
                                // SizedBox(height: 20.0), // Spacer
                                // Task List View
                                if (tasks.isNotEmpty) _buildTaskList(),



                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 10.0), // Spacer
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [

                              SizedBox(
                                // width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_formKey.currentState!.validate() && _validateDateInterval()) {
                                      // Show task input form
                                      exists? _showTaskInputForm() :

                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Image URL does not exist')),
                                        );

                                    }
                                  },
                                  child: Text('Add Tasks'),
                                ),
                              ),

                              SizedBox(
                                // width: 200,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if(tasks.length>0){
                                      // Create the Goal object
                                      Goal goal = Goal(
                                        id: goalID,
                                        name: name,
                                        startDate: startDate!,
                                        targetDate: targetDate!,
                                        ImageURL: imageURL,
                                        description: description,
                                        tasks: tasks,
                                      );

                                      setState(() {
                                        // Print the Goal object's data
                                        global_user_data_OBJ.addGoalAndAppendArray(newGoal:goal); //TODO
                                      });
                                      goal.printData();
                                      Navigator.of(context).pop();

                                    }
                                  },
                                  child: Text('Add goal'),

                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Build task list
  SizedBox _buildTaskList() {
    return SizedBox(
      height: 180.0, // Set the height of the horizontal list view
      child: ListView.builder(
        scrollDirection: Axis.horizontal, // Set the scroll direction to horizontal
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          Task task = tasks[index];
          return Container(
            width: MediaQuery.of(context).size.width * 2/3 - 32.0, // Calculate the width of the container
            margin: EdgeInsets.symmetric(horizontal: 16.0, vertical:8), // Set the horizontal margin

            child: ElevatedContainer( // Wrap the Container with ElevatedContainer
              borderRadius: BorderRadius.circular(16.0), // Add border radius
              elevation: 1, // Add elevation
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(task.name),
                  subtitle: Text(
                    'Start Date: ${DateFormat('MMM dd, yyyy').format(task.startDate)}\n'
                        'End Date: ${DateFormat('MMM dd, yyyy').format(task.targetDate)}\n'
                        'Description: ${task.achievements[0].description}',


                  ),
                ),
              ),
            ),
          );
        },
      ),
    )
    ;
  }



// Build input field widget
  Widget _buildTaskDateInputField({
    required String labelText,
    String? value,
    bool readOnly = false,
    Function(String)? onChanged,
    Function()? onTap,
    IconData? suffixIcon,
    int? maxLines,
  }) {
    return Container(
      width: 250.0, // Set total height including margins
      // margin: EdgeInsets.symmetric(vertical: 0.0), // Add margin

      child: Row(
        children: [
          Expanded(
            child: TextFormField(
              style: TextStyle(fontSize: 16.0), // Adjust font size
              decoration: InputDecoration(labelText: labelText),
              readOnly: readOnly,
              initialValue: '',
              onChanged: onChanged,
              onTap: onTap as void Function()?,
              maxLines: maxLines,
            ),
          ),
          // SizedBox(width:16),
          if (value != null && value.isNotEmpty) // Display selected date if not null
            Text(
              value,
              style: TextStyle(color: Colors.grey[700]),
            ),
        ],
      ),
    );
  }




  // Select date function
  void _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          startDate = pickedDate;
        } else {
          targetDate = pickedDate;
          remainingDays = targetDate!.difference(startDate!).inDays;
        }
      });
    }
  }


  void _selectTaskDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null) {
      setState(() {
        if (isStartDate) {
          taskStartDate = pickedDate;
          _taskFormKey.currentState?.validate(); // Trigger form validation to update the UI
        } else {
          taskTargetDate = pickedDate;
          _taskFormKey.currentState?.validate(); // Trigger form validation to update the UI
        }
      });
    }
  }



// Show task input form
  void _showTaskInputForm() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add New Task'),
        content: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _taskFormKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextFormField(
                    controller: _taskNamesController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(labelText: 'Enter task name'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _taskNamesController.text = '';
                        return 'Please enter a valid task name';
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16),
                  TaskDateInputField(
                    labelText: 'Start Date',
                    value: taskStartDate,
                    readOnly: true,
                    onTap: (selectedDate) => _selectTaskDate(context, true),
                    suffixIcon: Icons.calendar_today,
                  ),
                  SizedBox(height: 16),
                  TaskDateInputField(
                    labelText: 'End Date',
                    value: taskTargetDate,
                    readOnly: true,
                    onTap: (selectedDate) => _selectTaskDate(context, false),
                    suffixIcon: Icons.calendar_today,
                  ),
                  SizedBox(height: 16),
                  TextFormField(
                    controller: _taskDescriptionController,
                    decoration: InputDecoration(labelText: 'Achievement description'),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        _taskDescriptionController.text = '';
                        return 'Please enter a valid description';
                      }
                      return null;
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (_taskFormKey.currentState!.validate()) {
                String taskID = Uuid().v4(); // Generate a UUID for the task ID

                setState(() {
                  tasks.add(Task(
                    goalID: goalID,
                    taskID: taskID,
                    name: _taskNamesController.text,
                    startDate: taskStartDate!,
                    targetDate: taskTargetDate!,
                    completed: false,
                    achievements: _taskDescriptionController.text.isEmpty
                        ? []
                        : [
                      Achievement(
                        goalID: goalID,
                        taskId: taskID,
                        name: '',
                        description: _taskDescriptionController.text,
                        dateEarned: taskTargetDate!,
                      )
                    ],
                    report: Report(
                      goalID: goalID,
                      taskId: taskID,
                      dateRangeStart: taskStartDate!,
                      dateRangeEnd: taskTargetDate!,
                      statistics: generateStatistics(datesInRange(taskStartDate!, taskTargetDate!)),
                    ),
                    progress: Progress(
                      goalID: goalID,
                      taskId: taskID,
                      date: DateTime.now(),
                      value: 0,
                    ),
                  ));
                });

                Navigator.of(context).pop();
              }
            },
            child: Text('Add Task'),
          ),
        ],
      ),
    );
  }






// Build input field widget
  Widget _buildInputField({
    required String labelText,
    String? value,
    bool readOnly = false,
    Function(String)? onChanged,
    Function()? onTap,
    IconData? suffixIcon,
    int? maxLines,
  }) {
    return Container(
      // height: 55.0, // Set total height including margins
      margin: EdgeInsets.symmetric(vertical: 0.0), // Add margin
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0), // Rounded corners
        color: Colors.grey[200],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0),
        child: Row(
          children: [
            Expanded(
              child: TextFormField(
                style: TextStyle(fontSize: 16.0), // Adjust font size
                decoration: InputDecoration(
                  labelText: value != null && value.isNotEmpty ? null : labelText, // Show label text only if value is null or empty
                  hintText: value != null && value.isNotEmpty ? labelText : null, // Show hint text only if value is null or empty
                  border: InputBorder.none,
                  suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
                ),
                readOnly: readOnly,
                initialValue: value,
                onChanged: onChanged,
                onTap: () {
                  // Call onTap function if provided
                  onTap?.call();

                  // If onTap is not provided, check if it's for date fields and call date picker
                  if (onTap == null && (labelText == 'Start Date' || labelText == 'Target Date')) {
                    _selectDate(context, labelText == 'Start Date');
                  }
                },
                maxLines: maxLines,
              ),
            ),
            if (value != null && value.isNotEmpty) // Display selected date if not null
              Text(
                value,
                style: TextStyle(color: Colors.grey[700]),
              ),
          ],
        ),
      ),
    );
  }






// Create a function to generate a list of dates within a range
  List<DateTime> datesInRange(DateTime start, DateTime end) {
    var dates = <DateTime>[];

    // Increment the end date by one day to exclude it from the range
    end = end.add(Duration(days: 1));

    for (var date = start; date.isBefore(end); date = date.add(Duration(days: 1))) {
      dates.add(date);
    }

    print(dates);
    return dates;
  }


  // Create a function to generate a map of statistics with dates as keys
  Map<String, bool> generateStatistics(List<DateTime> dates) {
    Map<String, bool> statistics = {};
    for (var date in dates) {
      // Format the date to a string representation
      String formattedDate = DateFormat('yyyy-MM-dd').format(date);
      // Set the value to false initially
      statistics[formattedDate] = false;
    }
    return statistics;
  }




  // Validate date interval
  bool _validateDateInterval() {
    if (startDate == null || targetDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select both start date and target date')),
      );
      return false;
    }

    if (targetDate!.isBefore(startDate!)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Target date should be after start date')),
      );
      return false;
    }

    return true;
  }
}







class ElevatedContainer extends StatelessWidget {
  final Widget child;
  final double elevation;
  final Color? color;
  final BorderRadius? borderRadius;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;

  ElevatedContainer({
    required this.child,
    this.elevation = 1,
    this.color,
    this.borderRadius,
    this.margin,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        borderRadius: borderRadius,
        color: color ?? Theme.of(context).canvasColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            spreadRadius: elevation,
            blurRadius: elevation,
            offset: Offset(0, elevation), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: padding ?? EdgeInsets.zero,
        child: child,
      ),
    );
  }
}


// Define the TaskDateInputField widget
class TaskDateInputField extends StatelessWidget {
  final String labelText;
  final DateTime? value;
  final bool readOnly;
  final Function(DateTime)? onTap;
  final IconData? suffixIcon;

  const TaskDateInputField({
    Key? key,
    required this.labelText,
    required this.value,
    required this.readOnly,
    required this.onTap,
    required this.suffixIcon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.4, // Adjust width as needed
      child: TextFormField(
        style: TextStyle(fontSize: 16.0),
        decoration: InputDecoration(
          labelText: labelText,
          suffixIcon: suffixIcon != null ? Icon(suffixIcon) : null,
        ),
        readOnly: readOnly,
        onTap: () => onTap!(value!),
        controller: TextEditingController(
          text: value != null ? DateFormat('MMM dd, yyyy').format(value!) : null,
        ),
      ),
    );
  }
}