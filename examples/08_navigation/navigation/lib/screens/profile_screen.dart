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
          onPressed: () {
            // Return to the previous screen
            Navigator.pop(context);
            // Or
            // Navigator.of(context).pop();
          },
          child: const Text('Back to Home'),
        ),
      ),
    );
  }
}
