import 'package:flutter/material.dart';

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
              cardBackgroundColor: const Color(0xFFF8F8FF),
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

class RadioButtonGroup extends StatelessWidget {
  final String title;
  final List<String> options;
  final int selectedOptionIndex;
  final Function(int) onOptionSelected;
  final Color cardBackgroundColor;

  const RadioButtonGroup({
    required this.title,
    required this.options,
    required this.selectedOptionIndex,
    required this.onOptionSelected,
    required this.cardBackgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardBackgroundColor,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            ...options.asMap().entries.map((entry) {
              int index = entry.key;
              String text = entry.value;
              return RadioListTile(
                title: Text(text),
                value: index,
                groupValue: selectedOptionIndex,
                onChanged: (value) {
                  onOptionSelected(value!);
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
