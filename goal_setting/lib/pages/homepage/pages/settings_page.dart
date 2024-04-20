import 'package:flutter/material.dart';

import '../../../data_state/dataState.dart';
import '../../../widgets/Charts/chart.dart';
import '../widgets/aboutPage.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool notificationsEnabled = global_user_data_OBJ.userData.notificationsOn;
  TimeOfDay selectedTime = stringToTimeOfDay(global_user_data_OBJ.userData.notificationTime); // Initial time

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [
          // Background Image
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Positioned.fill(
                child: Image.asset(
                  'assets/images/settings_background.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ],
          ),
          // Content
          Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                SizedBox(height: 18),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Settings',
                      style: TextStyle(
                        fontSize: 36.0,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF1A237E), // Adjusted color to a darker shade
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          // Show task input form
                          Navigator.push(context, MaterialPageRoute(
                              builder: (context) => AboutPage()));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text('About'),
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 128),
                // Notifications Switch
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notifications on:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      Switch(
                        value: notificationsEnabled,
                        onChanged: (value) {
                          setState(() {
                            notificationsEnabled = value;
                          });
                          _executeFunction();
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16),
                // Notification Time Picker
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal:16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Notification time:',
                        style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _showTimePicker();
                        },
                        child: Text(
                          '${selectedTime.format(context)}',
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _executeFunction() {
    // Execute the function
    print('Function executed');
    global_user_data_OBJ.userData.notificationsOn = notificationsEnabled;
    global_user_data_OBJ.userData.notificationTime = timeOfDayToString(selectedTime); // Initial time

    sendGlobalData(globalData: global_user_data_OBJ);
  }

  Future<void> _showTimePicker() async {
    final TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (pickedTime != null && pickedTime != selectedTime) {
      setState(() {
        selectedTime = pickedTime;
      });
      _executeFunction();
    }
  }
}

void main() {
  runApp(MaterialApp(
    home: SettingsPage(),
  ));
}
