import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
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
