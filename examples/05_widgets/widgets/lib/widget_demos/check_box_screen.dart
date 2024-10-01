import 'package:flutter/material.dart';
import 'package:widgets/widgets/checkbox_list.dart';

class CheckBoxScreen extends StatefulWidget {
  const CheckBoxScreen();
  @override
  _CheckBoxScreenState createState() => _CheckBoxScreenState();
}

class _CheckBoxScreenState extends State<CheckBoxScreen> {
  final options = {
    'Java': false,
    'Dart': true,
    'Kotlin': true,
    'JavaScript': true,
  };

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('CheckBox Screen'),
        ),
        body: Column(
          children: [
            CheckBoxList(
              title: 'Which are your most favorite language?',
              options: options,
              onChanged: (String key, bool value) {
                setState(() {
                  options[key] = value;
                });
              },
            ),
            const SizedBox(height: 15.0),
            Center(
              child: Text(
                options.entries
                    .map((entry) => '${entry.key} (${entry.value})')
                    .join('\n'),
                textAlign: TextAlign.center,
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
