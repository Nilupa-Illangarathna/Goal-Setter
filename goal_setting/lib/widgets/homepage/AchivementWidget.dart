import 'package:flutter/material.dart';
import 'package:goal_setting/data_classes/sub%20classes/task_class.dart';
import 'package:intl/intl.dart';

import '../../data_classes/sub classes/achievement_class.dart';
import '../Social share/social.dart';

class AchievementWidget extends StatelessWidget {
  final Achievement achievement;
  final Task task;
  final String imageUrl;

  const AchievementWidget({Key? key, required this.achievement, required this.task, required this.imageUrl}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      color:Color(0xFFF8DE7E),
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 0),
      child: ListTile(
        leading: _buildAwardBadge(),
        title: Text(
          'Description: ${achievement.description}',
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.black),
        ),
        subtitle: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Date Earned: ${DateFormat('yyyy-MM-dd').format(achievement.dateEarned)}',
              style: TextStyle(color: Colors.black),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 8.0),
              child: IconButton(
                icon: Container(
                  height: 32,
                  width: 56,
                  decoration: BoxDecoration(
                    color: Colors.blue.withOpacity(1.0),
                    borderRadius: BorderRadius.circular(6.0),
                  ),
                  child: Center(
                    child: Text(
                      "Share",
                      style:TextStyle(
                          fontWeight: FontWeight.w500,
                          color: Colors.white,
                          fontSize:14
                      )
                    ),
                  ),
                ),
                onPressed: () {
                  // String body = 'Check out my latest update on $topic!';
                  // String imageUrl = 'https://example.com/image.jpg'; // Replace with the actual image URL
                  // String topic = 'Flutter Development';

                  shareOnSocialMedia(context: context, body: achievement.description, imageUrl: imageUrl, topic:task.name);
                  // Navigator.of(context).pop();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildAwardBadge() {
    return Container(
      padding: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Colors.orange,
        shape: BoxShape.circle,
      ),
      child: Icon(
        Icons.star,
        color: Colors.amber,
        size: 24,
      ),
    );
  }
}