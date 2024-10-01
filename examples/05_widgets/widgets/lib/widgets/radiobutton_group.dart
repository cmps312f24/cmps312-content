import 'package:flutter/material.dart';

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
    this.cardBackgroundColor = const Color(0xFFF8F8FF),
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
