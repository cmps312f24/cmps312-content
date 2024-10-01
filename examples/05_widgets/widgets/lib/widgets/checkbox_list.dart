import 'package:flutter/material.dart';

class CheckBoxList extends StatelessWidget {
  final String title;
  final Map<String, bool> options;
  final Function(String, bool) onChanged;

  const CheckBoxList({
    required this.title,
    required this.options,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8.0),
          ...options.keys.map((String key) {
            return CheckboxListTile(
              title: Text(key),
              value: options[key],
              onChanged: (bool? value) {
                onChanged(key, value!);
              },
            );
          }),
        ],
      ),
    );
  }
}
