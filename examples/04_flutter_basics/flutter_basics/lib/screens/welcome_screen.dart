import 'package:flutter/material.dart';
import 'package:flutter_basics/widgets/name_editor.dart';
import 'package:flutter_basics/widgets/welcome_card.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen();
  @override
  _WelcomeScreenState createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  String name = "Flutter";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Welcome"),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
