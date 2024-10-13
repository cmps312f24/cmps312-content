import 'package:flutter/material.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: const Center(
        child: Text('Back to Home'),
      ),
    );
  }
}
