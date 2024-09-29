import 'package:flutter/material.dart';
import 'package:flutter_basics/basics/name_editor.dart';
import 'package:flutter_basics/basics/welcome_card.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String name = "Android";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          NameEditor(
            name: name,
            onNameChange: (newName) {
              setState(() {
                name = newName;
              });
            },
          ),
          const SizedBox(height: 16),
          WelcomeCard(name: name),
        ],
      ),
    );
  }
}
