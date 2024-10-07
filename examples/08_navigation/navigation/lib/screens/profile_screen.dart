import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Center(
        child: ElevatedButton(
          child: const Text('Back to Home'),
          onPressed: () {
            // Return to the previous screen
            Navigator.of(context).pop();
            // Or
            // Navigator.pop(context);
          },
        ),
      ),
    );
  }
}
