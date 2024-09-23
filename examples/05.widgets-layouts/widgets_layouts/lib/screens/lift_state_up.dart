import 'package:flutter/material.dart';

// State hoisting is a technique to manage state in
// a parent widget and pass it down to child widgets
class HelloScreen extends StatefulWidget {
  const HelloScreen();
  @override
  _HelloScreenState createState() => _HelloScreenState();
}

class _HelloScreenState extends State<HelloScreen> {
  String name = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hello, $name',
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          const SizedBox(height: 8),
          NameEditor(
            name: name,
            onNameChange: (String newName) {
              setState(() {
                name = newName;
              });
            },
          ),
        ],
      ),
    );
  }
}

class NameEditor extends StatelessWidget {
  final String name;
  final Function(String) onNameChange;

  const NameEditor({required this.name, required this.onNameChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Name',
          border: OutlineInputBorder(),
        ),
        onChanged: onNameChange,
      ),
    );
  }
}
