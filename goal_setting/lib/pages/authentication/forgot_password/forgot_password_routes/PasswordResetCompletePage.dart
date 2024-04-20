import 'package:flutter/material.dart';

class PasswordResetCompletePage extends StatelessWidget {
  final Function() onClose;

  const PasswordResetCompletePage({required this.onClose});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text('Password Reset Complete Page'), // Placeholder for password reset complete
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: onClose, // Call the onClose callback to close the modal
            child: Text('Close'),
          ),
        ],
      ),
    );
  }
}
