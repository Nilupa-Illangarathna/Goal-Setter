import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../data_classes/sub classes/progress_class.dart';

class ProgressWidget extends StatelessWidget {
  final Progress progress;

  const ProgressWidget({Key? key, required this.progress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Format the date to display only the date part (yyyy-mm-dd)
    final formattedDate = DateFormat('yyyy-MM-dd').format(progress.date);

    // Parse completion percentage and convert it to double
    final completionPercentage = progress.value / 100;

    // Calculate color based on completion percentage
    final color = Color.lerp(Colors.red.withOpacity(0.9), Colors.green.withOpacity(0.9), completionPercentage);
    final BackGroundColor = Color.lerp(Colors.red.withOpacity(0.1), Colors.green.withOpacity(0.1), completionPercentage);

    return Card(
      color: BackGroundColor,
      elevation: 0.0, // Remove the elevation
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)), // Optional: Add rounded corners to the card
      child: Container(
        // Set background color based on completion percentage
        padding: const EdgeInsets.all(12.0), // Add padding for better spacing
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Task Completion Date:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.9), // Adjust text color to be visible on the background color
                  ), // Use the specified headerTextStyle directly
                ),
                Text(
                  formattedDate, // Display formatted date
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black.withOpacity(0.9),),
                ),
              ],
            ),
            SizedBox(height: 8), // Add vertical spacing between the date and value
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Completion Percentage:',
                  style: TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.bold,
                    color: Colors.black.withOpacity(0.9), // Adjust text color to be visible on the background color
                  ), // Use the specified headerTextStyle directly
                ),
                Text(

                  '${progress.value}%', // Display completion percentage
                  style: TextStyle(fontWeight: FontWeight.bold, color:color,fontSize: 18.0,),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}