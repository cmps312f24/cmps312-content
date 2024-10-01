import 'package:flutter/material.dart';
import 'package:widgets/widgets/radiobutton_group.dart';

class RadioButtonScreen extends StatefulWidget {
  const RadioButtonScreen({super.key});
  @override
  _RadioButtonScreenState createState() => _RadioButtonScreenState();
}

class _RadioButtonScreenState extends State<RadioButtonScreen> {
  final languageOptions = ["Java", "Dart", "Kotlin", "JavaScript"];
  final ideOptions = [
    "Android Studio",
    "Visual Studio",
    "IntelliJ Idea",
    "Eclipse"
  ];

  int selectedLanguageIndex = 1;
  int selectedIdeIndex = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Radio Button Screen'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RadioButtonGroup(
              title: "Which is your most favorite language?",
              options: languageOptions,
              selectedOptionIndex: selectedLanguageIndex,
              onOptionSelected: (index) {
                setState(() {
                  selectedLanguageIndex = index;
                });
              },
              cardBackgroundColor: const Color(0xFFFFFAF0),
            ),
            const SizedBox(height: 8.0),
            RadioButtonGroup(
              title: "Which is your most favorite IDE?",
              options: ideOptions,
              selectedOptionIndex: selectedIdeIndex,
              onOptionSelected: (index) {
                setState(() {
                  selectedIdeIndex = index;
                });
              },
            ),
            const SizedBox(height: 15.0),
            Center(
              child: Text(
                'Selected Language: ${languageOptions[selectedLanguageIndex]} (index: $selectedLanguageIndex)\n'
                'Selected IDE: ${ideOptions[selectedIdeIndex]} (index: $selectedIdeIndex)',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
