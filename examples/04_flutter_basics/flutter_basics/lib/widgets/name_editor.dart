import 'package:flutter/material.dart';

class NameEditor extends StatelessWidget {
  final String name;
  //final ValueChanged<String> onNameChange;
  // Or
  final void Function(String) onNameChange;

  const NameEditor({required this.name, required this.onNameChange});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        initialValue: name,
        decoration: const InputDecoration(labelText: "Your name"),
        onChanged: (newName) => onNameChange(newName),
      ),
    );
  }
}
